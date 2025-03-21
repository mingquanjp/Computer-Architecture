# Laboratory Exercise 3, Home Assignment 1
.text
start:
# TODO:
li s1, 2# Khởi tạo giá trị i vào thanh ghi s1
li s2, -5# Khởi tạo giá trị j vào thanh ghi s2
li s3, 3 #Khởi tạo giá trị m vào thanh ghi s3
li s4, 4 #Khởi tạo giá trị n vào thanh ghi s4
add t2, s1, s2 # i + j
add t3, s3,s4  # m + n
bgt t2,t3 ,then # i + j > m + n then jump then
else:
addi t2, t2, -1 # begin else part: y=y-1
add t3, t3, t3 # z=2*z
j endif # skip then part
then:
addi t1, t1, 1 # then part: x=x+1
addi t3, zero, 1 # z=1
endif:
