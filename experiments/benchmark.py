"""
Main Benchmark Harness — Experiments 2 & 3.

Experiment 2: Throughput benchmarking
  - Payload sizes: 16, 32, 64, 128, 256, 512 bytes
  - AD sizes: 0, 8, 16 bytes
  - Measures encryption/decryption time, throughput (KB/s)

Experiment 3: Initialization cost analysis
  - Separates init / data processing / finalization phases
  - Shows initialization cost penalty for short packets
"""

import os
import json
import time
import statistics
from aes_gcm_pure import AES128GCM
from ascon_aead import ascon_aead128_encrypt, ascon_aead128_decrypt, get_init_time_probe
from tinyjambu import TinyJAMBU128


# === Configuration ===
PAYLOAD_SIZES = [16, 32, 64, 128, 256, 512]
AD_SIZES = [0, 8, 16]
ITERATIONS = 200
WARMUP_ITERATIONS = 20
KEY = bytes.fromhex('000102030405060708090a0b0c0d0e0f')
NONCE_AES = bytes.fromhex('000102030405060708090a0b')
NONCE_ASCON = bytes.fromhex('000102030405060708090a0b0c0d0e0f')
NONCE_TJ = bytes.fromhex('000102030405060708090a0b')


def _measure(func, iterations=ITERATIONS, warmup=WARMUP_ITERATIONS):
    """High-precision timing measurement."""
    # Warmup
    for _ in range(warmup):
        func()

    # Measurement
    times = []
    for _ in range(iterations):
        t0 = time.perf_counter_ns()
        func()
        t1 = time.perf_counter_ns()
        times.append((t1 - t0) / 1000.0)  # Convert ns to us

    return {
        'mean_us': statistics.mean(times),
        'median_us': statistics.median(times),
        'stdev_us': statistics.stdev(times) if len(times) > 1 else 0,
        'min_us': min(times),
        'max_us': max(times),
    }


def _bench_aes_gcm(ad, pt):
    """Benchmark AES-128-GCM."""
    aes = AES128GCM(KEY)

    enc_times = _measure(lambda: aes.encrypt(NONCE_AES, ad, pt))
    ct, tag = aes.encrypt(NONCE_AES, ad, pt)
    dec_times = _measure(lambda: aes.decrypt(NONCE_AES, ad, ct, tag))

    # Init cost
    init_times = _measure(lambda: aes.init_only(NONCE_AES))

    return enc_times, dec_times, init_times


def _bench_ascon(ad, pt):
    """Benchmark ASCON-128."""
    enc_times = _measure(lambda: ascon_aead128_encrypt(KEY, NONCE_ASCON, ad, pt))
    ct, tag = ascon_aead128_encrypt(KEY, NONCE_ASCON, ad, pt)
    dec_times = _measure(lambda: ascon_aead128_decrypt(KEY, NONCE_ASCON, ad, ct, tag))

    init_times = _measure(lambda: get_init_time_probe(KEY, NONCE_ASCON))

    return enc_times, dec_times, init_times


def _bench_tinyjambu(ad, pt):
    """Benchmark TinyJAMBU-128 v2."""
    tj = TinyJAMBU128(KEY)

    enc_times = _measure(lambda: tj.encrypt(NONCE_TJ, ad, pt))
    ct, tag = tj.encrypt(NONCE_TJ, ad, pt)
    dec_times = _measure(lambda: tj.decrypt(NONCE_TJ, ad, ct, tag))

    init_times = _measure(lambda: tj.init_only(NONCE_TJ))

    return enc_times, dec_times, init_times


BENCHMARKS = {
    'AES-128-GCM': _bench_aes_gcm,
    'ASCON-128': _bench_ascon,
    'TinyJAMBU-128': _bench_tinyjambu,
}


