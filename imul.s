	.intel_syntax noprefix
	.section .data #editing the data so we do .data here
	.global IMUL_POSITIVE
	.global IMUL_NEGATIVE
IMUL_POSITIVE:
	.quad 0  #initialize the value of imul postive here
IMUL_NEGATIVE:
	.quad 0
	.section .text
	.global IMUL_FRAG
IMUL_FRAG:
	mov rdx, [ rbx] #since we can not multiply two value extraced from memory address directly, we should move the value of rbx into rdx
	imul rax, rdx
	cmp rdx, 0
	jl is_neg  #jump to negative part if rdx is less than 0
	add QWORD PTR [IMUL_POSITIVE], rdx
	jmp done
is_neg:
	add QWORD PTR [IMUL_NEGATIVE], rdx
done:
	add rbx, 8 #update the value
	ret
