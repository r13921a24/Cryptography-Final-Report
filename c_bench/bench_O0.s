	.file	"bench.c"
# GNU C17 (Ubuntu 13.3.0-6ubuntu2~24.04.1) version 13.3.0 (x86_64-linux-gnu)
#	compiled by GNU C version 13.3.0, GMP version 6.3.0, MPFR version 4.2.1, MPC version 1.3.1, isl version isl-0.26-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mtune=generic -march=x86-64 -O0 -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection
	.text
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
	.text
	.type	xtime, @function
xtime:
.LFB6:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	movl	%edi, %eax	# a, tmp88
	movb	%al, -4(%rbp)	# tmp89, a
# bench.c:38:     return (a & 0x80) ? ((a << 1) ^ 0x1B) : (a << 1);
	movzbl	-4(%rbp), %eax	# a, a.1_1
# bench.c:38:     return (a & 0x80) ? ((a << 1) ^ 0x1B) : (a << 1);
	testb	%al, %al	# a.1_1
	jns	.L2	#,
# bench.c:38:     return (a & 0x80) ? ((a << 1) ^ 0x1B) : (a << 1);
	movzbl	-4(%rbp), %eax	# a, a.2_2
	addl	%eax, %eax	# _3
	xorl	$27, %eax	#, _4
# bench.c:38:     return (a & 0x80) ? ((a << 1) ^ 0x1B) : (a << 1);
	jmp	.L4	#
.L2:
# bench.c:38:     return (a & 0x80) ? ((a << 1) ^ 0x1B) : (a << 1);
	movzbl	-4(%rbp), %eax	# a, tmp90
	addl	%eax, %eax	# iftmp.0_5
.L4:
# bench.c:39: }
	popq	%rbp	#
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE6:
	.size	xtime, .-xtime
	.type	aes_encrypt_block, @function
aes_encrypt_block:
.LFB7:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	pushq	%rbx	#
	subq	$48, %rsp	#,
	.cfi_offset 3, -24
	movq	%rdi, -48(%rbp)	# state, state
	movq	%rsi, -56(%rbp)	# rk, rk
# bench.c:46:     for (i = 0; i < 16; i++) state[i] ^= rk[i];
	movb	$0, -25(%rbp)	#, i
# bench.c:46:     for (i = 0; i < 16; i++) state[i] ^= rk[i];
	jmp	.L6	#
.L7:
# bench.c:46:     for (i = 0; i < 16; i++) state[i] ^= rk[i];
	movzbl	-25(%rbp), %edx	# i, _1
	movq	-48(%rbp), %rax	# state, tmp214
	addq	%rdx, %rax	# _1, _2
	movzbl	(%rax), %esi	# *_2, _3
# bench.c:46:     for (i = 0; i < 16; i++) state[i] ^= rk[i];
	movzbl	-25(%rbp), %edx	# i, _4
	movq	-56(%rbp), %rax	# rk, tmp215
	addq	%rdx, %rax	# _4, _5
	movzbl	(%rax), %ecx	# *_5, _6
# bench.c:46:     for (i = 0; i < 16; i++) state[i] ^= rk[i];
	movzbl	-25(%rbp), %edx	# i, _7
	movq	-48(%rbp), %rax	# state, tmp216
	addq	%rdx, %rax	# _7, _8
# bench.c:46:     for (i = 0; i < 16; i++) state[i] ^= rk[i];
	xorl	%ecx, %esi	# _6, _3
	movl	%esi, %edx	# _3, _9
	movb	%dl, (%rax)	# _9, *_8
# bench.c:46:     for (i = 0; i < 16; i++) state[i] ^= rk[i];
	movzbl	-25(%rbp), %eax	# i, i.3_10
	addl	$1, %eax	#, tmp217
	movb	%al, -25(%rbp)	# tmp217, i
.L6:
# bench.c:46:     for (i = 0; i < 16; i++) state[i] ^= rk[i];
	cmpb	$15, -25(%rbp)	#, i
	jbe	.L7	#,
# bench.c:48:     for (r = 1; r < 10; r++) {
	movb	$1, -24(%rbp)	#, r
# bench.c:48:     for (r = 1; r < 10; r++) {
	jmp	.L8	#
.L15:
# bench.c:50:         for (i = 0; i < 16; i++) state[i] = AES_SBOX[state[i]];
	movb	$0, -25(%rbp)	#, i
# bench.c:50:         for (i = 0; i < 16; i++) state[i] = AES_SBOX[state[i]];
	jmp	.L9	#
.L10:
# bench.c:50:         for (i = 0; i < 16; i++) state[i] = AES_SBOX[state[i]];
	movzbl	-25(%rbp), %edx	# i, _11
	movq	-48(%rbp), %rax	# state, tmp218
	addq	%rdx, %rax	# _11, _12
	movzbl	(%rax), %eax	# *_12, _13
	movzbl	%al, %eax	# _13, _14
# bench.c:50:         for (i = 0; i < 16; i++) state[i] = AES_SBOX[state[i]];
	movzbl	-25(%rbp), %ecx	# i, _15
	movq	-48(%rbp), %rdx	# state, tmp219
	addq	%rcx, %rdx	# _15, _16
# bench.c:50:         for (i = 0; i < 16; i++) state[i] = AES_SBOX[state[i]];
	cltq
	leaq	AES_SBOX(%rip), %rcx	#, tmp221
	movzbl	(%rax,%rcx), %eax	# AES_SBOX[_14], _17
# bench.c:50:         for (i = 0; i < 16; i++) state[i] = AES_SBOX[state[i]];
	movb	%al, (%rdx)	# _17, *_16
# bench.c:50:         for (i = 0; i < 16; i++) state[i] = AES_SBOX[state[i]];
	movzbl	-25(%rbp), %eax	# i, i.4_18
	addl	$1, %eax	#, tmp222
	movb	%al, -25(%rbp)	# tmp222, i
.L9:
# bench.c:50:         for (i = 0; i < 16; i++) state[i] = AES_SBOX[state[i]];
	cmpb	$15, -25(%rbp)	#, i
	jbe	.L10	#,
# bench.c:53:         uint8_t tmp = state[1];
	movq	-48(%rbp), %rax	# state, tmp223
	movzbl	1(%rax), %eax	# MEM[(uint8_t *)state_151(D) + 1B], tmp224
	movb	%al, -21(%rbp)	# tmp224, tmp
# bench.c:54:         state[1] = state[5]; state[5] = state[9]; state[9] = state[13]; state[13] = tmp;
	movq	-48(%rbp), %rax	# state, tmp225
	leaq	1(%rax), %rdx	#, _19
# bench.c:54:         state[1] = state[5]; state[5] = state[9]; state[9] = state[13]; state[13] = tmp;
	movq	-48(%rbp), %rax	# state, tmp226
	movzbl	5(%rax), %eax	# MEM[(uint8_t *)state_151(D) + 5B], _20
	movb	%al, (%rdx)	# _20, *_19
# bench.c:54:         state[1] = state[5]; state[5] = state[9]; state[9] = state[13]; state[13] = tmp;
	movq	-48(%rbp), %rax	# state, tmp227
	leaq	5(%rax), %rdx	#, _21
# bench.c:54:         state[1] = state[5]; state[5] = state[9]; state[9] = state[13]; state[13] = tmp;
	movq	-48(%rbp), %rax	# state, tmp228
	movzbl	9(%rax), %eax	# MEM[(uint8_t *)state_151(D) + 9B], _22
	movb	%al, (%rdx)	# _22, *_21
# bench.c:54:         state[1] = state[5]; state[5] = state[9]; state[9] = state[13]; state[13] = tmp;
	movq	-48(%rbp), %rax	# state, tmp229
	leaq	9(%rax), %rdx	#, _23
# bench.c:54:         state[1] = state[5]; state[5] = state[9]; state[9] = state[13]; state[13] = tmp;
	movq	-48(%rbp), %rax	# state, tmp230
	movzbl	13(%rax), %eax	# MEM[(uint8_t *)state_151(D) + 13B], _24
	movb	%al, (%rdx)	# _24, *_23
# bench.c:54:         state[1] = state[5]; state[5] = state[9]; state[9] = state[13]; state[13] = tmp;
	movq	-48(%rbp), %rax	# state, tmp231
	leaq	13(%rax), %rdx	#, _25
# bench.c:54:         state[1] = state[5]; state[5] = state[9]; state[9] = state[13]; state[13] = tmp;
	movzbl	-21(%rbp), %eax	# tmp, tmp232
	movb	%al, (%rdx)	# tmp232, *_25
# bench.c:55:         tmp = state[2]; state[2] = state[10]; state[10] = tmp;
	movq	-48(%rbp), %rax	# state, tmp233
	movzbl	2(%rax), %eax	# MEM[(uint8_t *)state_151(D) + 2B], tmp234
	movb	%al, -21(%rbp)	# tmp234, tmp
# bench.c:55:         tmp = state[2]; state[2] = state[10]; state[10] = tmp;
	movq	-48(%rbp), %rax	# state, tmp235
	leaq	2(%rax), %rdx	#, _26
# bench.c:55:         tmp = state[2]; state[2] = state[10]; state[10] = tmp;
	movq	-48(%rbp), %rax	# state, tmp236
	movzbl	10(%rax), %eax	# MEM[(uint8_t *)state_151(D) + 10B], _27
	movb	%al, (%rdx)	# _27, *_26
# bench.c:55:         tmp = state[2]; state[2] = state[10]; state[10] = tmp;
	movq	-48(%rbp), %rax	# state, tmp237
	leaq	10(%rax), %rdx	#, _28
# bench.c:55:         tmp = state[2]; state[2] = state[10]; state[10] = tmp;
	movzbl	-21(%rbp), %eax	# tmp, tmp238
	movb	%al, (%rdx)	# tmp238, *_28
# bench.c:56:         tmp = state[6]; state[6] = state[14]; state[14] = tmp;
	movq	-48(%rbp), %rax	# state, tmp239
	movzbl	6(%rax), %eax	# MEM[(uint8_t *)state_151(D) + 6B], tmp240
	movb	%al, -21(%rbp)	# tmp240, tmp
# bench.c:56:         tmp = state[6]; state[6] = state[14]; state[14] = tmp;
	movq	-48(%rbp), %rax	# state, tmp241
	leaq	6(%rax), %rdx	#, _29
# bench.c:56:         tmp = state[6]; state[6] = state[14]; state[14] = tmp;
	movq	-48(%rbp), %rax	# state, tmp242
	movzbl	14(%rax), %eax	# MEM[(uint8_t *)state_151(D) + 14B], _30
	movb	%al, (%rdx)	# _30, *_29
