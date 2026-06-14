	.file	"bench.c"
# GNU C17 (Ubuntu 13.3.0-6ubuntu2~24.04.1) version 13.3.0 (x86_64-linux-gnu)
#	compiled by GNU C version 13.3.0, GMP version 6.3.0, MPFR version 4.2.1, MPC version 1.3.1, isl version isl-0.26-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mtune=generic -march=x86-64 -O3 -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC13:
	.string	"AES-128 enc_block  | %8d iter | %10.1f ns/op\n"
	.align 8
.LC14:
	.string	"ASCON permute 12   | %8d iter | %10.1f ns/op\n"
	.align 8
.LC16:
	.string	"TinyJAMBU upd 1024 | %8d iter | %10.1f ns/op\n"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC17:
	.string	"\nsink=%llu (prevent DCE)\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB59:
	.cfi_startproc
	endbr64	
	pushq	%r15	#
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
# bench.c:133:     clock_gettime(CLOCK_MONOTONIC, &ts);
	movl	$1, %edi	#,
# bench.c:137: int main(void) {
	pushq	%r14	#
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13	#
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	leaq	AES_SBOX(%rip), %rbp	#, tmp676
	pushq	%rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$328, %rsp	#,
	.cfi_def_cfa_offset 384
# bench.c:147:         for (int i = 0; i < 176; i++) rk[i] = (uint8_t)(i * 7 + 13);
	movdqa	.LC0(%rip), %xmm0	#, tmp446
# bench.c:137: int main(void) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp715
	movq	%rax, 312(%rsp)	# tmp715, D.4826
	xorl	%eax, %eax	# tmp715
# bench.c:133:     clock_gettime(CLOCK_MONOTONIC, &ts);
	leaq	96(%rsp), %rbx	#, tmp669
# bench.c:139:     volatile uint64_t sink = 0; /* prevent dead-code elimination */
	movq	$0, 88(%rsp)	#, sink
# bench.c:147:         for (int i = 0; i < 176; i++) rk[i] = (uint8_t)(i * 7 + 13);
	movaps	%xmm0, 128(%rsp)	# tmp446, MEM <vector(16) unsigned char> [(unsigned char *)_46]
	movdqa	.LC1(%rip), %xmm0	#, tmp447
# bench.c:133:     clock_gettime(CLOCK_MONOTONIC, &ts);
	movq	%rbx, %rsi	# tmp669,
# bench.c:147:         for (int i = 0; i < 176; i++) rk[i] = (uint8_t)(i * 7 + 13);
	movaps	%xmm0, 144(%rsp)	# tmp447, MEM <vector(16) unsigned char> [(unsigned char *)_46]
	movdqa	.LC2(%rip), %xmm0	#, tmp448
	movaps	%xmm0, 160(%rsp)	# tmp448, MEM <vector(16) unsigned char> [(unsigned char *)_46]
	movdqa	.LC3(%rip), %xmm0	#, tmp449
	movaps	%xmm0, 176(%rsp)	# tmp449, MEM <vector(16) unsigned char> [(unsigned char *)_46]
	movdqa	.LC4(%rip), %xmm0	#, tmp450
	movaps	%xmm0, 192(%rsp)	# tmp450, MEM <vector(16) unsigned char> [(unsigned char *)_46]
	movdqa	.LC5(%rip), %xmm0	#, tmp451
	movaps	%xmm0, 208(%rsp)	# tmp451, MEM <vector(16) unsigned char> [(unsigned char *)_46]
	movdqa	.LC6(%rip), %xmm0	#, tmp452
	movaps	%xmm0, 224(%rsp)	# tmp452, MEM <vector(16) unsigned char> [(unsigned char *)_46]
	movdqa	.LC7(%rip), %xmm0	#, tmp453
	movaps	%xmm0, 240(%rsp)	# tmp453, MEM <vector(16) unsigned char> [(unsigned char *)_46]
	movdqa	.LC8(%rip), %xmm0	#, tmp454
	movaps	%xmm0, 256(%rsp)	# tmp454, MEM <vector(16) unsigned char> [(unsigned char *)_46]
	movdqa	.LC9(%rip), %xmm0	#, tmp455
	movaps	%xmm0, 272(%rsp)	# tmp455, MEM <vector(16) unsigned char> [(unsigned char *)_46]
	movdqa	.LC10(%rip), %xmm0	#, tmp456
	movaps	%xmm0, 288(%rsp)	# tmp456, MEM <vector(16) unsigned char> [(unsigned char *)_46]
# bench.c:133:     clock_gettime(CLOCK_MONOTONIC, &ts);
	call	clock_gettime@PLT	#
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	pxor	%xmm0, %xmm0	# tmp458
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	pxor	%xmm1, %xmm1	# tmp461
# bench.c:150:         for (int n = 0; n < ITERATIONS; n++) {
	xorl	%ecx, %ecx	# n
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	cvtsi2sdq	96(%rsp), %xmm0	# MEM[(struct timespec *)_77].tv_sec, tmp458
	movq	%rbx, 72(%rsp)	# tmp669, %sfp
	movl	%ecx, %edx	# n, n
	leaq	144(%rsp), %rdi	#, ivtmp.113
	mulsd	.LC11(%rip), %xmm0	#, tmp459
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	cvtsi2sdq	104(%rsp), %xmm1	# MEM[(struct timespec *)_77].tv_nsec, tmp461
	movq	%rdi, 56(%rsp)	# ivtmp.113, %sfp
	leaq	288(%rsp), %rax	#, _1428
	movq	%rax, 40(%rsp)	# _1428, %sfp
	addsd	%xmm1, %xmm0	# tmp461, tmp459
	movsd	%xmm0, 64(%rsp)	# tmp459, %sfp
.L35:
# bench.c:46:     for (i = 0; i < 16; i++) state[i] ^= rk[i];
	xorl	%ecx, %ecx	# state$13
	xorl	%r9d, %r9d	# state$7
	xorl	%r13d, %r13d	# state$5
	movb	$0, 23(%rsp)	#, %sfp
	movb	$0, 24(%rsp)	#, %sfp
	movq	56(%rsp), %r11	# %sfp, ivtmp.113
	xorl	%r10d, %r10d	# state$15
	xorl	%edi, %edi	# state$14
	movb	$0, 25(%rsp)	#, %sfp
	xorl	%r14d, %r14d	# state$12
	xorl	%r15d, %r15d	# state$11
	movb	$0, 26(%rsp)	#, %sfp
	movb	$0, 27(%rsp)	#, %sfp
	movb	$0, 28(%rsp)	#, %sfp
	movb	$0, 22(%rsp)	#, %sfp
	movb	%dl, 21(%rsp)	# state, %sfp
	movb	%cl, 29(%rsp)	# state$13, %sfp
	movb	%r9b, 30(%rsp)	# state$7, %sfp
	movb	%r13b, 31(%rsp)	# state$5, %sfp
	movl	%edx, 52(%rsp)	# n, %sfp
	.p2align 4,,10
	.p2align 3
