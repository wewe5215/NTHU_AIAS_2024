## Lab 14-2-3 Assembly code for verifying 
## cpu, bus, dma, accelerator work properly.

## exexcution flow :
## (1) CPU program DMA to move data from shared data memory to the local memory of accelerator.
## (2) After DMA completing the movement, CPU program accelerator to start computing.
## (3) Accelerator start to compute matrixA(4x4) * matrixB(4x4).
## (4) Once CPU observe the done bit in Status reg of accelerator is high, halt the itself.

.data
## allocate memory space for Martix A, B, C data in shared data memory. (start from 0x8000)
mat_A:
.byte 1 2 1 2 1 0 2 1 3 2 0 0 1 1 0 3
.byte 2 0 2 3 2 0 0 2 2 0 1 3 2 1 3 0
.byte 1 3 0 2 0 1 1 2 3 1 0 1 1 2 3 0
.byte 2 2 2 0 1 0 3 0 2 1 1 0 1 3 2 1
.byte 0 2 3 1 2 3 0 2 2 3 1 0 1 1 1 0
.byte 1 3 0 2 1 1 3 1 2 0 1 2 0 2 1 1
.byte 3 2 0 1 0 3 1 3 2 2 3 0 1 0 3 2
.byte 0 1 3 0 2 2 0 3 1 3 1 2 0 2 1 1
.byte 2 3 1 0 2 1 3 1 2 0 1 0 2 3 0 2
.byte 3 0 1 2 3 0 1 2 0 3 2 0 1 1 1 2
.byte 1 1 3 0 0 1 1 2 2 0 3 1 1 2 0 3
.byte 0 2 1 3 1 1 2 1 2 0 2 3 1 3 1 0
.byte 1 0 2 1 2 0 3 3 1 2 1 0 2 1 0 3
.byte 3 3 0 1 1 2 1 2 3 0 2 3 0 1 2 0
.byte 2 0 1 3 2 0 1 2 2 0 3 1 1 2 1 0
.byte 0 3 2 1 2 1 3 2 0 1 1 2 0 2 1 0

mat_B:
.byte 3 2 1 0 2 1 1 3 2 0 1 2 0 3 1 1
.byte 0 1 2 3 1 2 0 1 2 3 0 1 2 0 1 3
.byte 2 0 1 2 3 0 1 2 1 0 3 1 2 1 3 0
.byte 1 3 0 2 1 2 0 3 1 0 2 1 0 2 1 3
.byte 2 1 0 3 2 1 0 3 2 1 1 2 3 0 2 1
.byte 1 2 1 3 2 0 3 1 0 2 2 1 0 3 1 2
.byte 0 3 2 1 2 3 0 1 3 1 0 2 3 0 2 1
.byte 3 1 2 1 0 3 1 2 1 3 2 0 1 3 1 2
.byte 2 0 1 2 3 0 1 2 0 3 2 1 2 1 0 3
.byte 1 2 0 3 1 2 3 0 1 2 1 3 0 2 3 1
.byte 3 0 2 1 0 3 1 2 2 0 1 3 1 2 3 0
.byte 0 3 1 2 1 0 3 1 2 0 3 2 1 3 0 1
.byte 1 2 3 0 2 1 3 0 1 2 1 0 2 1 3 0
.byte 2 0 1 3 1 2 0 3 1 2 1 0 3 2 1 0
.byte 3 1 0 2 1 0 2 1 3 2 0 3 2 1 3 0
.byte 0 3 2 1 2 1 3 2 0 1 3 2 1 0 2 1
mat_C:
.byte 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
.byte 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
.byte 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
.byte 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
.byte 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
.byte 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
.byte 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
.byte 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
.byte 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
.byte 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
.byte 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
.byte 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
.byte 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
.byte 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
.byte 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
.byte 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

## allocate memory space for constant value in shared data memory for computation.
ACCEL_REG_BASE_ADDR:
.word 0x100000

ACCEL_MEM_BASE_ADDR:
.word 0x200000

