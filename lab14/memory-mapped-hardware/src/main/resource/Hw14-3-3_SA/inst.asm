lui x08, 0x00000008
addi x08, x08, 0x00000000
lui x09, 0x00000008
addi x09, x09, 0x00000100
lui x18, 0x00000008
addi x18, x18, 0x00000200
lui x19, 0x00000008
addi x19, x19, 0x00000304
lw s3, 0(s3)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_000
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x100
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_000
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000000
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000100
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000200
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_000
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_001
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x40
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x140
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_001
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000004
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000140
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000200
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_001
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_002
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x80
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x180
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_002
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000008
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000180
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000200
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_002
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_003
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1c0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_003
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000000c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000001c0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000200
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_003
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_010
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x104
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_010
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000000
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000104
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000204
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_010
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_011
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x44
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x144
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_011
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000004
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000144
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000204
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_011
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_012
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x84
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x184
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_012
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000008
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000184
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000204
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_012
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_013
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1c4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_013
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000000c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000001c4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000204
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_013
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_020
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x108
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_020
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000000
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000108
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000208
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_020
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_021
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x48
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x148
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_021
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000004
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000148
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000208
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_021
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_022
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x88
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x188
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_022
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000008
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000188
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000208
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_022
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_023
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1c8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_023
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000000c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000001c8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000208
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_023
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_030
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x10c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_030
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000000
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000010c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000020c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_030
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_031
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x4c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x14c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_031
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000004
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000014c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000020c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_031
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_032
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x8c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x18c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_032
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000008
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000018c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000020c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_032
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_033
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xcc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1cc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_033
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000000c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000001cc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000020c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_033
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x40
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x40
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_100
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x100
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_100
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000040
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000100
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000240
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_100
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x44
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x44
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_101
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x40
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x140
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_101
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000044
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000140
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000240
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_101
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x48
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x48
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_102
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x80
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x180
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_102
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000048
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000180
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000240
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_102
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x4c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x4c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_103
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1c0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_103
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000004c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000001c0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000240
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_103
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x40
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x40
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_110
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x104
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_110
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000040
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000104
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000244
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_110
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x44
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x44
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_111
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x44
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x144
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_111
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000044
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000144
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000244
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_111
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x48
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x48
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_112
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x84
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x184
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_112
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000048
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000184
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000244
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_112
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x4c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x4c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_113
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1c4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_113
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000004c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000001c4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000244
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_113
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x40
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x40
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_120
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x108
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_120
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000040
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000108
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000248
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_120
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x44
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x44
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_121
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x48
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x148
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_121
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000044
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000148
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000248
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_121
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x48
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x48
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_122
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x88
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x188
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_122
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000048
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000188
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000248
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_122
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x4c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x4c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_123
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1c8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_123
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000004c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000001c8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000248
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_123
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x40
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x40
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_130
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x10c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_130
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000040
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000010c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000024c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_130
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x44
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x44
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_131
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x4c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x14c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_131
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000044
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000014c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000024c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_131
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x48
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x48
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_132
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x8c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x18c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_132
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000048
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000018c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000024c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_132
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x4c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x4c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_133
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xcc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1cc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_133
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000004c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000001cc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000024c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_133
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x80
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x80
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_200
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x100
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_200
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000080
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000100
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000280
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_200
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x84
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x84
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_201
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x40
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x140
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_201
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000084
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000140
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000280
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_201
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x88
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x88
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_202
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x80
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x180
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_202
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000088
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000180
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000280
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_202
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x8c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x8c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_203
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1c0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_203
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000008c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000001c0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000280
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_203
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x80
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x80
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_210
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x104
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_210
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000080
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000104
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000284
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_210
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x84
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x84
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_211
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x44
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x144
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_211
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000084
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000144
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000284
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_211
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x88
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x88
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_212
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x84
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x184
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_212
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000088
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000184
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000284
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_212
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x8c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x8c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_213
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1c4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_213
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000008c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000001c4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000284
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_213
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x80
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x80
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_220
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x108
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_220
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000080
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000108
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000288
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_220
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x84
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x84
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_221
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x48
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x148
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_221
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000084
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000148
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000288
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_221
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x88
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x88
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_222
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x88
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x188
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_222
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000088
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000188
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000288
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_222
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x8c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x8c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_223
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1c8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_223
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000008c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000001c8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000288
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_223
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x80
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x80
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_230
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x10c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_230
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000080
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000010c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000028c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_230
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x84
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x84
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_231
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x4c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x14c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_231
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000084
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000014c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000028c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_231
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x88
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x88
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_232
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x8c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x18c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_232
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000088
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000018c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000028c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_232
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x8c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x8c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_233
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xcc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1cc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_233
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000008c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000001cc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000028c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_233
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_300
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x100
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_300
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000000c0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000100
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000002c0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_300
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_301
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x40
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x140
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_301
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000000c4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000140
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000002c0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_301
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_302
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x80
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x180
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_302
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000000c8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000180
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000002c0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_302
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xcc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xcc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_303
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1c0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_303
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000000cc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000001c0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000002c0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_303
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_310
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x104
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_310
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000000c0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000104
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000002c4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_310
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_311
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x44
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x144
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_311
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000000c4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000144
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000002c4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_311
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_312
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x84
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x184
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_312
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000000c8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000184
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000002c4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_312
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xcc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xcc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_313
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1c4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_313
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000000cc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000001c4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000002c4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_313
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_320
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x108
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_320
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000000c0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000108
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000002c8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_320
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_321
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x48
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x148
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_321
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000000c4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000148
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000002c8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_321
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_322
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x88
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x188
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_322
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000000c8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000188
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000002c8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_322
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xcc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xcc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_323
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1c8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_323
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000000cc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000001c8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000002c8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_323
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_330
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x10c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_330
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000000c0
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000010c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000002cc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_330
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_331
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x4c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x14c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_331
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000000c4
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000014c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000002cc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_331
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_332
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x8c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x18c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_332
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000000c8
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x0000018c
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000002cc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_332
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xcc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xcc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_333
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000328
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xcc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000032c
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1cc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000330
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00010100
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000324
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000334
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_333
sw x0, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000300
lw t0, 0(t6)
lui x31, 0x00000008
addi x31, x31, 0x00000314
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000000cc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000318
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000001cc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x0000031c
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x000002cc
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000320
lw t1, 0(t6)
add t1, t1, t0
lui x07, 0x00000040
addi x07, x07, 0x00000404
sw t2, 0(t1)
lui x06, 0x00000000
addi x06, x06, 0x00000000
add t1, t1, t0
lui x07, 0x00000000
addi x07, x07, 0x00000001
sw t2, 0(t1)
lui x31, 0x00000008
addi x31, x31, 0x00000310
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_333
sw x0, 0(t1)
hcf