.L34:
# bench.c:50:         for (i = 0; i < 16; i++) state[i] = AES_SBOX[state[i]];
	movzbl	21(%rsp), %eax	# %sfp, state
	movzbl	%r14b, %r14d	# state$12, state$12
	movzbl	%r10b, %r10d	# state$15, state$15
	movzbl	23(%rsp), %edx	# %sfp, state$9
	movzbl	%r15b, %r15d	# state$11, state$11
	movzbl	0(%rbp,%rax), %r13d	# AES_SBOX[_256], _255
	movzbl	22(%rsp), %eax	# %sfp, state$1
	movzbl	0(%rbp,%r15), %r15d	# AES_SBOX[_221], _220
	movzbl	0(%rbp,%rdx), %edx	# AES_SBOX[_225], _224
	movzbl	0(%rbp,%rax), %eax	# AES_SBOX[_254], _253
	movb	%al, 21(%rsp)	# _253, %sfp
	movzbl	28(%rsp), %eax	# %sfp, state$2
	movzbl	0(%rbp,%rax), %ebx	# AES_SBOX[_252], _251
	movzbl	27(%rsp), %eax	# %sfp, state$3
	movzbl	0(%rbp,%rax), %r12d	# AES_SBOX[_250], _249
	movzbl	26(%rsp), %eax	# %sfp, state$4
	movb	%bl, 38(%rsp)	# _251, %sfp
	movzbl	0(%rbp,%rax), %ebx	# AES_SBOX[_236], _235
	movzbl	31(%rsp), %eax	# %sfp, state$5
	movzbl	0(%rbp,%rax), %ecx	# AES_SBOX[_234], _233
	movzbl	25(%rsp), %eax	# %sfp, state$6
	movzbl	0(%rbp,%rax), %eax	# AES_SBOX[_232], _231
	movb	%al, 22(%rsp)	# _231, %sfp
	movzbl	30(%rsp), %eax	# %sfp, state$7
	movzbl	0(%rbp,%rax), %esi	# AES_SBOX[_230], _228
	movzbl	24(%rsp), %eax	# %sfp, state$8
	movb	%sil, 37(%rsp)	# _228, %sfp
	movzbl	%dil, %esi	# state$10, state$10
	movzbl	0(%rbp,%r14), %edi	# AES_SBOX[_218], _217
	movzbl	0(%rbp,%rsi), %r8d	# AES_SBOX[_223], _222
	movzbl	29(%rsp), %esi	# %sfp, state$13
	movb	%dil, 8(%rsp)	# _217, %sfp
	movzbl	%r9b, %edi	# state$14, state$14
	movzbl	0(%rbp,%r10), %r9d	# AES_SBOX[_212], _211
# bench.c:38:     return (a & 0x80) ? ((a << 1) ^ 0x1B) : (a << 1);
	leal	(%r13,%r13), %r10d	#, tmp512
	movl	%r10d, %r14d	# tmp512, tmp678
# bench.c:50:         for (i = 0; i < 16; i++) state[i] = AES_SBOX[state[i]];
	movzbl	0(%rbp,%rsi), %esi	# AES_SBOX[_216], _215
	movzbl	0(%rbp,%rdi), %edi	# AES_SBOX[_214], _213
# bench.c:38:     return (a & 0x80) ? ((a << 1) ^ 0x1B) : (a << 1);
	xorl	$27, %r14d	#, tmp678
	testb	%r13b, %r13b	# _255
# bench.c:50:         for (i = 0; i < 16; i++) state[i] = AES_SBOX[state[i]];
	movzbl	0(%rbp,%rax), %eax	# AES_SBOX[_227], _226
