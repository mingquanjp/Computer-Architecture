	.data
	A: .word -3, 4, 1, 2, 7, 9, 10, -4, 11, 2, 3
	Aend: .word
	
	.text
	main:
	    la a0, A
	    la a1, Aend
	    addi a1, a1, -4
	    j insertion_sort
	after_sort:
	    li a7, 10
	    ecall
	
	insertion_sort:
	    la t0, A
	    addi t1, t0, 4
	outer_loop:
	    bgt t1, a1, end_sort
	    lw t2, 0(t1)
	    add t3, t1, zero
	inner_loop:
	    addi t4, t3, -4
	    blt t4, t0, insert_done
	    lw t5, 0(t4)
	    ble t5, t2, insert_done
	    sw t5, 4(t4)
	    addi t3, t3, -4
	    j inner_loop
	insert_done:
	    sw t2, 0(t3)
	    jal print_array
	    addi t1, t1, 4
	    j outer_loop
	end_sort:
	    j after_sort
	
	print_array:
	    addi sp, sp, -20
	    sw t0, 0(sp)
	    sw t1, 4(sp)
	    sw t2, 8(sp)
	    sw t3, 12(sp)
	    sw a7, 16(sp)
	
	    la t0, A
	    la t1, Aend
	    addi t1, t1, -4
	print_loop:
	    bgt t0, t1, print_done
	    lw a0, 0(t0)
	    li a7, 1
	    ecall
	    li a0, 32
	    li a7, 11
	    ecall
	    addi t0, t0, 4
	    j print_loop
	print_done:
	    li a0, 10
	    li a7, 11
	    ecall
	
	    lw t0, 0(sp)
	    lw t1, 4(sp)
	    lw t2, 8(sp)
	    lw t3, 12(sp)
	    lw a7, 16(sp)
	    addi sp, sp, 20
	
	    jr ra