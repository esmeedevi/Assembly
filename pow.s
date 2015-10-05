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

	subq	$8, %rsp		#reserve stack space for variable
	leaq	-8(%rbp), %rsi		#load address of stack var in rsi
	movq	$inputstr, %rdi		#load first argument of scanf
	call	scanf			#scan variable

	subq	$8, %rsp		#reserve stack space for variable
	leaq	-8(%rbp), %rsi		#load address of stack var in rdx
	movq	$inputstr2, %rdi	#load first argument of scanf
	call	scanf			#scan variable
	
	popq	%rdx			#pop exponent variable into rdx
	popq	%rsi			#pop base into rsi

	movq 	%rsi, %rax		#copy base into rax
	movq	$0, %rcx		#put the value 0 in rcx

loop:
	cmpq	%rcx, %rdx		#compare rcx with the exponent in rdx	
	je 	end			#if so, go to end
	
	incq	%rcx			#increment rcx by 1
	mulq	%rsi			#multiply rsi by the value in rax

	jmp	loop

end:
	movq	$printstr2, %rdi	#copy printstr2 into rdi
	movq	%rsi, %rdx		#copy rsi into rdx
	movq	$0, %rax		#no vector args
	call	printf			#print

	movq    %rbp, %rsp		#epilogue: move rbp to rap
	popq	%rbp			#restore base pointer

	ret