# bench.c:38:     return (a & 0x80) ? ((a << 1) ^ 0x1B) : (a << 1);
	cmovns	%r10d, %r14d	# tmp512,, tmp678
	leal	(%rcx,%rcx), %r10d	#, tmp513
	movb	%r14b, 36(%rsp)	# tmp678, %sfp
	movl	%r10d, %r14d	# tmp513, tmp694
	xorl	$27, %r14d	#, tmp694
	testb	%cl, %cl	# _233
	cmovns	%r10d, %r14d	# tmp513,, tmp694
	movl	%r8d, %r10d	# _222, tmp514
	xorl	%ecx, %r10d	# _233, tmp514
	xorl	%r9d, %r10d	# _211, tmp514
	movb	%r14b, 24(%rsp)	# tmp694, %sfp
	movl	%r8d, %r14d	# _222, _196
	xorl	%r13d, %r14d	# _255, _196
	movb	%r10b, 35(%rsp)	# tmp514, %sfp
	leal	(%r8,%r8), %r10d	#, tmp515
	movb	%r14b, 25(%rsp)	# _196, %sfp
	movl	%r10d, %r14d	# tmp515, tmp680
	xorl	$27, %r14d	#, tmp680
	testb	%r8b, %r8b	# _222
	cmovns	%r10d, %r14d	# tmp515,, tmp680
	xorl	%r13d, %ecx	# _255, _188
	leal	(%r9,%r9), %r10d	#, tmp516
	movl	%ecx, %r13d	# _188, _187
	xorl	%r9d, %r13d	# _211, _187
	movb	%r14b, 23(%rsp)	# tmp680, %sfp
	movzbl	25(%rsp), %r14d	# %sfp, _196
	movb	%r13b, 28(%rsp)	# _187, %sfp
	movl	%r10d, %r13d	# tmp516, tmp702
	xorl	%r9d, %r14d	# _211, _196
	xorl	$27, %r13d	#, tmp702
	testb	%r9b, %r9b	# _211
	cmovns	%r10d, %r13d	# tmp516,, iftmp.16_181
	xorl	%r8d, %ecx	# _222, _188
	movb	%r14b, 34(%rsp)	# _196, %sfp
	movzbl	21(%rsp), %r10d	# %sfp, _253
	movb	%cl, 27(%rsp)	# _188, %sfp
	leal	(%rbx,%rbx), %ecx	#, tmp517
	movl	%ecx, %r8d	# tmp517, tmp682
	xorl	$27, %r8d	#, tmp682
	testb	%bl, %bl	# _235
	cmovns	%ecx, %r8d	# tmp517,, tmp682
	leal	(%rdx,%rdx), %ecx	#, tmp518
	movb	%r8b, 33(%rsp)	# tmp682, %sfp
	movl	%ecx, %r8d	# tmp518, tmp696
	xorl	$27, %r8d	#, tmp696
	testb	%dl, %dl	# _224
	cmovns	%ecx, %r8d	# tmp518,, tmp696
	movl	%edx, %ecx	# _224, tmp519
	xorl	%r12d, %ecx	# _249, tmp519
	movl	%r8d, %r14d	# tmp696, iftmp.16_168
	xorl	%edi, %ecx	# _213, tmp519
	leal	(%rdi,%rdi), %r8d	#, tmp520
	movb	%cl, 26(%rsp)	# tmp519, %sfp
	movl	%r8d, %r9d	# tmp520, tmp684
	movl	%ebx, %ecx	# _235, _165
	xorl	%r12d, %ecx	# _249, _165
	xorl	$27, %r9d	#, tmp684
	testb	%dil, %dil	# _213
	cmovns	%r8d, %r9d	# tmp520,, tmp684
	movl	%ecx, %r8d	# _165, _146
	xorl	%edx, %ecx	# _224, _165
	xorl	%edi, %r8d	# _213, _146
	movb	%cl, 25(%rsp)	# _165, %sfp
	leal	(%r12,%r12), %ecx	#, tmp521
	movb	%r8b, 31(%rsp)	# _146, %sfp
	movl	%ecx, %r8d	# tmp521, tmp706
	xorl	$27, %r8d	#, tmp706
	testb	%r12b, %r12b	# _249
	movb	%r9b, 32(%rsp)	# tmp684, %sfp
	movzbl	37(%rsp), %r9d	# %sfp, _228
	movl	%r8d, %r12d	# tmp706, tmp706
	movl	%esi, %r8d	# _215, _1203
	cmovns	%ecx, %r12d	# tmp521,, tmp706
	xorl	%ebx, %edx	# _235, tmp522
	movzbl	38(%rsp), %ebx	# %sfp, _251
	xorl	%edi, %edx	# _213, tmp522
	movb	%dl, 30(%rsp)	# tmp522, %sfp
	leal	(%rax,%rax), %edx	#, tmp523
	leal	(%rbx,%rbx), %ecx	#, tmp525
	movl	%edx, %edi	# tmp523, tmp686
	xorl	$27, %edi	#, tmp686
	testb	%al, %al	# _226
	cmovns	%edx, %edi	# tmp523,, tmp686
	movb	%dil, 29(%rsp)	# tmp686, %sfp
	leal	(%rsi,%rsi), %edi	#, tmp524
	movl	%edi, %edx	# tmp524, tmp698
	xorl	$27, %edx	#, tmp698
	testb	%sil, %sil	# _215
	cmovs	%edx, %edi	# tmp524,, tmp698, iftmp.16_37
	movl	%r9d, %edx	# _228, _360
	xorl	%ebx, %edx	# _251, _360
	xorl	%edx, %r8d	# _360, _1203
	movb	%r8b, 37(%rsp)	# _1203, %sfp
	movl	%ecx, %r8d	# tmp525, tmp688
	xorl	$27, %r8d	#, tmp688
	testb	%bl, %bl	# _251
	cmovs	%r8d, %ecx	# tmp525,, tmp688, iftmp.16_1209
	xorl	%eax, %edx	# _226, _360
	leal	(%r9,%r9), %r8d	#, tmp527
	movb	%dl, 38(%rsp)	# _360, %sfp
	movl	%r9d, %edx	# _228, tmp526
	xorl	%eax, %edx	# _226, tmp526
	xorl	%esi, %edx	# _215, tmp526
	movb	%dl, 39(%rsp)	# tmp526, %sfp
	movl	%r8d, %edx	# tmp527, tmp704
	xorl	$27, %edx	#, tmp704
	testb	%r9b, %r9b	# _228
	cmovs	%edx, %r8d	# tmp527,, tmp704, iftmp.16_1229
	xorl	%ebx, %eax	# _251, tmp528
	movzbl	22(%rsp), %ebx	# %sfp, _231
	xorl	%esi, %eax	# _215, tmp528
	movzbl	8(%rsp), %esi	# %sfp, _217
	movb	%al, 48(%rsp)	# tmp528, %sfp
	leal	(%rsi,%rsi), %eax	#, tmp529
	movl	%eax, %r9d	# tmp529, tmp690
	xorl	$27, %r9d	#, tmp690
	testb	%sil, %sil	# _217
	movl	%r9d, %edx	# tmp690, tmp690
	leal	(%r10,%r10), %r9d	#, tmp530
	movl	%r9d, %esi	# tmp530, tmp700
	cmovs	%edx, %eax	# tmp529,, tmp690, iftmp.16_1247
	xorl	$27, %esi	#, tmp700
	testb	%r10b, %r10b	# _253
	movl	%esi, %edx	# tmp700, tmp700
	movl	%ebx, %esi	# _231, _1272
	cmovs	%edx, %r9d	# tmp530,, tmp700, iftmp.16_1262
	xorl	%r10d, %esi	#, _1272
	movl	%r15d, %edx	# _220, _1274
	movl	%ebx, %r10d	# _231, _1275
	xorl	%esi, %edx	# _1272, _1274
	xorl	%r15d, %r10d	# _220, _1275
	movb	%dl, 49(%rsp)	# _1274, %sfp
	leal	(%rbx,%rbx), %edx	#, tmp531
	movl	%edx, %ebx	# tmp531, tmp692
	xorl	$27, %ebx	#, tmp692
	cmpb	$0, 22(%rsp)	#, %sfp
	cmovs	%ebx, %edx	# tmp531,, tmp692, iftmp.16_1281
	movzbl	8(%rsp), %ebx	# %sfp, _217
	xorl	%ebx, %r10d	# _217, _1275
	movb	%r10b, 50(%rsp)	# _1275, %sfp
	movzbl	21(%rsp), %r10d	# %sfp, _253
	xorl	%r15d, %r10d	# _220, _253
	xorl	%ebx, %r10d	#, tmp532
	movb	%r10b, 51(%rsp)	# tmp532, %sfp
	leal	(%r15,%r15), %r10d	#, tmp533
	movl	%r10d, %ebx	# tmp533, tmp708
	xorl	$27, %ebx	#, tmp708
	testb	%r15b, %r15b	# _220
	cmovs	%ebx, %r10d	# tmp533,, tmp708, iftmp.16_1301
