# Cryptography Final Report: IoT AEAD Performance Comparison

**A Comprehensive Performance Evaluation of AES-128-GCM, Ascon-AEAD128, and TinyJAMBU-128 for Resource-Constrained IoT Devices**

Course: Cryptography | Student: r13921a24 | June 2026

## Repository Structure

```
├── experiments/                      # Pure Python implementations + benchmark suite
│   ├── aes_gcm_pure.py              # AES-128-GCM (pure Python, no HW acceleration)
│   ├── ascon_aead.py                # Ascon-AEAD128 (NIST SP 800-232, little-endian)
│   ├── tinyjambu.py                 # TinyJAMBU-128 v2 (FBK_32 optimized)
│   ├── benchmark.py                 # Throughput + init cost benchmark (Exp 2-3)
│   ├── kat_verify.py                # Known Answer Test verification (Exp 1)
│   ├── memory_profile.py            # Memory footprint analysis (Exp 4)
│   ├── code_size.py                 # Code size analysis (Exp 5)
│   ├── energy_estimate.py           # Energy consumption estimation (Exp 6)
│   ├── visualize.py                 # Chart generation (Exp 7)
│   └── run_all.py                   # Master runner
├── c_bench/                          # C compiler bias evidence
│   ├── bench.c                      # Main benchmark (x86_64, all opt levels)
│   ├── bench_edge.c                 # Integer-timing variant (no SSE dependency)
│   ├── bench_nosimd.c              # SIMD-disabled variant
│   ├── bench_O0.s                   # Assembly listing at -O0
│   └── bench_O3.s                   # Assembly listing at -O3 (shows SSE auto-vec)
├── results_pure/                    # All experiment outputs (pure-software fair comparison)
│   ├── experiment1_kat/             # Known Answer Test results
│   ├── experiment2_throughput/      # Throughput benchmark data
│   ├── experiment3_init/            # Initialization cost analysis
│   ├── experiment4_memory/          # Memory footprint estimates
│   ├── experiment5_codesize/        # Code size metrics
│   ├── experiment6_energy/          # Energy consumption estimates
│   └── experiment7_combined/        # Comparison charts + decision matrix
└── .gitignore
```

## Quick Start

```bash
pip install cryptography matplotlib numpy
cd experiments && python3 run_all.py
# Results will appear in ../results_pure/
```

## Key Findings

At identical pure-software abstraction levels:

| Metric | AES-128-GCM | ASCON-128 | TinyJAMBU-128 |
|--------|-------------|-----------|---------------|
| Throughput @ 16B | 27.3 KB/s | **164.8 KB/s** | 93.6 KB/s |
| Throughput @ 512B | 75.7 KB/s | **599.5 KB/s** | 210.9 KB/s |
| Energy @ 16B (Cortex-M3) | 19.9 μJ | **3.3 μJ** | 5.8 μJ |
| Internal State | 512+ bits | 320 bits | **128 bits** |
| Lookup Tables | 8,192 bytes | **0** | **0** |

ASCON-128 achieves 6.0× higher throughput and 6.1× better energy efficiency than pure-software AES-128-GCM.

## References

- NIST SP 800-232: Ascon-Based Lightweight Cryptography Standards (Aug 2025)
- NIST IR 8454: Status Report on the Final Round of NIST LWC Standardization (Jun 2023)
- TinyJAMBU v2 Specification (Wu & Huang, May 2021)
