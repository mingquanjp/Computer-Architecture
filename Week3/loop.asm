# Laboratory 3, Home Assigment 2
.data
A: .word 1,3,0,7,9
.text
# TODO: Khởi tạo giá trị các thanh ghi s2, s3, s4
li s3, 5
la s2, A
li s4, 1
li s1, 1 # i = 1
li s5, 0 # sum = 0
loop:
bgt s1, s3, endloop # if i > n then end loop
addi t1, s1, -1
add t1, t1, t1 # t1 = 2 * s1
add t1, t1, t1 # t1 = 4 * s1 => t1 = 4*i
add t1, t1, s2 # t1 store the address of A[i]
lw t0, 0(t1) # load value of A[i] in t0
beq t0, zero, endloop
add s5, s5, t0 # sum = sum + A[i]
add s1, s1, s4 # i = i + step
j loop # go to loop
endloop:
