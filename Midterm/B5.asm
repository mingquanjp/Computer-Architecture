.data
	mess1: .asciz "Nhap so phan tu cua mang : " 
	mess2: .asciz "Nhap tung phan tu cho mang : "
	mess3: .asciz "Chuoi sau khi sap xep : "
	space: .asciz " "
	.align 2 #Set up dia chi bat dau mang A chia het cho 4,neu k co dong nay khi chay se loi o dong sw a0, 0(t2) do dia chi hien tai khong chia het cho 4
	A: .space 400 
.text
	#In mess1
	li a7, 4
	la a0, mess1
	ecall 
	
	#Input N
	li a7,5
	ecall
	mv a2,a0 # a2 = N ( kich thuoc cua mang )
	
	#kiem tra N hop le
	blez a2, end       # Nếu N <= 0 -> kết thúc
   	
	
	# In mess2 
  	li a7, 4
 	la a0, mess2
  	ecall
	
	li t0, 0 # i = 0
	la s0, A #a0 = address A[0]

input:
	bge t0, a2, endInput # if i >= N --> endInput
	
	#nhap A[i]
	li a7,5
	ecall
	
	
	slli t1, t0, 2 # t1 = 4 * i
	add t2, s0, t1 # t2 = A + 4 * i
	sw a0, 0(t2) # A[i] = a0
	
	addi t0,t0,1
	beq x0,x0, input
	
endInput:	
	# a2 = N 
	
	li t0, 0 #i = 0
	addi t2, a2, -1 # t2 = N -1
loop1: 
	bge t0,t2, endloop1  # if i >= N - 1 --> endloop
	#get a[i]
	slli t3,t0,2
	add t4,s0,t3
	lw s1, 0(t4) # s1 = A[i]
	blez s1, endloop2 # check if s0 <= 0 --> i++ va quay lai loop
	addi t1, t0,1 # j = i + 1
	
loop2:	
	bge t1, a2, endloop2 # if j >= N --> endloop2
	#get a[j]
	slli t5,t1,2
	add t6, s0, t5
	lw s2, 0(t6) #s2 = A[j]
	
	blez s2, no_swap # if s2 <= 0 --> No swap
	ble s1,s2,no_swap  # if A[i] <= A[j] --> No swap

swap:
	sw s1, 0(t6)
	sw s2, 0(t4)
	mv s1, s2  #Cap nhat A[i[ moi]
no_swap:
	addi t1,t1,1
	beq x0,x0, loop2
	
endloop2:
	addi t0,t0, 1
	beq x0,x0, loop1
endloop1:

	#In chuoi ra man hinh
	li a7, 4
	la a0, mess3
	ecall
	
	li t6, 0
print:
	bge t6,a2,end
	slli t3,t6, 2
	add t5, s0, t3
	lw s3, 0(t5)
	
	li a7, 1
	mv a0,s3
	ecall
	
	#in space
	li a7,4
	la a0,space
	ecall
	
	addi t6,t6,1
	beq x0,x0,print
	
end:
    # Kết thúc chương trình
    li a7, 10
    ecall