# bench.c:70:         for (i = 0; i < 16; i++) state[i] ^= rk[r * 16 + i];
	movzbl	35(%rsp), %ebx	# %sfp, _197
	xorb	(%r11), %bl	# MEM[(const uint8_t *)_1410], _197
	movzbl	36(%rsp), %r15d	# %sfp, iftmp.16_205
	xorl	%r15d, %ebx	# iftmp.16_205, tmp535
	xorb	24(%rsp), %bl	# %sfp, tmp535
	movb	%bl, 21(%rsp)	# tmp535, %sfp
	movzbl	34(%rsp), %ebx	# %sfp, _189
	xorb	1(%r11), %bl	# MEM[(const uint8_t *)_1410 + 1B], _189
	xorb	24(%rsp), %bl	# %sfp, tmp537
	xorb	23(%rsp), %bl	# %sfp, tmp537
	movb	%bl, 22(%rsp)	# tmp537, %sfp
	movzbl	28(%rsp), %ebx	# %sfp, _187
	xorb	2(%r11), %bl	# MEM[(const uint8_t *)_1410 + 2B], _187
	xorb	23(%rsp), %bl	# %sfp, tmp539
	xorl	%r13d, %ebx	# iftmp.16_181, tmp539
	movb	%bl, 28(%rsp)	# tmp539, %sfp
	movzbl	27(%rsp), %ebx	# %sfp, _180
	xorb	3(%r11), %bl	# MEM[(const uint8_t *)_1410 + 3B], _180
	xorl	%r15d, %ebx	# iftmp.16_205, tmp541
	movl	%ebx, %r15d	# tmp541, tmp541
	movzbl	26(%rsp), %ebx	# %sfp, _166
	xorb	4(%r11), %bl	# MEM[(const uint8_t *)_1410 + 4B], _166
	xorl	%r13d, %r15d	# iftmp.16_181, tmp541
	movb	%r15b, 27(%rsp)	# tmp541, %sfp
	movzbl	33(%rsp), %r15d	# %sfp, iftmp.16_174
	xorl	%r15d, %ebx	# iftmp.16_174, tmp543
	movl	%ebx, %r13d	# tmp543, tmp543
	movzbl	31(%rsp), %ebx	# %sfp, _146
	xorb	5(%r11), %bl	# MEM[(const uint8_t *)_1410 + 5B], _146
	xorl	%r14d, %r13d	# iftmp.16_168, tmp543
	xorl	%r14d, %ebx	# iftmp.16_168, tmp545
	movzbl	32(%rsp), %r14d	# %sfp, iftmp.16_147
	movb	%r13b, 26(%rsp)	# tmp543, %sfp
	movl	%ebx, %r13d	# tmp545, tmp545
	movzbl	25(%rsp), %ebx	# %sfp, _145
	xorb	6(%r11), %bl	# MEM[(const uint8_t *)_1410 + 6B], _145
	xorl	%r14d, %r13d	# iftmp.16_147, tmp545
	xorl	%r14d, %ebx	# iftmp.16_147, tmp547
	movb	%r13b, 31(%rsp)	# tmp545, %sfp
	movzbl	29(%rsp), %r14d	# %sfp, iftmp.16_64
	movl	%ebx, %r13d	# tmp547, tmp547
	movzbl	30(%rsp), %ebx	# %sfp, _79
	xorb	7(%r11), %bl	# MEM[(const uint8_t *)_1410 + 7B], _79
	xorl	%r12d, %r13d	# iftmp.16_139, tmp547
	xorl	%r15d, %ebx	# iftmp.16_174, tmp549
	movb	%r13b, 25(%rsp)	# tmp547, %sfp
	movl	%ebx, %r13d	# tmp549, tmp549
	movzbl	37(%rsp), %ebx	# %sfp, _1203
	xorb	8(%r11), %bl	# MEM[(const uint8_t *)_1410 + 8B], _1203
	xorl	%r12d, %r13d	# iftmp.16_139, tmp549
	xorl	%r14d, %ebx	# iftmp.16_64, tmp551
	movb	%r13b, 30(%rsp)	# tmp549, %sfp
	movl	%ebx, %r12d	# tmp551, tmp551
	xorl	%edi, %r12d	# iftmp.16_37, tmp551
	movb	%r12b, 24(%rsp)	# tmp551, %sfp
	movzbl	38(%rsp), %ebx	# %sfp, _1220
	xorb	9(%r11), %bl	# MEM[(const uint8_t *)_1410 + 9B], _1220
	movzbl	48(%rsp), %r15d	# %sfp, _1244
	xorl	%edi, %ebx	# iftmp.16_37, tmp553
	movzbl	39(%rsp), %edi	# %sfp, _1226
	xorb	10(%r11), %dil	# MEM[(const uint8_t *)_1410 + 10B], _1226
	xorl	%ecx, %edi	# iftmp.16_1209, tmp555
	xorl	%ecx, %ebx	# iftmp.16_1209, tmp553
	movzbl	50(%rsp), %ecx	# %sfp, _1292
	xorl	%r8d, %edi	# iftmp.16_1229, state$10
	xorb	13(%r11), %cl	# MEM[(const uint8_t *)_1410 + 13B], _1292
	xorb	11(%r11), %r15b	# MEM[(const uint8_t *)_1410 + 11B], _1244
# bench.c:48:     for (r = 1; r < 10; r++) {
	addq	$16, %r11	#, ivtmp.113
# bench.c:70:         for (i = 0; i < 16; i++) state[i] ^= rk[r * 16 + i];
	xorl	%r9d, %ecx	# iftmp.16_1262, tmp561
	xorl	%r14d, %r15d	# iftmp.16_64, tmp557
	movzbl	49(%rsp), %r14d	# %sfp, _1274
	xorb	-4(%r11), %r14b	# MEM[(const uint8_t *)_1410 + 12B], _1274
	xorl	%edx, %ecx	# iftmp.16_1281, tmp561
	xorl	%eax, %r14d	# iftmp.16_1247, tmp559
	movb	%bl, 23(%rsp)	# tmp553, %sfp
	xorl	%r8d, %r15d	# iftmp.16_1229, state$11
	movb	%cl, 29(%rsp)	# tmp561, %sfp
	movzbl	51(%rsp), %ecx	# %sfp, _1298
	xorl	%r9d, %r14d	# iftmp.16_1262, state$12
	xorb	-2(%r11), %cl	# MEM[(const uint8_t *)_1410 + 14B], _1298
	xorl	%edx, %ecx	# iftmp.16_1281, tmp563
	movzbl	8(%rsp), %edx	# %sfp, _217
	xorl	%r10d, %ecx	# iftmp.16_1301, tmp563
	xorl	%esi, %edx	# _1272, _217
	xorb	-1(%r11), %dl	# MEM[(const uint8_t *)_1410 + 15B], tmp565
	movl	%ecx, %r9d	# tmp563, state$14
	xorl	%eax, %edx	# iftmp.16_1247, tmp566
# bench.c:48:     for (r = 1; r < 10; r++) {
	movq	40(%rsp), %rax	# %sfp, _1428
# bench.c:70:         for (i = 0; i < 16; i++) state[i] ^= rk[r * 16 + i];
	xorl	%edx, %r10d	# tmp566, state$15
# bench.c:48:     for (r = 1; r < 10; r++) {
	cmpq	%rax, %r11	# _1428, ivtmp.113
	jne	.L34	#,
# bench.c:154:             sink ^= state[0];
	movzbl	21(%rsp), %eax	# %sfp,
	movq	88(%rsp), %rcx	# sink, sink.0_479
	movl	52(%rsp), %edx	# %sfp, n
# bench.c:80:     for (i = 0; i < 16; i++) state[i] ^= rk[160 + i];
	movzbl	0(%rbp,%rax), %eax	# AES_SBOX[_491], AES_SBOX[_491]
# bench.c:150:         for (int n = 0; n < ITERATIONS; n++) {
	addl	$1, %edx	#, n
# bench.c:80:     for (i = 0; i < 16; i++) state[i] ^= rk[160 + i];
	xorl	$109, %eax	#, tmp570
