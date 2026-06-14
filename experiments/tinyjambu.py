"""
TinyJAMBU-128 v2 — Optimized pure Python implementation.

Follows the reference C++ implementation (itzmeanjan/tinyjambu):
- 128-bit state as 4 x 32-bit words [s0(L), s1, s2, s3(H)]
- FBK_32: computes 32 feedback bits per iteration (rounds/32 iterations)
- FrameBits: shifted left by 4 → state[1] bits 4..6 (= state bits 36..38)
- State update happens BEFORE absorbing data in each phase
- Tag: extracted from state[2]

Key insight: state[0] is LSB (bits 96..127), state[3] is MSB (bits 0..31).
Each state_update<r> shifts the state right by r bit-positions (MSB gets feedback).
"""

import struct


TINYJAMBU_KEY_SIZE = 16
TINYJAMBU_NONCE_SIZE = 12
TINYJAMBU_TAG_SIZE = 8

ROUNDS_KEY_INIT = 1024
ROUNDS_NONCE_AD = 640
ROUNDS_PT_CT = 1024
ROUNDS_TAG1 = 1024
ROUNDS_TAG2 = 640

# FrameBits (FBK_32: shifted left by 4, applied to state[1])
FB_NONCE = 0x10   # 001 << 4
FB_AD    = 0x30   # 011 << 4
FB_PTCT  = 0x50   # 101 << 4
FB_TAG   = 0x70   # 111 << 4


def _from_le_bytes(data, offset=0):
    """Load 4 little-endian bytes as uint32."""
    return (data[offset] | (data[offset + 1] << 8) |
            (data[offset + 2] << 16) | (data[offset + 3] << 24))


def _to_le_bytes(word):
    """Store uint32 as 4 little-endian bytes."""
    return bytes([word & 0xFF, (word >> 8) & 0xFF,
                   (word >> 16) & 0xFF, (word >> 24) & 0xFF])


def _load_key(key_bytes):
    """Load 16-byte key as 4 x uint32 (little-endian)."""
    return [_from_le_bytes(key_bytes, i * 4) for i in range(4)]


# ============================================================
# State Update (FBK_32: 32 feedback bits per iteration)
# ============================================================

def _state_update(state, rounds, key):
    """
    TinyJAMBU keyed permutation — FBK_32 method.

    State layout: state[0]=LSB, state[3]=MSB.
    Computes 32 feedback bits per iteration, processing 32 rounds at once.

    For each group of 32 rounds:
      s47 = 32-bit window starting at bit 47 of the 128-bit state
      s70 = 32-bit window starting at bit 70
      s85 = 32-bit window starting at bit 85
      s91 = 32-bit window starting at bit 91
      fbk = state[0] ^ s47 ^ (~(s70 & s85)) ^ s91 ^ key_word

      Shift right by 32 bits:
        state[0] = state[1]
        state[1] = state[2]
        state[2] = state[3]
        state[3] = fbk

    state[0] (old s_96..s_127) is discarded.
    fbk becomes new s_0..s_31.
    """
    s = list(state)
    itr_cnt = rounds >> 5  # rounds / 32

    for i in range(itr_cnt):
        # Extract 32-bit windows from the 128-bit state using word-level shifts
        # s47: bits 47..78 = lower 17 bits from state[1] + upper 15 bits from state[2]
        s47 = ((s[2] << 17) | (s[1] >> 15)) & 0xFFFFFFFF
        # s70: bits 70..101 = lower 26 bits from state[2] + upper 6 bits from state[3]
        s70 = ((s[3] << 26) | (s[2] >> 6)) & 0xFFFFFFFF
        # s85: bits 85..116 = lower 21 bits from state[2] + upper 11 bits from state[3]
        s85 = ((s[3] << 11) | (s[2] >> 21)) & 0xFFFFFFFF
        # s91: bits 91..122 = lower 27 bits from state[2] + upper 5 bits from state[3]
        s91 = ((s[3] << 5) | (s[2] >> 27)) & 0xFFFFFFFF

        # 32 feedback bits: XOR of 5 state windows + key word
        fbk = s[0] ^ s47 ^ (~(s70 & s85)) ^ s91 ^ key[i & 3]

        # Shift right by 32 bits
        s[0] = s[1]
        s[1] = s[2]
        s[2] = s[3]
        s[3] = fbk & 0xFFFFFFFF

    return s


# ============================================================
# Core processing helpers
# ============================================================

def _mix_word(state, word, partial_byte_cnt):
    """Mix a 32-bit word into state[3]."""
    mask = 0xFFFFFFFF >> ((4 - partial_byte_cnt) << 3) if partial_byte_cnt < 4 else 0xFFFFFFFF
    state[3] ^= (word & mask)


