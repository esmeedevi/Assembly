.data
printstr:	.asciz "Assignment 3: pow\n\nGive me two integers: \n"
inputstr:	.asciz "%ld" 
inputstr2:	.asciz "%ld" 
main:
	movq	$0, %rax		#no vector args
	movq    $printstr, %rdi		#move printstr into rdi
	call	printf			#print
	
	call 	input
	call 	loop
	call	exit

input:
	pushq	%rbp			#prologue: push rbp onto stack
	movq	%rsp, %rbp		#then move stackpointer to rbp		

	subq	$16, %rsp		#reserve stack space for variable
	leaq	-16(%rbp), %rsi		#load address of stack var in rsi
	movq	$inputstr, %rdi		#load first argument of scanf
	movq	$0, %rax		#no vector arguments

	movq	$inputstr2, %rdi	#load first argument of scanf, need different reg
	call	scanf

	movq	-8(%rbp), %rsi		#move waarde/value of var to rdx
	movq	$newlinestr, %rdi	#store inputstr into rdi
loop:
	