def run_throughput_benchmark():
    """Experiment 2: Throughput benchmark."""
    results_dir = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                                'results_pure', 'experiment2_throughput')
    os.makedirs(results_dir, exist_ok=True)

    print("=" * 80)
    print("EXPERIMENT 2: Throughput Benchmark")
    print("=" * 80)

    all_results = {}

    for algo_name, bench_fn in BENCHMARKS.items():
        print(f"\n--- {algo_name} ---")
        algo_results = []

        for ad_size in AD_SIZES:
            ad = bytes(ad_size)
            for pt_size in PAYLOAD_SIZES:
                pt = bytes(pt_size)

                enc_times, dec_times, init_times = bench_fn(ad, pt)

                # Calculate throughput (KB/s)
                enc_throughput = (pt_size / 1024) / (enc_times['mean_us'] / 1_000_000)
                dec_throughput = (pt_size / 1024) / (dec_times['mean_us'] / 1_000_000)

                result = {
                    'ad_size': ad_size,
                    'pt_size': pt_size,
                    'enc_mean_us': enc_times['mean_us'],
                    'enc_stdev_us': enc_times['stdev_us'],
                    'enc_throughput_kbps': enc_throughput,
                    'dec_mean_us': dec_times['mean_us'],
                    'dec_stdev_us': dec_times['stdev_us'],
                    'dec_throughput_kbps': dec_throughput,
                    'init_mean_us': init_times['mean_us'],
                }

                algo_results.append(result)

                print(f"  AD={ad_size:3d} PT={pt_size:3d}: "
                      f"enc={enc_times['mean_us']:8.2f}us "
                      f"dec={dec_times['mean_us']:8.2f}us "
                      f"tp_enc={enc_throughput:8.1f} KB/s")

        all_results[algo_name] = algo_results

    # Save results
    with open(os.path.join(results_dir, 'throughput_results.json'), 'w') as f:
        json.dump(all_results, f, indent=2)

    # Generate comparison table
    _generate_throughput_table(all_results, results_dir)

    return all_results


def _generate_throughput_table(results, results_dir):
    """Generate throughput comparison table."""
    lines = []
    lines.append("Throughput Comparison (KB/s)")
    lines.append("=" * 100)
    header = f"{'PT Size':>8} {'AD Size':>8}"
    for algo in results:
        header += f" {algo:>20}"
    lines.append(header)
    lines.append("-" * 100)

    for pt_size in PAYLOAD_SIZES:
        for ad_size in AD_SIZES:
            row = f"{pt_size:>8} {ad_size:>8}"
            for algo_name in results:
                for r in results[algo_name]:
                    if r['pt_size'] == pt_size and r['ad_size'] == ad_size:
                        row += f" {r['enc_throughput_kbps']:19.1f} "
                        break
                else:
                    row += f" {'N/A':>20}"
            lines.append(row)

    table = '\n'.join(lines)
    print("\n" + table)

    with open(os.path.join(results_dir, 'throughput_table.txt'), 'w') as f:
        f.write(table)


def run_init_cost_analysis():
    """Experiment 3: Initialization cost analysis."""
    results_dir = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                                'results_pure', 'experiment3_init')
    os.makedirs(results_dir, exist_ok=True)

    print("\n" + "=" * 80)
    print("EXPERIMENT 3: Initialization Cost Analysis")
    print("=" * 80)

    all_results = {}

    for algo_name, bench_fn in BENCHMARKS.items():
        print(f"\n--- {algo_name} ---")
        algo_results = []

        for ad_size in [0, 8, 16]:
            ad = bytes(ad_size)
            for pt_size in PAYLOAD_SIZES:
                pt = bytes(pt_size)

                enc_times, dec_times, init_times = bench_fn(ad, pt)

                init_ratio_enc = (init_times['mean_us'] / enc_times['mean_us']) * 100
                init_ratio_dec = (init_times['mean_us'] / dec_times['mean_us']) * 100

                result = {
                    'ad_size': ad_size,
                    'pt_size': pt_size,
                    'enc_total_us': enc_times['mean_us'],
                    'init_us': init_times['mean_us'],
                    'init_ratio_enc_pct': init_ratio_enc,
                    'init_ratio_dec_pct': init_ratio_dec,
                }
                algo_results.append(result)

                print(f"  AD={ad_size:3d} PT={pt_size:3d}: "
                      f"init={init_times['mean_us']:8.2f}us "
                      f"({init_ratio_enc:5.1f}% of encrypt)")

        all_results[algo_name] = algo_results

    with open(os.path.join(results_dir, 'init_cost_results.json'), 'w') as f:
        json.dump(all_results, f, indent=2)

    return all_results


def run_benchmarks():
    """Run both Experiment 2 and Experiment 3."""
    print("Starting benchmark suite...")
    print(f"Payload sizes: {PAYLOAD_SIZES}")
    print(f"AD sizes: {AD_SIZES}")
    print(f"Iterations per test: {ITERATIONS}")

    throughput = run_throughput_benchmark()
    init_cost = run_init_cost_analysis()

    print("\n" + "=" * 80)
    print("ALL BENCHMARKS COMPLETE")
    print("=" * 80)

    return throughput, init_cost


if __name__ == '__main__':
    run_benchmarks()