# bench.c:154:             sink ^= state[0];
	movzbl	%al, %eax	# tmp570, tmp572
# bench.c:154:             sink ^= state[0];
	xorq	%rcx, %rax	# sink.0_479, _478
	movq	%rax, 88(%rsp)	# _478, sink
# bench.c:150:         for (int n = 0; n < ITERATIONS; n++) {
	cmpl	$500000, %edx	#, n
	jne	.L35	#,
# bench.c:133:     clock_gettime(CLOCK_MONOTONIC, &ts);
	movq	72(%rsp), %rbx	# %sfp, tmp669
	movl	$1, %edi	#,
	xorl	%ebp, %ebp	# ivtmp.100
	leaq	128(%rsp), %r14	#, ivtmp.98
# bench.c:165:             x0 = 0x80400c0600000000ULL ^ (n & 0xFF);
	movabsq	$-9205344418435956736, %r13	#, tmp589
# bench.c:91:     const uint8_t RC[12] = {0xf0,0xe1,0xd2,0xc3,0xb4,0xa5,0x96,0x87,0x78,0x69,0x5a,0x4b};
	movabsq	$-8676565436284608016, %r12	#, tmp590
# bench.c:133:     clock_gettime(CLOCK_MONOTONIC, &ts);
	movq	%rbx, %rsi	# tmp669,
	call	clock_gettime@PLT	#
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	pxor	%xmm0, %xmm0	# tmp574
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	pxor	%xmm1, %xmm1	# tmp577
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	$500000, %edx	#,
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	cvtsi2sdq	96(%rsp), %xmm0	# MEM[(struct timespec *)_77].tv_sec, tmp574
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	$2, %edi	#,
	movl	$1, %eax	#,
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	mulsd	.LC11(%rip), %xmm0	#, tmp575
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	cvtsi2sdq	104(%rsp), %xmm1	# MEM[(struct timespec *)_77].tv_nsec, tmp577
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC13(%rip), %rsi	#, tmp581
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	addsd	%xmm1, %xmm0	# tmp577, _95
# bench.c:157:         printf("AES-128 enc_block  | %8d iter | %10.1f ns/op\n", ITERATIONS, (t1-t0)/ITERATIONS);
	subsd	64(%rsp), %xmm0	# %sfp, tmp578
# bench.c:157:         printf("AES-128 enc_block  | %8d iter | %10.1f ns/op\n", ITERATIONS, (t1-t0)/ITERATIONS);
	divsd	.LC12(%rip), %xmm0	#, tmp579
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	call	__printf_chk@PLT	#
# bench.c:133:     clock_gettime(CLOCK_MONOTONIC, &ts);
	movq	%rbx, %rsi	# tmp669,
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	pxor	%xmm0, %xmm0	# tmp583
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	pxor	%xmm1, %xmm1	# tmp586
	leaq	140(%rsp), %r11	#, _1399
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	cvtsi2sdq	96(%rsp), %xmm0	# MEM[(struct timespec *)_77].tv_sec, tmp583
	mulsd	.LC11(%rip), %xmm0	#, tmp584
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	cvtsi2sdq	104(%rsp), %xmm1	# MEM[(struct timespec *)_77].tv_nsec, tmp586
	addsd	%xmm1, %xmm0	# tmp586, tmp584
	movsd	%xmm0, 8(%rsp)	# tmp584, %sfp
.L37:
# bench.c:165:             x0 = 0x80400c0600000000ULL ^ (n & 0xFF);
	movzbl	%bpl, %edi	# ivtmp.100, ivtmp.100
	movq	%r14, %r10	# ivtmp.98, ivtmp.98
# bench.c:166:             x1 = x2 = x3 = x4 = (uint64_t)n;
	movq	%rbp, %rdx	# ivtmp.100, x4
# bench.c:166:             x1 = x2 = x3 = x4 = (uint64_t)n;
	movq	%rbp, %r8	# ivtmp.100, x3
# bench.c:91:     const uint8_t RC[12] = {0xf0,0xe1,0xd2,0xc3,0xb4,0xa5,0x96,0x87,0x78,0x69,0x5a,0x4b};
	movq	%r12, 128(%rsp)	# tmp590, MEM[(uint8_t[12] *)_46]
# bench.c:165:             x0 = 0x80400c0600000000ULL ^ (n & 0xFF);
	xorq	%r13, %rdi	# tmp589, x0
# bench.c:166:             x1 = x2 = x3 = x4 = (uint64_t)n;
	movq	%rbp, %rax	# ivtmp.100, x2
# bench.c:166:             x1 = x2 = x3 = x4 = (uint64_t)n;
	movq	%rbp, %r15	# ivtmp.100, x1
# bench.c:91:     const uint8_t RC[12] = {0xf0,0xe1,0xd2,0xc3,0xb4,0xa5,0x96,0x87,0x78,0x69,0x5a,0x4b};
	movl	$1264216440, 136(%rsp)	#, MEM[(uint8_t[12] *)_46]
	.p2align 4,,10
	.p2align 3
.L36:
# bench.c:94:         *x0 ^= *x4; *x4 ^= *x3; *x2 ^= *x1;
	xorq	%rdx, %rdi	# x4, _261
# bench.c:98:         *x2 ^= (~t3 & t4);
	movq	%r8, %rcx	# x3, tmp593
# bench.c:94:         *x0 ^= *x4; *x4 ^= *x3; *x2 ^= *x1;
	xorq	%r8, %rdx	# x3, _264
# bench.c:96:         *x0 ^= (~t1 & t2);
	movq	%r15, %rsi	# x1, tmp591
# bench.c:100:         *x4 ^= (~t0 & t1);
	movq	%rdi, %r9	# _261, tmp596
# bench.c:98:         *x2 ^= (~t3 & t4);
	notq	%rcx	# tmp593
# bench.c:94:         *x0 ^= *x4; *x4 ^= *x3; *x2 ^= *x1;
	xorq	%r15, %rax	# x1, _267
# bench.c:96:         *x0 ^= (~t1 & t2);
	notq	%rsi	# tmp591
# bench.c:100:         *x4 ^= (~t0 & t1);
	notq	%r9	# tmp596
# bench.c:98:         *x2 ^= (~t3 & t4);
	andq	%rdx, %rcx	# _264, tmp594
# bench.c:96:         *x0 ^= (~t1 & t2);
	andq	%rax, %rsi	# _267, tmp592
# bench.c:100:         *x4 ^= (~t0 & t1);
	andq	%r15, %r9	# x1, tmp597
# bench.c:101:         *x2 = ~*x2; *x4 = ~*x4;
	xorq	%rax, %rcx	# _267, _292
# bench.c:97:         *x1 ^= (~t2 & t3);
	notq	%rax	# tmp599
# bench.c:96:         *x0 ^= (~t1 & t2);
	xorq	%rdi, %rsi	# _261, _274
# bench.c:101:         *x2 = ~*x2; *x4 = ~*x4;
	xorq	%rdx, %r9	# _264, _294
