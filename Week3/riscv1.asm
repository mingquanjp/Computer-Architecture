.data 
	A: .word 1,3,0,7,9
	B: .word 2,4,6,8, 10, 5
.text
	la s0, A
	la s1, B
	lw t0, 16(s1)
	