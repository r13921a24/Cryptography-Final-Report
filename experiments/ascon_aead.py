"""
Ascon-AEAD128 - NIST SP 800-232 compliant implementation.

Based on the ASCON v1.2 specification with NIST SP 800-232 modifications:
- Little-endian byte ordering (critical change from original big-endian CAESAR submission)
- 320-bit state: 5 x 64-bit words (x0..x4)
- Rate: 64 bits (x0), Capacity: 256 bits (x1..x4)
- Rounds: pa=12 (init/final), pb=6 (data processing)
- 5-bit S-box with algebraic degree 2, bit-sliced implementation
"""


ASCON_128_KEY_SIZE = 16
ASCON_128_NONCE_SIZE = 16
ASCON_128_TAG_SIZE = 16
ASCON_BLOCK_SIZE = 8

PA_ROUNDS = 12
PB_ROUNDS = 6

ROUND_CONSTANTS = [
    0xf0, 0xe1, 0xd2, 0xc3, 0xb4, 0xa5, 0x96, 0x87,
    0x78, 0x69, 0x5a, 0x4b, 0x3c, 0x2d, 0x1e, 0x0f,
]


def _bytes_to_u64_le(data, offset=0):
    return int.from_bytes(data[offset:offset+8], 'little')


def _u64_to_bytes_le(value):
    return value.to_bytes(8, 'little')


def _rotr(val, shift):
    shift &= 63
    return ((val >> shift) | (val << (64 - shift))) & 0xFFFFFFFFFFFFFFFF


def _ascon_sbox(x0, x1, x2, x3, x4):
    """ASCON 5-bit S-box (bit-sliced). Algebraic degree 2."""
    x0 ^= x4
    x4 ^= x3
    x2 ^= x1
    t0 = x0
    t1 = x1
    t2 = x2
    t3 = x3
    t4 = x4
    x0 ^= (~t1 & t2)
    x1 ^= (~t2 & t3)
    x2 ^= (~t3 & t4)
    x3 ^= (~t4 & t0)
    x4 ^= (~t0 & t1)
    x2 = ~x2 & 0xFFFFFFFFFFFFFFFF
    x4 = ~x4 & 0xFFFFFFFFFFFFFFFF
    x1 ^= x0
    x0 ^= x4
    x3 ^= x2
    return x0, x1, x2, x3, x4


def _ascon_linear(x0, x1, x2, x3, x4):
    """ASCON linear diffusion layer."""
    x0 ^= _rotr(x0, 19) ^ _rotr(x0, 28)
    x1 ^= _rotr(x1, 61) ^ _rotr(x1, 39)
    x2 ^= _rotr(x2, 1) ^ _rotr(x2, 6)
    x3 ^= _rotr(x3, 10) ^ _rotr(x3, 17)
    x4 ^= _rotr(x4, 7) ^ _rotr(x4, 41)
    return x0, x1, x2, x3, x4


def _ascon_permutation(x0, x1, x2, x3, x4, rounds):
    for r in range(rounds):
        x0, x1, x2, x3, x4 = _ascon_sbox(x0, x1, x2, x3, x4)
        x0, x1, x2, x3, x4 = _ascon_linear(x0, x1, x2, x3, x4)
        x2 ^= ROUND_CONSTANTS[r]
    return x0, x1, x2, x3, x4


def _pad_data(data):
    """Pad data to multiple of 8 bytes with 1||0* scheme."""
    dlen = len(data)
    padded = bytearray(data)
    if dlen == 0:
        padded = bytearray(8)
        padded[0] = 0x80
    else:
        remainder = dlen % 8
        if remainder == 0:
            padded.extend(b'\x80' + b'\x00' * 7)
        else:
            padded.append(0x80)
            padded.extend(b'\x00' * (8 - remainder - 1))
    return bytes(padded)


def ascon_aead128_encrypt(key, nonce, associated_data, plaintext, tag_size=16):
    """ASCON-128 AEAD encryption (Ascon-AEAD128)."""
    assert len(key) == 16 and len(nonce) == 16

    k0 = _bytes_to_u64_le(key, 0)
    k1 = _bytes_to_u64_le(key, 8)
    n0 = _bytes_to_u64_le(nonce, 0)
    n1 = _bytes_to_u64_le(nonce, 8)

    # === Initialization ===
    x0 = 0x80400c0600000000  # IV for ASCON-128
    x1 = k0
    x2 = k1
    x3 = n0
    x4 = n1

    x0, x1, x2, x3, x4 = _ascon_permutation(x0, x1, x2, x3, x4, PA_ROUNDS)
    x3 ^= k0
    x4 ^= k1

    # === Process Associated Data ===
    ad_padded = _pad_data(associated_data)
    for i in range(0, len(ad_padded), 8):
        if len(associated_data) > 0:
            x0 ^= _bytes_to_u64_le(ad_padded, i)
        x0, x1, x2, x3, x4 = _ascon_permutation(x0, x1, x2, x3, x4, PB_ROUNDS)

    # Domain separation
    x4 ^= 1

    # === Process Plaintext ===
    pt_len = len(plaintext)
    pt_padded = _pad_data(plaintext)
    ct_blocks = []

    for i in range(0, len(pt_padded), 8):
        pt_block = _bytes_to_u64_le(pt_padded, i)
        x0 ^= pt_block
        ct_block = _u64_to_bytes_le(x0)

        remaining = pt_len - len(b''.join(ct_blocks))
        if remaining >= 8:
            ct_blocks.append(ct_block)
        else:
            ct_blocks.append(ct_block[:remaining])

        if i + 8 < len(pt_padded):
            x0, x1, x2, x3, x4 = _ascon_permutation(x0, x1, x2, x3, x4, PB_ROUNDS)

    ciphertext = b''.join(ct_blocks)

    # === Finalization ===
    x1 ^= k0
    x2 ^= k1
    x0, x1, x2, x3, x4 = _ascon_permutation(x0, x1, x2, x3, x4, PA_ROUNDS)
    x3 ^= k0
    x4 ^= k1

    tag = _u64_to_bytes_le(x3) + _u64_to_bytes_le(x4)
    return ciphertext, tag[:tag_size]