def _process_plaintext(state, key, text, ct_len):
    """Process plaintext → ciphertext. See spec section 3.3.3."""
    part_byte_cnt = ct_len & 3
    b_off = 0
    result = bytearray()

    while b_off < ct_len:
        state[1] ^= FB_PTCT
        state = _state_update(state, ROUNDS_PT_CT, key)

        take = min(4, ct_len - b_off)
        word = 0
        for i in range(take):
            word |= text[b_off + i] << (i << 3)

        state[3] ^= word
        enc = state[2] ^ word

        for i in range(take):
            result.append((enc >> (i << 3)) & 0xFF)
        b_off += take

    state[1] ^= part_byte_cnt
    return state, bytes(result)


def _process_ciphertext(state, key, cipher, ct_len):
    """Process ciphertext → plaintext. See spec section 3.3.5."""
    part_byte_cnt = ct_len & 3
    b_off = 0
    result = bytearray()

    while b_off < ct_len:
        state[1] ^= FB_PTCT
        state = _state_update(state, ROUNDS_PT_CT, key)

        take = min(4, ct_len - b_off)
        word = 0
        for i in range(take):
            word |= cipher[b_off + i] << (i << 3)

        dec = state[2] ^ word
        mask = 0xFFFFFFFF >> ((4 - take) << 3)
        state[3] ^= (dec & mask)

        for i in range(take):
            result.append((dec >> (i << 3)) & 0xFF)
        b_off += take

    state[1] ^= part_byte_cnt
    return state, bytes(result)


def _process_associated_data(state, key, data, data_len):
    """Process associated data. See spec section 3.3.2."""
    if data_len == 0:
        return state

    part_byte_cnt = data_len & 3
    b_off = 0

    while b_off < data_len:
        state[1] ^= FB_AD
        state = _state_update(state, ROUNDS_NONCE_AD, key)

        take = min(4, data_len - b_off)
        word = 0
        for i in range(take):
            word |= data[b_off + i] << (i << 3)

        state[3] ^= word
        b_off += take

    state[1] ^= part_byte_cnt
    return state


# ============================================================
# TinyJAMBU-128 AEAD
# ============================================================

class TinyJAMBU128:
    """TinyJAMBU-128 v2 AEAD cipher — corrected FBK_32 implementation."""

    def __init__(self, key):
        assert len(key) == TINYJAMBU_KEY_SIZE
        self.key = key
        self._key_words = _load_key(key)

    def encrypt(self, nonce, associated_data, plaintext):
        assert len(nonce) == TINYJAMBU_NONCE_SIZE

        state = [0, 0, 0, 0]
        k = self._key_words

        # === Initialization (spec 3.3.1) ===
        # Key setup: single state_update<1024>
        state = _state_update(state, ROUNDS_KEY_INIT, k)

        # Nonce setup: for each 32-bit nonce word, state_update<640> then absorb
        for i in range(3):
            state[1] ^= FB_NONCE
            state = _state_update(state, ROUNDS_NONCE_AD, k)
            nw = _from_le_bytes(nonce, i * 4)
            state[3] ^= nw

        # === Process Associated Data (spec 3.3.2) ===
        state = _process_associated_data(state, k, associated_data, len(associated_data))

        # === Process Plaintext (spec 3.3.3) ===
        state, ciphertext = _process_plaintext(state, k, plaintext, len(plaintext))

        # === Finalize (spec 3.3.4) ===
        # First 32 tag bits
        state[1] ^= FB_TAG
        state = _state_update(state, ROUNDS_TAG1, k)
        tag = _to_le_bytes(state[2])

        # Last 32 tag bits
        state[1] ^= FB_TAG
        state = _state_update(state, ROUNDS_TAG2, k)
        tag += _to_le_bytes(state[2])

        return ciphertext, tag

    def decrypt(self, nonce, associated_data, ciphertext, tag):
        assert len(nonce) == TINYJAMBU_NONCE_SIZE

        state = [0, 0, 0, 0]
        k = self._key_words

        # === Initialization ===
        state = _state_update(state, ROUNDS_KEY_INIT, k)

        for i in range(3):
            state[1] ^= FB_NONCE
            state = _state_update(state, ROUNDS_NONCE_AD, k)
            nw = _from_le_bytes(nonce, i * 4)
            state[3] ^= nw

        # === Process Associated Data ===
        state = _process_associated_data(state, k, associated_data, len(associated_data))

        # === Process Ciphertext (spec 3.3.5) ===
        state, plaintext = _process_ciphertext(state, k, ciphertext, len(ciphertext))

        # === Finalize ===
        state[1] ^= FB_TAG
        state = _state_update(state, ROUNDS_TAG1, k)
        expected_tag = _to_le_bytes(state[2])

        state[1] ^= FB_TAG
        state = _state_update(state, ROUNDS_TAG2, k)
        expected_tag += _to_le_bytes(state[2])

        is_valid = (expected_tag == tag)
        return plaintext, is_valid

    def init_only(self, nonce):
        """Run only initialization (key setup + nonce) for timing."""
        state = [0, 0, 0, 0]
        k = self._key_words
        state = _state_update(state, ROUNDS_KEY_INIT, k)
        for i in range(3):
            state[1] ^= FB_NONCE
            state = _state_update(state, ROUNDS_NONCE_AD, k)
            nw = _from_le_bytes(nonce, i * 4)
            state[3] ^= nw
        return state
