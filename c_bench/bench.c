/*
 * Compiler Bias Demonstration:
 * Same core operations, different optimization levels → different speedups.
 *
 * Compile with: gcc -O0/-O1/-O2/-O3/-Os bench.c -o bench_O0 -lrt
 * Run each and compare.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdint.h>

#define ITERATIONS 500000

/* ---- AES-128 S-box (256 bytes pre-computed) ---- */
static const uint8_t AES_SBOX[256] = {
    0x63,0x7c,0x77,0x7b,0xf2,0x6b,0x6f,0xc5,0x30,0x01,0x67,0x2b,0xfe,0xd7,0xab,0x76,
    0xca,0x82,0xc9,0x7d,0xfa,0x59,0x47,0xf0,0xad,0xd4,0xa2,0xaf,0x9c,0xa4,0x72,0xc0,
    0xb7,0xfd,0x93,0x26,0x36,0x3f,0xf7,0xcc,0x34,0xa5,0xe5,0xf1,0x71,0xd8,0x31,0x15,
    0x04,0xc7,0x23,0xc3,0x18,0x96,0x05,0x9a,0x07,0x12,0x80,0xe2,0xeb,0x27,0xb2,0x75,
    0x09,0x83,0x2c,0x1a,0x1b,0x6e,0x5a,0xa0,0x52,0x3b,0xd6,0xb3,0x29,0xe3,0x2f,0x84,
    0x53,0xd1,0x00,0xed,0x20,0xfc,0xb1,0x5b,0x6a,0xcb,0xbe,0x39,0x4a,0x4c,0x58,0xcf,
    0xd0,0xef,0xaa,0xfb,0x43,0x4d,0x33,0x85,0x45,0xf9,0x02,0x7f,0x50,0x3c,0x9f,0xa8,
    0x51,0xa3,0x40,0x8f,0x92,0x9d,0x38,0xf5,0xbc,0xb6,0xda,0x21,0x10,0xff,0xf3,0xd2,
    0xcd,0x0c,0x13,0xec,0x5f,0x97,0x44,0x17,0xc4,0xa7,0x7e,0x3d,0x64,0x5d,0x19,0x73,
    0x60,0x81,0x4f,0xdc,0x22,0x2a,0x90,0x88,0x46,0xee,0xb8,0x14,0xde,0x5e,0x0b,0xdb,
    0xe0,0x32,0x3a,0x0a,0x49,0x06,0x24,0x5c,0xc2,0xd3,0xac,0x62,0x91,0x95,0xe4,0x79,
    0xe7,0xc8,0x37,0x6d,0x8d,0xd5,0x4e,0xa9,0x6c,0x56,0xf4,0xea,0x65,0x7a,0xae,0x08,
    0xba,0x78,0x25,0x2e,0x1c,0xa6,0xb4,0xc6,0xe8,0xdd,0x74,0x1f,0x4b,0xbd,0x8b,0x8a,
    0x70,0x3e,0xb5,0x66,0x48,0x03,0xf6,0x0e,0x61,0x35,0x57,0xb9,0x86,0xc1,0x1d,0x9e,
    0xe1,0xf8,0x98,0x11,0x69,0xd9,0x8e,0x94,0x9b,0x1e,0x87,0xe9,0xce,0x55,0x28,0xdf,
    0x8c,0xa1,0x89,0x0d,0xbf,0xe6,0x42,0x68,0x41,0x99,0x2d,0x0f,0xb0,0x54,0xbb,0x16
};

/* GF(2^8) xtime for MixColumns */
static uint8_t xtime(uint8_t a) {
    return (a & 0x80) ? ((a << 1) ^ 0x1B) : (a << 1);
}

/* ---- AES-128: Encrypt single block (10 rounds) ---- */
static void aes_encrypt_block(uint8_t state[16], const uint8_t rk[176]) {
    uint8_t i, r;

    /* Initial AddRoundKey */
    for (i = 0; i < 16; i++) state[i] ^= rk[i];

    for (r = 1; r < 10; r++) {
        /* SubBytes */
        for (i = 0; i < 16; i++) state[i] = AES_SBOX[state[i]];

        /* ShiftRows */
        uint8_t tmp = state[1];
        state[1] = state[5]; state[5] = state[9]; state[9] = state[13]; state[13] = tmp;
        tmp = state[2]; state[2] = state[10]; state[10] = tmp;
        tmp = state[6]; state[6] = state[14]; state[14] = tmp;
        tmp = state[3]; state[3] = state[15]; state[15] = state[11]; state[11] = state[7]; state[7] = tmp;

        /* MixColumns */
        for (uint8_t c = 0; c < 4; c++) {
            uint8_t *col = state + c * 4;
            uint8_t a0 = col[0], a1 = col[1], a2 = col[2], a3 = col[3];
            col[0] = xtime(a0) ^ (xtime(a1) ^ a1) ^ a2 ^ a3;
            col[1] = a0 ^ xtime(a1) ^ (xtime(a2) ^ a2) ^ a3;
            col[2] = a0 ^ a1 ^ xtime(a2) ^ (xtime(a3) ^ a3);
            col[3] = (xtime(a0) ^ a0) ^ a1 ^ a2 ^ xtime(a3);
        }

        /* AddRoundKey */
        for (i = 0; i < 16; i++) state[i] ^= rk[r * 16 + i];
    }

    /* Final round (no MixColumns) */
    for (i = 0; i < 16; i++) state[i] = AES_SBOX[state[i]];
    uint8_t tmp = state[1];
    state[1] = state[5]; state[5] = state[9]; state[9] = state[13]; state[13] = tmp;
    tmp = state[2]; state[2] = state[10]; state[10] = tmp;
    tmp = state[6]; state[6] = state[14]; state[14] = tmp;
    tmp = state[3]; state[3] = state[15]; state[15] = state[11]; state[11] = state[7]; state[7] = tmp;
    for (i = 0; i < 16; i++) state[i] ^= rk[160 + i];
}


