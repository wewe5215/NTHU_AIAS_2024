addi t0, zero, 0
lui x06, 0x00000008
addi x06, x06, 0x00000057
lw t1, 0(t1)
addi t1, t1, -1
add s10, t1, zero
addi a5, zero, -1
lui x18, 0x00000008
addi x18, x18, 0x0000005b
lw s2, 0(s2)
lui x08, 0x00000008
addi x08, x08, 0x0000002b
jal ra, binary_search
bltz a5, fail
hcf