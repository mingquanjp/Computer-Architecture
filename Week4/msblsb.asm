.text
li s0, 0x12345678  # s0 = 0x12345678
# Extract MSB of register s0
srli t0, s0, 24
# Clear LSB of register s0
andi t1, s0, 0xffffff00
# Set LSB of register s0 (bit 7 to bit 0 are set to 1)
ori t2, s0, 0xff
# Clear register s0 using logical instructions (s0 = 0)
xor t3, s0, s0