DMA_REG_BASE_ADDR:
.word 0x300000

ACCEL_OFFSET_ENABLE:
.word 0x0

ACCEL_OFFSET_STATUS:
.word 0x4

ACCEL_OFFSET_MATA_MEM_ADDR:
.word 0x14

ACCEL_OFFSET_MATB_MEM_ADDR:
.word 0x18

ACCEL_OFFSET_MATC_MEM_ADDR:
.word 0x1c

ACCEL_OFFSET_MAT_MEM_STRIDE:
.word 0x20

DMA_OFFSET_ENABLE:
.word 0x100

DMA_OFFSET_SOURCE_INFO:
.word 0x104

DMA_OFFSET_DEST_INFO:
.word 0x108

DMA_OFFSET_SIZE_CFG:
.word 0x10c

DMA_OFFSET_DONE:
.word 0x114


.text
######################
##                  ##
##      Step 0      ##
##                  ##
######################

## s0 -> base address of Matrix A in shared data memory.
la s0, mat_A
## s1 -> base address of Matrix B in shared data memory.
la s1, mat_B
## s2 -> base address of Matrix C in shared data memory.
la s2, mat_C

## s3 -> address of ACCEL_MEM_BASE_ADDR
la s3, ACCEL_MEM_BASE_ADDR
lw s3, 0(s3)