# bench.c:97:         *x1 ^= (~t2 & t3);
	andq	%r8, %rax	# x3, tmp600
# bench.c:99:         *x3 ^= (~t4 & t0);
	notq	%rdx	# tmp602
# bench.c:101:         *x2 = ~*x2; *x4 = ~*x4;
	notq	%rcx	# _292
# bench.c:101:         *x2 = ~*x2; *x4 = ~*x4;
	notq	%r9	# _294
# bench.c:102:         *x1 ^= *x0; *x0 ^= *x4; *x3 ^= *x2;
	xorq	%rsi, %rax	# _274, tmp601
# bench.c:99:         *x3 ^= (~t4 & t0);
	andq	%rdi, %rdx	# _261, tmp603
# bench.c:102:         *x1 ^= *x0; *x0 ^= *x4; *x3 ^= *x2;
	xorq	%r9, %rsi	# _294, _300
# bench.c:99:         *x3 ^= (~t4 & t0);
	xorq	%r8, %rdx	# x3, tmp604
# bench.c:102:         *x1 ^= *x0; *x0 ^= *x4; *x3 ^= *x2;
	xorq	%r15, %rax	# x1, _297
# bench.c:86:     return (v >> s) | (v << (64 - s));
	movq	%rsi, %rdi	# _300, tmp605
	movq	%rsi, %r8	# _300, tmp606
	movq	%rax, %r15	# _297, tmp608
# bench.c:102:         *x1 ^= *x0; *x0 ^= *x4; *x3 ^= *x2;
	xorq	%rcx, %rdx	# _292, _303
# bench.c:86:     return (v >> s) | (v << (64 - s));
	rorq	$28, %r8	#, tmp606
	rorq	$19, %rdi	#, tmp605
# bench.c:105:         *x0 ^= ascon_rotr(*x0, 19) ^ ascon_rotr(*x0, 28);
	xorq	%r8, %rdi	# tmp606, tmp607
# bench.c:86:     return (v >> s) | (v << (64 - s));
	rolq	$3, %r15	#, tmp608
	movq	%rdx, %r8	# _303, tmp611
# bench.c:105:         *x0 ^= ascon_rotr(*x0, 19) ^ ascon_rotr(*x0, 28);
	xorq	%rsi, %rdi	# _300, x0
# bench.c:86:     return (v >> s) | (v << (64 - s));
	movq	%rax, %rsi	# _297, tmp609
	rorq	$10, %r8	#, tmp611
	rolq	$25, %rsi	#, tmp609
# bench.c:106:         *x1 ^= ascon_rotr(*x1, 61) ^ ascon_rotr(*x1, 39);
	xorq	%rsi, %r15	# tmp609, tmp610
# bench.c:86:     return (v >> s) | (v << (64 - s));
	movq	%rcx, %rsi	# _292, tmp619
# bench.c:106:         *x1 ^= ascon_rotr(*x1, 61) ^ ascon_rotr(*x1, 39);
	xorq	%rax, %r15	# _297, x1
# bench.c:86:     return (v >> s) | (v << (64 - s));
	movq	%rdx, %rax	# _303, tmp612
	rorq	$17, %rax	#, tmp612
# bench.c:108:         *x3 ^= ascon_rotr(*x3, 10) ^ ascon_rotr(*x3, 17);
	xorq	%rax, %r8	# tmp612, tmp613
# bench.c:86:     return (v >> s) | (v << (64 - s));
	movq	%r9, %rax	# _294, tmp615
# bench.c:108:         *x3 ^= ascon_rotr(*x3, 10) ^ ascon_rotr(*x3, 17);
	xorq	%rdx, %r8	# _303, x3
# bench.c:86:     return (v >> s) | (v << (64 - s));
	movq	%r9, %rdx	# _294, tmp614
	rolq	$23, %rax	#, tmp615
	rorq	$7, %rdx	#, tmp614
# bench.c:109:         *x4 ^= ascon_rotr(*x4, 7) ^ ascon_rotr(*x4, 41);
	xorq	%rax, %rdx	# tmp615, tmp616
# bench.c:112:         *x2 ^= RC[r];
	movzbl	(%r10), %eax	# MEM[(unsigned char *)_1391], MEM[(unsigned char *)_1391]
# bench.c:109:         *x4 ^= ascon_rotr(*x4, 7) ^ ascon_rotr(*x4, 41);
	xorq	%r9, %rdx	# _294, x4
# bench.c:112:         *x2 ^= RC[r];
	xorq	%rcx, %rax	# _292, tmp618
# bench.c:86:     return (v >> s) | (v << (64 - s));
	rorq	%rsi	# tmp619
# bench.c:92:     for (int r = 0; r < 12; r++) {
	addq	$1, %r10	#, ivtmp.98
# bench.c:112:         *x2 ^= RC[r];
	xorq	%rsi, %rax	# tmp619, tmp620
# bench.c:86:     return (v >> s) | (v << (64 - s));
	rorq	$6, %rcx	#, tmp621
# bench.c:112:         *x2 ^= RC[r];
	xorq	%rcx, %rax	# tmp621, x2
# bench.c:92:     for (int r = 0; r < 12; r++) {
	cmpq	%r11, %r10	# _1399, ivtmp.98
	jne	.L36	#,
# bench.c:168:             sink ^= x0;
	movq	88(%rsp), %rax	# sink, sink.4_14
# bench.c:164:         for (int n = 0; n < ITERATIONS; n++) {
	addq	$1, %rbp	#, ivtmp.100
# bench.c:168:             sink ^= x0;
	xorq	%rdi, %rax	# x0, _16
	movq	%rax, 88(%rsp)	# _16, sink
# bench.c:164:         for (int n = 0; n < ITERATIONS; n++) {
	cmpq	$500000, %rbp	#, ivtmp.100
	jne	.L37	#,
# bench.c:133:     clock_gettime(CLOCK_MONOTONIC, &ts);
	movq	%rbx, %rsi	# tmp669,
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	pxor	%xmm0, %xmm0	# tmp623
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	pxor	%xmm1, %xmm1	# tmp626
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	$500000, %edx	#,
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	cvtsi2sdq	96(%rsp), %xmm0	# MEM[(struct timespec *)_77].tv_sec, tmp623
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	$2, %edi	#,
	movl	$1, %eax	#,
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	mulsd	.LC11(%rip), %xmm0	#, tmp624
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	cvtsi2sdq	104(%rsp), %xmm1	# MEM[(struct timespec *)_77].tv_nsec, tmp626
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC14(%rip), %rsi	#, tmp630
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	addsd	%xmm1, %xmm0	# tmp626, _107
# bench.c:171:         printf("ASCON permute 12   | %8d iter | %10.1f ns/op\n", ITERATIONS, (t1-t0)/ITERATIONS);
	subsd	8(%rsp), %xmm0	# %sfp, tmp627
