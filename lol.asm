.data
prompt: .asciz "Nhập số nguyên dương N: "
result: .asciz "Dãy Fibonacci nhỏ hơn N là: "
space:  .asciz " "

.text
.globl main

main:
    # In prompt để yêu cầu nhập N
    li a7, 4
    la a0, prompt
    ecall

    # Đọc số nguyên N từ bàn phím (lưu vào a0)
    li a7, 5
    ecall
    mv t0, a0          # t0 = N

    # Kiểm tra N > 0
    blez t0, end_program  # Nếu N <= 0, kết thúc

    # In kết quả header
    li a7, 4
    la a0, result
    ecall

    # Khởi tạo các giá trị Fibonacci ban đầu
    li t1, 0           # F0 = 0
    li t2, 1           # F1 = 1

    # In F0 nếu N > 0
    li a7, 1
    mv a0, t1
    ecall

    # Nếu N == 1, kết thúc
    li t3, 1
    beq t0, t3, end_program

    # In dấu cách trước F1
    li a7, 4
    la a0, space
    ecall

    # In F1 nếu N > 1
    li a7, 1
    mv a0, t2
    ecall

    # Vòng lặp tính Fibonacci
loop:
    # Tính số Fibonacci tiếp theo (t3 = t1 + t2)
    add t3, t1, t2     # F_next = F_prev1 + F_prev2

    # Kiểm tra nếu F_next >= N thì thoát
    bge t3, t0, end_program

    # In dấu cách
    li a7, 4
    la a0, space
    ecall

    # In F_next
    li a7, 1
    mv a0, t3
    ecall

    # Cập nhật F_prev1 và F_prev2
    mv t1, t2          # F_prev1 = F_prev2 cũ
    mv t2, t3          # F_prev2 = F_next

    # Lặp lại
    j loop

end_program:
    # Kết thúc chương trình
    li a7, 10
    ecall