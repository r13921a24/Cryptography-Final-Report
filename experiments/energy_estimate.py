"""
Energy Consumption Estimation — Experiment 6.

Estimates energy consumption for each algorithm on IoT microcontrollers
using timing data from the benchmark (Experiment 2) and typical MCU power
characteristics from datasheets.

Models:
  - ATmega328P @ 16MHz: ~1.8mA active @ 3.3V = ~5.94mW
  - ARM Cortex-M3 @ 84MHz: ~0.4mW/MHz = ~33.6mW active
  - ARM Cortex-M4 @ 64MHz: ~0.4mW/MHz = ~25.6mW active
  - ESP32 @ 240MHz: ~68mA @ 3.3V = ~224mW active

Methodology:
  Energy (uJ) = Power (mW) × Time (us) / 1000
"""

import os
import json
import time
from aes_gcm_pure import AES128GCM
from ascon_aead import ascon_aead128_encrypt, ascon_aead128_decrypt, get_init_time_probe
from tinyjambu import TinyJAMBU128


# MCU Power Models (from datasheets and NIST IR 8454)
MCU_POWER_MODELS = {
    'ATmega328P (8-bit, 16MHz)': {
        'power_mw': 5.94,  # 1.8mA @ 3.3V
        'clock_mhz': 16,
        'description': '8-bit AVR, 2KB SRAM, 32KB Flash',
    },
    'Cortex-M3 (32-bit, 84MHz)': {
        'power_mw': 33.6,  # ~0.4mW/MHz
        'clock_mhz': 84,
        'description': 'ARM Cortex-M3, 96KB SRAM, 512KB Flash (AT91SAM3X8E)',
    },
    'Cortex-M4 (32-bit, 64MHz)': {
        'power_mw': 25.6,  # ~0.4mW/MHz
        'clock_mhz': 64,
        'description': 'ARM Cortex-M4, 256KB SRAM, 1MB Flash (nRF52840)',
    },
    'ESP32 (32-bit, 240MHz)': {
        'power_mw': 224.0,  # ~68mA @ 3.3V
        'clock_mhz': 240,
        'description': 'Xtensa LX6, 520KB SRAM, 4MB Flash',
    },
}

# Algorithm security level (bits) for combined analysis
SECURITY_LEVELS = {
    'AES-128-GCM': 128,
    'ASCON-128': 128,
    'TinyJAMBU-128': 112,  # 112-bit confidentiality, 64-bit integrity
}


def estimate_energy(mean_time_us, power_mw):
    """Estimate energy consumption in microjoules."""
    return mean_time_us * power_mw / 1000.0  # uJ = us * mW / 1000


def run_energy_estimation():
    """Experiment 6: Energy consumption estimation."""
    results_dir = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                                'results_pure', 'experiment6_energy')
    os.makedirs(results_dir, exist_ok=True)

    # Load throughput benchmark results or run quick benchmark
    from benchmark import BENCHMARKS, PAYLOAD_SIZES, AD_SIZES
    from benchmark import KEY, NONCE_AES, NONCE_ASCON, NONCE_TJ, ITERATIONS, WARMUP_ITERATIONS, _measure

    print("=" * 80)
    print("EXPERIMENT 6: Energy Consumption Estimation")
    print("=" * 80)

    # Quick timing measurement for each algorithm at each payload size
    energy_results = {}

    for algo_name, bench_fn in BENCHMARKS.items():
        print(f"\n--- {algo_name} ---")
        algo_energy = []

        ad = bytes(8)  # Fixed 8-byte AD
        for pt_size in PAYLOAD_SIZES:
            pt = bytes(pt_size)

            enc_times, dec_times, _ = bench_fn(ad, pt)

            # Estimate energy for each MCU
            mcu_energy = {}
            for mcu_name, mcu_info in MCU_POWER_MODELS.items():
                enc_energy = estimate_energy(enc_times['mean_us'], mcu_info['power_mw'])
                dec_energy = estimate_energy(dec_times['mean_us'], mcu_info['power_mw'])
                mcu_energy[mcu_name] = {
                    'enc_energy_uj': enc_energy,
                    'dec_energy_uj': dec_energy,
                    'enc_energy_nj_per_byte': (enc_energy * 1000) / pt_size if pt_size > 0 else 0,
                }

            result = {
                'ad_size': 8,
                'pt_size': pt_size,
                'enc_time_us': enc_times['mean_us'],
                'mcu_energy': mcu_energy,
            }
            algo_energy.append(result)

            # Print summary for Cortex-M3
            cm3 = mcu_energy.get('Cortex-M3 (32-bit, 84MHz)', {})
            print(f"  PT={pt_size:3d}: enc_time={enc_times['mean_us']:8.2f}us, "
                  f"Cortex-M3 enc_energy={cm3.get('enc_energy_uj', 0):.2f}uJ")

        energy_results[algo_name] = algo_energy

    # Save results
    with open(os.path.join(results_dir, 'energy_results.json'), 'w') as f:
        json.dump(energy_results, f, indent=2)

    # Generate report
    _generate_energy_report(energy_results, results_dir)

    return energy_results