/* ---- ASCON-128: 12-round permutation (bit-sliced S-box) ---- */
static uint64_t ascon_rotr(uint64_t v, int s) {
    return (v >> s) | (v << (64 - s));
}

static void ascon_permutation_12(uint64_t *x0, uint64_t *x1, uint64_t *x2,
                                  uint64_t *x3, uint64_t *x4) {
    const uint8_t RC[12] = {0xf0,0xe1,0xd2,0xc3,0xb4,0xa5,0x96,0x87,0x78,0x69,0x5a,0x4b};
    for (int r = 0; r < 12; r++) {
        /* S-box */
        *x0 ^= *x4; *x4 ^= *x3; *x2 ^= *x1;
        uint64_t t0 = *x0, t1 = *x1, t2 = *x2, t3 = *x3, t4 = *x4;
        *x0 ^= (~t1 & t2);
        *x1 ^= (~t2 & t3);
        *x2 ^= (~t3 & t4);
        *x3 ^= (~t4 & t0);
        *x4 ^= (~t0 & t1);
        *x2 = ~*x2; *x4 = ~*x4;
        *x1 ^= *x0; *x0 ^= *x4; *x3 ^= *x2;

        /* Linear diffusion */
        *x0 ^= ascon_rotr(*x0, 19) ^ ascon_rotr(*x0, 28);
        *x1 ^= ascon_rotr(*x1, 61) ^ ascon_rotr(*x1, 39);
        *x2 ^= ascon_rotr(*x2, 1) ^ ascon_rotr(*x2, 6);
        *x3 ^= ascon_rotr(*x3, 10) ^ ascon_rotr(*x3, 17);
        *x4 ^= ascon_rotr(*x4, 7) ^ ascon_rotr(*x4, 41);

        /* Constant */
        *x2 ^= RC[r];
    }
}


/* ---- TinyJAMBU-128: state_update<1024> FBK_32 ---- */
static void tinyjambu_state_update_1024(uint32_t s[4], const uint32_t key[4]) {
    for (int i = 0; i < 32; i++) {
        uint32_t s47 = (s[2] << 17) | (s[1] >> 15);
        uint32_t s70 = (s[3] << 26) | (s[2] >> 6);
        uint32_t s85 = (s[3] << 11) | (s[2] >> 21);
        uint32_t s91 = (s[3] << 5) | (s[2] >> 27);
        uint32_t fbk = s[0] ^ s47 ^ (~(s70 & s85)) ^ s91 ^ key[i & 3];
        s[0] = s[1]; s[1] = s[2]; s[2] = s[3]; s[3] = fbk;
    }
}


/* ---- Benchmark harness ---- */
static double now_ns(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return ts.tv_sec * 1e9 + ts.tv_nsec;
}

int main(void) {
    double t0, t1;
    volatile uint64_t sink = 0; /* prevent dead-code elimination */

    /* ---- AES-128 benchmark ---- */
    {
        uint8_t key[16] = {0};
        uint8_t rk[176];
        uint8_t state[16] = {0};
        /* Simple key expansion (just copy key 11 times for testing) */
        for (int i = 0; i < 176; i++) rk[i] = (uint8_t)(i * 7 + 13);

        t0 = now_ns();
        for (int n = 0; n < ITERATIONS; n++) {
            memcpy(state, rk, 16); /* reset state */
            state[0] ^= (n & 0xFF);
            aes_encrypt_block(state, rk);
            sink ^= state[0];
        }
        t1 = now_ns();
        printf("AES-128 enc_block  | %8d iter | %10.1f ns/op\n", ITERATIONS, (t1-t0)/ITERATIONS);
    }

    /* ---- ASCON-128 benchmark ---- */
    {
        uint64_t x0 = 0x80400c0600000000ULL, x1 = 0, x2 = 0, x3 = 0, x4 = 0;
        t0 = now_ns();
        for (int n = 0; n < ITERATIONS; n++) {
            x0 = 0x80400c0600000000ULL ^ (n & 0xFF);
            x1 = x2 = x3 = x4 = (uint64_t)n;
            ascon_permutation_12(&x0, &x1, &x2, &x3, &x4);
            sink ^= x0;
        }
        t1 = now_ns();
        printf("ASCON permute 12   | %8d iter | %10.1f ns/op\n", ITERATIONS, (t1-t0)/ITERATIONS);
    }

    /* ---- TinyJAMBU-128 benchmark ---- */
    {
        uint32_t state[4] = {0};
        uint32_t key[4] = {0x01234567, 0x89ABCDEF, 0x01234567, 0x89ABCDEF};
        t0 = now_ns();
        for (int n = 0; n < ITERATIONS; n++) {
            state[0] = n; state[1] = n+1; state[2] = n+2; state[3] = n+3;
            tinyjambu_state_update_1024(state, key);
            sink ^= state[0];
        }
        t1 = now_ns();
        printf("TinyJAMBU upd 1024 | %8d iter | %10.1f ns/op\n", ITERATIONS, (t1-t0)/ITERATIONS);
    }

    printf("\nsink=%llu (prevent DCE)\n", (unsigned long long)sink);
    return 0;
}