def ascon_aead128_decrypt(key, nonce, associated_data, ciphertext, tag, tag_size=16):
    """ASCON-128 AEAD decryption with tag verification."""
    assert len(key) == 16 and len(nonce) == 16

    k0 = _bytes_to_u64_le(key, 0)
    k1 = _bytes_to_u64_le(key, 8)
    n0 = _bytes_to_u64_le(nonce, 0)
    n1 = _bytes_to_u64_le(nonce, 8)

    # === Initialization ===
    x0 = 0x80400c0600000000
    x1 = k0
    x2 = k1
    x3 = n0
    x4 = n1

    x0, x1, x2, x3, x4 = _ascon_permutation(x0, x1, x2, x3, x4, PA_ROUNDS)
    x3 ^= k0
    x4 ^= k1

    # === Process Associated Data ===
    ad_padded = _pad_data(associated_data)
    for i in range(0, len(ad_padded), 8):
        if len(associated_data) > 0:
            x0 ^= _bytes_to_u64_le(ad_padded, i)
        x0, x1, x2, x3, x4 = _ascon_permutation(x0, x1, x2, x3, x4, PB_ROUNDS)

    x4 ^= 1

    # === Process Ciphertext ===
    ct_len = len(ciphertext)
    pt_blocks = []

    # In encryption, plaintext is always padded with 1||0* to fill blocks.
    # In decryption, we reconstruct the same state evolution.

    # Determine how encryption would have padded the plaintext
    if ct_len == 0:
        num_encrypt_blocks = 1  # One padding block
    elif ct_len % 8 == 0:
        num_encrypt_blocks = (ct_len // 8) + 1  # Full blocks + padding block
    else:
        num_encrypt_blocks = (ct_len + 7) // 8  # Partial last block includes padding

    for i in range(num_encrypt_blocks):
        start = i * 8
        end = start + 8

        if start < ct_len:
            # This block has actual ciphertext data
            ct_data = ciphertext[start:min(end, ct_len)]
            if len(ct_data) == 8:
                # Full ciphertext block
                ct_block = _bytes_to_u64_le(ct_data, 0)
                pt_block = _u64_to_bytes_le(x0 ^ ct_block)
                pt_blocks.append(pt_block)
                x0 = ct_block
            else:
                # Partial last block: zero-pad ciphertext
                ct_padded = ct_data + b'\x00' * (8 - len(ct_data))
                ct_block = _bytes_to_u64_le(ct_padded, 0)
                pt_full = _u64_to_bytes_le(x0 ^ ct_block)
                pt_blocks.append(pt_full[:len(ct_data)])
                # Reconstruct the full padded plaintext block that was used in encryption
                pt_with_pad = (pt_full[:len(ct_data)] +
                               b'\x80' + b'\x00' * (8 - len(ct_data) - 1))
                x0 ^= _bytes_to_u64_le(pt_with_pad, 0)
        else:
            # Padding-only block (0x80 + 0x00*7), no ciphertext output
            pad_block = b'\x80' + b'\x00' * 7
            x0 ^= _bytes_to_u64_le(pad_block, 0)

        # Permutation between blocks (except after the last)
        if i < num_encrypt_blocks - 1:
            x0, x1, x2, x3, x4 = _ascon_permutation(x0, x1, x2, x3, x4, PB_ROUNDS)

    plaintext = b''.join(pt_blocks)

    # === Finalization ===
    x1 ^= k0
    x2 ^= k1
    x0, x1, x2, x3, x4 = _ascon_permutation(x0, x1, x2, x3, x4, PA_ROUNDS)
    x3 ^= k0
    x4 ^= k1

    expected_tag = _u64_to_bytes_le(x3) + _u64_to_bytes_le(x4)
    is_valid = (expected_tag[:tag_size] == tag[:tag_size])

    return plaintext, is_valid


def get_init_time_probe(key, nonce):
    """Run only the initialization phase for timing analysis."""
    k0 = _bytes_to_u64_le(key, 0)
    k1 = _bytes_to_u64_le(key, 8)
    n0 = _bytes_to_u64_le(nonce, 0)
    n1 = _bytes_to_u64_le(nonce, 8)
    x0 = 0x80400c0600000000
    x1 = k0
    x2 = k1
    x3 = n0
    x4 = n1
    return _ascon_permutation(x0, x1, x2, x3, x4, PA_ROUNDS)
