	.intel_syntax noprefix
	.section .text
	.global OR_FRAG
OR_FRAG:
	or rax, QWORD PTR [rbx]  #same as and, we just replace the and by or
	add rbx, 8
	ret #return back to where they get called from
	
