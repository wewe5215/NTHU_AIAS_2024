   .text
   .global test_asm
   .type test_asm, @function
test_asm:
prologue:
   addi sp, sp, -12
   sw ra, 0(sp)
   sw a0, 4(sp)
   addi t3, x0, 0
test:
   addi t1, x0, 0
   addi t2, x0, 64
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 0
   addi t2, x0, -1
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 0
   addi t2, x0, 0
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 0
   addi t2, x0, -1
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 32
   addi t2, x0, -1
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -65
   addi t2, x0, -1
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 1364
   addi t2, x0, -1
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -2
   addi t2, x0, -1
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -33
   addi t2, x0, -1
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 818
   addi t2, x0, -1
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 64
   addi t2, x0, -1
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 1283
   addi t2, x0, -1
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 0
   addi t2, x0, -1
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 819
   addi t2, x0, -1
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 17
   addi t2, x0, -1
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -2
   addi t2, x0, -1
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 0
   addi t2, x0, -1
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 19
   addi t2, x0, -1
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 5
   addi t2, x0, 2047
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1025
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -513
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 128
   addi t2, x0, -257
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 2047
   addi t2, x0, -129
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -513
   addi t2, x0, -65
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -257
   addi t2, x0, -33
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 19
   addi t2, x0, -17
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 0
   addi t2, x0, -9
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 1285
   addi t2, x0, -5
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -33
   addi t2, x0, -3
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 32
   addi t2, x0, -2
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, 0
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -2
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -5
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, 0
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, 8
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, 0
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, 0
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, 0
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -513
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1025
   addi t2, x0, 1639
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -129
   addi t2, x0, -1
   mulhu t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
epilogue:
   lw ra, 0(sp)
   lw a0, 4(sp)
   addi sp, sp, 12
   jr ra
   .size test_asm, .-test_asm
