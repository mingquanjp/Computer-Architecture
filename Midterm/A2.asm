.data
	mess1: .asciz "Nhap so nguyen: "
	mess2: .asciz "Day fibonnaci nho hon N la: "
	space: .asciz " "
.text
	#In chuoi Nhap so nguyen
	li a7,4
	la a0, mess1
	ecall

get_Input:		
	#Nhap so nguyen
	li a7,5 
	ecall
	mv t0,a0  # t0 = N
	
	#Neu N <=0 --> Ket thuc
	bltz t0, ket_thuc
	
	#In mess2
	li a7,4
	la a0, mess2
	ecall
	
	#Gan 2 so dau voi 0 va 1
	li t1,0 #t1 =0
	li t2,1 #t2 =1
	
	#In so dau tien( 0 )
	li a7,1
	mv a0,t1
	ecall
	
	#In space
	li a7,4
	la a0, space
	ecall
	
	#In so thu 2 ( 1 )
	li a7,1
	mv a0,t2
	ecall
	
	#In space
	li a7,4
	la a0, space
	ecall
	
	
fibonacci:
	add t3, t1, t2  #t3 = t1 + t2
	
	bge t3, t0,ket_thuc #if t1 + t2 >= N --> end
	
	#In so tiep theo t3
	li a7, 1
	mv a0, t3
	ecall
	
	#In space
	li a7,4
	la a0, space
	ecall
	
	#update t1, t2
	mv t1,t2  #t1 = t2
	mv t2,t3  #t2 = t3
	
	#loop
	beq x0,x0,fibonacci
	
ket_thuc: 
