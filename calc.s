	.intel_syntax noprefix
	.section .data
FINAL:		.quad 0
	.section .text
	.global _start
_start:
	xor rax, rax  #initialize rax to zero
	mov rbx, OFFSET CALC_DATA_BEGIN
	.global loop_head
loop_head:
	cmp BYTE PTR [rbx], 0
	je loop_end
	cmp BYTE PTR [rbx], '&'
	je and_command
	cmp BYTE PTR [rbx], '|'
	je or_command
	cmp BYTE PTR [rbx], 'M'
	je imul_command
	cmp BYTE PTR [rbx], 'U'
	je low_command
and_command:
	add rbx, 8
	call AND_FRAG
	jmp loop_head
or_command:
	add rbx, 8
	call OR_FRAG
	jmp loop_head
imul_command:
	add rbx, 8
	call IMUL_FRAG
	jmp loop_head
low_command:
	add rbx,8
	call LOW_FRAG
	jmp loop_head
loop_end:
	#write out the final value of rax
	mov [FINAL], rax  #store rax's value in another memory address in case of losing primary value
	mov rax, 1
	mov rdi, 1
	mov rsi, OFFSET FINAL
	mov rdx, 8
	syscall

	#write out the final value of IMUL_POSITIVE
	mov rax, 1
	mov rdi, 1
	mov rsi, OFFSET IMUL_POSITIVE
	mov rdx, 8
	syscall

	#write out the final value of IMUL_NEGATIVE
	mov rax, 1
	mov rdi, 1
	mov rsi, OFFSET IMUL_NEGATIVE
	mov rdx, 8
	syscall

	#write the memory between CALC_DATA_BEGIN and CALC_DATA_END
	mov r11, OFFSET CALC_DATA_BEGIN
	mov r12, OFFSET CALC_DATA_END
	sub r12, r11  #calculate bytes by subtracting
	mov rax, 1
	mov rdi, 1
	mov rsi, OFFSET CALC_DATA_BEGIN
	mov rdx, r12
	syscall

	mov rax, 60
	mov rdi, 0
	syscall
