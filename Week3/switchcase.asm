# Laboratory Exercise 3, Home Assignment 3
.data
test: .word 5
.text
la s0, test # Nạp địa chỉ của biến test vào s0
lw s1, 0(s0) # Nạp giá trị của biến test vào s1
li t0, 1 # Nạp giá trị cần kiểm tra
li t1, 3 # Nạp giá trị cần kiểm tra
li t2, 5 # Nạp giá trị cần kiểm tra
beq s1, t0, case_0
beq s1, t1, case_1
beq s1, t2, case_2
j default
case_0:
addi s2, s2, 1 # a = a + 1
j continue
case_1:
sub s2, s2, t1 # a = a - 1
j continue
case_2:
addi s3, s3, 5  # b = b + 5
j continue
default:
continue: