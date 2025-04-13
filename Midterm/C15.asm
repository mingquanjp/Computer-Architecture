.data
	mess1: .asciz "Nhap chuoi thu nhat : "
	mess2: .asciz "Nhap chuoi thu hai : "
	mess3: .asciz "Cac chu so ko co trong ca 2 chuoi la : "
	space: .asciz " "
	A: .space 100
	B: .space 100
	C: .word 0,0,0,0,0,0,0,0,0,0  #Mang dem chu so 0-9
.text
	#mess1
	li a7,4
	la a0,mess1
	ecall
	
	#Nhap xau 1
	li a7,8
	la a0,A
	li a1,100
	ecall
	
	#mess2
	li a7,4
	la a0,mess2
	ecall
	
	#Nhap xau 2
	li a7,8
	la a0,B
	li a1,100
	ecall
	
###### DEM KY TU CHU SO TRONG A ########
	li t0,0   #i = 0
	la s1, A
	la s2, C
loopA:
	add s3,s1,t0    #Dia chi cua A[i]
	lb t2, 0(s3)    #Lay A[i]
	beqz t2, endloopA   #Neu A[i] = '\n' --> ket thuc
	 li t5, '0'            # Load ASCII '0' into t5
   	 blt t2, t5, continue  # if (A[i] < '0') skip
   	 li t5, '9'            # Load ASCII '9' into t5
   	 bgt t2, t5, continue  # if (A[i] > '9') skip
   	 
   	 
	#Neu la chu so, tang C[digit]++
	li t5,'0'
	sub t3,t2,t5 #digit = A[i] -'0'
	slli t3,t3,2  #offset = digit * 4
	add s4,s2,t3  #Dia chi C[digit]
	lw t4, 0(s4) #t4 = C[A[i]]
	addi t4,t4,1
	sw t4,0(s4)
	
	
continue:
	addi t0,t0,1
	beq x0,x0, loopA

endloopA:
	
###### DEM KY TU CHU SO TRONG B ########
	li t0,0 #i = 0
	la s1, B
	la s2, C
loopB:
	add s3,s1,t0 # s3 = B + i (1 char = 1 byte)
	lb t2, 0(s3)  #( t2 = byte C[i] ) 
	beqz t2, endloopB  # if t2 = 0 ( null ) --> endloop 
	 li t5, '0'            # Load ASCII '0' into t5
   	 blt t2, t5, continues  # if (B[i] < '0') skip
   	 li t5, '9'            # Load ASCII '9' into t5
   	 bgt t2, t5, continues # if (B[i] > '9') skip
	
	li t5,'0'
	sub t3,t2,t5 #(byte)B[i] -'0'
	slli t3,t3,2 # t3 = t3 * 4
	add s4,s2,t3 # s4 = C + t3 *4 
	lw t4, 0(s4) #t4 = C[B[i]]
	addi t4,t4,1 
	sw t4,0(s4) #C[B[i]]++
	
	
continues:
	addi t0,t0,1
	beq x0,x0, loopB

endloopB:

###### In cac chu so ko xuat hien trong ca A va B #####
	li t5,9 # Strength of C = 9
	li t6,0 # j=0
	la t2,C
	
	#mess3
	li a7,4
	la a0,mess3
	ecall
	
loopC: 
#printtest
	bgt t6,t5,end #if j > 9 --> end
	slli s8,t6,2 #s8 = 4*j
	add t3,t2,s8 # t3 =  C + 4*j
	lw s6, 0(t3) #s6 = C[j]
	bgt s6,zero, skip
	
print:	
	li a7,1
	mv a0,t6
	ecall
	
	#space
	li a7,4
	la a0,space
	ecall
	
skip:
	
	addi t6,t6,1
	beq x0,x0,loopC
	
end:



	

	
	
	
	
