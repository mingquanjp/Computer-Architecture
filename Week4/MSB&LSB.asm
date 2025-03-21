.text
li s1,2
li s2,3
# ble s1, s2, label (if (s1 <= s2) j lab )
bge s2, s1, CONDITION  # if (s2 >= s1) j lab
CONDITION:
addi s2,s2,1




#li s0, 0x12345 #s0=0x12345
#xori s1,s0,0xFFFFFFFF # s0 = s0 XOR 0xFFFFFFFF





#mv s0,s1
#li s1, 30 #s1=30
#add s0,zero,s1 #s0 = 0 + 30 = 30=s1





#a)neg s0,s1
#li s0, 20 #s0 = 20
#sub s1,zero,s0 #s1 = 0 - s0 = -s0