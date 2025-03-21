.data
A: .word 1, -3, 4, 5, 2, -8, 8, 7
Aend: .word

.text
main:
    la a0, A
    la a1, Aend
    addi a1, a1, -4
    j bubble_sort
after_sort:
    li a7, 10
    ecall

bubble_sort:
    la t0, A
    addi t1, a1, 4
outer_loop:
    add t2, t0, zero
    addi a3, t1, -4
    li t3, 0
inner_loop:
    bge t2, a3, end_inner
    lw t4, 0(t2)
    lw t5, 4(t2)
    ble t4, t5, no_swap
    sw t5, 0(t2)
    sw t4, 4(t2)
    li t3, 1
no_swap:
    addi t2, t2, 4
    j inner_loop
end_inner:
    jal print_array
    beqz t3, end_sort
    addi t1, t1, -4
    b outer_loop
end_sort:
    j after_sort

print_array:
    addi sp, sp, -20
    sw t0, 0(sp)
    sw t1, 4(sp)
    sw t2, 8(sp)
    sw a0, 12(sp)
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
    lw a0, 12(sp)
    lw a7, 16(sp)
    addi sp, sp, 20

    jr ra