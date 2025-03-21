.data
A: .word 7, -2, 5, 1, 5, 6, 7, 3, 6, 8, 8, 59, 5
Aend: .word
.text
main:
    la a0, A           # a0 = address(A[0])
    la a1, Aend        # a1 = address(Aend)
    mv s2, a0          # Lưu địa chỉ ban đầu của mảng vào s2
    addi a1, a1, -4    # a1 = address(A[n-1])
    li s6, 13          # Số phần tử của mảng (13)
    j sort             # Nhảy đến thủ tục sort để sắp xếp
after_sort:
    li a7, 10          # Chuẩn bị gọi hệ thống để kết thúc chương trình
    ecall              # Gọi hệ thống để kết thúc chương trình
end_main:

sort:
    beq a0, a1, done   # Nếu a0 == a1 (mảng chỉ có 1 phần tử), nhảy đến nhãn done
    j max              # Gọi thủ tục max để tìm phần tử lớn nhất trong phần chưa sắp xếp
after_max:
    lw t0, 0(a1)       # Load giá trị của phần tử cuối cùng vào t0
    sw t0, 0(s0)       # Ghi giá trị của phần tử cuối cùng vào vị trí của phần tử lớn nhất
    sw s1, 0(a1)       # Ghi giá trị lớn nhất vào vị trí của phần tử cuối cùng
    addi a1, a1, -4    # Di chuyển con trỏ a1 sang trái (giảm kích thước phần chưa sắp xếp)

    jal print_array    # Gọi thủ tục in mảng

    j sort             # Lặp lại thủ tục sort
done:
    j after_sort

max:
    addi s0, a0, 0     # Khởi tạo con trỏ max (s0) trỏ đến phần tử đầu tiên
    lw s1, 0(s0)       # Khởi tạo giá trị max (s1) bằng giá trị của phần tử đầu tiên
    addi t0, a0, 0     # Khởi tạo con trỏ next (t0) trỏ đến phần tử đầu tiên
loops:
    beq t0, a1, ret    # Nếu t0 == a1 (đã duyệt hết mảng), nhảy đến nhãn ret
    addi t0, t0, 4     # Di chuyển con trỏ t0 sang phải (phần tử tiếp theo)
    lw t1, 0(t0)       # Load giá trị của phần tử tiếp theo vào t1
    blt t1, s1, loops  # Nếu t1 < s1 (phần tử tiếp theo nhỏ hơn max), lặp lại
    addi s0, t0, 0     # Cập nhật con trỏ max (s0) trỏ đến phần tử tiếp theo
    addi s1, t1, 0     # Cập nhật giá trị max (s1) bằng giá trị của phần tử tiếp theo
    j loops            # Lặp lại vòng lặp
ret:
    j after_max

print_array:
    addi sp, sp, -8    # Cấp phát không gian trên stack
    sw ra, 0(sp)       # Lưu giá trị của ra vào stack
    sw a0, 4(sp)       # Lưu giá trị của a0 vào stack

    li s5, 0           # Khởi tạo biến đếm s5 = 0
print_loop:
    beq s5, s6, print_done # Nếu s5 == s6 (đã duyệt hết mảng), kết thúc in
    slli s7, s5, 2     # s7 = s5 * 4 (offset của phần tử thứ s5)
    add s7, s7, s2     # s7 = địa chỉ của phần tử thứ s5 (sử dụng s2 thay vì a0)
    lw s8, 0(s7)       # Load giá trị của phần tử thứ s5 vào s8

    # In giá trị
    li a7, 1           # Chuẩn bị in số nguyên
    mv a0, s8          # Đặt giá trị cần in vào a0
    ecall              # Gọi hệ thống để in giá trị

    # In khoảng trắng
    li a7, 11          # Chuẩn bị in ký tự
    li a0, 32          # Đặt ký tự khoảng trắng (ASCII 32) vào a0
    ecall              # Gọi hệ thống để in ký tự

    addi s5, s5, 1     # Tăng biến đếm s5 lên 1
    j print_loop       # Lặp lại vòng lặp
print_done:
    # In ký tự xuống dòng
    li a7, 11          # Chuẩn bị in ký tự
    li a0, 10          # Đặt ký tự xuống dòng (ASCII 10) vào a0
    ecall              # Gọi hệ thống để in ký tự

    lw ra, 0(sp)       # Khôi phục giá trị của ra từ stack
    lw a0, 4(sp)       # Khôi phục giá trị của a0 từ stack
    addi sp, sp, 8     # Giải phóng không gian trên stack
    jr ra              # Trở về thủ tục gọi
