#Program name: Assignment 1
#Description: print namen, sluit dan af
#Namen en studentnummers: Soumaya Azaouagh 4334604 Esmee Hildebrand 4353765
#Datum: 21-09-2015

.text
randomstr:	.asciz "Esmee Hildebrand 4353765 Soumaya Azaouagh 4334604 Assignment %d\n"

.global		main

##############################################################

main:
	
	movq	$0, %rax
	movq	$25, %rsi
	movq   $randomstr, %rdi
	call	printf

end:	
	mov	$0, %rdi
	call	exit
