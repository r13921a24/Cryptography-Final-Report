"""
Results Visualization — Experiment 7.

Generates all comparison charts for the final report:
1. Throughput comparison bar charts
2. Initialization cost stacked bars
3. Throughput vs Payload convergence curves
4. Memory footprint comparison
5. Code size comparison
6. Energy consumption comparison
7. Radar chart (6-dimension comparison)
8. Deployment decision matrix
"""

import os
import json
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import numpy as np


# Color scheme
COLORS = {
    'AES-128-GCM': '#E74C3C',      # Red - traditional standard
    'ASCON-128': '#2ECC71',         # Green - NIST LWC winner
    'TinyJAMBU-128': '#3498DB',     # Blue - memory champion
}

RESULTS_BASE = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'results_pure')


def load_json(path):
    """Load JSON file if it exists."""
    if os.path.exists(path):
        with open(path) as f:
            return json.load(f)
    return None


def set_style():
    """Configure matplotlib style."""
    plt.rcParams.update({
        'figure.dpi': 150,
        'savefig.dpi': 300,
        'savefig.bbox': 'tight',
        'font.size': 10,
        'axes.titlesize': 14,
        'axes.labelsize': 12,
    })


def plot_throughput_comparison():
    """Single line chart: Throughput (KB/s) vs Payload Size for all algorithms."""
    results = load_json(os.path.join(RESULTS_BASE, 'experiment2_throughput', 'throughput_results.json'))
    if not results:
        print("No throughput results found. Run benchmark first.")
        return

    set_style()
    fig, ax = plt.subplots(figsize=(12, 7))

    payload_sizes = sorted(set(r['pt_size'] for r in next(iter(results.values()))))

    for algo_name in results:
        data = [r for r in results[algo_name] if r['ad_size'] == 8]
        data.sort(key=lambda x: x['pt_size'])
        throughputs = [r['enc_throughput_kbps'] for r in data]

        color = COLORS.get(algo_name, '#999')
        marker = 's' if 'AES' in algo_name else ('o' if 'ASCON' in algo_name else '^')
        ax.plot(payload_sizes, throughputs, marker=marker, linestyle='-', label=algo_name,
                color=color, linewidth=2.5, markersize=10, markeredgewidth=0.5,
                markeredgecolor='white')

        # Value labels at each point
        for x, y in zip(payload_sizes, throughputs):
            offset = max(throughputs) * 0.03
            ax.annotate(f'{y:.0f}', (x, y), textcoords="offset points",
                       xytext=(0, 12), ha='center', fontsize=9, fontweight='bold', color=color)

    ax.set_xlabel('Payload Size (bytes)', fontsize=13)
    ax.set_ylabel('Encryption Throughput (KB/s)', fontsize=13)
    ax.set_title('Encryption Throughput vs. Payload Size (AD = 8 bytes, all Pure-Python)', fontsize=14, fontweight='bold')
    ax.legend(fontsize=12, loc='lower right')
    ax.grid(True, alpha=0.3, linestyle='--')
    ax.set_xlim(0, 540)

    plt.tight_layout()
    fig.savefig(os.path.join(RESULTS_BASE, 'experiment7_combined', 'throughput_comparison.png'), dpi=300)
    plt.close(fig)
    print("  [OK] Throughput comparison chart saved (single line chart)")


def plot_init_cost():
    """Stacked bar chart: Initialization vs Data Processing time."""
    results = load_json(os.path.join(RESULTS_BASE, 'experiment3_init', 'init_cost_results.json'))
    if not results:
        print("No init cost results found.")
        return

    set_style()
    fig, axes = plt.subplots(1, 3, figsize=(18, 6))

    pt_sizes = sorted(set(r['pt_size'] for r in next(iter(results.values()))))

    for idx, algo_name in enumerate(results):
        ax = axes[idx]
        algo_results = results[algo_name]

        # Filter for AD=8
        data = [r for r in algo_results if r['ad_size'] == 8]

        init_times = [r['init_us'] for r in data]
        data_times = [r['enc_total_us'] - r['init_us'] for r in data]

        x = range(len(pt_sizes))
        ax.bar(x, init_times, label='Initialization', color=COLORS.get(algo_name, '#999'), alpha=0.7)
        ax.bar(x, data_times, bottom=init_times, label='Data Processing',
               color=COLORS.get(algo_name, '#999'), alpha=0.3)

        ax.set_title(algo_name)
        ax.set_xlabel('Payload Size (bytes)')
        ax.set_ylabel('Time (us)')
        ax.set_xticks(x)
        ax.set_xticklabels(pt_sizes)
        ax.legend(fontsize=8)

    fig.suptitle('Initialization Cost vs Data Processing Time (AD=8 bytes)', fontsize=14, fontweight='bold')
    plt.tight_layout()
    fig.savefig(os.path.join(RESULTS_BASE, 'experiment7_combined', 'init_cost_stacked.png'))
    plt.close(fig)
    print("  [OK] Init cost chart saved")


