# Laboratory Exercise 3, Home Assignment 3
.text
li s0,0x12345678 #s0 = 0x12345678
#Trich xuat MSB cua thanh ghi S0
srli t0, s0, 24
#Xóa LSB của thanh ghi s0
andi t1, s0, 0xffffff00
#Thiết lập LSB của thanh ghi s0 (bit 7 đến bit 0 được thiết lập bằng 1)
ori t2,s0,0xff
#Xóa thanh ghi s0 bằng cách dùng các lệnh logic (s0 = 0)
xor t3,s0,s0