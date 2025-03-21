.data
mess1: .asciz "The sum of " 
mess2: .asciz " and "
mess3: .asciz " is "
.text
	li s0, 15 #s0 = 15
	li s1, 8 #s1 = 8
	add s2, s0, s1 #s2 = 15 + 8= 23

#In chuoi "The sum of"
	li a7,4 #Systemcall Stringprint
	la a0, mess1 #Load address of "The sum of"
	ecall
#In gia tri s0
	li a7,1 #Systemcall Intergerprint
	mv a0,s0 #a0=s0
	ecall
#In chuoi "and"
	li a7,4
	la a0,mess2
	ecall
#In gia tri s1
	li a7,1
	mv a0,s1
	ecall
#In chuoi "is"
	li a7,4
	la a0,mess3
	ecall 
#In gia tri s2
	li a7,1
	mv a0,s2
	ecall
#Exit
	li a7,10
	ecall