# bench.c:171:         printf("ASCON permute 12   | %8d iter | %10.1f ns/op\n", ITERATIONS, (t1-t0)/ITERATIONS);
	divsd	.LC12(%rip), %xmm0	#, tmp628
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	call	__printf_chk@PLT	#
# bench.c:177:         uint32_t key[4] = {0x01234567, 0x89ABCDEF, 0x01234567, 0x89ABCDEF};
	movdqa	.LC15(%rip), %xmm0	#, tmp631
# bench.c:133:     clock_gettime(CLOCK_MONOTONIC, &ts);
	movq	%rbx, %rsi	# tmp669,
	movl	$1, %edi	#,
# bench.c:177:         uint32_t key[4] = {0x01234567, 0x89ABCDEF, 0x01234567, 0x89ABCDEF};
	movaps	%xmm0, 112(%rsp)	# tmp631, MEM <vector(4) unsigned int> [(unsigned int *)&key]
# bench.c:133:     clock_gettime(CLOCK_MONOTONIC, &ts);
	call	clock_gettime@PLT	#
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	pxor	%xmm0, %xmm0	# tmp633
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	pxor	%xmm1, %xmm1	# tmp636
# bench.c:179:         for (int n = 0; n < ITERATIONS; n++) {
	xorl	%r10d, %r10d	# n
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	cvtsi2sdq	96(%rsp), %xmm0	# MEM[(struct timespec *)_77].tv_sec, tmp633
	mulsd	.LC11(%rip), %xmm0	#, tmp634
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	cvtsi2sdq	104(%rsp), %xmm1	# MEM[(struct timespec *)_77].tv_nsec, tmp636
	addsd	%xmm1, %xmm0	# tmp636, tmp634
	movsd	%xmm0, 8(%rsp)	# tmp634, %sfp
.L40:
	movl	%r10d, %r11d	# n, state$0
# bench.c:180:             state[0] = n; state[1] = n+1; state[2] = n+2; state[3] = n+3;
	addl	$1, %r10d	#, n
	movl	$19088743, %r9d	#, pretmp_1459
# bench.c:119:     for (int i = 0; i < 32; i++) {
	xorl	%edi, %edi	# i
	movl	%r10d, %r8d	# n,
	leal	2(%r11), %ecx	#, state$2
	leal	3(%r11), %esi	#, state$3
	jmp	.L39	#
	.p2align 4,,10
	.p2align 3
.L49:
# bench.c:124:         uint32_t fbk = s[0] ^ s47 ^ (~(s70 & s85)) ^ s91 ^ key[i & 3];
	movl	%edi, %edx	# i, tmp655
# bench.c:125:         s[0] = s[1]; s[1] = s[2]; s[2] = s[3]; s[3] = fbk;
	movl	%r8d, %r11d	# state$1, state$0
# bench.c:125:         s[0] = s[1]; s[1] = s[2]; s[2] = s[3]; s[3] = fbk;
	movl	%ecx, %r8d	# state$2,
# bench.c:125:         s[0] = s[1]; s[1] = s[2]; s[2] = s[3]; s[3] = fbk;
	movl	%esi, %ecx	# state$3, state$2
# bench.c:124:         uint32_t fbk = s[0] ^ s47 ^ (~(s70 & s85)) ^ s91 ^ key[i & 3];
	andl	$3, %edx	#, tmp655
# bench.c:125:         s[0] = s[1]; s[1] = s[2]; s[2] = s[3]; s[3] = fbk;
	movl	%eax, %esi	# fbk, state$3
# bench.c:124:         uint32_t fbk = s[0] ^ s47 ^ (~(s70 & s85)) ^ s91 ^ key[i & 3];
	movl	112(%rsp,%rdx,4), %r9d	# *_1458, pretmp_1459
.L39:
# bench.c:121:         uint32_t s70 = (s[3] << 26) | (s[2] >> 6);
	movl	%ecx, %eax	# state$2, tmp711
# bench.c:122:         uint32_t s85 = (s[3] << 11) | (s[2] >> 21);
	movl	%ecx, %edx	# state$2, tmp712
# bench.c:123:         uint32_t s91 = (s[3] << 5) | (s[2] >> 27);
	movl	%ecx, %ebp	# state$2, tmp714
# bench.c:119:     for (int i = 0; i < 32; i++) {
	addl	$1, %edi	#, i
# bench.c:122:         uint32_t s85 = (s[3] << 11) | (s[2] >> 21);
	shrdl	$21, %esi, %edx	#, state$3, tmp712
# bench.c:121:         uint32_t s70 = (s[3] << 26) | (s[2] >> 6);
	shrdl	$6, %esi, %eax	#, state$3, tmp711
# bench.c:124:         uint32_t fbk = s[0] ^ s47 ^ (~(s70 & s85)) ^ s91 ^ key[i & 3];
	andl	%edx, %eax	# s85, tmp643
# bench.c:120:         uint32_t s47 = (s[2] << 17) | (s[1] >> 15);
	movl	%r8d, %edx	# state$1, tmp713
# bench.c:123:         uint32_t s91 = (s[3] << 5) | (s[2] >> 27);
	shrdl	$27, %esi, %ebp	#, state$3, tmp714
# bench.c:120:         uint32_t s47 = (s[2] << 17) | (s[1] >> 15);
	shrdl	$15, %ecx, %edx	#, state$2, tmp713
# bench.c:124:         uint32_t fbk = s[0] ^ s47 ^ (~(s70 & s85)) ^ s91 ^ key[i & 3];
	xorl	%ebp, %edx	# s91, tmp650
	xorl	%edx, %eax	# tmp650, tmp651
	xorl	%r11d, %eax	# state$0, tmp652
# bench.c:124:         uint32_t fbk = s[0] ^ s47 ^ (~(s70 & s85)) ^ s91 ^ key[i & 3];
	xorl	%r9d, %eax	# pretmp_1459, fbk
	notl	%eax	# fbk
# bench.c:119:     for (int i = 0; i < 32; i++) {
	cmpl	$32, %edi	#, i
	jne	.L49	#,
# bench.c:182:             sink ^= state[0];
	movq	88(%rsp), %rax	# sink, sink.7_28
	xorq	%rax, %r8	# sink.7_28, _29
	movq	%r8, 88(%rsp)	# _29, sink
# bench.c:179:         for (int n = 0; n < ITERATIONS; n++) {
	cmpl	$500000, %r10d	#, n
	jne	.L40	#,
# bench.c:133:     clock_gettime(CLOCK_MONOTONIC, &ts);
	movq	%rbx, %rsi	# tmp669,
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	pxor	%xmm0, %xmm0	# tmp658
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	pxor	%xmm1, %xmm1	# tmp661
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	$500000, %edx	#,
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	cvtsi2sdq	96(%rsp), %xmm0	# MEM[(struct timespec *)_77].tv_sec, tmp658
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	$2, %edi	#,
	movl	$1, %eax	#,
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	mulsd	.LC11(%rip), %xmm0	#, tmp659
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	cvtsi2sdq	104(%rsp), %xmm1	# MEM[(struct timespec *)_77].tv_nsec, tmp661
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC16(%rip), %rsi	#, tmp665
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	addsd	%xmm1, %xmm0	# tmp661, _119
# bench.c:185:         printf("TinyJAMBU upd 1024 | %8d iter | %10.1f ns/op\n", ITERATIONS, (t1-t0)/ITERATIONS);
	subsd	8(%rsp), %xmm0	# %sfp, tmp662
