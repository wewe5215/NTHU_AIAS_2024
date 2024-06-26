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
   addi t1, x0, 6
   addi t2, x0, -1365
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 1365
   addi t2, x0, -1
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 0
   addi t2, x0, 0
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 8
   addi t2, x0, 8
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -257
   addi t2, x0, -1
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 4
   addi t2, x0, 0
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 9
   addi t2, x0, -1
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 0
   addi t2, x0, -1
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 9
   addi t2, x0, -1
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 0
   addi t2, x0, -1
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 819
   addi t2, x0, -1
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 0
   addi t2, x0, -1
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 1638
   addi t2, x0, -1
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 128
   addi t2, x0, -1
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1366
   addi t2, x0, -1
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 16
   addi t2, x0, -1
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 7
   addi t2, x0, 2047
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 0
   addi t2, x0, -1025
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 1639
   addi t2, x0, -513
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -4
   addi t2, x0, -257
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 0
   addi t2, x0, -129
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -65
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 0
   addi t2, x0, -33
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1365
   addi t2, x0, -17
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -9
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 6
   addi t2, x0, -5
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -17
   addi t2, x0, -3
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 0
   addi t2, x0, -2
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, 0
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, 5
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, 1366
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, 0
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, 820
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, 0
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, 0
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 2047
   addi t2, x0, 1364
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1025
   addi t2, x0, 820
   mul t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -513
   addi t2, x0, 2
   mul t0, t1, t2
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
