#!/usr/bin/env python3
"""
Master Runner — Execute all experiments in sequence.

Usage:
    python3 run_all.py          # Run all experiments
    python3 run_all.py --skip-viz  # Skip visualization
"""

import os
import sys
import time
import traceback


EXPERIMENTS_DIR = os.path.dirname(os.path.abspath(__file__))
RESULTS_DIR = os.path.join(os.path.dirname(EXPERIMENTS_DIR), 'results_pure')


def run_experiment(name, module_name, func_name='run_benchmarks', **kwargs):
    """Run a single experiment with timing and error handling."""
    print("\n" + "#" * 80)
    print(f"# RUNNING: {name}")
    print("#" * 80)

    start = time.time()
    try:
        # Import and run
        module = __import__(module_name)
        if func_name:
            func = getattr(module, func_name)
            result = func(**kwargs)
        else:
            result = None
        elapsed = time.time() - start
        print(f"\n[PASS] {name} completed in {elapsed:.1f}s")
        return result
    except Exception as e:
        elapsed = time.time() - start
        print(f"\n[FAIL] {name} failed after {elapsed:.1f}s: {e}")
        traceback.print_exc()
        return None


def main():
    skip_viz = '--skip-viz' in sys.argv

    # Ensure results directories exist
    for exp_num in range(1, 8):
        exp_dir = os.path.join(RESULTS_DIR, f'experiment{exp_num}')
        prefix = 'kat' if exp_num == 1 else (
            'throughput' if exp_num == 2 else (
            'init' if exp_num == 3 else (
            'memory' if exp_num == 4 else (
            'codesize' if exp_num == 5 else (
            'energy' if exp_num == 6 else 'combined'
        )))))
        os.makedirs(os.path.join(RESULTS_DIR, f'experiment{exp_num}_{prefix}'), exist_ok=True)

    print("=" * 80)
    print("IoT CRYPTOGRAPHY PERFORMANCE COMPARISON")
    print("AES-128-GCM vs ASCON-128 vs TinyJAMBU-128 (v2)")
    print("=" * 80)
    print(f"Start time: {time.strftime('%Y-%m-%d %H:%M:%S')}")
    print(f"Results directory: {RESULTS_DIR}")
    print()

    # Experiment 1: KAT Verification
    run_experiment(
        'Experiment 1: KAT Verification',
        'kat_verify',
        'run_kat',
    )

    # Experiment 2 & 3: Throughput + Init Cost
    run_experiment(
        'Experiment 2+3: Throughput Benchmark + Init Cost',
        'benchmark',
        'run_benchmarks',
    )

    # Experiment 4: Memory Footprint
    run_experiment(
        'Experiment 4: Memory Footprint',
        'memory_profile',
        'run_memory_profile',
    )

    # Experiment 5: Code Size
    run_experiment(
        'Experiment 5: Code Size Analysis',
        'code_size',
        'run_code_size_analysis',
    )

    # Experiment 6: Energy Estimation
    run_experiment(
        'Experiment 6: Energy Estimation',
        'energy_estimate',
        'run_energy_estimation',
    )

    # Experiment 7: Visualization
    if not skip_viz:
        run_experiment(
            'Experiment 7: Visualization',
            'visualize',
            'run_visualization',
        )
    else:
        print("\n[Skipping] Experiment 7: Visualization (--skip-viz)")

    print("\n" + "=" * 80)
    print("ALL EXPERIMENTS COMPLETE")
    print("=" * 80)
    print(f"End time: {time.strftime('%Y-%m-%d %H:%M:%S')}")
    print(f"Results saved to: {RESULTS_DIR}")
    print()
    print("Results directory structure:")
    for item in sorted(os.listdir(RESULTS_DIR)):
        item_path = os.path.join(RESULTS_DIR, item)
        if os.path.isdir(item_path):
            files = os.listdir(item_path)
            print(f"  {item}/ ({len(files)} files)")
            for f in sorted(files):
                size = os.path.getsize(os.path.join(item_path, f))
                print(f"    - {f} ({size:,} bytes)")


if __name__ == '__main__':
    os.chdir(EXPERIMENTS_DIR)
    main()