# bench.c:56:         tmp = state[6]; state[6] = state[14]; state[14] = tmp;
	movq	-48(%rbp), %rax	# state, tmp243
	leaq	14(%rax), %rdx	#, _31
# bench.c:56:         tmp = state[6]; state[6] = state[14]; state[14] = tmp;
	movzbl	-21(%rbp), %eax	# tmp, tmp244
	movb	%al, (%rdx)	# tmp244, *_31
# bench.c:57:         tmp = state[3]; state[3] = state[15]; state[15] = state[11]; state[11] = state[7]; state[7] = tmp;
	movq	-48(%rbp), %rax	# state, tmp245
	movzbl	3(%rax), %eax	# MEM[(uint8_t *)state_151(D) + 3B], tmp246
	movb	%al, -21(%rbp)	# tmp246, tmp
# bench.c:57:         tmp = state[3]; state[3] = state[15]; state[15] = state[11]; state[11] = state[7]; state[7] = tmp;
	movq	-48(%rbp), %rax	# state, tmp247
	leaq	3(%rax), %rdx	#, _32
# bench.c:57:         tmp = state[3]; state[3] = state[15]; state[15] = state[11]; state[11] = state[7]; state[7] = tmp;
	movq	-48(%rbp), %rax	# state, tmp248
	movzbl	15(%rax), %eax	# MEM[(uint8_t *)state_151(D) + 15B], _33
	movb	%al, (%rdx)	# _33, *_32
# bench.c:57:         tmp = state[3]; state[3] = state[15]; state[15] = state[11]; state[11] = state[7]; state[7] = tmp;
	movq	-48(%rbp), %rax	# state, tmp249
	leaq	15(%rax), %rdx	#, _34
# bench.c:57:         tmp = state[3]; state[3] = state[15]; state[15] = state[11]; state[11] = state[7]; state[7] = tmp;
	movq	-48(%rbp), %rax	# state, tmp250
	movzbl	11(%rax), %eax	# MEM[(uint8_t *)state_151(D) + 11B], _35
	movb	%al, (%rdx)	# _35, *_34
# bench.c:57:         tmp = state[3]; state[3] = state[15]; state[15] = state[11]; state[11] = state[7]; state[7] = tmp;
	movq	-48(%rbp), %rax	# state, tmp251
	leaq	11(%rax), %rdx	#, _36
# bench.c:57:         tmp = state[3]; state[3] = state[15]; state[15] = state[11]; state[11] = state[7]; state[7] = tmp;
	movq	-48(%rbp), %rax	# state, tmp252
	movzbl	7(%rax), %eax	# MEM[(uint8_t *)state_151(D) + 7B], _37
	movb	%al, (%rdx)	# _37, *_36
# bench.c:57:         tmp = state[3]; state[3] = state[15]; state[15] = state[11]; state[11] = state[7]; state[7] = tmp;
	movq	-48(%rbp), %rax	# state, tmp253
	leaq	7(%rax), %rdx	#, _38
# bench.c:57:         tmp = state[3]; state[3] = state[15]; state[15] = state[11]; state[11] = state[7]; state[7] = tmp;
	movzbl	-21(%rbp), %eax	# tmp, tmp254
	movb	%al, (%rdx)	# tmp254, *_38
# bench.c:60:         for (uint8_t c = 0; c < 4; c++) {
	movb	$0, -23(%rbp)	#, c
# bench.c:60:         for (uint8_t c = 0; c < 4; c++) {
	jmp	.L11	#
.L12:
# bench.c:61:             uint8_t *col = state + c * 4;
	movzbl	-23(%rbp), %eax	# c, _39
	sall	$2, %eax	#, _40
	movslq	%eax, %rdx	# _40, _41
# bench.c:61:             uint8_t *col = state + c * 4;
	movq	-48(%rbp), %rax	# state, tmp258
	addq	%rdx, %rax	# _41, tmp257
	movq	%rax, -16(%rbp)	# tmp257, col
# bench.c:62:             uint8_t a0 = col[0], a1 = col[1], a2 = col[2], a3 = col[3];
	movq	-16(%rbp), %rax	# col, tmp259
	movzbl	(%rax), %eax	# *col_196, tmp260
	movb	%al, -20(%rbp)	# tmp260, a0
# bench.c:62:             uint8_t a0 = col[0], a1 = col[1], a2 = col[2], a3 = col[3];
	movq	-16(%rbp), %rax	# col, tmp261
	movzbl	1(%rax), %eax	# MEM[(uint8_t *)col_196 + 1B], tmp262
	movb	%al, -19(%rbp)	# tmp262, a1
# bench.c:62:             uint8_t a0 = col[0], a1 = col[1], a2 = col[2], a3 = col[3];
	movq	-16(%rbp), %rax	# col, tmp263
	movzbl	2(%rax), %eax	# MEM[(uint8_t *)col_196 + 2B], tmp264
	movb	%al, -18(%rbp)	# tmp264, a2
# bench.c:62:             uint8_t a0 = col[0], a1 = col[1], a2 = col[2], a3 = col[3];
	movq	-16(%rbp), %rax	# col, tmp265
	movzbl	3(%rax), %eax	# MEM[(uint8_t *)col_196 + 3B], tmp266
	movb	%al, -17(%rbp)	# tmp266, a3
# bench.c:63:             col[0] = xtime(a0) ^ (xtime(a1) ^ a1) ^ a2 ^ a3;
	movzbl	-20(%rbp), %eax	# a0, _42
	movl	%eax, %edi	# _42,
	call	xtime	#
	movl	%eax, %ebx	#, _43
# bench.c:63:             col[0] = xtime(a0) ^ (xtime(a1) ^ a1) ^ a2 ^ a3;
	movzbl	-19(%rbp), %eax	# a1, _44
	movl	%eax, %edi	# _44,
	call	xtime	#
# bench.c:63:             col[0] = xtime(a0) ^ (xtime(a1) ^ a1) ^ a2 ^ a3;
	xorb	-19(%rbp), %al	# a1, _46
	xorl	%ebx, %eax	# _43, _47
	xorb	-18(%rbp), %al	# a2, _48
	xorb	-17(%rbp), %al	# a3, _48
	movl	%eax, %edx	# _48, _49
	movq	-16(%rbp), %rax	# col, tmp267
	movb	%dl, (%rax)	# _49, *col_196
# bench.c:64:             col[1] = a0 ^ xtime(a1) ^ (xtime(a2) ^ a2) ^ a3;
	movzbl	-19(%rbp), %eax	# a1, _50
	movl	%eax, %edi	# _50,
	call	xtime	#
# bench.c:64:             col[1] = a0 ^ xtime(a1) ^ (xtime(a2) ^ a2) ^ a3;
	xorb	-20(%rbp), %al	# a0, _51
	movl	%eax, %ebx	# _51, _52
# bench.c:64:             col[1] = a0 ^ xtime(a1) ^ (xtime(a2) ^ a2) ^ a3;
	movzbl	-18(%rbp), %eax	# a2, _53
	movl	%eax, %edi	# _53,
	call	xtime	#
# bench.c:64:             col[1] = a0 ^ xtime(a1) ^ (xtime(a2) ^ a2) ^ a3;
	xorb	-18(%rbp), %al	# a2, _55
	xorl	%ebx, %eax	# _52, _56
# bench.c:64:             col[1] = a0 ^ xtime(a1) ^ (xtime(a2) ^ a2) ^ a3;
	movq	-16(%rbp), %rdx	# col, tmp268
	addq	$1, %rdx	#, _57
# bench.c:64:             col[1] = a0 ^ xtime(a1) ^ (xtime(a2) ^ a2) ^ a3;
	xorb	-17(%rbp), %al	# a3, _58
	movb	%al, (%rdx)	# _58, *_57
# bench.c:65:             col[2] = a0 ^ a1 ^ xtime(a2) ^ (xtime(a3) ^ a3);
	movzbl	-20(%rbp), %eax	# a0, tmp269
	xorb	-19(%rbp), %al	# a1, tmp269
	movl	%eax, %ebx	# tmp269, _59
# bench.c:65:             col[2] = a0 ^ a1 ^ xtime(a2) ^ (xtime(a3) ^ a3);
	movzbl	-18(%rbp), %eax	# a2, _60
	movl	%eax, %edi	# _60,
	call	xtime	#
# bench.c:65:             col[2] = a0 ^ a1 ^ xtime(a2) ^ (xtime(a3) ^ a3);
	xorl	%eax, %ebx	# _61, _62
# bench.c:65:             col[2] = a0 ^ a1 ^ xtime(a2) ^ (xtime(a3) ^ a3);
	movzbl	-17(%rbp), %eax	# a3, _63
	movl	%eax, %edi	# _63,
	call	xtime	#
# bench.c:65:             col[2] = a0 ^ a1 ^ xtime(a2) ^ (xtime(a3) ^ a3);
	xorb	-17(%rbp), %al	# a3, _64
	movl	%eax, %edx	# _64, _65
# bench.c:65:             col[2] = a0 ^ a1 ^ xtime(a2) ^ (xtime(a3) ^ a3);
	movq	-16(%rbp), %rax	# col, tmp270
	addq	$2, %rax	#, _66
# bench.c:65:             col[2] = a0 ^ a1 ^ xtime(a2) ^ (xtime(a3) ^ a3);
	xorl	%ebx, %edx	# _62, _67
	movb	%dl, (%rax)	# _67, *_66
# bench.c:66:             col[3] = (xtime(a0) ^ a0) ^ a1 ^ a2 ^ xtime(a3);
	movzbl	-20(%rbp), %eax	# a0, _68
	movl	%eax, %edi	# _68,
	call	xtime	#
# bench.c:66:             col[3] = (xtime(a0) ^ a0) ^ a1 ^ a2 ^ xtime(a3);
	xorb	-20(%rbp), %al	# a0, _70
	xorb	-19(%rbp), %al	# a1, _71
	xorb	-18(%rbp), %al	# a2, _71
	movl	%eax, %ebx	# _71, _72
# bench.c:66:             col[3] = (xtime(a0) ^ a0) ^ a1 ^ a2 ^ xtime(a3);
	movzbl	-17(%rbp), %eax	# a3, _73
	movl	%eax, %edi	# _73,
	call	xtime	#
	movl	%eax, %edx	#, _74
# bench.c:66:             col[3] = (xtime(a0) ^ a0) ^ a1 ^ a2 ^ xtime(a3);
	movq	-16(%rbp), %rax	# col, tmp271
	addq	$3, %rax	#, _75
# bench.c:66:             col[3] = (xtime(a0) ^ a0) ^ a1 ^ a2 ^ xtime(a3);
	xorl	%ebx, %edx	# _72, _76
	movb	%dl, (%rax)	# _76, *_75
