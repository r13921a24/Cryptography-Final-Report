"""
Pure-Python AES-128-GCM — NO hardware acceleration.

Implements AES-128 block cipher and GCM mode entirely in Python
using byte-level operations. Every SubBytes lookup, MixColumns
GF(2^8) multiplication, and GHASH GF(2^128) multiplication is
done in pure software.

API matches aes_gcm.AES128GCM for drop-in replacement in benchmarks.
"""


AES_GCM_KEY_SIZE = 16
AES_GCM_NONCE_SIZE = 12
AES_GCM_TAG_SIZE = 16

# ============================================================
# GF(2^8) Arithmetic for AES MixColumns
# ============================================================

# The Rijndael field: GF(2)[x]/(x^8 + x^4 + x^3 + x + 1)
# Element a = sum(a_i * x^i), i=0..7, a_i in {0,1}
# Represented as byte: bit i = coefficient of x^i (a_0 is LSB)

def _gf256_xtime(a):
    """Multiply by x in GF(2^8). (a << 1) XOR (0x1B if overflow)."""
    hi = a & 0x80
    b = (a << 1) & 0xFF
    if hi:
        b ^= 0x1B
    return b


def _gf256_mul(a, b):
    """Multiply a * b in GF(2^8) using Russian peasant algorithm."""
    p = 0
    for _ in range(8):
        if b & 1:
            p ^= a
        hi = a & 0x80
        a = ((a << 1) & 0xFF)
        if hi:
            a ^= 0x1B
        b >>= 1
    return p


def _gf256_inv(a):
    """Multiplicative inverse in GF(2^8). a^254 since a^255 = 1."""
    if a == 0:
        return 0
    # Square-and-multiply chain for 254 = 0xFE
    # 254 = 2 + 4 + 8 + 16 + 32 + 64 + 128 (all even powers except 128)
    # Compute a^254 efficiently
    r = a
    for _ in range(6):  # square 6 times to get a^(2^6) = a^64
        r = _gf256_mul(r, r)
        if _ < 5:  # multiply by original for powers 2,4,8,16,32
            pass
    # Simpler: just use repeated squaring
    r = a
    for _ in range(7):
        r = _gf256_mul(r, r)
    # r = a^128
    # a^254 = a^128 * a^64 * a^32 * a^16 * a^8 * a^4 * a^2
    # Build a^254 by multiplication chain
    r = a
    p2 = _gf256_mul(r, r)       # a^2
    p3 = _gf256_mul(p2, r)      # a^3
    p6 = _gf256_mul(p3, p3)     # a^6
    p7 = _gf256_mul(p6, r)      # a^7
    p14 = _gf256_mul(p7, p7)    # a^14
    p15 = _gf256_mul(p14, r)    # a^15
    p30 = _gf256_mul(p15, p15)  # a^30
    p31 = _gf256_mul(p30, r)    # a^31
    p62 = _gf256_mul(p31, p31)  # a^62
    p63 = _gf256_mul(p62, r)    # a^63
    p126 = _gf256_mul(p63, p63) # a^126
    p127 = _gf256_mul(p126, r)  # a^127
    p254 = _gf256_mul(p127, p127) # a^254
    return p254


# ============================================================
# AES-128 S-Box
# ============================================================

def _build_sbox():
    """Build the AES S-box: affine transform of GF(2^8) inverse.

    The affine transform is: y = x XOR rotl(x,4) XOR rotl(x,5)
                                 XOR rotl(x,6) XOR rotl(x,7) XOR 0x63
    """
    sbox = [0] * 256
    for a in range(256):
        inv = _gf256_inv(a)
        s = inv
        # Affine: y = x XOR rotr(x,4) XOR rotr(x,5) XOR rotr(x,6) XOR rotr(x,7) XOR 0x63
        # (ROTR because AES bit 0 = MSB of the integer byte)
        for r in [4, 5, 6, 7]:
            s ^= ((inv >> r) | (inv << (8 - r))) & 0xFF
        s ^= 0x63
        sbox[a] = s & 0xFF
    return sbox


SBOX = _build_sbox()

# Round constants for key expansion
RCON = [0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1B, 0x36]

# MixColumns matrix columns (for faster computation)
# [02, 03, 01, 01], [01, 02, 03, 01], [01, 01, 02, 03], [03, 01, 01, 02]


# ============================================================
# AES-128 Block Cipher
# ============================================================

