.data
message_largest: .asciz "largest: "
message_smallest: .asciz " \nSmallest: "

.text
main:
li a0, 56
li a1, -23
li a2, 44
li a3, 7
li a4, 3
li a5, -4
li a6, 4
li a7, -7

# Push registers a0-a7 onto the stack
addi sp, sp, -32    # Allocate 32 bytes (8 registers * 4 bytes each)
sw a0, 28(sp)    # Save a0 at top of allocated stack space
sw a1, 24(sp)    # Save a1
sw a2, 20(sp)    # Save a2
sw a3, 16(sp)    # Save a3
sw a4, 12(sp)    # Save a4
sw a5, 8(sp)    # Save a5
sw a6, 4(sp)    # Save a6
sw a7, 0(sp)    # Save a7

# Call subroutine to find min and max values
jal find_min_max

# Print the result for largest value
la a0, message_largest    # Load message address for largest
li a7, 4    # Print string syscall
ecall

mv a0, t0    # Load largest value
li a7, 1    # Print integer syscall
ecall

li a0, ','    # Print comma separator
li a7, 11    # Print character syscall
ecall

mv a0, t1    # Load largest position
li a7, 1    # Print integer syscall
ecall

# Print the result for smallest value
la a0, message_smallest    # Load message address for smallest
li a7, 4    # Print string syscall
ecall

mv a0, t2    # Load smallest value
li a7, 1    # Print integer syscall
ecall

li a0, ','    # Print comma separator
li a7, 11    # Print character syscall
ecall

mv a0, t3    # Load smallest position
li a7, 1    # Print integer syscall
ecall

# Clean up stack and end program
addi sp, sp, 32    # Restore stack pointer
li a7, 10    # Exit syscall
ecall

find_min_max:
# Initialize largest and smallest with the first value (equivalent to a0 at sp+28)
lw t0, 28(sp)    # t0 = largest value
li t1, 0    # t1 = position of largest (0 for a0)
lw t2, 28(sp)    # t2 = smallest value
li t3, 0    # t3 = position of smallest (0 for a0)

# Set up loop to iterate through stack values
li t4, 1    # Position counter (for stack values from a1 to a7)
li t5, 24    # Offset to next stack value (a1 stored at sp+24)

loop_check:
# Access current value from stack using offset (sp + t5)
add t5, sp, t5    # Access current value from stack using offset (sp + t5)
lw t6, 0(t5)    # Load value at current offset

# Check if current value is the new largest
bgt t6, t0, update_largest

# Check if current value is the new smallest
blt t6, t2, update_smallest

# If neither, continue to the next stack value
addi t5, t5, -4    # Move offset to the next stack value
addi t4, t4, 1    # Increment position counter
blt t4, s0, loop_check    # Continue if position < 8 (a0 to a7)

jr ra    # Return to caller

update_largest:
mv t0, t6    # Update largest value
mv t1, t4    # Update position of largest
j loop_check    # Continue to next value

update_smallest:
mv t2, t6    # Update smallest value
mv t3, t4    # Update position of smallest
j loop_check    # Continue to next value