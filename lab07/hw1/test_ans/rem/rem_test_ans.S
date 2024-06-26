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
   addi t1, x0, 1283
   addi t2, x0, -1
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -2048
   addi t2, x0, -1
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -257
   addi t2, x0, -1
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 818
   addi t2, x0, -1
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 0
   addi t2, x0, 0
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 1024
   addi t2, x0, -1
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -17
   addi t2, x0, -1
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 2
   addi t2, x0, -1
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 0
   addi t2, x0, -1
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 0
   addi t2, x0, -1
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 820
   addi t2, x0, -1
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 4
   addi t2, x0, -1
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1365
   addi t2, x0, -1
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 1365
   addi t2, x0, -1
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 0
   addi t2, x0, -1
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1284
   addi t2, x0, -1
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 0
   addi t2, x0, 2047
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1025
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 819
   addi t2, x0, -513
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -257
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -129
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 0
   addi t2, x0, -65
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -33
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 8
   addi t2, x0, -17
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 8
   addi t2, x0, -9
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -129
   addi t2, x0, -5
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1365
   addi t2, x0, -3
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 0
   addi t2, x0, -2
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, 2
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, 2047
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, 819
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, 820
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, 0
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, 1365
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, 0
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -1284
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, 0
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, 7
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, -4
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1
   addi t2, x0, 0
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, 2047
   addi t2, x0, 0
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -1025
   addi t2, x0, 820
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -513
   addi t2, x0, 0
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -65
   addi t2, x0, 1284
   rem t0, t1, t2
   slli t4, t3, 2
   add t5, a0, t4
   sw t0, 0(t5)
   addi t3, t3, 1
   addi t1, x0, -33
   addi t2, x0, -1365
   rem t0, t1, t2
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