# bench.c:60:         for (uint8_t c = 0; c < 4; c++) {
	movzbl	-23(%rbp), %eax	# c, c.5_77
	addl	$1, %eax	#, tmp272
	movb	%al, -23(%rbp)	# tmp272, c
.L11:
# bench.c:60:         for (uint8_t c = 0; c < 4; c++) {
	cmpb	$3, -23(%rbp)	#, c
	jbe	.L12	#,
# bench.c:70:         for (i = 0; i < 16; i++) state[i] ^= rk[r * 16 + i];
	movb	$0, -25(%rbp)	#, i
# bench.c:70:         for (i = 0; i < 16; i++) state[i] ^= rk[r * 16 + i];
	jmp	.L13	#
.L14:
# bench.c:70:         for (i = 0; i < 16; i++) state[i] ^= rk[r * 16 + i];
	movzbl	-25(%rbp), %edx	# i, _78
	movq	-48(%rbp), %rax	# state, tmp273
	addq	%rdx, %rax	# _78, _79
	movzbl	(%rax), %esi	# *_79, _80
# bench.c:70:         for (i = 0; i < 16; i++) state[i] ^= rk[r * 16 + i];
	movzbl	-24(%rbp), %eax	# r, _81
	sall	$4, %eax	#, _81
	movl	%eax, %edx	# _81, _82
# bench.c:70:         for (i = 0; i < 16; i++) state[i] ^= rk[r * 16 + i];
	movzbl	-25(%rbp), %eax	# i, _83
	addl	%edx, %eax	# _82, _84
	movslq	%eax, %rdx	# _84, _85
# bench.c:70:         for (i = 0; i < 16; i++) state[i] ^= rk[r * 16 + i];
	movq	-56(%rbp), %rax	# rk, tmp274
	addq	%rdx, %rax	# _85, _86
	movzbl	(%rax), %ecx	# *_86, _87
# bench.c:70:         for (i = 0; i < 16; i++) state[i] ^= rk[r * 16 + i];
	movzbl	-25(%rbp), %edx	# i, _88
	movq	-48(%rbp), %rax	# state, tmp275
	addq	%rdx, %rax	# _88, _89
# bench.c:70:         for (i = 0; i < 16; i++) state[i] ^= rk[r * 16 + i];
	xorl	%ecx, %esi	# _87, _80
	movl	%esi, %edx	# _80, _90
	movb	%dl, (%rax)	# _90, *_89
# bench.c:70:         for (i = 0; i < 16; i++) state[i] ^= rk[r * 16 + i];
	movzbl	-25(%rbp), %eax	# i, i.6_91
	addl	$1, %eax	#, tmp276
	movb	%al, -25(%rbp)	# tmp276, i
.L13:
# bench.c:70:         for (i = 0; i < 16; i++) state[i] ^= rk[r * 16 + i];
	cmpb	$15, -25(%rbp)	#, i
	jbe	.L14	#,
# bench.c:48:     for (r = 1; r < 10; r++) {
	movzbl	-24(%rbp), %eax	# r, r.7_92
	addl	$1, %eax	#, tmp277
	movb	%al, -24(%rbp)	# tmp277, r
.L8:
# bench.c:48:     for (r = 1; r < 10; r++) {
	cmpb	$9, -24(%rbp)	#, r
	jbe	.L15	#,
# bench.c:74:     for (i = 0; i < 16; i++) state[i] = AES_SBOX[state[i]];
	movb	$0, -25(%rbp)	#, i
# bench.c:74:     for (i = 0; i < 16; i++) state[i] = AES_SBOX[state[i]];
	jmp	.L16	#
.L17:
# bench.c:74:     for (i = 0; i < 16; i++) state[i] = AES_SBOX[state[i]];
	movzbl	-25(%rbp), %edx	# i, _93
	movq	-48(%rbp), %rax	# state, tmp278
	addq	%rdx, %rax	# _93, _94
	movzbl	(%rax), %eax	# *_94, _95
	movzbl	%al, %eax	# _95, _96
# bench.c:74:     for (i = 0; i < 16; i++) state[i] = AES_SBOX[state[i]];
	movzbl	-25(%rbp), %ecx	# i, _97
	movq	-48(%rbp), %rdx	# state, tmp279
	addq	%rcx, %rdx	# _97, _98
# bench.c:74:     for (i = 0; i < 16; i++) state[i] = AES_SBOX[state[i]];
	cltq
	leaq	AES_SBOX(%rip), %rcx	#, tmp281
	movzbl	(%rax,%rcx), %eax	# AES_SBOX[_96], _99
# bench.c:74:     for (i = 0; i < 16; i++) state[i] = AES_SBOX[state[i]];
	movb	%al, (%rdx)	# _99, *_98
# bench.c:74:     for (i = 0; i < 16; i++) state[i] = AES_SBOX[state[i]];
	movzbl	-25(%rbp), %eax	# i, i.8_100
	addl	$1, %eax	#, tmp282
	movb	%al, -25(%rbp)	# tmp282, i
.L16:
# bench.c:74:     for (i = 0; i < 16; i++) state[i] = AES_SBOX[state[i]];
	cmpb	$15, -25(%rbp)	#, i
	jbe	.L17	#,
# bench.c:75:     uint8_t tmp = state[1];
	movq	-48(%rbp), %rax	# state, tmp283
	movzbl	1(%rax), %eax	# MEM[(uint8_t *)state_151(D) + 1B], tmp284
	movb	%al, -22(%rbp)	# tmp284, tmp
# bench.c:76:     state[1] = state[5]; state[5] = state[9]; state[9] = state[13]; state[13] = tmp;
	movq	-48(%rbp), %rax	# state, tmp285
	leaq	1(%rax), %rdx	#, _101
# bench.c:76:     state[1] = state[5]; state[5] = state[9]; state[9] = state[13]; state[13] = tmp;
	movq	-48(%rbp), %rax	# state, tmp286
	movzbl	5(%rax), %eax	# MEM[(uint8_t *)state_151(D) + 5B], _102
	movb	%al, (%rdx)	# _102, *_101
# bench.c:76:     state[1] = state[5]; state[5] = state[9]; state[9] = state[13]; state[13] = tmp;
	movq	-48(%rbp), %rax	# state, tmp287
	leaq	5(%rax), %rdx	#, _103
# bench.c:76:     state[1] = state[5]; state[5] = state[9]; state[9] = state[13]; state[13] = tmp;
	movq	-48(%rbp), %rax	# state, tmp288
	movzbl	9(%rax), %eax	# MEM[(uint8_t *)state_151(D) + 9B], _104
	movb	%al, (%rdx)	# _104, *_103
# bench.c:76:     state[1] = state[5]; state[5] = state[9]; state[9] = state[13]; state[13] = tmp;
	movq	-48(%rbp), %rax	# state, tmp289
	leaq	9(%rax), %rdx	#, _105
# bench.c:76:     state[1] = state[5]; state[5] = state[9]; state[9] = state[13]; state[13] = tmp;
	movq	-48(%rbp), %rax	# state, tmp290
	movzbl	13(%rax), %eax	# MEM[(uint8_t *)state_151(D) + 13B], _106
	movb	%al, (%rdx)	# _106, *_105
# bench.c:76:     state[1] = state[5]; state[5] = state[9]; state[9] = state[13]; state[13] = tmp;
	movq	-48(%rbp), %rax	# state, tmp291
	leaq	13(%rax), %rdx	#, _107
# bench.c:76:     state[1] = state[5]; state[5] = state[9]; state[9] = state[13]; state[13] = tmp;
	movzbl	-22(%rbp), %eax	# tmp, tmp292
	movb	%al, (%rdx)	# tmp292, *_107
# bench.c:77:     tmp = state[2]; state[2] = state[10]; state[10] = tmp;
	movq	-48(%rbp), %rax	# state, tmp293
	movzbl	2(%rax), %eax	# MEM[(uint8_t *)state_151(D) + 2B], tmp294
	movb	%al, -22(%rbp)	# tmp294, tmp
# bench.c:77:     tmp = state[2]; state[2] = state[10]; state[10] = tmp;
	movq	-48(%rbp), %rax	# state, tmp295
	leaq	2(%rax), %rdx	#, _108
# bench.c:77:     tmp = state[2]; state[2] = state[10]; state[10] = tmp;
	movq	-48(%rbp), %rax	# state, tmp296
	movzbl	10(%rax), %eax	# MEM[(uint8_t *)state_151(D) + 10B], _109
	movb	%al, (%rdx)	# _109, *_108
# bench.c:77:     tmp = state[2]; state[2] = state[10]; state[10] = tmp;
	movq	-48(%rbp), %rax	# state, tmp297
	leaq	10(%rax), %rdx	#, _110
# bench.c:77:     tmp = state[2]; state[2] = state[10]; state[10] = tmp;
	movzbl	-22(%rbp), %eax	# tmp, tmp298
	movb	%al, (%rdx)	# tmp298, *_110
# bench.c:78:     tmp = state[6]; state[6] = state[14]; state[14] = tmp;
	movq	-48(%rbp), %rax	# state, tmp299
	movzbl	6(%rax), %eax	# MEM[(uint8_t *)state_151(D) + 6B], tmp300
	movb	%al, -22(%rbp)	# tmp300, tmp
# bench.c:78:     tmp = state[6]; state[6] = state[14]; state[14] = tmp;
	movq	-48(%rbp), %rax	# state, tmp301
	leaq	6(%rax), %rdx	#, _111
# bench.c:78:     tmp = state[6]; state[6] = state[14]; state[14] = tmp;
	movq	-48(%rbp), %rax	# state, tmp302
	movzbl	14(%rax), %eax	# MEM[(uint8_t *)state_151(D) + 14B], _112
	movb	%al, (%rdx)	# _112, *_111
# bench.c:78:     tmp = state[6]; state[6] = state[14]; state[14] = tmp;
	movq	-48(%rbp), %rax	# state, tmp303
	leaq	14(%rax), %rdx	#, _113
# bench.c:78:     tmp = state[6]; state[6] = state[14]; state[14] = tmp;
	movzbl	-22(%rbp), %eax	# tmp, tmp304
	movb	%al, (%rdx)	# tmp304, *_113
# bench.c:79:     tmp = state[3]; state[3] = state[15]; state[15] = state[11]; state[11] = state[7]; state[7] = tmp;
	movq	-48(%rbp), %rax	# state, tmp305
	movzbl	3(%rax), %eax	# MEM[(uint8_t *)state_151(D) + 3B], tmp306
	movb	%al, -22(%rbp)	# tmp306, tmp
# bench.c:79:     tmp = state[3]; state[3] = state[15]; state[15] = state[11]; state[11] = state[7]; state[7] = tmp;
	movq	-48(%rbp), %rax	# state, tmp307
	leaq	3(%rax), %rdx	#, _114
