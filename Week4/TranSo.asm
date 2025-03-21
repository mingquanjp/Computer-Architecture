.text
li s0,-2147483000
li s1,-1000
add s2,s0,s1 #s2 = s0 + s1
xor t0, s0, s1  # t0 = s0 XOR s1 (kiểm tra cùng dấu)
bltz t0, EXIT # Nếu khác dấu, không tràn số
xor t1,s2,s0 #t1= s2 XOR s0 
blt t1, zero, OVERFLOW #if t1<0 -> tràn số
OVERFLOW:
li a0, 1
EXIT: