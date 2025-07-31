.data
exit_str:   .asciz "exit"       # Chuỗi "exit" để so sánh
buffer:     .space 5            # Vùng đệm chứa 4 ký tự nhập + ký tự kết thúc null
newline:    .asciz "\n"         # Ký tự xuống dòng

.text
.globl main

main:
    # Khởi tạo
    li s1, 0                   # s1 = chỉ số hiện tại trong buffer
    la s2, buffer              # s2 = con trỏ tới buffer
    
main_loop:
    # Kiểm tra có phím nào được nhấn không
    li t0, 0xFFFF0000          # Địa chỉ control của bàn phím
    lw t1, 0(t0)               # Đọc trạng thái
    andi t1, t1, 1             # Kiểm tra bit sẵn sàng
    beqz t1, main_loop         # Nếu không có input, tiếp tục kiểm tra
    
    # Đọc ký tự từ bàn phím
    li t0, 0xFFFF0004          # Địa chỉ data của bàn phím
    lw a0, 0(t0)               # Đọc ký tự
    
    # Lưu ký tự vào buffer
    sb a0, 0(s2)               # Lưu ký tự vào vị trí hiện tại
    addi s2, s2, 1             # Tăng con trỏ buffer
    addi s1, s1, 1             # Tăng chỉ số buffer
    
    # Xử lý ký tự
    jal process_char           # Gọi hàm xử lý ký tự
    
    # Kiểm tra nếu buffer đã có đủ 4 ký tự
    li t0, 4
    bne s1, t0, main_loop      # Nếu chưa đủ 4 ký tự, tiếp tục vòng lặp
    
    # So sánh với chuỗi "exit"
    la a0, buffer              # Địa chỉ buffer
    la a1, exit_str            # Địa chỉ chuỗi "exit"
    jal strcmp                 # Gọi hàm so sánh chuỗi
    beqz a0, exit_program      # Nếu bằng nhau thì thoát chương trình
    
    # Dịch buffer (bỏ ký tự cũ nhất)
    la s2, buffer              # Đặt lại con trỏ buffer
    lb t0, 1(s2)               # Đọc ký tự thứ 2
    sb t0, 0(s2)               # Ghi vào vị trí đầu
    lb t0, 2(s2)               # Đọc ký tự thứ 3
    sb t0, 1(s2)               # Ghi vào vị trí thứ 2
    lb t0, 3(s2)               # Đọc ký tự thứ 4
    sb t0, 2(s2)               # Ghi vào vị trí thứ 3
    li s1, 3                   # Cập nhật chỉ số buffer = 3
    addi s2, s2, 3             # Di chuyển con trỏ buffer
    
    j main_loop                # Tiếp tục vòng lặp chính
    
process_char:
    # Kiểm tra nếu ký tự là chữ thường (a-z)
    li t0, 'a'
    li t1, 'z'
    blt a0, t0, check_upper    # Nếu nhỏ hơn 'a', kiểm tra chữ hoa
    bgt a0, t1, check_digit    # Nếu lớn hơn 'z', kiểm tra số
    # Là chữ thường - chuyển thành chữ hoa
    addi a0, a0, -32           # Trừ 32 để chuyển thành hoa
    j display_char
    
check_upper:
    # Kiểm tra nếu ký tự là chữ hoa (A-Z)
    li t0, 'A'
    li t1, 'Z'
    blt a0, t0, check_digit    # Nếu nhỏ hơn 'A', kiểm tra số
    bgt a0, t1, check_digit    # Nếu lớn hơn 'Z', kiểm tra số
    # Là chữ hoa - chuyển thành chữ thường
    addi a0, a0, 32            # Cộng 32 để chuyển thành thường
    j display_char
    
check_digit:
    # Kiểm tra nếu ký tự là số (0-9)
    li t0, '0'
    li t1, '9'
    blt a0, t0, other_char     # Nếu nhỏ hơn '0', xử lý ký tự khác
    bgt a0, t1, other_char     # Nếu lớn hơn '9', xử lý ký tự khác
    # Là số - giữ nguyên
    j display_char
    
other_char:
    # Ký tự khác - thay bằng '*'
    li a0, '*'
    
display_char:
    # Chờ cho đến khi màn hình sẵn sàng
    li t0, 0xFFFF0008          # Địa chỉ control của màn hình
display_wait:
    lw t1, 0(t0)               # Đọc trạng thái
    andi t1, t1, 1             # Kiểm tra bit sẵn sàng
    beqz t1, display_wait      # Nếu chưa sẵn sàng, tiếp tục chờ
    
    # Hiển thị ký tự
    li t0, 0xFFFF000C          # Địa chỉ data của màn hình
    sw a0, 0(t0)               # Ghi ký tự ra màn hình
    
    ret                        # Trở về từ hàm
    
strcmp:
    # Hàm so sánh chuỗi
    # a0 = địa chỉ chuỗi 1, a1 = địa chỉ chuỗi 2
    # Trả về 0 trong a0 nếu bằng nhau
    lb t0, 0(a0)               # Đọc ký tự từ chuỗi 1
    lb t1, 0(a1)               # Đọc ký tự từ chuỗi 2
    bne t0, t1, strcmp_not_equal  # Nếu khác nhau, trả về 1
    beqz t0, strcmp_equal      # Nếu gặp null terminator, trả về 0
    addi a0, a0, 1             # Di chuyển tới ký tự tiếp theo chuỗi 1
    addi a1, a1, 1             # Di chuyển tới ký tự tiếp theo chuỗi 2
    j strcmp                   # Tiếp tục so sánh
strcmp_equal:
    li a0, 0                   # Chuỗi bằng nhau
    ret
strcmp_not_equal:
    li a0, 1                   # Chuỗi khác nhau
    ret
    
exit_program:
    # Thoát chương trình
    li a7, 10                  # Syscall exit
    ecall