# bench.c:79:     tmp = state[3]; state[3] = state[15]; state[15] = state[11]; state[11] = state[7]; state[7] = tmp;
	movq	-48(%rbp), %rax	# state, tmp308
	movzbl	15(%rax), %eax	# MEM[(uint8_t *)state_151(D) + 15B], _115
	movb	%al, (%rdx)	# _115, *_114
# bench.c:79:     tmp = state[3]; state[3] = state[15]; state[15] = state[11]; state[11] = state[7]; state[7] = tmp;
	movq	-48(%rbp), %rax	# state, tmp309
	leaq	15(%rax), %rdx	#, _116
# bench.c:79:     tmp = state[3]; state[3] = state[15]; state[15] = state[11]; state[11] = state[7]; state[7] = tmp;
	movq	-48(%rbp), %rax	# state, tmp310
	movzbl	11(%rax), %eax	# MEM[(uint8_t *)state_151(D) + 11B], _117
	movb	%al, (%rdx)	# _117, *_116
# bench.c:79:     tmp = state[3]; state[3] = state[15]; state[15] = state[11]; state[11] = state[7]; state[7] = tmp;
	movq	-48(%rbp), %rax	# state, tmp311
	leaq	11(%rax), %rdx	#, _118
# bench.c:79:     tmp = state[3]; state[3] = state[15]; state[15] = state[11]; state[11] = state[7]; state[7] = tmp;
	movq	-48(%rbp), %rax	# state, tmp312
	movzbl	7(%rax), %eax	# MEM[(uint8_t *)state_151(D) + 7B], _119
	movb	%al, (%rdx)	# _119, *_118
# bench.c:79:     tmp = state[3]; state[3] = state[15]; state[15] = state[11]; state[11] = state[7]; state[7] = tmp;
	movq	-48(%rbp), %rax	# state, tmp313
	leaq	7(%rax), %rdx	#, _120
# bench.c:79:     tmp = state[3]; state[3] = state[15]; state[15] = state[11]; state[11] = state[7]; state[7] = tmp;
	movzbl	-22(%rbp), %eax	# tmp, tmp314
	movb	%al, (%rdx)	# tmp314, *_120
# bench.c:80:     for (i = 0; i < 16; i++) state[i] ^= rk[160 + i];
	movb	$0, -25(%rbp)	#, i
# bench.c:80:     for (i = 0; i < 16; i++) state[i] ^= rk[160 + i];
	jmp	.L18	#
.L19:
# bench.c:80:     for (i = 0; i < 16; i++) state[i] ^= rk[160 + i];
	movzbl	-25(%rbp), %edx	# i, _121
	movq	-48(%rbp), %rax	# state, tmp315
	addq	%rdx, %rax	# _121, _122
	movzbl	(%rax), %esi	# *_122, _123
# bench.c:80:     for (i = 0; i < 16; i++) state[i] ^= rk[160 + i];
	movzbl	-25(%rbp), %eax	# i, _124
	addl	$160, %eax	#, _125
	movslq	%eax, %rdx	# _125, _126
# bench.c:80:     for (i = 0; i < 16; i++) state[i] ^= rk[160 + i];
	movq	-56(%rbp), %rax	# rk, tmp316
	addq	%rdx, %rax	# _126, _127
	movzbl	(%rax), %ecx	# *_127, _128
# bench.c:80:     for (i = 0; i < 16; i++) state[i] ^= rk[160 + i];
	movzbl	-25(%rbp), %edx	# i, _129
	movq	-48(%rbp), %rax	# state, tmp317
	addq	%rdx, %rax	# _129, _130
# bench.c:80:     for (i = 0; i < 16; i++) state[i] ^= rk[160 + i];
	xorl	%ecx, %esi	# _128, _123
	movl	%esi, %edx	# _123, _131
	movb	%dl, (%rax)	# _131, *_130
# bench.c:80:     for (i = 0; i < 16; i++) state[i] ^= rk[160 + i];
	movzbl	-25(%rbp), %eax	# i, i.9_132
	addl	$1, %eax	#, tmp318
	movb	%al, -25(%rbp)	# tmp318, i
.L18:
# bench.c:80:     for (i = 0; i < 16; i++) state[i] ^= rk[160 + i];
	cmpb	$15, -25(%rbp)	#, i
	jbe	.L19	#,
# bench.c:81: }
	nop	
	nop	
	movq	-8(%rbp), %rbx	#,
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE7:
	.size	aes_encrypt_block, .-aes_encrypt_block
	.type	ascon_rotr, @function
ascon_rotr:
.LFB8:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)	# v, v
	movl	%esi, -12(%rbp)	# s, s
# bench.c:86:     return (v >> s) | (v << (64 - s));
	movl	-12(%rbp), %eax	# s, tmp84
	movq	-8(%rbp), %rdx	# v, tmp85
	movl	%eax, %ecx	# tmp84, tmp89
	rorq	%cl, %rdx	# tmp89, tmp85
	movq	%rdx, %rax	# tmp85, _3
# bench.c:87: }
	popq	%rbp	#
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE8:
	.size	ascon_rotr, .-ascon_rotr
	.type	ascon_permutation_12, @function
ascon_permutation_12:
.LFB9:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	pushq	%rbx	#
	subq	$136, %rsp	#,
	.cfi_offset 3, -24
	movq	%rdi, -104(%rbp)	# x0, x0
	movq	%rsi, -112(%rbp)	# x1, x1
	movq	%rdx, -120(%rbp)	# x2, x2
	movq	%rcx, -128(%rbp)	# x3, x3
	movq	%r8, -136(%rbp)	# x4, x4
# bench.c:90:                                   uint64_t *x3, uint64_t *x4) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp234
	movq	%rax, -24(%rbp)	# tmp234, D.4193
	xorl	%eax, %eax	# tmp234
# bench.c:91:     const uint8_t RC[12] = {0xf0,0xe1,0xd2,0xc3,0xb4,0xa5,0x96,0x87,0x78,0x69,0x5a,0x4b};
	movabsq	$-8676565436284608016, %rax	#, tmp237
	movq	%rax, -36(%rbp)	# tmp237, RC
	movl	$1264216440, -28(%rbp)	#, RC
# bench.c:92:     for (int r = 0; r < 12; r++) {
	movl	$0, -84(%rbp)	#, r
# bench.c:92:     for (int r = 0; r < 12; r++) {
	jmp	.L23	#
.L24:
# bench.c:94:         *x0 ^= *x4; *x4 ^= *x3; *x2 ^= *x1;
	movq	-104(%rbp), %rax	# x0, tmp163
	movq	(%rax), %rdx	# *x0_83(D), _1
# bench.c:94:         *x0 ^= *x4; *x4 ^= *x3; *x2 ^= *x1;
	movq	-136(%rbp), %rax	# x4, tmp164
	movq	(%rax), %rax	# *x4_84(D), _2
# bench.c:94:         *x0 ^= *x4; *x4 ^= *x3; *x2 ^= *x1;
	xorq	%rax, %rdx	# _2, _3
	movq	-104(%rbp), %rax	# x0, tmp165
	movq	%rdx, (%rax)	# _3, *x0_83(D)
# bench.c:94:         *x0 ^= *x4; *x4 ^= *x3; *x2 ^= *x1;
	movq	-136(%rbp), %rax	# x4, tmp166
	movq	(%rax), %rdx	# *x4_84(D), _4
# bench.c:94:         *x0 ^= *x4; *x4 ^= *x3; *x2 ^= *x1;
	movq	-128(%rbp), %rax	# x3, tmp167
	movq	(%rax), %rax	# *x3_86(D), _5
# bench.c:94:         *x0 ^= *x4; *x4 ^= *x3; *x2 ^= *x1;
	xorq	%rax, %rdx	# _5, _6
	movq	-136(%rbp), %rax	# x4, tmp168
	movq	%rdx, (%rax)	# _6, *x4_84(D)
# bench.c:94:         *x0 ^= *x4; *x4 ^= *x3; *x2 ^= *x1;
	movq	-120(%rbp), %rax	# x2, tmp169
	movq	(%rax), %rdx	# *x2_88(D), _7
# bench.c:94:         *x0 ^= *x4; *x4 ^= *x3; *x2 ^= *x1;
	movq	-112(%rbp), %rax	# x1, tmp170
	movq	(%rax), %rax	# *x1_89(D), _8
# bench.c:94:         *x0 ^= *x4; *x4 ^= *x3; *x2 ^= *x1;
	xorq	%rax, %rdx	# _8, _9
	movq	-120(%rbp), %rax	# x2, tmp171
	movq	%rdx, (%rax)	# _9, *x2_88(D)
# bench.c:95:         uint64_t t0 = *x0, t1 = *x1, t2 = *x2, t3 = *x3, t4 = *x4;
	movq	-104(%rbp), %rax	# x0, tmp172
	movq	(%rax), %rax	# *x0_83(D), tmp173
	movq	%rax, -80(%rbp)	# tmp173, t0
# bench.c:95:         uint64_t t0 = *x0, t1 = *x1, t2 = *x2, t3 = *x3, t4 = *x4;
	movq	-112(%rbp), %rax	# x1, tmp174
	movq	(%rax), %rax	# *x1_89(D), tmp175
	movq	%rax, -72(%rbp)	# tmp175, t1
# bench.c:95:         uint64_t t0 = *x0, t1 = *x1, t2 = *x2, t3 = *x3, t4 = *x4;
	movq	-120(%rbp), %rax	# x2, tmp176
	movq	(%rax), %rax	# *x2_88(D), tmp177
	movq	%rax, -64(%rbp)	# tmp177, t2
# bench.c:95:         uint64_t t0 = *x0, t1 = *x1, t2 = *x2, t3 = *x3, t4 = *x4;
	movq	-128(%rbp), %rax	# x3, tmp178
	movq	(%rax), %rax	# *x3_86(D), tmp179
	movq	%rax, -56(%rbp)	# tmp179, t3
# bench.c:95:         uint64_t t0 = *x0, t1 = *x1, t2 = *x2, t3 = *x3, t4 = *x4;
	movq	-136(%rbp), %rax	# x4, tmp180
	movq	(%rax), %rax	# *x4_84(D), tmp181
	movq	%rax, -48(%rbp)	# tmp181, t4
# bench.c:96:         *x0 ^= (~t1 & t2);
	movq	-104(%rbp), %rax	# x0, tmp182
	movq	(%rax), %rdx	# *x0_83(D), _10
# bench.c:96:         *x0 ^= (~t1 & t2);
	movq	-72(%rbp), %rax	# t1, tmp183
	notq	%rax	# _11
# bench.c:96:         *x0 ^= (~t1 & t2);
	andq	-64(%rbp), %rax	# t2, _12