## i = 0, j = 0, k = 0
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x0
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x0
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_000:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_000
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x0
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x100
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_000:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_000
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x0
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x100
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x200
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_000:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_000
sw x0, 0(t1)
## i = 0, j = 0, k = 1
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x4
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x4
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_001:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_001
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x40
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x140
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_001:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_001
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x4
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x140
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x200
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_001:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_001
sw x0, 0(t1)
## i = 0, j = 0, k = 2
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x8
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x8
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_002:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_002
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x80
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x180
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_002:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_002
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x8
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x180
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x200
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_002:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_002
sw x0, 0(t1)
## i = 0, j = 0, k = 3
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_003:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_003
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc0
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1c0
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_003:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_003
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0xc
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x1c0
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x200
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_003:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_003
sw x0, 0(t1)
## i = 0, j = 1, k = 0
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x0
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x0
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_010:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_010
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x4
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x104
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_010:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_010
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x0
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x104
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x204
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_010:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_010
sw x0, 0(t1)
## i = 0, j = 1, k = 1
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x4
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x4
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_011:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_011
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x44
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x144
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_011:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_011
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x4
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x144
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x204
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_011:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_011
sw x0, 0(t1)
## i = 0, j = 1, k = 2
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x8
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x8
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_012:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_012
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x84
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x184
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_012:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_012
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x8
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x184
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x204
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_012:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_012
sw x0, 0(t1)
## i = 0, j = 1, k = 3
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_013:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_013
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc4
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1c4
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_013:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_013
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0xc
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x1c4
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x204
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_013:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_013
sw x0, 0(t1)
## i = 0, j = 2, k = 0
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x0
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x0
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_020:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_020
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x8
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x108
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_020:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_020
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x0
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x108
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x208
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_020:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_020
sw x0, 0(t1)
## i = 0, j = 2, k = 1
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x4
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x4
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_021:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_021
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x48
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x148
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_021:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_021
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x4
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x148
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x208
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_021:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_021
sw x0, 0(t1)
## i = 0, j = 2, k = 2
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x8
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x8
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_022:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_022
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x88
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x188
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_022:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_022
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x8
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x188
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x208
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_022:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_022
sw x0, 0(t1)
## i = 0, j = 2, k = 3
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_023:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_023
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc8
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1c8
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_023:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_023
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0xc
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x1c8
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x208
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_023:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_023
sw x0, 0(t1)
## i = 0, j = 3, k = 0
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x0
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x0
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_030:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_030
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x10c
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_030:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_030
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x0
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x20c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_030:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_030
sw x0, 0(t1)
## i = 0, j = 3, k = 1
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x4
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x4
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_031:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_031
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x4c
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x14c
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_031:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_031
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x4
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x14c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x20c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_031:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_031
sw x0, 0(t1)
## i = 0, j = 3, k = 2
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x8
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x8
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_032:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_032
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x8c
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x18c
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_032:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_032
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x8
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x18c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x20c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_032:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_032
sw x0, 0(t1)
## i = 0, j = 3, k = 3
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_033:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_033
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xcc
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1cc
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_033:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_033
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0xc
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x1cc
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x20c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_033:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_033
sw x0, 0(t1)
## i = 1, j = 0, k = 0
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x40
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x40
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_100:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_100
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x0
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x100
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_100:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_100
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x40
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x100
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x240
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_100:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_100
sw x0, 0(t1)
## i = 1, j = 0, k = 1
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x44
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x44
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_101:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_101
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x40
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x140
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_101:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_101
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x44
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x140
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x240
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_101:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_101
sw x0, 0(t1)
## i = 1, j = 0, k = 2
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x48
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x48
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_102:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_102
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x80
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x180
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_102:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_102
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x48
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x180
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x240
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_102:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_102
sw x0, 0(t1)
## i = 1, j = 0, k = 3
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x4c
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x4c
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_103:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_103
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc0
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1c0
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_103:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_103
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x4c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x1c0
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x240
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_103:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_103
sw x0, 0(t1)
## i = 1, j = 1, k = 0
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x40
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x40
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_110:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_110
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x4
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x104
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_110:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_110
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x40
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x104
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x244
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_110:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_110
sw x0, 0(t1)
## i = 1, j = 1, k = 1
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x44
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x44
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_111:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_111
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x44
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x144
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_111:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_111
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x44
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x144
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x244
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_111:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_111
sw x0, 0(t1)
## i = 1, j = 1, k = 2
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x48
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x48
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_112:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_112
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x84
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x184
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_112:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_112
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x48
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x184
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x244
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_112:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_112
sw x0, 0(t1)
## i = 1, j = 1, k = 3
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x4c
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x4c
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_113:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_113
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc4
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1c4
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_113:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_113
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x4c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x1c4
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x244
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_113:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_113
sw x0, 0(t1)
## i = 1, j = 2, k = 0
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x40
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x40
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_120:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_120
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x8
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x108
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_120:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_120
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x40
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x108
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x248
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_120:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_120
sw x0, 0(t1)
## i = 1, j = 2, k = 1
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x44
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x44
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_121:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_121
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x48
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x148
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_121:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_121
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x44
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x148
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x248
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_121:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_121
sw x0, 0(t1)
## i = 1, j = 2, k = 2
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x48
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x48
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_122:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_122
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x88
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x188
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_122:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_122
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x48
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x188
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x248
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_122:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_122
sw x0, 0(t1)
## i = 1, j = 2, k = 3
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x4c
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x4c
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_123:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_123
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc8
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1c8
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_123:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_123
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x4c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x1c8
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x248
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_123:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_123
sw x0, 0(t1)
## i = 1, j = 3, k = 0
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x40
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x40
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_130:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_130
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x10c
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_130:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_130
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x40
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x24c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_130:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_130
sw x0, 0(t1)
## i = 1, j = 3, k = 1
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x44
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x44
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_131:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_131
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x4c
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x14c
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_131:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_131
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x44
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x14c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x24c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_131:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_131
sw x0, 0(t1)
## i = 1, j = 3, k = 2
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x48
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x48
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_132:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_132
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x8c
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x18c
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_132:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_132
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x48
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x18c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x24c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_132:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_132
sw x0, 0(t1)
## i = 1, j = 3, k = 3
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x4c
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x4c
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_133:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_133
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xcc
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1cc
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_133:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_133
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x4c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x1cc
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x24c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_133:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_133
sw x0, 0(t1)
## i = 2, j = 0, k = 0
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x80
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x80
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_200:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_200
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x0
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x100
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_200:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_200
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x80
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x100
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x280
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_200:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_200
sw x0, 0(t1)
## i = 2, j = 0, k = 1
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x84
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x84
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_201:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_201
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x40
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x140
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_201:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_201
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x84
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x140
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x280
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_201:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_201
sw x0, 0(t1)
## i = 2, j = 0, k = 2
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x88
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x88
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_202:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_202
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x80
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x180
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_202:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_202
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x88
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x180
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x280
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_202:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_202
sw x0, 0(t1)
## i = 2, j = 0, k = 3
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x8c
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x8c
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_203:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_203
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc0
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1c0
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_203:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_203
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x8c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x1c0
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x280
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_203:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_203
sw x0, 0(t1)
## i = 2, j = 1, k = 0
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x80
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x80
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_210:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_210
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x4
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x104
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_210:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_210
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x80
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x104
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x284
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_210:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_210
sw x0, 0(t1)
## i = 2, j = 1, k = 1
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x84
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x84
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_211:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_211
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x44
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x144
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_211:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_211
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x84
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x144
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x284
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_211:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_211
sw x0, 0(t1)
## i = 2, j = 1, k = 2
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x88
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x88
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_212:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_212
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x84
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x184
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_212:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_212
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x88
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x184
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x284
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_212:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_212
sw x0, 0(t1)
## i = 2, j = 1, k = 3
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x8c
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x8c
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_213:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_213
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc4
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1c4
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_213:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_213
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x8c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x1c4
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x284
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_213:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_213
sw x0, 0(t1)
## i = 2, j = 2, k = 0
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x80
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x80
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_220:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_220
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x8
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x108
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_220:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_220
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x80
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x108
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x288
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_220:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_220
sw x0, 0(t1)
## i = 2, j = 2, k = 1
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x84
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x84
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_221:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_221
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x48
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x148
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_221:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_221
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x84
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x148
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x288
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_221:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_221
sw x0, 0(t1)
## i = 2, j = 2, k = 2
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x88
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x88
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_222:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_222
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x88
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x188
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_222:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_222
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x88
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x188
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x288
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_222:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_222
sw x0, 0(t1)
## i = 2, j = 2, k = 3
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x8c
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x8c
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_223:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_223
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc8
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1c8
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_223:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_223
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x8c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x1c8
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x288
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_223:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_223
sw x0, 0(t1)
## i = 2, j = 3, k = 0
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x80
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x80
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_230:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_230
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x10c
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_230:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_230
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x80
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x28c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_230:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_230
sw x0, 0(t1)
## i = 2, j = 3, k = 1
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x84
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x84
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_231:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_231
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x4c
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x14c
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_231:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_231
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x84
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x14c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x28c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_231:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_231
sw x0, 0(t1)
## i = 2, j = 3, k = 2
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x88
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x88
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_232:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_232
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x8c
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x18c
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_232:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_232
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x88
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x18c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x28c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_232:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_232
sw x0, 0(t1)
## i = 2, j = 3, k = 3
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0x8c
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x8c
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_233:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_233
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xcc
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1cc
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_233:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_233
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x8c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x1cc
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x28c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_233:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_233
sw x0, 0(t1)
## i = 3, j = 0, k = 0
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc0
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc0
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_300:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_300
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x0
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x100
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_300:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_300
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0xc0
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x100
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x2c0
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_300:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_300
sw x0, 0(t1)
## i = 3, j = 0, k = 1
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc4
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc4
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_301:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_301
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x40
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x140
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_301:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_301
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0xc4
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x140
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x2c0
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_301:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_301
sw x0, 0(t1)
## i = 3, j = 0, k = 2
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc8
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc8
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_302:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_302
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x80
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x180
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_302:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_302
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0xc8
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x180
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x2c0
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_302:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_302
sw x0, 0(t1)
## i = 3, j = 0, k = 3
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xcc
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xcc
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_303:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_303
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc0
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1c0
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_303:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_303
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0xcc
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x1c0
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x2c0
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_303:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_303
sw x0, 0(t1)
## i = 3, j = 1, k = 0
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc0
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc0
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_310:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_310
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x4
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x104
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_310:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_310
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0xc0
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x104
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x2c4
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_310:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_310
sw x0, 0(t1)
## i = 3, j = 1, k = 1
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc4
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc4
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_311:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_311
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x44
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x144
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_311:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_311
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0xc4
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x144
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x2c4
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_311:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_311
sw x0, 0(t1)
## i = 3, j = 1, k = 2
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc8
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc8
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_312:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_312
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x84
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x184
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_312:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_312
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0xc8
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x184
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x2c4
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_312:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_312
sw x0, 0(t1)
## i = 3, j = 1, k = 3
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xcc
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xcc
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_313:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_313
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc4
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1c4
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_313:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_313
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0xcc
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x1c4
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x2c4
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_313:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_313
sw x0, 0(t1)
## i = 3, j = 2, k = 0
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc0
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc0
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_320:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_320
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x8
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x108
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_320:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_320
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0xc0
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x108
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x2c8
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_320:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_320
sw x0, 0(t1)
## i = 3, j = 2, k = 1
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc4
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc4
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_321:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_321
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x48
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x148
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_321:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_321
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0xc4
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x148
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x2c8
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_321:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_321
sw x0, 0(t1)
## i = 3, j = 2, k = 2
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc8
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc8
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_322:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_322
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x88
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x188
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_322:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_322
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0xc8
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x188
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x2c8
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_322:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_322
sw x0, 0(t1)
## i = 3, j = 2, k = 3
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xcc
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xcc
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_323:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_323
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc8
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1c8
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_323:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_323
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0xcc
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x1c8
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x2c8
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_323:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_323
sw x0, 0(t1)
## i = 3, j = 3, k = 0
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc0
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc0
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_330:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_330
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xc
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x10c
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_330:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_330
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0xc0
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x2cc
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_330:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_330
sw x0, 0(t1)
## i = 3, j = 3, k = 1
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc4
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc4
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_331:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_331
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x4c
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x14c
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_331:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_331
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0xc4
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x14c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x2cc
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_331:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_331
sw x0, 0(t1)
## i = 3, j = 3, k = 2
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xc8
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xc8
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_332:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_332
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0x8c
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x18c
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_332:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_332
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0xc8
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x18c
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x2cc
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_332:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_332
sw x0, 0(t1)
## i = 3, j = 3, k = 3
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s0, 0xcc
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0xcc
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma1_333:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma1_333
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, DMA_OFFSET_SOURCE_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s1, 0xcc
sw t2, 0(t1)
la t6, DMA_OFFSET_DEST_INFO
lw t1, 0(t6)
add t1, t1, t0
addi t2, s3, 0x1cc
sw t2, 0(t1)
la t6, DMA_OFFSET_SIZE_CFG
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x10100404
sw t2, 0(t1)
la t6, DMA_OFFSET_ENABLE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x01
sw t2, 0(t1)
wait_dma2_333:
la t6, DMA_OFFSET_DONE
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_dma2_333
sw x0, 0(t1)
la t6, ACCEL_REG_BASE_ADDR
lw t0, 0(t6)
la t6, ACCEL_OFFSET_MATA_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0xcc
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATB_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x1cc
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MATC_MEM_ADDR
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x2cc
sw t2, 0(t1)
la t6, ACCEL_OFFSET_MAT_MEM_STRIDE
lw t1, 0(t6)
add t1, t1, t0
li t2, 0x00040404
sw t2, 0(t1)
li t1, 0x0
add t1, t1, t0
li t2, 0x00000001
sw t2, 0(t1)
wait_sa_333:
la t6, ACCEL_OFFSET_STATUS
lw t1, 0(t6)
add t1, t1, t0
lw t2, 0(t1)
beq t2, x0, wait_sa_333
sw x0, 0(t1)


hcf