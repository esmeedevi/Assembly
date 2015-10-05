.data
printstr:	.asciz "Assignment 3: pow\n\nGive me a positive base and an exponent: \n"
printstr2:	.asciz "/nResult is: %ld/n"
inputstr:	.asciz "%ld" 
inputstr2:	.asciz "%ld" 

.global		main

main:
	movq	$0, %rax		#no vector args
	movq    $printstr, %rdi		#move printstr into rdi
	call	printf			#print
	
	call 	input
	call 	loop
	call	exit

input:
	pushq	%rbp			#prologue: push rbp onto stack
	movq	%rsp, %rbp		#then copy stackpointer to rbp		

	subq	$16, %rsp		#reserve stack space for variables

	leaq	-8(%rbp), %rsi		#load address of stack var in rsi
	movq	$inputstr, %rdi		#load first argument of scanf
	call	scanf			#scan variable
	
	movq 	-8(%rbp), %rsi 		#copy scanned variable into rsi

	leaq	-8(%rbp), %rcx		#load address of stack var in rcx
	movq	$inputstr2, %rdi	#load first argument of scanf
	call	scanf			#scan variable

	movq 	-8(%rbp), %rcx		#copy scanned variable into rcx

	movq 	%rsi, %rax		#copy rsi into rax
	movq	$1, %r8			#put the value 1 in r8

loop:
	cmpq	%r8, %rcx		#compare r8 with the exponent in rcx	
	jle 	end			#if so, go to end
	
	incq	%r8			#increment r8 by 1
	mulq	%rsi			#multiply rsi by the value in rax

	jmp	loop

end:
	movq	$printstr2, %rdi	#copy printstr2 into rdi
	movq	%rsi, %rdx		#copy rsi into rdx
	movq	$0, %rax		#no vector args
	call	printf			#print

	movq    %rbp, %rsp		#epilogue: move rsp to rdi
	popq	%rbp			#restore base pointer

	ret