# bench.c:96:         *x0 ^= (~t1 & t2);
	xorq	%rax, %rdx	# _12, _13
	movq	-104(%rbp), %rax	# x0, tmp184
	movq	%rdx, (%rax)	# _13, *x0_83(D)
# bench.c:97:         *x1 ^= (~t2 & t3);
	movq	-112(%rbp), %rax	# x1, tmp185
	movq	(%rax), %rdx	# *x1_89(D), _14
# bench.c:97:         *x1 ^= (~t2 & t3);
	movq	-64(%rbp), %rax	# t2, tmp186
	notq	%rax	# _15
# bench.c:97:         *x1 ^= (~t2 & t3);
	andq	-56(%rbp), %rax	# t3, _16
# bench.c:97:         *x1 ^= (~t2 & t3);
	xorq	%rax, %rdx	# _16, _17
	movq	-112(%rbp), %rax	# x1, tmp187
	movq	%rdx, (%rax)	# _17, *x1_89(D)
# bench.c:98:         *x2 ^= (~t3 & t4);
	movq	-120(%rbp), %rax	# x2, tmp188
	movq	(%rax), %rdx	# *x2_88(D), _18
# bench.c:98:         *x2 ^= (~t3 & t4);
	movq	-56(%rbp), %rax	# t3, tmp189
	notq	%rax	# _19
# bench.c:98:         *x2 ^= (~t3 & t4);
	andq	-48(%rbp), %rax	# t4, _20
# bench.c:98:         *x2 ^= (~t3 & t4);
	xorq	%rax, %rdx	# _20, _21
	movq	-120(%rbp), %rax	# x2, tmp190
	movq	%rdx, (%rax)	# _21, *x2_88(D)
# bench.c:99:         *x3 ^= (~t4 & t0);
	movq	-128(%rbp), %rax	# x3, tmp191
	movq	(%rax), %rdx	# *x3_86(D), _22
# bench.c:99:         *x3 ^= (~t4 & t0);
	movq	-48(%rbp), %rax	# t4, tmp192
	notq	%rax	# _23
# bench.c:99:         *x3 ^= (~t4 & t0);
	andq	-80(%rbp), %rax	# t0, _24
# bench.c:99:         *x3 ^= (~t4 & t0);
	xorq	%rax, %rdx	# _24, _25
	movq	-128(%rbp), %rax	# x3, tmp193
	movq	%rdx, (%rax)	# _25, *x3_86(D)
# bench.c:100:         *x4 ^= (~t0 & t1);
	movq	-136(%rbp), %rax	# x4, tmp194
	movq	(%rax), %rdx	# *x4_84(D), _26
# bench.c:100:         *x4 ^= (~t0 & t1);
	movq	-80(%rbp), %rax	# t0, tmp195
	notq	%rax	# _27
# bench.c:100:         *x4 ^= (~t0 & t1);
	andq	-72(%rbp), %rax	# t1, _28
# bench.c:100:         *x4 ^= (~t0 & t1);
	xorq	%rax, %rdx	# _28, _29
	movq	-136(%rbp), %rax	# x4, tmp196
	movq	%rdx, (%rax)	# _29, *x4_84(D)
# bench.c:101:         *x2 = ~*x2; *x4 = ~*x4;
	movq	-120(%rbp), %rax	# x2, tmp197
	movq	(%rax), %rax	# *x2_88(D), _30
# bench.c:101:         *x2 = ~*x2; *x4 = ~*x4;
	notq	%rax	# _30
	movq	%rax, %rdx	# _30, _31
# bench.c:101:         *x2 = ~*x2; *x4 = ~*x4;
	movq	-120(%rbp), %rax	# x2, tmp198
	movq	%rdx, (%rax)	# _31, *x2_88(D)
# bench.c:101:         *x2 = ~*x2; *x4 = ~*x4;
	movq	-136(%rbp), %rax	# x4, tmp199
	movq	(%rax), %rax	# *x4_84(D), _32
# bench.c:101:         *x2 = ~*x2; *x4 = ~*x4;
	notq	%rax	# _32
	movq	%rax, %rdx	# _32, _33
# bench.c:101:         *x2 = ~*x2; *x4 = ~*x4;
	movq	-136(%rbp), %rax	# x4, tmp200
	movq	%rdx, (%rax)	# _33, *x4_84(D)
# bench.c:102:         *x1 ^= *x0; *x0 ^= *x4; *x3 ^= *x2;
	movq	-112(%rbp), %rax	# x1, tmp201
	movq	(%rax), %rdx	# *x1_89(D), _34
# bench.c:102:         *x1 ^= *x0; *x0 ^= *x4; *x3 ^= *x2;
	movq	-104(%rbp), %rax	# x0, tmp202
	movq	(%rax), %rax	# *x0_83(D), _35
# bench.c:102:         *x1 ^= *x0; *x0 ^= *x4; *x3 ^= *x2;
	xorq	%rax, %rdx	# _35, _36
	movq	-112(%rbp), %rax	# x1, tmp203
	movq	%rdx, (%rax)	# _36, *x1_89(D)
# bench.c:102:         *x1 ^= *x0; *x0 ^= *x4; *x3 ^= *x2;
	movq	-104(%rbp), %rax	# x0, tmp204
	movq	(%rax), %rdx	# *x0_83(D), _37
# bench.c:102:         *x1 ^= *x0; *x0 ^= *x4; *x3 ^= *x2;
	movq	-136(%rbp), %rax	# x4, tmp205
	movq	(%rax), %rax	# *x4_84(D), _38
# bench.c:102:         *x1 ^= *x0; *x0 ^= *x4; *x3 ^= *x2;
	xorq	%rax, %rdx	# _38, _39
	movq	-104(%rbp), %rax	# x0, tmp206
	movq	%rdx, (%rax)	# _39, *x0_83(D)
# bench.c:102:         *x1 ^= *x0; *x0 ^= *x4; *x3 ^= *x2;
	movq	-128(%rbp), %rax	# x3, tmp207
	movq	(%rax), %rdx	# *x3_86(D), _40
# bench.c:102:         *x1 ^= *x0; *x0 ^= *x4; *x3 ^= *x2;
	movq	-120(%rbp), %rax	# x2, tmp208
	movq	(%rax), %rax	# *x2_88(D), _41
# bench.c:102:         *x1 ^= *x0; *x0 ^= *x4; *x3 ^= *x2;
	xorq	%rax, %rdx	# _41, _42
	movq	-128(%rbp), %rax	# x3, tmp209
	movq	%rdx, (%rax)	# _42, *x3_86(D)
# bench.c:105:         *x0 ^= ascon_rotr(*x0, 19) ^ ascon_rotr(*x0, 28);
	movq	-104(%rbp), %rax	# x0, tmp210
	movq	(%rax), %rax	# *x0_83(D), _43
	movl	$19, %esi	#,
	movq	%rax, %rdi	# _43,
	call	ascon_rotr	#
	movq	%rax, %rbx	#, _44
# bench.c:105:         *x0 ^= ascon_rotr(*x0, 19) ^ ascon_rotr(*x0, 28);
	movq	-104(%rbp), %rax	# x0, tmp211
	movq	(%rax), %rax	# *x0_83(D), _45
	movl	$28, %esi	#,
	movq	%rax, %rdi	# _45,
	call	ascon_rotr	#
# bench.c:105:         *x0 ^= ascon_rotr(*x0, 19) ^ ascon_rotr(*x0, 28);
	xorq	%rax, %rbx	# _46, _44
	movq	%rbx, %rdx	# _44, _108
# bench.c:105:         *x0 ^= ascon_rotr(*x0, 19) ^ ascon_rotr(*x0, 28);
	movq	-104(%rbp), %rax	# x0, tmp212
	movq	(%rax), %rax	# *x0_83(D), _47
# bench.c:105:         *x0 ^= ascon_rotr(*x0, 19) ^ ascon_rotr(*x0, 28);
	xorq	%rax, %rdx	# _47, _48
	movq	-104(%rbp), %rax	# x0, tmp213
	movq	%rdx, (%rax)	# _48, *x0_83(D)
# bench.c:106:         *x1 ^= ascon_rotr(*x1, 61) ^ ascon_rotr(*x1, 39);
	movq	-112(%rbp), %rax	# x1, tmp214
	movq	(%rax), %rax	# *x1_89(D), _49
	movl	$61, %esi	#,
	movq	%rax, %rdi	# _49,
	call	ascon_rotr	#
	movq	%rax, %rbx	#, _50
# bench.c:106:         *x1 ^= ascon_rotr(*x1, 61) ^ ascon_rotr(*x1, 39);
	movq	-112(%rbp), %rax	# x1, tmp215
	movq	(%rax), %rax	# *x1_89(D), _51
	movl	$39, %esi	#,
	movq	%rax, %rdi	# _51,
	call	ascon_rotr	#
# bench.c:106:         *x1 ^= ascon_rotr(*x1, 61) ^ ascon_rotr(*x1, 39);
	xorq	%rax, %rbx	# _52, _50
	movq	%rbx, %rdx	# _50, _112
# bench.c:106:         *x1 ^= ascon_rotr(*x1, 61) ^ ascon_rotr(*x1, 39);
	movq	-112(%rbp), %rax	# x1, tmp216
	movq	(%rax), %rax	# *x1_89(D), _53
# bench.c:106:         *x1 ^= ascon_rotr(*x1, 61) ^ ascon_rotr(*x1, 39);
	xorq	%rax, %rdx	# _53, _54
	movq	-112(%rbp), %rax	# x1, tmp217
	movq	%rdx, (%rax)	# _54, *x1_89(D)
# bench.c:107:         *x2 ^= ascon_rotr(*x2, 1) ^ ascon_rotr(*x2, 6);
	movq	-120(%rbp), %rax	# x2, tmp218
	movq	(%rax), %rax	# *x2_88(D), _55
	movl	$1, %esi	#,
	movq	%rax, %rdi	# _55,
	call	ascon_rotr	#
	movq	%rax, %rbx	#, _56
# bench.c:107:         *x2 ^= ascon_rotr(*x2, 1) ^ ascon_rotr(*x2, 6);
	movq	-120(%rbp), %rax	# x2, tmp219
	movq	(%rax), %rax	# *x2_88(D), _57
	movl	$6, %esi	#,
	movq	%rax, %rdi	# _57,
	call	ascon_rotr	#
# bench.c:107:         *x2 ^= ascon_rotr(*x2, 1) ^ ascon_rotr(*x2, 6);
	xorq	%rax, %rbx	# _58, _56
	movq	%rbx, %rdx	# _56, _116
