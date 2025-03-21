# Laboratory Exercise 5, Home Assignment 3
.data
string: .space 20
message1: .asciz "Nhap xau: "
message2: .asciz "Do dai xau la: "
.text
main:
get_string:
# TODO Nhập chuỗi ký tự từ bàn phím
li a7,54
la a0, message1
la a1, string
li a2, 100
ecall
get_length:
la a0, string # a0 = address(string[0])
li t0, 0 # t0 = i = 0
check_char:
add t1, a0, t0 # t1 = a0 + t0 = address(string[0]+i)
lb t2, 0(t1) # t2 = string[i]
beq t2, zero, end_of_str # Nếu là ký tự NULL thì kết thúc
addi t3, t2, -10  # t3 = t2 - 10
beqz t3, end_of_str  # Nếu t3 == 0 (tức là t2 == 10 ==" \n"), thì kết thúc
addi t0, t0, 1 # t0 = t0 + 1 -> i = i + 1
j check_char
end_of_str:
end_of_get_length:
print_length:
# TODO In kết quả ra màn hình
li a7, 4
la a0, message2
ecall
#EXIT
li a7,1
mv a0, t0
ecall
