.data
reverse: .space 22
.text
la t0, reverse
addi t0, t0, 21
li s2, 0
sb s2, 0(t0)
li s0, 1
li s1, 20
input:
    li a7, 12
    ecall
    li t1, '\n'
    beq a0, t1, print
    sub t2, t0, s0
    sb a0, 0(t2)
    beq s0, s1, exceed
    addi s0, s0, 1
    j input
exceed:
    addi s0, s0, 1
print:
    sub a0, t0, s0
    li t3, '\n'
    sb t3, 0(a0)
    li a7, 4
    ecall