# bench.c:107:         *x2 ^= ascon_rotr(*x2, 1) ^ ascon_rotr(*x2, 6);
	movq	-120(%rbp), %rax	# x2, tmp220
	movq	(%rax), %rax	# *x2_88(D), _59
# bench.c:107:         *x2 ^= ascon_rotr(*x2, 1) ^ ascon_rotr(*x2, 6);
	xorq	%rax, %rdx	# _59, _60
	movq	-120(%rbp), %rax	# x2, tmp221
	movq	%rdx, (%rax)	# _60, *x2_88(D)
# bench.c:108:         *x3 ^= ascon_rotr(*x3, 10) ^ ascon_rotr(*x3, 17);
	movq	-128(%rbp), %rax	# x3, tmp222
	movq	(%rax), %rax	# *x3_86(D), _61
	movl	$10, %esi	#,
	movq	%rax, %rdi	# _61,
	call	ascon_rotr	#
	movq	%rax, %rbx	#, _62
# bench.c:108:         *x3 ^= ascon_rotr(*x3, 10) ^ ascon_rotr(*x3, 17);
	movq	-128(%rbp), %rax	# x3, tmp223
	movq	(%rax), %rax	# *x3_86(D), _63
	movl	$17, %esi	#,
	movq	%rax, %rdi	# _63,
	call	ascon_rotr	#
# bench.c:108:         *x3 ^= ascon_rotr(*x3, 10) ^ ascon_rotr(*x3, 17);
	xorq	%rax, %rbx	# _64, _62
	movq	%rbx, %rdx	# _62, _120
# bench.c:108:         *x3 ^= ascon_rotr(*x3, 10) ^ ascon_rotr(*x3, 17);
	movq	-128(%rbp), %rax	# x3, tmp224
	movq	(%rax), %rax	# *x3_86(D), _65
# bench.c:108:         *x3 ^= ascon_rotr(*x3, 10) ^ ascon_rotr(*x3, 17);
	xorq	%rax, %rdx	# _65, _66
	movq	-128(%rbp), %rax	# x3, tmp225
	movq	%rdx, (%rax)	# _66, *x3_86(D)
# bench.c:109:         *x4 ^= ascon_rotr(*x4, 7) ^ ascon_rotr(*x4, 41);
	movq	-136(%rbp), %rax	# x4, tmp226
	movq	(%rax), %rax	# *x4_84(D), _67
	movl	$7, %esi	#,
	movq	%rax, %rdi	# _67,
	call	ascon_rotr	#
	movq	%rax, %rbx	#, _68
# bench.c:109:         *x4 ^= ascon_rotr(*x4, 7) ^ ascon_rotr(*x4, 41);
	movq	-136(%rbp), %rax	# x4, tmp227
	movq	(%rax), %rax	# *x4_84(D), _69
	movl	$41, %esi	#,
	movq	%rax, %rdi	# _69,
	call	ascon_rotr	#
# bench.c:109:         *x4 ^= ascon_rotr(*x4, 7) ^ ascon_rotr(*x4, 41);
	xorq	%rax, %rbx	# _70, _68
	movq	%rbx, %rdx	# _68, _124
# bench.c:109:         *x4 ^= ascon_rotr(*x4, 7) ^ ascon_rotr(*x4, 41);
	movq	-136(%rbp), %rax	# x4, tmp228
	movq	(%rax), %rax	# *x4_84(D), _71
# bench.c:109:         *x4 ^= ascon_rotr(*x4, 7) ^ ascon_rotr(*x4, 41);
	xorq	%rax, %rdx	# _71, _72
	movq	-136(%rbp), %rax	# x4, tmp229
	movq	%rdx, (%rax)	# _72, *x4_84(D)
# bench.c:112:         *x2 ^= RC[r];
	movq	-120(%rbp), %rax	# x2, tmp230
	movq	(%rax), %rdx	# *x2_88(D), _73
# bench.c:112:         *x2 ^= RC[r];
	movl	-84(%rbp), %eax	# r, tmp232
	cltq
	movzbl	-36(%rbp,%rax), %eax	# RC[r_77], _74
	movzbl	%al, %eax	# _74, _75
# bench.c:112:         *x2 ^= RC[r];
	xorq	%rax, %rdx	# _75, _76
	movq	-120(%rbp), %rax	# x2, tmp233
	movq	%rdx, (%rax)	# _76, *x2_88(D)
# bench.c:92:     for (int r = 0; r < 12; r++) {
	addl	$1, -84(%rbp)	#, r
.L23:
# bench.c:92:     for (int r = 0; r < 12; r++) {
	cmpl	$11, -84(%rbp)	#, r
	jle	.L24	#,
# bench.c:114: }
	nop	
	movq	-24(%rbp), %rax	# D.4193, tmp235
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp235
	je	.L25	#,
	call	__stack_chk_fail@PLT	#
.L25:
	movq	-8(%rbp), %rbx	#,
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE9:
	.size	ascon_permutation_12, .-ascon_permutation_12
	.type	tinyjambu_state_update_1024, @function
tinyjambu_state_update_1024:
.LFB10:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	movq	%rdi, -40(%rbp)	# s, s
	movq	%rsi, -48(%rbp)	# key, key
# bench.c:119:     for (int i = 0; i < 32; i++) {
	movl	$0, -24(%rbp)	#, i
# bench.c:119:     for (int i = 0; i < 32; i++) {
	jmp	.L27	#
.L28:
# bench.c:120:         uint32_t s47 = (s[2] << 17) | (s[1] >> 15);
	movq	-40(%rbp), %rax	# s, tmp123
	addq	$8, %rax	#, _1
	movl	(%rax), %eax	# *_1, _2
# bench.c:120:         uint32_t s47 = (s[2] << 17) | (s[1] >> 15);
	sall	$17, %eax	#, _2
	movl	%eax, %edx	# _2, _3
# bench.c:120:         uint32_t s47 = (s[2] << 17) | (s[1] >> 15);
	movq	-40(%rbp), %rax	# s, tmp124
	addq	$4, %rax	#, _4
	movl	(%rax), %eax	# *_4, _5
# bench.c:120:         uint32_t s47 = (s[2] << 17) | (s[1] >> 15);
	shrl	$15, %eax	#, _6
# bench.c:120:         uint32_t s47 = (s[2] << 17) | (s[1] >> 15);
	orl	%edx, %eax	# _3, tmp125
	movl	%eax, -20(%rbp)	# tmp125, s47
# bench.c:121:         uint32_t s70 = (s[3] << 26) | (s[2] >> 6);
	movq	-40(%rbp), %rax	# s, tmp126
	addq	$12, %rax	#, _7
	movl	(%rax), %eax	# *_7, _8
# bench.c:121:         uint32_t s70 = (s[3] << 26) | (s[2] >> 6);
	sall	$26, %eax	#, _8
	movl	%eax, %edx	# _8, _9
# bench.c:121:         uint32_t s70 = (s[3] << 26) | (s[2] >> 6);
	movq	-40(%rbp), %rax	# s, tmp127
	addq	$8, %rax	#, _10
	movl	(%rax), %eax	# *_10, _11
# bench.c:121:         uint32_t s70 = (s[3] << 26) | (s[2] >> 6);
	shrl	$6, %eax	#, _12
# bench.c:121:         uint32_t s70 = (s[3] << 26) | (s[2] >> 6);
	orl	%edx, %eax	# _9, tmp128
	movl	%eax, -16(%rbp)	# tmp128, s70
# bench.c:122:         uint32_t s85 = (s[3] << 11) | (s[2] >> 21);
	movq	-40(%rbp), %rax	# s, tmp129
	addq	$12, %rax	#, _13
	movl	(%rax), %eax	# *_13, _14
# bench.c:122:         uint32_t s85 = (s[3] << 11) | (s[2] >> 21);
	sall	$11, %eax	#, _14
	movl	%eax, %edx	# _14, _15
# bench.c:122:         uint32_t s85 = (s[3] << 11) | (s[2] >> 21);
	movq	-40(%rbp), %rax	# s, tmp130
	addq	$8, %rax	#, _16
	movl	(%rax), %eax	# *_16, _17
# bench.c:122:         uint32_t s85 = (s[3] << 11) | (s[2] >> 21);
	shrl	$21, %eax	#, _18
# bench.c:122:         uint32_t s85 = (s[3] << 11) | (s[2] >> 21);
	orl	%edx, %eax	# _15, tmp131
	movl	%eax, -12(%rbp)	# tmp131, s85
# bench.c:123:         uint32_t s91 = (s[3] << 5) | (s[2] >> 27);
	movq	-40(%rbp), %rax	# s, tmp132
	addq	$12, %rax	#, _19
	movl	(%rax), %eax	# *_19, _20
# bench.c:123:         uint32_t s91 = (s[3] << 5) | (s[2] >> 27);
	sall	$5, %eax	#, _20
	movl	%eax, %edx	# _20, _21
# bench.c:123:         uint32_t s91 = (s[3] << 5) | (s[2] >> 27);
	movq	-40(%rbp), %rax	# s, tmp133
	addq	$8, %rax	#, _22
	movl	(%rax), %eax	# *_22, _23
# bench.c:123:         uint32_t s91 = (s[3] << 5) | (s[2] >> 27);
	shrl	$27, %eax	#, _24
# bench.c:123:         uint32_t s91 = (s[3] << 5) | (s[2] >> 27);
	orl	%edx, %eax	# _21, tmp134
	movl	%eax, -8(%rbp)	# tmp134, s91
# bench.c:124:         uint32_t fbk = s[0] ^ s47 ^ (~(s70 & s85)) ^ s91 ^ key[i & 3];
	movl	-16(%rbp), %eax	# s70, tmp135
	andl	-12(%rbp), %eax	# s85, tmp135
	movl	%eax, %edx	# tmp135, _25
# bench.c:124:         uint32_t fbk = s[0] ^ s47 ^ (~(s70 & s85)) ^ s91 ^ key[i & 3];
	movq	-40(%rbp), %rax	# s, tmp136
	movl	(%rax), %eax	# *s_46(D), _26
# bench.c:124:         uint32_t fbk = s[0] ^ s47 ^ (~(s70 & s85)) ^ s91 ^ key[i & 3];
	xorl	-20(%rbp), %eax	# s47, _27
# bench.c:124:         uint32_t fbk = s[0] ^ s47 ^ (~(s70 & s85)) ^ s91 ^ key[i & 3];
	xorl	%edx, %eax	# _25, _28
# bench.c:124:         uint32_t fbk = s[0] ^ s47 ^ (~(s70 & s85)) ^ s91 ^ key[i & 3];
	xorl	-8(%rbp), %eax	# s91, _28
	movl	%eax, %edx	# _28, _29
# bench.c:124:         uint32_t fbk = s[0] ^ s47 ^ (~(s70 & s85)) ^ s91 ^ key[i & 3];
	movl	-24(%rbp), %eax	# i, tmp137
	cltq
	andl	$3, %eax	#, _31
