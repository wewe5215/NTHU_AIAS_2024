lui x08, 0x00000008
addi x08, x08, 0x00000000
lui x09, 0x00000008
addi x09, x09, 0x00000050
lui x18, 0x00000008
addi x18, x18, 0x00000320
lui x19, 0x00000008
addi x19, x19, 0x000003b4
lw s3, 0(s3)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_00
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x100
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_00
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000000
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000100
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000400
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_00
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_01
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x104
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_01
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000000
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000104
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_01
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_02
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x108
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_02
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000000
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000108
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000408
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_02
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_03
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x10c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_03
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000000
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000010c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000040c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_03
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_04
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x10
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x110
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_04
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000000
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000110
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000410
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_04
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_05
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x14
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x114
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_05
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000000
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000114
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000414
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_05
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_06
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x18
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x118
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_06
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000000
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000118
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000418
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_06
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_07
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x1c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x11c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_07
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000000
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000011c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000041c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_07
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_08
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x20
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x120
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_08
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000000
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000120
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000420
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_08
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_10
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x90
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x190
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_10
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000004
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000190
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000400
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_10
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_11
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x94
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x194
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_11
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000004
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000194
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_11
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_12
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x98
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x198
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_12
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000004
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000198
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000408
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_12
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_13
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x9c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x19c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_13
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000004
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000019c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000040c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_13
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_14
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xa0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1a0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_14
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000004
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000001a0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000410
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_14
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_15
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xa4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1a4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_15
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000004
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000001a4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000414
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_15
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_16
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xa8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1a8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_16
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000004
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000001a8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000418
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_16
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_17
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xac
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1ac
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_17
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000004
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000001ac
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000041c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_17
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_18
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xb0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1b0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_18
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000004
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000001b0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000420
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_18
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_20
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x120
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x220
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_20
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000008
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000220
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000400
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_20
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_21
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x124
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x224
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_21
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000008
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000224
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_21
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_22
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x128
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x228
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_22
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000008
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000228
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000408
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_22
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_23
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x12c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x22c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_23
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000008
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000022c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000040c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_23
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_24
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x130
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x230
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_24
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000008
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000230
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000410
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_24
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_25
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x134
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x234
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_25
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000008
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000234
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000414
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_25
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_26
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x138
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x238
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_26
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000008
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000238
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000418
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_26
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_27
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x13c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x23c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_27
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000008
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000023c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000041c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_27
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_28
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x140
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x240
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_28
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000008
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000240
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000420
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_28
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_30
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x1b0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x2b0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_30
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000000c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000002b0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000400
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_30
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_31
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x1b4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x2b4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_31
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000000c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000002b4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_31
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_32
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x1b8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x2b8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_32
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000000c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000002b8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000408
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_32
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_33
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x1bc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x2bc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_33
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000000c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000002bc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000040c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_33
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_34
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x1c0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x2c0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_34
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000000c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000002c0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000410
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_34
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_35
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x1c4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x2c4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_35
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000000c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000002c4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000414
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_35
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_36
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x1c8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x2c8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_36
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000000c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000002c8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000418
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_36
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_37
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x1cc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x2cc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_37
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000000c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000002cc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000041c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_37
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_38
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x1d0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x2d0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_38
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000000c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000002d0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000420
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_38
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x10
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x10
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_40
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x240
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x340
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_40
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000010
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000340
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000400
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_40
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x10
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x10
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_41
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x244
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x344
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_41
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000010
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000344
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_41
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x10
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x10
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_42
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x248
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x348
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_42
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000010
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000348
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000408
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_42
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x10
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x10
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_43
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x24c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x34c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_43
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000010
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000034c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000040c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_43
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x10
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x10
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_44
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x250
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x350
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_44
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000010
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000350
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000410
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_44
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x10
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x10
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_45
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x254
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x354
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_45
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000010
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000354
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000414
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_45
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x10
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x10
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_46
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x258
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x358
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_46
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000010
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000358
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000418
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_46
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x10
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x10
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_47
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x25c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x35c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_47
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000010
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000035c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000041c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_47
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x10
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x10
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00014140
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_48
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003d8
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x260
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003dc
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x360
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00024240
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003e4
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_48
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003b0
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x000003c4
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000010
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c8
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000360
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003cc
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000420
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003d0
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000090
addi x07, x07, 0x00000905
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x000003c0
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_48
sw x0, 0(t1)
hcf