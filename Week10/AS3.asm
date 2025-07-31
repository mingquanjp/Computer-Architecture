.eqv RED 0x00FF0000       # Định nghĩa màu ĐỎ (Red)
.eqv MONITOR_SCREEN 0x10010000 # Địa chỉ bắt đầu của bộ nhớ màn hình
.eqv WHITE 0x00FFFFFF      # Định nghĩa màu TRẮNG

.text
li a0, MONITOR_SCREEN     # Load địa chỉ bắt đầu màn hình vào a0
li t0, 0                # Khởi tạo chỉ số pixel (bắt đầu từ 0)
li t2, 8                # Kích thước cửa sổ: 8 hàng và 8 cột
li t3, 2                # Giá trị 2 (dùng cho phép chia modulo 2)

loop:
    li t4, 64             # Tổng số pixel trong cửa sổ (8 * 8 = 64)
    bge t0, t4, exit      # Nếu đã xử lý hết pixel (t0 >= 64), thoát vòng lặp

    # Tính toán vị trí hàng và cột từ chỉ số pixel
    div t1, t0, t2        # t1 = hàng = chỉ số pixel / 8
    rem t4, t0, t2        # t4 = cột = chỉ số pixel % 8

    # Xác định màu dựa trên tổng (hàng + cột) modulo 2
    add t5, t1, t4        # t5 = tổng của hàng và cột
    rem t5, t5, t3        # t5 = (hàng + cột) % 2
    beqz t5, color_white  # Nếu (hàng + cột) % 2 == 0, chọn màu TRẮNG
    j color_pink          # Ngược lại, chọn màu HỒNG

color_white:
    li t6, WHITE          # Load mã màu TRẮNG vào t6
    j set_pixel           # Nhảy đến đoạn code vẽ pixel

color_pink:
    li t6, RED         # Load mã màu HỒNG vào t6
    j set_pixel           # Nhảy đến đoạn code vẽ pixel

set_pixel:
    slli t5, t0, 2        # Tính offset byte: chỉ số pixel * 4 (mỗi pixel 4 byte)
    add t5, a0, t5        # Tính địa chỉ pixel trong bộ nhớ màn hình
    sw t6, 0(t5)          # Lưu mã màu vào địa chỉ bộ nhớ của pixel
    addi t0, t0, 1        # Tăng chỉ số pixel để xử lý pixel tiếp theo
    j loop                # Quay lại vòng lặp

exit:
    li a7, 10             # Gọi syscall để thoát chương trình
    ecall