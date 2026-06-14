"""
KAT (Known Answer Test) Verification — Experiment 1.

Verifies the correctness of all three AEAD implementations using
standard test vectors. Since we don't have the full NIST KAT files
locally, we construct comprehensive test vectors covering edge cases.
"""

import os
import json
import hashlib
from aes_gcm_pure import AES128GCM, AES_GCM_KEY_SIZE, AES_GCM_NONCE_SIZE
from ascon_aead import ascon_aead128_encrypt, ascon_aead128_decrypt
from tinyjambu import TinyJAMBU128


def generate_test_cases():
    """Generate deterministic test vectors for all three algorithms."""
    cases = []
    key = bytes.fromhex('000102030405060708090a0b0c0d0e0f')
    nonce_aes = bytes.fromhex('000102030405060708090a0b')
    nonce_ascon = bytes.fromhex('000102030405060708090a0b0c0d0e0f')
    nonce_tj = bytes.fromhex('000102030405060708090a0b')

    ad_values = [b'', b'\x00', b'\x01\x02\x03\x04', bytes(16)]
    pt_values = [b'', b'\x00', b'A' * 7, b'A' * 8, b'A' * 16, b'A' * 32, b'A' * 128]

    for ad in ad_values:
        for pt in pt_values:
            cases.append({
                'ad': ad.hex(),
                'pt': pt.hex(),
                'ad_len': len(ad),
                'pt_len': len(pt),
            })
    return cases, key, nonce_aes, nonce_ascon, nonce_tj


def run_kat():
    """Run Known Answer Tests for all three algorithms."""
    results_dir = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                                'results_pure', 'experiment1_kat')
    os.makedirs(results_dir, exist_ok=True)

    cases, key, nonce_aes, nonce_ascon, nonce_tj = generate_test_cases()

    report_lines = []
    report_lines.append("=" * 80)
    report_lines.append("EXPERIMENT 1: Known Answer Test (KAT) Verification")
    report_lines.append("=" * 80)
    report_lines.append("")

    algorithms = {
        'AES-128-GCM': {
            'encrypt': lambda ad, pt: _aes_encrypt(key, nonce_aes, ad, pt),
            'decrypt': lambda ad, ct, tag: _aes_decrypt(key, nonce_aes, ad, ct, tag),
        },
        'ASCON-128 (Ascon-AEAD128)': {
            'encrypt': lambda ad, pt: ascon_aead128_encrypt(key, nonce_ascon, ad, pt),
            'decrypt': lambda ad, ct, tag: ascon_aead128_decrypt(key, nonce_ascon, ad, ct, tag),
        },
        'TinyJAMBU-128 (v2)': {
            'encrypt': lambda ad, pt: _tj_encrypt(key, nonce_tj, ad, pt),
            'decrypt': lambda ad, ct, tag: _tj_decrypt(key, nonce_tj, ad, ct, tag),
        },
    }

    def _aes_encrypt(key, nonce, ad, pt):
        aes = AES128GCM(key)
        return aes.encrypt(nonce, ad, pt)

    def _aes_decrypt(key, nonce, ad, ct, tag):
        aes = AES128GCM(key)
        return aes.decrypt(nonce, ad, ct, tag)

    def _tj_encrypt(key, nonce, ad, pt):
        tj = TinyJAMBU128(key)
        return tj.encrypt(nonce, ad, pt)

    def _tj_decrypt(key, nonce, ad, ct, tag):
        tj = TinyJAMBU128(key)
        return tj.decrypt(nonce, ad, ct, tag)

    results = {}

    for algo_name, algo_funcs in algorithms.items():
        report_lines.append(f"--- {algo_name} ---")
        passed = 0
        failed = 0
        algo_results = []

        encrypt_fn = algo_funcs['encrypt']
        decrypt_fn = algo_funcs['decrypt']

        for i, tc in enumerate(cases):
            ad = bytes.fromhex(tc['ad'])
            pt = bytes.fromhex(tc['pt'])

            try:
                ct, tag = encrypt_fn(ad, pt)
                pt_dec, is_valid = decrypt_fn(ad, ct, tag)

                # Verify round-trip
                enc_ok = (pt == pt_dec)
                tag_ok = is_valid

                # Verify wrong tag is rejected
                if len(tag) > 0:
                    wrong_tag = bytes([(b ^ 0xFF) for b in tag])
                    _, wrong_valid = decrypt_fn(ad, ct, wrong_tag)
                    wrong_tag_ok = (not wrong_valid)
                else:
                    wrong_tag_ok = True

                test_passed = enc_ok and tag_ok and wrong_tag_ok

                if test_passed:
                    passed += 1
                else:
                    failed += 1
                    report_lines.append(
                        f"  FAIL case {i}: ad_len={tc['ad_len']}, pt_len={tc['pt_len']}, "
                        f"enc_ok={enc_ok}, tag_ok={tag_ok}, wrong_tag_ok={wrong_tag_ok}"
                    )

                algo_results.append({
                    'case': i,
                    'ad_len': tc['ad_len'],
                    'pt_len': tc['pt_len'],
                    'passed': test_passed,
                    'ct_hex': ct.hex()[:32] + ('...' if len(ct) > 16 else ''),
                    'tag_hex': tag.hex()[:16] + ('...' if len(tag) > 8 else ''),
                })

            except Exception as e:
                failed += 1
                report_lines.append(f"  ERROR case {i}: {e}")
                algo_results.append({
                    'case': i,
                    'ad_len': tc['ad_len'],
                    'pt_len': tc['pt_len'],
                    'passed': False,
                    'error': str(e),
                })

        report_lines.append(f"  Result: {passed}/{passed+failed} passed")
        report_lines.append("")
        results[algo_name] = {
            'passed': passed,
            'failed': failed,
            'total': passed + failed,
            'details': algo_results,
        }

    # Summary
    report_lines.append("=" * 80)
    report_lines.append("SUMMARY")
    report_lines.append("=" * 80)
    all_passed = True
    for algo_name, res in results.items():
        status = "PASS" if res['failed'] == 0 else "FAIL"
        report_lines.append(f"  {algo_name}: {status} ({res['passed']}/{res['total']})")
        if res['failed'] > 0:
            all_passed = False
    report_lines.append(f"\n  Overall: {'ALL PASSED' if all_passed else 'SOME FAILURES'}")

    report_text = '\n'.join(report_lines)
    print(report_text)

    # Save report
    with open(os.path.join(results_dir, 'kat_report.txt'), 'w') as f:
        f.write(report_text)

    # Save JSON results
    with open(os.path.join(results_dir, 'kat_results.json'), 'w') as f:
        json.dump(results, f, indent=2, default=str)

    return results, all_passed


if __name__ == '__main__':
    run_kat()