# bench.c:124:         uint32_t fbk = s[0] ^ s47 ^ (~(s70 & s85)) ^ s91 ^ key[i & 3];
	leaq	0(,%rax,4), %rcx	#, _32
	movq	-48(%rbp), %rax	# key, tmp138
	addq	%rcx, %rax	# _32, _33
	movl	(%rax), %eax	# *_33, _34
# bench.c:124:         uint32_t fbk = s[0] ^ s47 ^ (~(s70 & s85)) ^ s91 ^ key[i & 3];
	xorl	%edx, %eax	# _29, _35
# bench.c:124:         uint32_t fbk = s[0] ^ s47 ^ (~(s70 & s85)) ^ s91 ^ key[i & 3];
	notl	%eax	# tmp139
	movl	%eax, -4(%rbp)	# tmp139, fbk
# bench.c:125:         s[0] = s[1]; s[1] = s[2]; s[2] = s[3]; s[3] = fbk;
	movq	-40(%rbp), %rax	# s, tmp140
	movl	4(%rax), %edx	# MEM[(uint32_t *)s_46(D) + 4B], _36
	movq	-40(%rbp), %rax	# s, tmp141
	movl	%edx, (%rax)	# _36, *s_46(D)
# bench.c:125:         s[0] = s[1]; s[1] = s[2]; s[2] = s[3]; s[3] = fbk;
	movq	-40(%rbp), %rax	# s, tmp142
	leaq	4(%rax), %rdx	#, _37
# bench.c:125:         s[0] = s[1]; s[1] = s[2]; s[2] = s[3]; s[3] = fbk;
	movq	-40(%rbp), %rax	# s, tmp143
	movl	8(%rax), %eax	# MEM[(uint32_t *)s_46(D) + 8B], _38
	movl	%eax, (%rdx)	# _38, *_37
# bench.c:125:         s[0] = s[1]; s[1] = s[2]; s[2] = s[3]; s[3] = fbk;
	movq	-40(%rbp), %rax	# s, tmp144
	leaq	8(%rax), %rdx	#, _39
# bench.c:125:         s[0] = s[1]; s[1] = s[2]; s[2] = s[3]; s[3] = fbk;
	movq	-40(%rbp), %rax	# s, tmp145
	movl	12(%rax), %eax	# MEM[(uint32_t *)s_46(D) + 12B], _40
	movl	%eax, (%rdx)	# _40, *_39
# bench.c:125:         s[0] = s[1]; s[1] = s[2]; s[2] = s[3]; s[3] = fbk;
	movq	-40(%rbp), %rax	# s, tmp146
	leaq	12(%rax), %rdx	#, _41
# bench.c:125:         s[0] = s[1]; s[1] = s[2]; s[2] = s[3]; s[3] = fbk;
	movl	-4(%rbp), %eax	# fbk, tmp147
	movl	%eax, (%rdx)	# tmp147, *_41
# bench.c:119:     for (int i = 0; i < 32; i++) {
	addl	$1, -24(%rbp)	#, i
.L27:
# bench.c:119:     for (int i = 0; i < 32; i++) {
	cmpl	$31, -24(%rbp)	#, i
	jle	.L28	#,
# bench.c:127: }
	nop	
	nop	
	popq	%rbp	#
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE10:
	.size	tinyjambu_state_update_1024, .-tinyjambu_state_update_1024
	.type	now_ns, @function
now_ns:
.LFB11:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$32, %rsp	#,
# bench.c:131: static double now_ns(void) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp92
	movq	%rax, -8(%rbp)	# tmp92, D.4195
	xorl	%eax, %eax	# tmp92
# bench.c:133:     clock_gettime(CLOCK_MONOTONIC, &ts);
	leaq	-32(%rbp), %rax	#, tmp89
	movq	%rax, %rsi	# tmp89,
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	movq	-32(%rbp), %rax	# ts.tv_sec, _1
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	pxor	%xmm1, %xmm1	# _2
	cvtsi2sdq	%rax, %xmm1	# _1, _2
	movsd	.LC0(%rip), %xmm0	#, tmp90
	mulsd	%xmm0, %xmm1	# tmp90, _3
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	movq	-24(%rbp), %rax	# ts.tv_nsec, _4
# bench.c:134:     return ts.tv_sec * 1e9 + ts.tv_nsec;
	pxor	%xmm0, %xmm0	# _5
	cvtsi2sdq	%rax, %xmm0	# _4, _5
	addsd	%xmm1, %xmm0	# _3, _8
# bench.c:135: }
	movq	-8(%rbp), %rax	# D.4195, tmp93
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp93
	je	.L31	#,
	call	__stack_chk_fail@PLT	#
.L31:
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE11:
	.size	now_ns, .-now_ns
	.section	.rodata
	.align 8
.LC2:
	.string	"AES-128 enc_block  | %8d iter | %10.1f ns/op\n"
	.align 8
.LC3:
	.string	"ASCON permute 12   | %8d iter | %10.1f ns/op\n"
	.align 8
.LC4:
	.string	"TinyJAMBU upd 1024 | %8d iter | %10.1f ns/op\n"
.LC5:
	.string	"\nsink=%llu (prevent DCE)\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB12:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$336, %rsp	#,
# bench.c:137: int main(void) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp163
	movq	%rax, -8(%rbp)	# tmp163, D.4196
	xorl	%eax, %eax	# tmp163
# bench.c:139:     volatile uint64_t sink = 0; /* prevent dead-code elimination */
	movq	$0, -320(%rbp)	#, sink
# bench.c:143:         uint8_t key[16] = {0};
	movq	$0, -224(%rbp)	#, key
	movq	$0, -216(%rbp)	#, key
# bench.c:145:         uint8_t state[16] = {0};
	movq	$0, -208(%rbp)	#, state
	movq	$0, -200(%rbp)	#, state
# bench.c:147:         for (int i = 0; i < 176; i++) rk[i] = (uint8_t)(i * 7 + 13);
	movl	$0, -336(%rbp)	#, i
# bench.c:147:         for (int i = 0; i < 176; i++) rk[i] = (uint8_t)(i * 7 + 13);
	jmp	.L33	#
.L34:
# bench.c:147:         for (int i = 0; i < 176; i++) rk[i] = (uint8_t)(i * 7 + 13);
	movl	-336(%rbp), %eax	# i, tmp125
	movl	%eax, %edx	# tmp125, _1
	movl	%edx, %eax	# _1, tmp126
	sall	$3, %eax	#, tmp127
	subl	%edx, %eax	# _1, _2
	leal	13(%rax), %edx	#, _3
# bench.c:147:         for (int i = 0; i < 176; i++) rk[i] = (uint8_t)(i * 7 + 13);
	movl	-336(%rbp), %eax	# i, tmp129
	cltq
	movb	%dl, -192(%rbp,%rax)	# _3, rk[i_41]
# bench.c:147:         for (int i = 0; i < 176; i++) rk[i] = (uint8_t)(i * 7 + 13);
	addl	$1, -336(%rbp)	#, i
.L33:
# bench.c:147:         for (int i = 0; i < 176; i++) rk[i] = (uint8_t)(i * 7 + 13);
	cmpl	$175, -336(%rbp)	#, i
	jle	.L34	#,
# bench.c:149:         t0 = now_ns();
	call	now_ns	#
	movq	%xmm0, %rax	#, tmp130
	movq	%rax, -272(%rbp)	# tmp130, t0
# bench.c:150:         for (int n = 0; n < ITERATIONS; n++) {
	movl	$0, -332(%rbp)	#, n
# bench.c:150:         for (int n = 0; n < ITERATIONS; n++) {
	jmp	.L35	#
.L36:
# bench.c:151:             memcpy(state, rk, 16); /* reset state */
	movq	-192(%rbp), %rax	# MEM <uint128_t> [(char * {ref-all})&rk], _109
	movq	-184(%rbp), %rdx	# MEM <uint128_t> [(char * {ref-all})&rk], _109
	movq	%rax, -208(%rbp)	# _109, MEM <uint128_t> [(char * {ref-all})&state]
	movq	%rdx, -200(%rbp)	# _109, MEM <uint128_t> [(char * {ref-all})&state]
# bench.c:152:             state[0] ^= (n & 0xFF);
	movzbl	-208(%rbp), %eax	# state[0], _4
	movl	%eax, %edx	# _4, _5
# bench.c:152:             state[0] ^= (n & 0xFF);
	movl	-332(%rbp), %eax	# n, tmp131
	xorl	%edx, %eax	# _5, _7
	movb	%al, -208(%rbp)	# _8, state[0]
# bench.c:153:             aes_encrypt_block(state, rk);
	leaq	-192(%rbp), %rdx	#, tmp132
	leaq	-208(%rbp), %rax	#, tmp133
	movq	%rdx, %rsi	# tmp132,
	movq	%rax, %rdi	# tmp133,
	call	aes_encrypt_block	#
# bench.c:154:             sink ^= state[0];
	movzbl	-208(%rbp), %eax	# state[0], _9
	movzbl	%al, %edx	# _9, _10
# bench.c:154:             sink ^= state[0];
	movq	-320(%rbp), %rax	# sink, sink.10_11
	xorq	%rdx, %rax	# _10, _12
	movq	%rax, -320(%rbp)	# _12, sink
# bench.c:150:         for (int n = 0; n < ITERATIONS; n++) {
	addl	$1, -332(%rbp)	#, n
.L35:
# bench.c:150:         for (int n = 0; n < ITERATIONS; n++) {
	cmpl	$499999, -332(%rbp)	#, n
	jle	.L36	#,
# bench.c:156:         t1 = now_ns();
	call	now_ns	#
	movq	%xmm0, %rax	#, tmp134
	movq	%rax, -264(%rbp)	# tmp134, t1
# bench.c:157:         printf("AES-128 enc_block  | %8d iter | %10.1f ns/op\n", ITERATIONS, (t1-t0)/ITERATIONS);
	movsd	-264(%rbp), %xmm0	# t1, tmp135
	subsd	-272(%rbp), %xmm0	# t0, _13
# bench.c:157:         printf("AES-128 enc_block  | %8d iter | %10.1f ns/op\n", ITERATIONS, (t1-t0)/ITERATIONS);
	movsd	.LC1(%rip), %xmm1	#, tmp136
	divsd	%xmm1, %xmm0	# tmp136, _13
	movq	%xmm0, %rax	# _13, _14
	movq	%rax, %xmm0	# _14,
	movl	$500000, %esi	#,
	leaq	.LC2(%rip), %rax	#, tmp137
	movq	%rax, %rdi	# tmp137,
	movl	$1, %eax	#,
	call	printf@PLT	#
