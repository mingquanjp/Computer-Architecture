.eqv SEVENSEG_LEFT 0xFFFF0011     # Địa chỉ của LED 7 đoạn bên trái
.eqv SEVENSEG_RIGHT 0xFFFF0010    # Địa chỉ của LED 7 đoạn bên phải

.data
sevenseg_map:                     # Bảng ánh xạ các số (0-9) tới mã nhị phân của LED 7 đoạn
    .byte 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F

.text
main:
    # Đọc ký tự từ bàn phím
    li a7, 12                      # Syscall để đọc một ký tự từ bàn phím
    ecall                          # Kết quả trả về nằm trong thanh ghi a0

    # Lấy 2 chữ số cuối của mã ASCII
    li t0, 100
    rem s0, a0, t0                 # s0 = mã ASCII % 100 (lấy 2 chữ số cuối)

    # Tách hàng chục và hàng đơn vị
    li t0, 10
    div t1, s0, t0                 # t1 = hàng chục
    rem t2, s0, t0                 # t2 = hàng đơn vị

    # Hiển thị số lên LED
    blt s0, t0, oneDigit           # Nếu số chỉ có 1 chữ số, nhảy tới oneDigit
    jal twoDigits                 # Nếu là 2 chữ số, nhảy tới twoDigits

oneDigit:
    li a0, 0x00                    # Dọn dẹp LED bên trái
    jal SHOW_7SEG_LEFT            # Gọi hàm hiển thị LED bên trái
    la t0, sevenseg_map
    add t0, t0, t2                # Tính địa chỉ cho số hàng đơn vị
    lb a0, 0(t0)                  # Lấy mã nhị phân cho số hàng đơn vị
    jal SHOW_7SEG_RIGHT          # Hiển thị lên LED bên phải
    j exit                        # Kết thúc

twoDigits:
    la t0, sevenseg_map
    add t0, t0, t1                # Tính địa chỉ cho số hàng chục
    lb a0, 0(t0)                  # Lấy mã nhị phân cho số hàng chục
    jal SHOW_7SEG_LEFT           # Hiển thị lên LED bên trái
    la t0, sevenseg_map
    add t0, t0, t2                # Tính địa chỉ cho số hàng đơn vị
    lb a0, 0(t0)                  # Lấy mã nhị phân cho số hàng đơn vị
    jal SHOW_7SEG_RIGHT          # Hiển thị lên LED bên phải

exit:
    li a7, 10
    ecall

SHOW_7SEG_LEFT:
    li t0, SEVENSEG_LEFT
    sb a0, 0(t0)
    jr ra

SHOW_7SEG_RIGHT:
    li t0, SEVENSEG_RIGHT
    sb a0, 0(t0)
    jr ra