def plot_throughput_curve():
    """Line chart: Throughput vs Payload Size (convergence curve)."""
    results = load_json(os.path.join(RESULTS_BASE, 'experiment2_throughput', 'throughput_results.json'))
    if not results:
        return

    set_style()
    fig, ax = plt.subplots(figsize=(10, 6))

    pt_sizes = sorted(set(r['pt_size'] for r in next(iter(results.values()))))

    for algo_name in results:
        data = [r for r in results[algo_name] if r['ad_size'] == 8]
        data.sort(key=lambda x: x['pt_size'])
        throughputs = [r['enc_throughput_kbps'] for r in data]
        ax.plot(pt_sizes, throughputs, 'o-', label=algo_name,
                color=COLORS.get(algo_name, '#999'), linewidth=2, markersize=8)

    ax.set_xlabel('Payload Size (bytes)')
    ax.set_ylabel('Throughput (KB/s)')
    ax.set_title('Throughput vs Payload Size (Convergence Curve)')
    ax.legend()
    ax.grid(True, alpha=0.3)
    ax.set_xscale('log', base=2)
    ax.xaxis.set_major_formatter(ticker.ScalarFormatter())

    fig.savefig(os.path.join(RESULTS_BASE, 'experiment7_combined', 'throughput_curve.png'))
    plt.close(fig)
    print("  [OK] Throughput convergence curve saved")


def plot_memory_comparison():
    """Bar chart: Memory footprint comparison."""
    analysis = load_json(os.path.join(RESULTS_BASE, 'experiment4_memory', 'memory_analysis.json'))
    if not analysis:
        return

    set_style()
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 6))

    algos = ['AES-128-GCM', 'ASCON-128', 'TinyJAMBU-128']

    # State size
    state_bits = [analysis[a]['internal_state_bits'] for a in algos]
    colors = [COLORS.get(a, '#999') for a in algos]
    ax1.bar(algos, state_bits, color=colors, edgecolor='white')
    ax1.set_title('Internal State Size (bits)')
    ax1.set_ylabel('Bits')
    ax1.tick_params(axis='x', rotation=15)
    for bar, val in zip(ax1.patches, state_bits):
        ax1.text(bar.get_x() + bar.get_width()/2., bar.get_height() + 10,
                str(val), ha='center', fontsize=10, fontweight='bold')

    # Lookup tables
    table_bytes = [analysis[a]['lookup_tables_bytes'] for a in algos]
    ax2.bar(algos, table_bytes, color=colors, edgecolor='white')
    ax2.set_title('Lookup Table Size (bytes)')
    ax2.set_ylabel('Bytes')
    ax2.tick_params(axis='x', rotation=15)
    ax2.set_yscale('symlog')
    for bar, val in zip(ax2.patches, table_bytes):
        label = f'{val:,}' if val > 0 else '0 (no tables)'
        ax2.text(bar.get_x() + bar.get_width()/2., bar.get_height() + max(1, val*0.05),
                label, ha='center', fontsize=9, fontweight='bold')

    fig.suptitle('Memory Footprint Comparison', fontsize=14, fontweight='bold')
    plt.tight_layout()
    fig.savefig(os.path.join(RESULTS_BASE, 'experiment7_combined', 'memory_comparison.png'))
    plt.close(fig)
    print("  [OK] Memory comparison chart saved")