def _key_expansion(key):
    """Expand 16-byte key into 11 x 16-byte round keys (176 bytes)."""
    # Key is stored column-major: key[col*4 + row]
    W = [0] * 44  # 44 words (4 bytes each) for AES-128

    # First 4 words = key
    for i in range(4):
        W[i] = (key[4*i] << 24) | (key[4*i+1] << 16) | (key[4*i+2] << 8) | key[4*i+3]

    for i in range(4, 44):
        temp = W[i-1]
        if i % 4 == 0:
            # RotWord: cyclic left shift of bytes
            temp = ((temp << 8) | (temp >> 24)) & 0xFFFFFFFF
            # SubWord: apply S-box to each byte
            temp = ((SBOX[(temp >> 24) & 0xFF] << 24) |
                    (SBOX[(temp >> 16) & 0xFF] << 16) |
                    (SBOX[(temp >> 8) & 0xFF] << 8) |
                    (SBOX[temp & 0xFF]))
            # XOR with RCON
            temp ^= (RCON[i//4 - 1] << 24)
        W[i] = W[i-4] ^ temp

    # Convert to 16-byte round keys
    round_keys = []
    for r in range(11):
        rk = bytearray(16)
        for c in range(4):
            w = W[r*4 + c]
            rk[4*c] = (w >> 24) & 0xFF
            rk[4*c+1] = (w >> 16) & 0xFF
            rk[4*c+2] = (w >> 8) & 0xFF
            rk[4*c+3] = w & 0xFF
        round_keys.append(bytes(rk))
    return round_keys


def _sub_bytes(state):
    """Apply S-box to each byte of 16-byte state."""
    return bytes(SBOX[b] for b in state)


def _shift_rows(state):
    """Cyclic shift rows of 4x4 byte matrix (row i shifted left by i)."""
    # State layout: column-major = state[col*4 + row]
    # Row 0 unchanged, row 1 << 1, row 2 << 2, row 3 << 3
    return bytes([
        state[0],  state[5],  state[10], state[15],  # row 0
        state[4],  state[9],  state[14], state[3],   # row 1 << 1
        state[8],  state[13], state[2],  state[7],   # row 2 << 2
        state[12], state[1],  state[6],  state[11],  # row 3 << 3
    ])


def _mix_columns(state):
    """Multiply each column by MDS matrix in GF(2^8)."""
    result = bytearray(16)
    for c in range(4):
        col = state[c*4:(c+1)*4]  # 4 bytes of column
        result[c*4]   = _gf256_mul(0x02, col[0]) ^ _gf256_mul(0x03, col[1]) ^ col[2] ^ col[3]
        result[c*4+1] = col[0] ^ _gf256_mul(0x02, col[1]) ^ _gf256_mul(0x03, col[2]) ^ col[3]
        result[c*4+2] = col[0] ^ col[1] ^ _gf256_mul(0x02, col[2]) ^ _gf256_mul(0x03, col[3])
        result[c*4+3] = _gf256_mul(0x03, col[0]) ^ col[1] ^ col[2] ^ _gf256_mul(0x02, col[3])
    return bytes(result)


def _add_round_key(state, rk):
    """XOR state with round key."""
    return bytes(a ^ b for a, b in zip(state, rk))


def aes128_encrypt_block(plaintext, round_keys):
    """Encrypt a single 128-bit block with AES-128."""
    assert len(plaintext) == 16
    state = plaintext

    # Initial round
    state = _add_round_key(state, round_keys[0])

    # Rounds 1-9
    for r in range(1, 10):
        state = _sub_bytes(state)
        state = _shift_rows(state)
        state = _mix_columns(state)
        state = _add_round_key(state, round_keys[r])

    # Final round (no MixColumns)
    state = _sub_bytes(state)
    state = _shift_rows(state)
    state = _add_round_key(state, round_keys[10])

    return state


# ============================================================
# GF(2^128) Arithmetic for GHASH
# ============================================================

# GF(2^128) with polynomial x^128 + x^7 + x^2 + x + 1
# Elements are 128-bit strings; bit i corresponds to coefficient of x^i.
# GHASH bit ordering: bytes are in big-endian order within the block,
# but bits within each byte are reversed (little-endian bit order).

GCM_R = (1 << 128) | (1 << 7) | (1 << 2) | (1 << 1) | 1  # x^128 + x^7 + x^2 + x + 1


def _bytes_to_gf128(data):
    """Convert 16 bytes to GF(2^128) element.

    In GCM, the block X = X[0]..X[15] maps to polynomial:
    sum_{i=0}^{127} x_i * x^i, where x_{8*j+b} = bit b of X[15-j].
    This is equivalent to int.from_bytes(data, 'big').
    """
    return int.from_bytes(data, 'big')


def _gf128_to_bytes(val):
    """Convert GF(2^128) element back to 16 bytes."""
    return val.to_bytes(16, 'big')


def _gf128_mul(a, b):
    """Multiply a * b in GF(2^128) — carry-less multiply + reduction."""
    # Carry-less multiplication (schoolbook)
    product = 0
    for i in range(128):
        if b & (1 << i):
            product ^= (a << i)
    # Reduction modulo x^128 + x^7 + x^2 + x + 1
    # For each bit position j >= 128, clear it and XOR R shifted by (j-128)
    for j in range(255, 127, -1):
        if product & (1 << j):
            product ^= (GCM_R << (j - 128))
    return product & ((1 << 128) - 1)


def _ghash(h, data):
    """GHASH: evaluate polynomial with hash key h over data blocks."""
    y = 0
    for i in range(0, len(data), 16):
        block = data[i:i+16]
        if len(block) < 16:
            block = block + b'\x00' * (16 - len(block))
        x = _bytes_to_gf128(block)
        y = _gf128_mul(y ^ x, h)
    return y


def _gctr(aes_encrypt, icb, data):
    """GCTR: AES counter mode keystream XOR."""
    output = bytearray()
    cb = bytearray(icb)
    nblocks = (len(data) + 15) // 16

    for i in range(nblocks):
        # Encrypt counter block
        ks = aes_encrypt(bytes(cb))
        chunk = data[i*16:(i+1)*16]
        for j in range(len(chunk)):
            output.append(chunk[j] ^ ks[j])
        # Increment counter (last 32 bits)
        ctr = int.from_bytes(cb[12:16], 'big')
        ctr = (ctr + 1) & 0xFFFFFFFF
        cb[12:16] = ctr.to_bytes(4, 'big')

    return bytes(output)


# ============================================================
# AES-128-GCM AEAD
# ============================================================

class AES128GCM:
    """Pure-Python AES-128-GCM — zero hardware acceleration."""

    def __init__(self, key):
        assert len(key) == AES_GCM_KEY_SIZE
        self.key = key
        self._round_keys = _key_expansion(key)

    def _encrypt_block(self, block):
        return aes128_encrypt_block(block, self._round_keys)

    def encrypt(self, nonce, associated_data, plaintext):
        """AES-128-GCM encryption. Returns (ciphertext, tag)."""
        assert len(nonce) == AES_GCM_NONCE_SIZE

        # Hash subkey H = AES_K(0^128) and convert to GF(2^128) element
        H_block = self._encrypt_block(b'\x00' * 16)
        H_gf = _bytes_to_gf128(H_block)

        # Pre-counter block J0
        # For 96-bit nonce: J0 = nonce || 0^31 || 1
        J0 = nonce + b'\x00\x00\x00\x01'

        # Encrypt plaintext with GCTR starting from inc(J0)
        ciphertext = _gctr(self._encrypt_block, self._inc32(J0), plaintext)

        # GHASH over A || C || len(A) || len(C)
        u = (128 - (len(associated_data) * 8) % 128) % 128
        v = (128 - (len(ciphertext) * 8) % 128) % 128
        s_data = associated_data + b'\x00' * (u // 8) + ciphertext + b'\x00' * (v // 8)
        s_data += (len(associated_data) * 8).to_bytes(8, 'big')
        s_data += (len(ciphertext) * 8).to_bytes(8, 'big')

        S = _ghash(H_gf, s_data)
        tag = _gf128_to_bytes(S)

        # XOR tag with E_K(J0)
        E_J0 = self._encrypt_block(J0)
        tag = bytes(a ^ b for a, b in zip(tag, E_J0))

        return ciphertext, tag

    def decrypt(self, nonce, associated_data, ciphertext, tag):
        """AES-128-GCM decryption. Returns (plaintext, is_valid)."""
        assert len(nonce) == AES_GCM_NONCE_SIZE

        H_block = self._encrypt_block(b'\x00' * 16)
        H_gf = _bytes_to_gf128(H_block)

        J0 = nonce + b'\x00\x00\x00\x01'

        # Decrypt
        plaintext = _gctr(self._encrypt_block, self._inc32(J0), ciphertext)

        # Verify tag
        u = (128 - (len(associated_data) * 8) % 128) % 128
        v = (128 - (len(ciphertext) * 8) % 128) % 128
        s_data = associated_data + b'\x00' * (u // 8) + ciphertext + b'\x00' * (v // 8)
        s_data += (len(associated_data) * 8).to_bytes(8, 'big')
        s_data += (len(ciphertext) * 8).to_bytes(8, 'big')

        S = _ghash(H_gf, s_data)
        expected_tag = _gf128_to_bytes(S)
        E_J0 = self._encrypt_block(J0)
        expected_tag = bytes(a ^ b for a, b in zip(expected_tag, E_J0))

        valid = (expected_tag == tag)
        return plaintext, valid

    @staticmethod
    def _inc32(block):
        """Increment last 4 bytes of a 16-byte block (big-endian)."""
        b = bytearray(block)
        ctr = int.from_bytes(b[12:16], 'big')
        ctr = (ctr + 1) & 0xFFFFFFFF
        b[12:16] = ctr.to_bytes(4, 'big')
        return bytes(b)

    def init_only(self, nonce):
        """Initialize cipher only — compute H = AES_K(0) and J0."""
        H_block = self._encrypt_block(b'\x00' * 16)
        J0 = nonce + b'\x00\x00\x00\x01'
        return H_block, J0
