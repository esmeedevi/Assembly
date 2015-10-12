#Program name: Assignment 4
#Description: Factorial
#Namen en studentnummers: Soumaya Azaouagh 4334604 Esmee Hildebrand 4353765
#Datum: 12-10-2015

.data
randomstr:	.asciz "Assignment 4: Factorial\n\nGive me a number: \n"
inputstr:	.asciz "%ld" 
newlinestr:	.asciz "%ld\n"


.global		main

##############################################################

# Main input, print randomstring

main:
	movq	$0, %rax		#no vector args
	movq    $randomstr, %rdi	#move randomstr into rdi
	call	printf			#print
	
	call 	in			
	movq	%rsi, %rdi

	call	factorial

	movq	%rax, %rsi
	movq	$newlinestr, %rdi	#store newlinestr into rdi
	movq	$0, %rax		#no vector args
	call	printf			#print
	
	mov	$0, %rdi
	
	call	exit
	

# Scan van de commandline; inout is de subroutine
in:	
	pushq	%rbp			#prologue: push rbp onto stack
	movq	%rsp, %rbp		#then move stackpointer to rbp		

	subq	$8, %rsp		#reserve stack space for variable
	leaq	-8(%rbp), %rsi		#load address of stack var in rsi
	movq	$inputstr, %rdi		#load first argument of scanf
	call	scanf			#scan

	movq 	-8(%rbp), %rsi		#move value of var to rbx

	movq    %rbp, %rsp		#epilogue: move rbp to rsp
	popq	%rbp			#restore base pointer
	ret
	

factorial:
	pushq	%rbp			#prologue: push rbp onto stack
	movq	%rsp, %rbp		#then move stackpointer to rbp	

	cmpq    $0, %rdi 		#compare rsi and 0
	je      nul			#if equal, jump to nul

	
	pushq	%rdi
	decq	%rdi

	call    factorial		#call function
	
	popq	%rdi
	imulq   %rdi			#rax = rax * rsi
	
	movq    %rbp, %rsp		#epilogue: move rbp to rsp
	popq	%rbp			#restore base pointer
	
	ret


nul:
	movq	$1, %rax		#copy 1 to rax
	movq    %rbp, %rsp		#epilogue: move rbp to rsp
	popq	%rbp			#restore base pointer
	
	ret