def plot_code_size():
    """Bar chart: Code size comparison."""
    combined = load_json(os.path.join(RESULTS_BASE, 'experiment5_codesize', 'code_size_results.json'))
    if not combined:
        return

    code_data = combined.get('source_code_analysis', {})
    if not code_data:
        return

    set_style()
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 6))

    algos = ['AES-128-GCM', 'ASCON-128', 'TinyJAMBU-128']
    colors = [COLORS.get(a, '#999') for a in algos]

    # SLOC
    sloc_vals = [code_data[a]['sloc'] for a in algos]
    ax1.bar(algos, sloc_vals, color=colors, edgecolor='white')
    ax1.set_title('Source Lines of Code (SLOC)')
    ax1.set_ylabel('Lines')
    ax1.tick_params(axis='x', rotation=15)
    for bar, val in zip(ax1.patches, sloc_vals):
        ax1.text(bar.get_x() + bar.get_width()/2., bar.get_height() + 2,
                str(val), ha='center', fontweight='bold')

    # File size
    file_sizes = [code_data[a]['file_size_bytes'] for a in algos]
    ax2.bar(algos, file_sizes, color=colors, edgecolor='white')
    ax2.set_title('Source File Size (bytes)')
    ax2.set_ylabel('Bytes')
    ax2.tick_params(axis='x', rotation=15)
    for bar, val in zip(ax2.patches, file_sizes):
        ax2.text(bar.get_x() + bar.get_width()/2., bar.get_height() + val*0.02,
                f'{val:,}', ha='center', fontweight='bold')

    fig.suptitle('Code Size Comparison', fontsize=14, fontweight='bold')
    plt.tight_layout()
    fig.savefig(os.path.join(RESULTS_BASE, 'experiment7_combined', 'code_size_comparison.png'))
    plt.close(fig)
    print("  [OK] Code size chart saved")


def plot_energy_comparison():
    """Bar chart: Energy consumption comparison."""
    energy_data = load_json(os.path.join(RESULTS_BASE, 'experiment6_energy', 'energy_results.json'))
    if not energy_data:
        return

    set_style()
    mcus = ['ATmega328P (8-bit, 16MHz)', 'Cortex-M3 (32-bit, 84MHz)',
            'Cortex-M4 (32-bit, 64MHz)', 'ESP32 (32-bit, 240MHz)']
    mcu_short = ['ATmega328P', 'Cortex-M3', 'Cortex-M4', 'ESP32']

    fig, axes = plt.subplots(2, 2, figsize=(16, 12))
    axes = axes.flatten()

    for idx, (mcu_name, mcu_short_name) in enumerate(zip(mcus, mcu_short)):
        ax = axes[idx]

        pt_size = 16  # Focus on short packet
        algos = []
        energies = []
        bar_colors = []

        for algo_name in energy_data:
            for r in energy_data[algo_name]:
                if r['pt_size'] == pt_size:
                    algos.append(algo_name)
                    mcu_data = r['mcu_energy'].get(mcu_name, {})
                    energies.append(mcu_data.get('enc_energy_uj', 0))
                    bar_colors.append(COLORS.get(algo_name, '#999'))
                    break

        ax.bar(algos, energies, color=bar_colors, edgecolor='white')
        ax.set_title(f'{mcu_short_name} ({pt_size}B payload)')
        ax.set_ylabel('Energy (uJ)')
        ax.tick_params(axis='x', rotation=15)

        for bar, val in zip(ax.patches, energies):
            ax.text(bar.get_x() + bar.get_width()/2., bar.get_height() + max(energies)*0.02,
                    f'{val:.3f}', ha='center', fontsize=8)

    fig.suptitle('Energy Consumption per Encryption (16-byte payload)', fontsize=14, fontweight='bold')
    plt.tight_layout()
    fig.savefig(os.path.join(RESULTS_BASE, 'experiment7_combined', 'energy_comparison.png'))
    plt.close(fig)
    print("  [OK] Energy comparison chart saved")


def plot_radar_chart():
    """Radar chart: 6-dimension comparison."""
    # Manually compiled from all experiments
    # Higher = better for all dimensions (normalized 0-10)
    categories = ['Throughput\n(128B)', 'Init Speed\n(lower=better)', 'RAM\n(lower=better)',
                   'ROM/Code\n(lower=better)', 'Energy\n(lower=better)', 'Security\nMargin']

    # Normalized scores (0-10, higher is better)
    scores = {
        'AES-128-GCM': [2.0, 2.0, 2.0, 1.0, 2.0, 7.0],
        'ASCON-128':    [9.0, 9.0, 8.0, 8.0, 9.0, 10.0],
        'TinyJAMBU-128':[6.0, 4.0, 10.0, 10.0, 7.0, 8.0],
    }

    set_style()
    N = len(categories)
    angles = [n / float(N) * 2 * np.pi for n in range(N)]
    angles += angles[:1]

    fig, ax = plt.subplots(figsize=(10, 10), subplot_kw=dict(polar=True))

    for algo_name, values in scores.items():
        values_plot = values + values[:1]
        ax.plot(angles, values_plot, 'o-', linewidth=2, label=algo_name,
                color=COLORS.get(algo_name, '#999'), markersize=8)
        ax.fill(angles, values_plot, alpha=0.1, color=COLORS.get(algo_name, '#999'))

    ax.set_xticks(angles[:-1])
    ax.set_xticklabels(categories, fontsize=10)
    ax.set_ylim(0, 10)
    ax.set_yticks([2, 4, 6, 8, 10])
    ax.set_yticklabels(['2', '4', '6', '8', '10'])
    ax.legend(loc='upper right', bbox_to_anchor=(1.3, 1.1))
    ax.set_title('6-Dimension Algorithm Comparison\n(10 = Best)', fontsize=14, fontweight='bold', pad=20)

    fig.savefig(os.path.join(RESULTS_BASE, 'experiment7_combined', 'radar_chart.png'))
    plt.close(fig)
    print("  [OK] Radar chart saved")


