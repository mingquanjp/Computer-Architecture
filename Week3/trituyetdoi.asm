.data
	A: .word 1, -3 , 5, -4, 8 , -10
.text
	li s3, 6 # so phan tu cua A
	la s4, A 
	li s1, 0 # i =0
	li s5, 0 # max = 0
loop:
	bge s1, s3, endloop
	add t1, s1, s1  #i=2*s1
	add t1, t1, t1  #i = 4 * s1 = 4*i
	add t1, t1, s4  #luu tru dia chi cua A[i] vao t1
	lw t0, 0(t1) #luu tru gia tri cua A[i] vao t0
    #kiem tra gia tri tuyet doi
	bge t0, zero, checkmax #Neu >=0 thi giu nguyen, di vao check 
	neg t0,t0 # Gan t0 = -t0 neu t0 la so am
	
checkmax:
	bgt t0, s5, then # if A[i] > max -> nhay vao then
	addi s1, s1, 1 #i++
	j loop
	
then:
	mv s5, t0 #max = A[i]
	addi s1,s1, 1 # i++
	j loop#quay lai loop
endloop:	
