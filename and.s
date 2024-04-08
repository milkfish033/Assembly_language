	.intel_syntax noprefix
	.section .text
	.global AND_FRAG  #since we're calling AND_FRAG in test,
	#here it should be global
AND_FRAG:
	and rax, QWORD PTR [rbx]
	add rbx, 8
	ret #return back to where they get called from