def generate_decision_matrix():
    """Generate deployment decision matrix."""
    matrix_text = """
DEPLOYMENT DECISION MATRIX
===========================
Based on NIST IR 8454 framework and experimental results

┌─────────────────────────────┬──────────────────┬───────────────────┬────────────────────┐
│ Edge Hardware Profile       │ Recommended      │ Rationale         │ Key Metrics        │
├─────────────────────────────┼──────────────────┼───────────────────┼────────────────────┤
│ High-end Gateway            │ AES-128-GCM      │ Hardware AES-NI   │ Throughput: High   │
│ (Cortex-A, x86, AES-NI)     │ (maintain)       │ acceleration      │ Energy: Low (HW)   │
│                             │                  │ Legacy compat.    │ RAM: Not limiting  │
├─────────────────────────────┼──────────────────┼───────────────────┼────────────────────┤
│ Mainstream IoT MCU          │ ASCON-128        │ NIST SP 800-232   │ Throughput: Best   │
│ (Cortex-M0/M3/M4, RISC-V)   │ (MIGRATE)        │ official standard │ RAM: ~40-80B       │
│ 10s KB SRAM, pure software  │                  │ No lookup tables  │ ROM: ~1-2KB        │
│                             │                  │ Little-endian     │ Energy: Lowest     │
├─────────────────────────────┼──────────────────┼───────────────────┼────────────────────┤
│ Extreme Constrained Node    │ TinyJAMBU-128 v2 │ 128-bit state     │ Throughput: Good   │
│ (8-bit AVR, RFID, <4KB SRAM)│ (ADOPT)          │ 117B RAM on AVR   │ RAM: ~16-32B       │
│ Energy harvesting sensors   │                  │ 640-round v2      │ ROM: ~500-1000B    │
│                             │                  │ NAND-only logic   │ Init: 1024 rounds  │
└─────────────────────────────┴──────────────────┴───────────────────┴────────────────────┘

KEY FINDINGS:
1. ASCON-128 achieves the best overall balance across all metrics
2. AES-128-GCM is only competitive with hardware acceleration
3. TinyJAMBU-128 dominates in memory-constrained scenarios
4. For short packets (16-32B), ASCON's low init cost gives 3-5x advantage over AES-GCM
5. ASCON's bit-sliced S-box eliminates cache-timing side-channel vulnerability

REFERENCE:
- NIST SP 800-232: Ascon-Based Lightweight Cryptography Standards
- NIST IR 8454: Status Report on the Final Round of NIST LWC Standardization
"""
    results_dir = os.path.join(RESULTS_BASE, 'experiment7_combined')
    os.makedirs(results_dir, exist_ok=True)

    with open(os.path.join(results_dir, 'decision_matrix.txt'), 'w') as f:
        f.write(matrix_text)

    print(matrix_text)
    print("  [OK] Decision matrix saved")


def run_visualization():
    """Generate all visualizations."""
    output_dir = os.path.join(RESULTS_BASE, 'experiment7_combined')
    os.makedirs(output_dir, exist_ok=True)

    print("=" * 80)
    print("EXPERIMENT 7: Combined Visualization & Charts")
    print("=" * 80)
    print()

    plot_throughput_comparison()
    plot_init_cost()
    plot_throughput_curve()
    plot_memory_comparison()
    plot_code_size()
    plot_energy_comparison()
    plot_radar_chart()
    generate_decision_matrix()

    print()
    print("All visualizations generated in:", output_dir)


if __name__ == '__main__':
    run_visualization()
