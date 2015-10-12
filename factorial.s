#Program name: Assignment 2
#Description: subroutines and I/O
#Namen en studentnummers: Soumaya Azaouagh 4334604 Esmee Hildebrand 4353765
#Datum: 28-09-2015

.data
randomstr:	.asciz "Assignment 2: inout\n\nGive me a number: \n"
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
	call	factorial
	call	exit
	

# Scan van de commandline; inout is de subroutine
in:	
	pushq	%rbp			#prologue: push rbp onto stack
	movq	%rsp, %rbp		#then move stackpointer to rbp		

	subq	$8, %rsp		#reserve stack space for variable
	leaq	-8(%rbp), %rsi		#load address of stack var in rsi
	movq	$inputstr, %rdi		#load first argument of scanf
	call	scanf			#scan

	movq	-8(%rbp), %rsi		#move value of var to rbx
	movq	$1, %rax		#copy 1 to rax

factorial:
	cmp    %rsi, $0		#compare rsi and 0
	je      out			#if equal, jump to out

	decq	%rsi
	pushq	%rsi
	call    factorial		#call function
	imulq   %rsi			#rax = rax * rsi
	popq	%rsi

out:
	movq	%rax, %rsi
	movq	$newlinestr, %rdi	#store newlinestr into rdi
	movq	$0, %rax		#no vector args
	call	printf			#print
	
	movq    %rbp, %rsp		#epilogue: move rbp to rsp
	popq	%rbp			#restore base pointer

	ret				#return from subroutine