# bench.c:185:         printf("TinyJAMBU upd 1024 | %8d iter | %10.1f ns/op\n", ITERATIONS, (t1-t0)/ITERATIONS);
	divsd	.LC12(%rip), %xmm0	#, tmp663
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	call	__printf_chk@PLT	#
# bench.c:188:     printf("\nsink=%llu (prevent DCE)\n", (unsigned long long)sink);
	movq	88(%rsp), %rdx	# sink, sink.8_32
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	xorl	%eax, %eax	#
	leaq	.LC17(%rip), %rsi	#, tmp666
	movl	$2, %edi	#,
	call	__printf_chk@PLT	#
# bench.c:190: }
	movq	312(%rsp), %rax	# D.4826, tmp716
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp716
	jne	.L50	#,
	addq	$328, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax	#
	popq	%rbx	#
	.cfi_def_cfa_offset 48
	popq	%rbp	#
	.cfi_def_cfa_offset 40
	popq	%r12	#
	.cfi_def_cfa_offset 32
	popq	%r13	#
	.cfi_def_cfa_offset 24
	popq	%r14	#
	.cfi_def_cfa_offset 16
	popq	%r15	#
	.cfi_def_cfa_offset 8
	ret	
.L50:
	.cfi_restore_state
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE59:
	.size	main, .-main
	.section	.rodata
	.align 32
	.type	AES_SBOX, @object
	.size	AES_SBOX, 256
AES_SBOX:
	.string	"c|w{\362ko\3050\001g+\376\327\253v\312\202\311}\372YG\360\255\324\242\257\234\244r\300\267\375\223&6?\367\3144\245\345\361q\3301\025\004\307#\303\030\226\005\232\007\022\200\342\353'\262u\t\203,\032\033nZ\240R;\326\263)\343/\204S\321"
	.ascii	"\355 \374\261[j\313\2769JLX\317\320\357\252\373CM3\205E\371\002"
	.ascii	"\177P<\237\250Q\243@\217\222\2358\365\274\266\332!\020\377\363"
	.ascii	"\322\315\f\023\354_\227D\027\304\247~=d]\031s`\201O\334\"*\220"
	.ascii	"\210F\356\270\024\336^\013\333\3402:\nI\006$\\\302\323\254b\221"
	.ascii	"\225\344y\347\3107m\215\325N\251lV\364\352ez\256\b\272x%.\034"
	.ascii	"\246\264\306\350\335t\037K\275\213\212p>\265fH\003\366\016a5"
	.ascii	"W\271\206\301\035\236\341\370\230\021i\331\216\224\233\036\207"
	.ascii	"\351\316U(\337\214\241\211\r\277\346BhA\231-\017\260T\273\026"
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.byte	13
	.byte	20
	.byte	27
	.byte	34
	.byte	41
	.byte	48
	.byte	55
	.byte	62
	.byte	69
	.byte	76
	.byte	83
	.byte	90
	.byte	97
	.byte	104
	.byte	111
	.byte	118
	.align 16
.LC1:
	.byte	125
	.byte	-124
	.byte	-117
	.byte	-110
	.byte	-103
	.byte	-96
	.byte	-89
	.byte	-82
	.byte	-75
	.byte	-68
	.byte	-61
	.byte	-54
	.byte	-47
	.byte	-40
	.byte	-33
	.byte	-26
	.align 16
.LC2:
	.byte	-19
	.byte	-12
	.byte	-5
	.byte	2
	.byte	9
	.byte	16
	.byte	23
	.byte	30
	.byte	37
	.byte	44
	.byte	51
	.byte	58
	.byte	65
	.byte	72
	.byte	79
	.byte	86
	.align 16
.LC3:
	.byte	93
	.byte	100
	.byte	107
	.byte	114
	.byte	121
	.byte	-128
	.byte	-121
	.byte	-114
	.byte	-107
	.byte	-100
	.byte	-93
	.byte	-86
	.byte	-79
	.byte	-72
	.byte	-65
	.byte	-58
	.align 16
.LC4:
	.byte	-51
	.byte	-44
	.byte	-37
	.byte	-30
	.byte	-23
	.byte	-16
	.byte	-9
	.byte	-2
	.byte	5
	.byte	12
	.byte	19
	.byte	26
	.byte	33
	.byte	40
	.byte	47
	.byte	54
	.align 16
.LC5:
	.byte	61
	.byte	68
	.byte	75
	.byte	82
	.byte	89
	.byte	96
	.byte	103
	.byte	110
	.byte	117
	.byte	124
	.byte	-125
	.byte	-118
	.byte	-111
	.byte	-104
	.byte	-97
	.byte	-90
	.align 16
.LC6:
	.byte	-83
	.byte	-76
	.byte	-69
	.byte	-62
	.byte	-55
	.byte	-48
	.byte	-41
	.byte	-34
	.byte	-27
	.byte	-20
	.byte	-13
	.byte	-6
	.byte	1
	.byte	8
	.byte	15
	.byte	22
	.align 16
.LC7:
	.byte	29
	.byte	36
	.byte	43
	.byte	50
	.byte	57
	.byte	64
	.byte	71
	.byte	78
	.byte	85
	.byte	92
	.byte	99
	.byte	106
	.byte	113
	.byte	120
	.byte	127
	.byte	-122
	.align 16
.LC8:
	.byte	-115
	.byte	-108
	.byte	-101
	.byte	-94
	.byte	-87
	.byte	-80
	.byte	-73
	.byte	-66
	.byte	-59
	.byte	-52
	.byte	-45
	.byte	-38
	.byte	-31
	.byte	-24
	.byte	-17
	.byte	-10
	.align 16
.LC9:
	.byte	-3
	.byte	4
	.byte	11
	.byte	18
	.byte	25
	.byte	32
	.byte	39
	.byte	46
	.byte	53
	.byte	60
	.byte	67
	.byte	74
	.byte	81
	.byte	88
	.byte	95
	.byte	102
	.align 16
.LC10:
	.byte	109
	.byte	116
	.byte	123
	.byte	-126
	.byte	-119
	.byte	-112
	.byte	-105
	.byte	-98
	.byte	-91
	.byte	-84
	.byte	-77
	.byte	-70
	.byte	-63
	.byte	-56
	.byte	-49
	.byte	-42
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC11:
	.long	0
	.long	1104006501
	.align 8
.LC12:
	.long	0
	.long	1092519040
	.section	.rodata.cst16
	.align 16
.LC15:
	.long	19088743
	.long	-1985229329
	.long	19088743
	.long	-1985229329
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
