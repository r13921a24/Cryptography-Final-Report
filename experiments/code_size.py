"""
Code & File Size Analysis — Experiment 5.

Measures:
- Source lines of code (SLOC)
- File sizes (.py, .pyc)
- Algorithm constant storage requirements
- ROM/Flash impact estimation for MCU deployment
"""

import os
import json
import subprocess
import sys
from pathlib import Path


def count_sloc(filepath):
    """Count source lines of code (excluding blanks and comments)."""
    with open(filepath, 'r') as f:
        lines = f.readlines()

    sloc = 0
    in_docstring = False
    for line in lines:
        stripped = line.strip()

        # Skip blank lines
        if not stripped:
            continue

        # Handle docstrings
        if stripped.startswith('"""') or stripped.startswith("'''"):
            if stripped.endswith('"""') or stripped.endswith("'''"):
                # Single-line docstring
                if len(stripped) >= 6:
                    continue
            else:
                in_docstring = not in_docstring
            continue

        if in_docstring:
            continue

        # Skip comment lines
        if stripped.startswith('#'):
            continue

        sloc += 1

    return sloc


def analyze_code_size():
    """Analyze source code and compiled sizes."""
    exp_dir = os.path.dirname(os.path.abspath(__file__))

    algorithm_files = {
        'AES-128-GCM': 'aes_gcm_pure.py',
        'ASCON-128': 'ascon_aead.py',
        'TinyJAMBU-128': 'tinyjambu.py',
    }

    analysis = {}

    for algo_name, filename in algorithm_files.items():
        filepath = os.path.join(exp_dir, filename)
        file_size = os.path.getsize(filepath)
        sloc = count_sloc(filepath)

        # Get total lines
        with open(filepath, 'r') as f:
            total_lines = len(f.readlines())

        # Try to compile and get .pyc size
        pyc_size = 0
        try:
            import py_compile
            pyc_path = filepath + 'c'
            py_compile.compile(filepath, cfile=pyc_path, doraise=True)
            if os.path.exists(pyc_path):
                pyc_size = os.path.getsize(pyc_path)
                os.remove(pyc_path)
        except Exception:
            pass

        analysis[algo_name] = {
            'filename': filename,
            'file_size_bytes': file_size,
            'sloc': sloc,
            'pyc_size_bytes': pyc_size,
        }

    return analysis


def estimate_rom_impact(analysis):
    """Estimate ROM/Flash requirements for MCU deployment."""
    rom_estimate = {
        'AES-128-GCM': {
            'core_algorithm_rom': '~2000-4000 bytes (AES encrypt/decrypt + GCM mode)',
            'lookup_tables': '~4096-8192 bytes (T-tables + S-box + GHASH tables)',
            'total_estimated_rom': '~6000-12000 bytes',
            'lines_of_c_code': '~500-1000 (optimized)',
            'nist_ir8454_ref': 'See NIST IR 8454 Appendix B, Figures 5-6',
        },
        'ASCON-128': {
            'core_algorithm_rom': '~1000-2000 bytes (permutation + AEAD mode)',
            'lookup_tables': '~16 bytes (round constants only)',
            'total_estimated_rom': '~1000-2000 bytes',
            'lines_of_c_code': '~200-400 (reference implementation)',
            'nist_ir8454_ref': 'Smallest among finalists on most platforms (IR 8454 Fig 5)',
        },
        'TinyJAMBU-128': {
            'core_algorithm_rom': '~500-1000 bytes (NLFSR update + AEAD mode)',
            'lookup_tables': '0 bytes (no tables)',
            'total_estimated_rom': '~500-1000 bytes',
            'lines_of_c_code': '~150-300 (reference implementation)',
            'nist_ir8454_ref': '117B RAM on AVR, ~600B flash (Watanabe et al.)',
        },
    }
    return rom_estimate


def run_code_size_analysis():
    """Experiment 5: Code/file size analysis."""
    results_dir = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                                'results_pure', 'experiment5_codesize')
    os.makedirs(results_dir, exist_ok=True)

    print("=" * 80)
    print("EXPERIMENT 5: Code & File Size Analysis")
    print("=" * 80)

    # Source code analysis
    code_analysis = analyze_code_size()
    rom_estimate = estimate_rom_impact(code_analysis)

    report = []
    report.append("Code Size Analysis")
    report.append("=" * 80)
    report.append("")

    report.append("Python Source Code Metrics")
    report.append("-" * 80)
    header = f"{'Algorithm':<20} {'File Size':>10} {'SLOC':>8} {'.pyc Size':>12}"
    report.append(header)
    report.append("-" * 80)

    for algo_name in ['AES-128-GCM', 'ASCON-128', 'TinyJAMBU-128']:
        info = code_analysis[algo_name]
        row = (f"{algo_name:<20} {info['file_size_bytes']:>10} "
               f"{info['sloc']:>8} "
               f"{info['pyc_size_bytes']:>12}")
        report.append(row)
        print(row)

    report.append("")
    report.append("Estimated MCU ROM/Flash Requirements")
    report.append("-" * 80)

    for algo_name in ['AES-128-GCM', 'ASCON-128', 'TinyJAMBU-128']:
        info = rom_estimate[algo_name]
        report.append(f"  {algo_name}:")
        for k, v in info.items():
            report.append(f"    {k}: {v}")
        report.append("")

    # Comparison
    report.append("")
    report.append("Code Size Comparison (Python SLOC)")
    report.append("-" * 40)
    max_sloc = max(info['sloc'] for info in code_analysis.values())
    for algo_name in ['ASCON-128', 'TinyJAMBU-128', 'AES-128-GCM']:
        info = code_analysis[algo_name]
        bar = '#' * int(50 * info['sloc'] / max_sloc)
        report.append(f"  {algo_name:<20} {bar} {info['sloc']} SLOC")
    report.append("")

    report_text = '\n'.join(report)
    print("\n" + report_text)

    with open(os.path.join(results_dir, 'code_size_report.txt'), 'w') as f:
        f.write(report_text)

    # Save JSON
    combined = {
        'source_code_analysis': code_analysis,
        'rom_estimates': rom_estimate,
    }
    with open(os.path.join(results_dir, 'code_size_results.json'), 'w') as f:
        json.dump(combined, f, indent=2)

    return combined


if __name__ == '__main__':
    run_code_size_analysis()