# bench.c:162:         uint64_t x0 = 0x80400c0600000000ULL, x1 = 0, x2 = 0, x3 = 0, x4 = 0;
	movabsq	$-9205344418435956736, %rax	#, tmp167
	movq	%rax, -312(%rbp)	# tmp167, x0
# bench.c:162:         uint64_t x0 = 0x80400c0600000000ULL, x1 = 0, x2 = 0, x3 = 0, x4 = 0;
	movq	$0, -304(%rbp)	#, x1
# bench.c:162:         uint64_t x0 = 0x80400c0600000000ULL, x1 = 0, x2 = 0, x3 = 0, x4 = 0;
	movq	$0, -296(%rbp)	#, x2
# bench.c:162:         uint64_t x0 = 0x80400c0600000000ULL, x1 = 0, x2 = 0, x3 = 0, x4 = 0;
	movq	$0, -288(%rbp)	#, x3
# bench.c:162:         uint64_t x0 = 0x80400c0600000000ULL, x1 = 0, x2 = 0, x3 = 0, x4 = 0;
	movq	$0, -280(%rbp)	#, x4
# bench.c:163:         t0 = now_ns();
	call	now_ns	#
	movq	%xmm0, %rax	#, tmp138
	movq	%rax, -272(%rbp)	# tmp138, t0
# bench.c:164:         for (int n = 0; n < ITERATIONS; n++) {
	movl	$0, -328(%rbp)	#, n
# bench.c:164:         for (int n = 0; n < ITERATIONS; n++) {
	jmp	.L37	#
.L38:
# bench.c:165:             x0 = 0x80400c0600000000ULL ^ (n & 0xFF);
	movl	-328(%rbp), %eax	# n, tmp139
	cltq
	movzbl	%al, %eax	# _15, _16
# bench.c:165:             x0 = 0x80400c0600000000ULL ^ (n & 0xFF);
	movabsq	$-9205344418435956736, %rdx	#, tmp140
	xorq	%rdx, %rax	# tmp140, _17
# bench.c:165:             x0 = 0x80400c0600000000ULL ^ (n & 0xFF);
	movq	%rax, -312(%rbp)	# _17, x0
# bench.c:166:             x1 = x2 = x3 = x4 = (uint64_t)n;
	movl	-328(%rbp), %eax	# n, tmp141
	cltq
# bench.c:166:             x1 = x2 = x3 = x4 = (uint64_t)n;
	movq	%rax, -280(%rbp)	# _18, x4
# bench.c:166:             x1 = x2 = x3 = x4 = (uint64_t)n;
	movq	-280(%rbp), %rax	# x4, x4.11_19
	movq	%rax, -288(%rbp)	# x4.11_19, x3
# bench.c:166:             x1 = x2 = x3 = x4 = (uint64_t)n;
	movq	-288(%rbp), %rax	# x3, x3.12_20
	movq	%rax, -296(%rbp)	# x3.12_20, x2
# bench.c:166:             x1 = x2 = x3 = x4 = (uint64_t)n;
	movq	-296(%rbp), %rax	# x2, x2.13_21
	movq	%rax, -304(%rbp)	# x2.13_21, x1
# bench.c:167:             ascon_permutation_12(&x0, &x1, &x2, &x3, &x4);
	leaq	-280(%rbp), %rdi	#, tmp142
	leaq	-288(%rbp), %rcx	#, tmp143
	leaq	-296(%rbp), %rdx	#, tmp144
	leaq	-304(%rbp), %rsi	#, tmp145
	leaq	-312(%rbp), %rax	#, tmp146
	movq	%rdi, %r8	# tmp142,
	movq	%rax, %rdi	# tmp146,
	call	ascon_permutation_12	#
# bench.c:168:             sink ^= x0;
	movq	-320(%rbp), %rdx	# sink, sink.14_22
	movq	-312(%rbp), %rax	# x0, x0.15_23
	xorq	%rdx, %rax	# sink.14_22, _24
	movq	%rax, -320(%rbp)	# _24, sink
# bench.c:164:         for (int n = 0; n < ITERATIONS; n++) {
	addl	$1, -328(%rbp)	#, n
.L37:
# bench.c:164:         for (int n = 0; n < ITERATIONS; n++) {
	cmpl	$499999, -328(%rbp)	#, n
	jle	.L38	#,
# bench.c:170:         t1 = now_ns();
	call	now_ns	#
	movq	%xmm0, %rax	#, tmp147
	movq	%rax, -264(%rbp)	# tmp147, t1
# bench.c:171:         printf("ASCON permute 12   | %8d iter | %10.1f ns/op\n", ITERATIONS, (t1-t0)/ITERATIONS);
	movsd	-264(%rbp), %xmm0	# t1, tmp148
	subsd	-272(%rbp), %xmm0	# t0, _25
# bench.c:171:         printf("ASCON permute 12   | %8d iter | %10.1f ns/op\n", ITERATIONS, (t1-t0)/ITERATIONS);
	movsd	.LC1(%rip), %xmm1	#, tmp149
	divsd	%xmm1, %xmm0	# tmp149, _25
	movq	%xmm0, %rax	# _25, _26
	movq	%rax, %xmm0	# _26,
	movl	$500000, %esi	#,
	leaq	.LC3(%rip), %rax	#, tmp150
	movq	%rax, %rdi	# tmp150,
	movl	$1, %eax	#,
	call	printf@PLT	#
# bench.c:176:         uint32_t state[4] = {0};
	movq	$0, -256(%rbp)	#, state
	movq	$0, -248(%rbp)	#, state
# bench.c:177:         uint32_t key[4] = {0x01234567, 0x89ABCDEF, 0x01234567, 0x89ABCDEF};
	movl	$19088743, -240(%rbp)	#, key[0]
	movl	$-1985229329, -236(%rbp)	#, key[1]
	movl	$19088743, -232(%rbp)	#, key[2]
	movl	$-1985229329, -228(%rbp)	#, key[3]
# bench.c:178:         t0 = now_ns();
	call	now_ns	#
	movq	%xmm0, %rax	#, tmp151
	movq	%rax, -272(%rbp)	# tmp151, t0
# bench.c:179:         for (int n = 0; n < ITERATIONS; n++) {
	movl	$0, -324(%rbp)	#, n
# bench.c:179:         for (int n = 0; n < ITERATIONS; n++) {
	jmp	.L39	#
.L40:
# bench.c:180:             state[0] = n; state[1] = n+1; state[2] = n+2; state[3] = n+3;
	movl	-324(%rbp), %eax	# n, n.16_27
	movl	%eax, -256(%rbp)	# n.16_27, state[0]
# bench.c:180:             state[0] = n; state[1] = n+1; state[2] = n+2; state[3] = n+3;
	movl	-324(%rbp), %eax	# n, tmp152
	addl	$1, %eax	#, _28
# bench.c:180:             state[0] = n; state[1] = n+1; state[2] = n+2; state[3] = n+3;
	movl	%eax, -252(%rbp)	# _29, state[1]
# bench.c:180:             state[0] = n; state[1] = n+1; state[2] = n+2; state[3] = n+3;
	movl	-324(%rbp), %eax	# n, tmp153
	addl	$2, %eax	#, _30
# bench.c:180:             state[0] = n; state[1] = n+1; state[2] = n+2; state[3] = n+3;
	movl	%eax, -248(%rbp)	# _31, state[2]
# bench.c:180:             state[0] = n; state[1] = n+1; state[2] = n+2; state[3] = n+3;
	movl	-324(%rbp), %eax	# n, tmp154
	addl	$3, %eax	#, _32
# bench.c:180:             state[0] = n; state[1] = n+1; state[2] = n+2; state[3] = n+3;
	movl	%eax, -244(%rbp)	# _33, state[3]
# bench.c:181:             tinyjambu_state_update_1024(state, key);
	leaq	-240(%rbp), %rdx	#, tmp155
	leaq	-256(%rbp), %rax	#, tmp156
	movq	%rdx, %rsi	# tmp155,
	movq	%rax, %rdi	# tmp156,
	call	tinyjambu_state_update_1024	#
# bench.c:182:             sink ^= state[0];
	movl	-256(%rbp), %eax	# state[0], _34
	movl	%eax, %edx	# _34, _35
# bench.c:182:             sink ^= state[0];
	movq	-320(%rbp), %rax	# sink, sink.17_36
	xorq	%rdx, %rax	# _35, _37
	movq	%rax, -320(%rbp)	# _37, sink
# bench.c:179:         for (int n = 0; n < ITERATIONS; n++) {
	addl	$1, -324(%rbp)	#, n
.L39:
# bench.c:179:         for (int n = 0; n < ITERATIONS; n++) {
	cmpl	$499999, -324(%rbp)	#, n
	jle	.L40	#,
# bench.c:184:         t1 = now_ns();
	call	now_ns	#
	movq	%xmm0, %rax	#, tmp157
	movq	%rax, -264(%rbp)	# tmp157, t1
# bench.c:185:         printf("TinyJAMBU upd 1024 | %8d iter | %10.1f ns/op\n", ITERATIONS, (t1-t0)/ITERATIONS);
	movsd	-264(%rbp), %xmm0	# t1, tmp158
	subsd	-272(%rbp), %xmm0	# t0, _38
# bench.c:185:         printf("TinyJAMBU upd 1024 | %8d iter | %10.1f ns/op\n", ITERATIONS, (t1-t0)/ITERATIONS);
	movsd	.LC1(%rip), %xmm1	#, tmp159
	divsd	%xmm1, %xmm0	# tmp159, _38
	movq	%xmm0, %rax	# _38, _39
	movq	%rax, %xmm0	# _39,
	movl	$500000, %esi	#,
	leaq	.LC4(%rip), %rax	#, tmp160
	movq	%rax, %rdi	# tmp160,
	movl	$1, %eax	#,
	call	printf@PLT	#
# bench.c:188:     printf("\nsink=%llu (prevent DCE)\n", (unsigned long long)sink);
	movq	-320(%rbp), %rax	# sink, sink.18_40
	movq	%rax, %rsi	# sink.18_40,
	leaq	.LC5(%rip), %rax	#, tmp161
	movq	%rax, %rdi	# tmp161,
	movl	$0, %eax	#,
	call	printf@PLT	#
# bench.c:189:     return 0;
	movl	$0, %eax	#, _93
# bench.c:190: }
	movq	-8(%rbp), %rdx	# D.4196, tmp164
	subq	%fs:40, %rdx	# MEM[(<address-space-1> long unsigned int *)40B], tmp164
	je	.L42	#,
	call	__stack_chk_fail@PLT	#
.L42:
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE12:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1104006501
	.align 8
.LC1:
	.long	0
	.long	1092519040
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
