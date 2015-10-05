.data
printstr:	.asciz "Assignment 3: pow\n\nGive me a positive base and an exponent: \n"
printstr2:	.asciz "\nResult is: %ld\n"
inputstr:	.asciz "%ld" 


.global		main

main:
	pushq	%rbp			#prologue: push rbp onto stack
	movq	%rsp, %rbp		#then copy stackpointer to rbp	

	movq	$0, %rax		#no vector args
	movq    $printstr, %rdi		#move printstr into rdi
	call	printf			#print

	#Scan variables and put them on the stack


	subq	$16, %rsp		#reserve stack space for variable

	leaq	-8(%rbp), %rsi		#load address of stack var in rsi
	movq	$inputstr, %rdi		#load first argument of scanf
	movq	$0, %rax		#no vector args
	call	scanf			#scan variable

	leaq	-8(%rbp), %rsi		#load address of stack var in rdx
	movq	$inputstr, %rdi		#load first argument of scanf
	movq	$0, %rax		#no vector args
	call	scanf			#scan variable

	#Put variables into registers, preparations for loop subroutine
	
	movq	-8(%rbp), %rsi		#move waarde/value of var to rsi
	movq	-16(%rbp), %rdx		#move waarde/value of var to rdi
	call 	loop
	
	movq	$0, %rcx		#put the value 0 in rcx

	movq	%rax, %rsi		#copy rax into rsi
	movq	$printstr2, %rdi
	call	printf

	call	exit


loop:
	pushq	%rbp
	movq	%rsp, %rbp

	movq	$1, %rax
	subq	$8, %rsp
	movq	%rdi, -8(%rbp)


powend:
	imulq 	%rsi, %rax
	decq 	-8(%rbp)
	cmpb 	$0, -8(%rbp)
	jg 	powend
	movq	%rbp, %rsp
	popq	%rbp
	ret


