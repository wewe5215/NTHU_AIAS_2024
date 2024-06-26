lui x02, 0x00000010
addi x02, x02, 0x00000000
lui x12, 0x00000000
addi x12, x12, 0x00000008
lui x13, 0x00000000
addi x13, x13, 0x00000003
lui x14, 0x00000000
addi x14, x14, 0x00000006
lui x15, 0x00000008
addi x15, x15, 0x00000000
lui x16, 0x00000008
addi x16, x16, 0x00000080
lui x17, 0x00000008
addi x17, x17, 0x00000092
addi sp, sp, -4
sw ra, 0(sp)
lui x05, 0x00000000
addi x05, x05, 0x00000000
lui x06, 0x00000000
addi x06, x06, 0x00000004
add t1, t1, t0
lui x08, 0x00000001
addi x08, x08, 0x00000000
sw s0, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000008
add t1, t1, t0
lui x19, 0x00000008
addi x19, x19, 0x00000000
sw s3, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x0000000c
add t1, t1, t0
lui x07, 0x00004040
addi x07, x07, 0x00000425
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000014
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1
sw x0, 0(t1)
jal ra, conv2d
addi a5, a5, 64
addi a6, a6, 9
jal ra, conv2d
lui x05, 0x00000000
addi x05, x05, 0x00000000
lui x06, 0x00000000
addi x06, x06, 0x00000004
add t1, t1, t0
lui x08, 0x00000001
addi x08, x08, 0x00000090
sw s0, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000008
add t1, t1, t0
lui x19, 0x00000008
addi x19, x19, 0x00000090
sw s3, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x0000000c
add t1, t1, t0
lui x07, 0x00004040
addi x07, x07, 0x00000425
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000014
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2
sw x0, 0(t1)
lw ra, 0(sp)
addi sp, sp, 4
lw s6, 0(a7)
lw s7, 6(a7)
lw s8, 12(a7)
lw s9, 18(a7)
lw s10, 24(a7)
lw s11, 30(a7)
hcf
srli s0, a3, 1
lui x05, 0x00000000
addi x05, x05, 0x00000000
bge t0, a4, endloop1
lui x06, 0x00000000
addi x06, x06, 0x00000000
bge t1, a4, endloop2
lui x07, 0x00000000
addi x07, x07, 0x00000000
bge t2, a3, endloop3
lui x28, 0x00000000
addi x28, x28, 0x00000000
bge t3, a3, endloop4
sub s1, t2, s0
add s1, s1, t0
addi s1, s1, 1
sub s2, t3, s0
add s2, s2, t1
addi s2, s2, 1
mul s3, s1, a2
add s3, s3, s2
add s3, s3, a5
lb s3, 0(s3)
mul s4, t2, a3
add s4, s4, t3
add s4, s4, a6
lb s4, 0(s4)
mul s3, s3, s4
mul s4, t0, a4
add s4, s4, t1
add s4, s4, a7
lb s5, 0(s4)
add s5, s5, s3
sb s5, 0(s4)
addi t3, t3, 1
blt t3, a3, loop4
addi t2, t2, 1
blt t2, a3, loop3
addi t1, t1, 1
blt t1, a4, loop2
addi t0, t0, 1
blt t0, a4, loop1
jalr x0, x1, x0
hcf
nop
nop
nop
nop
nop