def _generate_energy_report(energy_results, results_dir):
    """Generate energy consumption comparison report."""
    report = []
    report.append("Energy Consumption Estimation Report")
    report.append("=" * 80)
    report.append("")
    report.append("Methodology: Energy (uJ) = MCU Active Power (mW) × Time (us) / 1000")
    report.append("")

    # Per-MCU tables
    for mcu_name, mcu_info in MCU_POWER_MODELS.items():
        report.append(f"--- {mcu_name} ---")
        report.append(f"  Power: {mcu_info['power_mw']} mW, Clock: {mcu_info['clock_mhz']} MHz")
        report.append(f"  {mcu_info['description']}")
        report.append("")

        header = f"{'Payload':>10}"
        for algo in energy_results:
            header += f" {algo:>18} {'':>10}"
        report.append(header)

        header2 = f"{'Bytes':>10}"
        for algo in energy_results:
            header2 += f" {'Enc(uJ)':>10} {'Dec(uJ)':>10} {'nJ/B':>8}"
        report.append(header2)
        report.append("-" * 80)

        pt_sizes = sorted(set(r['pt_size'] for r in next(iter(energy_results.values()))))

        for pt_size in pt_sizes:
            row = f"{pt_size:>10}"
            for algo_name in energy_results:
                for r in energy_results[algo_name]:
                    if r['pt_size'] == pt_size:
                        mcu_data = r['mcu_energy'].get(mcu_name, {})
                        enc = mcu_data.get('enc_energy_uj', 0)
                        dec = mcu_data.get('dec_energy_uj', 0)
                        njpb = mcu_data.get('enc_energy_nj_per_byte', 0)
                        row += f" {enc:10.3f} {dec:10.3f} {njpb:8.1f}"
                        break
                else:
                    row += f" {'N/A':>10} {'N/A':>10} {'N/A':>8}"
            report.append(row)

        report.append("")

    # Energy efficiency comparison (16-byte payload on Cortex-M3)
    report.append("")
    report.append("Energy Efficiency Comparison (16-byte payload, Cortex-M3)")
    report.append("-" * 60)

    for algo_name in energy_results:
        for r in energy_results[algo_name]:
            if r['pt_size'] == 16:
                cm3 = r['mcu_energy'].get('Cortex-M3 (32-bit, 84MHz)', {})
                enc_uj = cm3.get('enc_energy_uj', 0)
                # Bits processed per uJ
                bits_per_uj = (16 * 8) / enc_uj if enc_uj > 0 else 0
                report.append(f"  {algo_name}: {enc_uj:.3f} uJ/encrypt, {bits_per_uj:.1f} bits/uJ")
                break

    report_text = '\n'.join(report)
    print("\n" + report_text)

    with open(os.path.join(results_dir, 'energy_report.txt'), 'w') as f:
        f.write(report_text)


if __name__ == '__main__':
    run_energy_estimation()
