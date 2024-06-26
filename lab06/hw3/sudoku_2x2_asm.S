# sudoku_2x2_asm.S
   
    .text                           # code section 
    .global sudoku_2x2_asm          # declare the asm function as a global function
    .type sudoku_2x2_asm, @function # define sum_asm as a function 
sudoku_2x2_asm:
prologue:
    addi sp, sp, -12
    sw ra, 0(sp)
    sw a0, 4(sp)
    sw a1, 8(sp)
    li a1, 0
    jal    solver           # call solver to solve the sudoku
    j      exit
solver:
    addi	sp, sp, -48
    sw	ra, 44(sp)
    sw	a0, 40(sp)
    sw  a1, 36(sp)
    li  t0, 16
    bge a1, t0, done_true    # index >= 16, return true
    add t0, a0, a1          # set + index
    lb  t0, 0(t0)           # t0 = *(set + index)
    li  t1, 0
    bgt t0, t1, jump_to_solver_rec  # if *(set + index) > 0
    li  t1, 1               # t1 = i
    j for_body              # else

jump_to_solver_rec:
    lw	a0, 40(sp)
    lw  a1, 36(sp)
    addi a1, a1, 1          # index+1
    jal solver
    li  t0, 0
    beq a0, t0, done_false
    j done_true

for_body:
    sw  t1, 32(sp)          # push i to stack
    lw	a0, 40(sp)
    lw  a1, 36(sp)
    add t0, a0, a1          # t0 = set + index
    andi t1, t1, 0xff       # Zero Extension for bytes
    sb  t1, 0(t0)           # *(set + index) = i
    lw	a0, 40(sp)
    lw  a1, 36(sp)
    jal check
    beqz a0, continue_for_body
    sw  a0, 28(sp)          # push result of check to stack
    lw	a0, 40(sp)
    lw  a1, 36(sp)
    addi a1, a1, 1          # index+1
    jal solver
    lw  t3, 28(sp)          # load result of check from stack
    and t3, t3, a0          # check(set, index) && solver(set, index + 1)
    li  t4, 1
    beq t3, t4, done_true   # return true
continue_for_body:
    lw	a0, 40(sp)
    lw  a1, 36(sp)
    add t0, a0, a1          # t0 = set + index
    sb  zero, 0(t0)         # *(set + index) = 0
    lw  t1, 32(sp)          # load i from stack
    addi t1, t1, 1
    li	t2, 4
    bgt t1, t2, done_false  # i > 4
    j for_body


done_false:
    li a0, 0
    lw ra, 44(sp)
    addi sp, sp, 48
    jr ra

done_true:
    li a0, 1
    lw ra, 44(sp)
    addi sp, sp, 48
    jr ra

check:
    addi sp, sp, -40
    sw ra, 0(sp)
    sw a0, 4(sp)
    sw a1, 8(sp)
    srai t1, a1, 0x2    # idx_i = index / 4
    sw   t1, 12(sp)     # push idx_i to stack
    andi t1, a1, 0x3    # idx_j = index % 4
    sw   t1, 16(sp)     # push idx_j to stack
    lw   t0, 12(sp)     # t0 = idx_i
    lw   t1, 16(sp)     # t1 = idx_j
    slli t0, t0, 0x2    # t0 = idx_i * 4
    add  t0, t0, t1     # t0 = idx_i * 4 + idx_j
    sw   t0, 20(sp)     # push idx_i * 4 + idx_j to stack
    li   t0, 0          # i = 0
    sw   t0, 32(sp)
check_same_col:
    lw   t0, 32(sp)
    lw   t2, 12(sp)     # t2 = idx_i
    beq  t0, t2, continue_same_col
    lw   t3, 16(sp)     # t3 = idx_j
    lw   t0, 32(sp)
    slli t4, t0, 0x2    # i * 4
    add  t3, t4, t3     # i * 4 + idx_j
    lw   a0, 4(sp)
    add  t3, a0, t3     # set + (i * 4 + idx_j)
    lb   t3, 0(t3)      # t3 = set[(i * 4 + idx_j)]
    lw   t4, 20(sp)     # t4 = current_cur = idx_i * 4 + idx_j
    lw   a0, 4(sp)
    add  t4, a0, t4     # set + current_cur
    lb   t4, 0(t4)      # t4 = set[current_cur]
    beq  t3, t4, done_check_false
continue_same_col:
    lw   t0, 32(sp)
    addi t0, t0, 1      # i ++
    sw   t0, 32(sp)
    li   t1, 4
    bgt  t1, t0, check_same_col
    li   t0, 0          # i = 0
check_same_row:
    lw   t2, 12(sp)     # t2 = idx_i
    lw   t3, 16(sp)     # t3 = idx_j
    beq  t0, t3, continue_same_row
    slli t4, t2, 0x2    # idx_i * 4
    add  t3, t4, t0     # idx_i * 4 + j
    lw   a0, 4(sp)
    add  t3, a0, t3     # set + (idx_i * 4 + j)
    lb  t3, 0(t3)       # t3 = set[(idx_i * 4 + j)]
    lw   t4, 20(sp)     # t4 = current_cur = idx_i * 4 + idx_j
    lw   a0, 4(sp)
    add  t4, a0, t4     # set + current_cur
    lb  t4, 0(t4)       # t4 = set[current_cur]
    beq  t3, t4, done_check_false
continue_same_row:
    addi t0, t0, 1      # j ++
    li   t1, 4
    bgt  t1, t0, check_same_row
check_blocks:
    lw   t0, 12(sp)     # t0 = idx_i
    andi t0, t0, 1
    sw   t0, 28(sp)     # t0 = mod_i = idx_i % 2
    lw   t0, 16(sp)     # t0 = idx_j
    andi t0, t0, 1
    sw   t0, 32(sp)     # t0 = mod_j = idx_j % 2
    lw   t0, 28(sp)     # load mod_i
    bnez t0, check_down
check_up:
    lw   t0, 32(sp)     #load mod_j
    bnez t0, check_right_up
check_left_up:
    lw   t1, 20(sp)     # t1 = current_cur = idx_i * 4 + idx_j
    add  t0, a0, t1     # set + current_cur
    lb   t0, 0(t0)      # t0 = set[current_cur]
    lw   t1, 20(sp)     # load current_cur
    addi t1, t1, 1      # current_cur + 1
    add  t1, a0, t1     # set + current_cur + 1
    lb   t1, 0(t1)
    beq  t0, t1, done_check_false
    lw   t1, 20(sp)     # t1 = current_cur = idx_i * 4 + idx_j
    add  t0, a0, t1     # set + current_cur
    lb   t0, 0(t0)      # t0 = set[current_cur]
    lw   t1, 20(sp)     # load current_cur
    addi t1, t1, 4      # current_cur + 4
    add  t1, a0, t1     # set + current_cur + 4
    lb   t1, 0(t1)
    beq  t0, t1, done_check_false
    lw   t1, 20(sp)     # t1 = current_cur = idx_i * 4 + idx_j
    add  t0, a0, t1     # set + current_cur
    lb   t0, 0(t0)      # t0 = set[current_cur]
    lw   t1, 20(sp)     # load current_cur
    addi t1, t1, 5      # current_cur + 5
    add  t1, a0, t1     # set + current_cur + 5
    lb   t1, 0(t1)
    beq  t0, t1, done_check_false
    j done_check_true
check_right_up:
    lw   t1, 20(sp)     # t1 = current_cur = idx_i * 4 + idx_j
    add  t0, a0, t1     # set + current_cur
    lb   t0, 0(t0)      # t0 = set[current_cur]
    lw   t1, 20(sp)     # load current_cur
    addi t1, t1, -1      # current_cur - 1
    add  t1, a0, t1     # set + current_cur - 1
    lb   t1, 0(t1)
    beq  t0, t1, done_check_false
    lw   t1, 20(sp)     # t1 = current_cur = idx_i * 4 + idx_j
    add  t0, a0, t1     # set + current_cur
    lb   t0, 0(t0)      # t0 = set[current_cur]
    lw   t1, 20(sp)     # load current_cur
    addi t1, t1, 3      # current_cur + 3
    add  t1, a0, t1     # set + current_cur + 3
    lb   t1, 0(t1)
    beq  t0, t1, done_check_false
    lw   t1, 20(sp)     # t1 = current_cur = idx_i * 4 + idx_j
    add  t0, a0, t1     # set + current_cur
    lb   t0, 0(t0)      # t0 = set[current_cur]
    lw   t1, 20(sp)     # load current_cur
    addi t1, t1, 4      # current_cur + 4
    add  t1, a0, t1     # set + current_cur + 4
    lb   t1, 0(t1)
    beq  t0, t1, done_check_false
    j done_check_true
check_down:
    lw   t0, 32(sp)     #load mod_j
    bnez t0, check_right_down
check_left_down:
    lw   t1, 20(sp)     # t1 = current_cur = idx_i * 4 + idx_j
    add  t0, a0, t1     # set + current_cur
    lb   t0, 0(t0)      # t0 = set[current_cur]
    lw   t1, 20(sp)     # load current_cur
    addi t1, t1, -4     # current_cur - 4
    add  t1, a0, t1     # set + current_cur - 4
    lb   t1, 0(t1)
    beq  t0, t1, done_check_false
    lw   t1, 20(sp)     # t1 = current_cur = idx_i * 4 + idx_j
    add  t0, a0, t1     # set + current_cur
    lb   t0, 0(t0)      # t0 = set[current_cur]
    lw   t1, 20(sp)     # load current_cur
    addi t1, t1, -3     # current_cur - 3
    add  t1, a0, t1     # set + current_cur - 3
    lb   t1, 0(t1)
    beq  t0, t1, done_check_false
    lw   t1, 20(sp)     # t1 = current_cur = idx_i * 4 + idx_j
    add  t0, a0, t1     # set + current_cur
    lb   t0, 0(t0)      # t0 = set[current_cur]
    lw   t1, 20(sp)     # load current_cur
    addi t1, t1, 1      # current_cur + 1
    add  t1, a0, t1     # set + current_cur + 1
    lb   t1, 0(t1)
    beq  t0, t1, done_check_false
    j done_check_true
check_right_down:
    lw   t1, 20(sp)     # t1 = current_cur = idx_i * 4 + idx_j
    add  t0, a0, t1     # set + current_cur
    lb   t0, 0(t0)      # t0 = set[current_cur]
    lw   t1, 20(sp)     # load current_cur
    addi t1, t1, -5     # current_cur - 5
    add  t1, a0, t1     # set + current_cur - 5
    lb   t1, 0(t1)
    beq  t0, t1, done_check_false
    lw   t1, 20(sp)     # t1 = current_cur = idx_i * 4 + idx_j
    add  t0, a0, t1     # set + current_cur
    lb   t0, 0(t0)      # t0 = set[current_cur]
    lw   t1, 20(sp)     # load current_cur
    addi t1, t1, -4     # current_cur - 4
    add  t1, a0, t1     # set + current_cur - 4
    lb   t1, 0(t1)
    beq  t0, t1, done_check_false
    lw   t1, 20(sp)     # t1 = current_cur = idx_i * 4 + idx_j
    add  t0, a0, t1     # set + current_cur
    lb   t0, 0(t0)      # t0 = set[current_cur]
    lw   t1, 20(sp)     # load current_cur
    addi t1, t1, -1     # current_cur - 1
    add  t1, a0, t1     # set + current_cur - 1
    lb   t1, 0(t1)
    beq  t0, t1, done_check_false
    j done_check_true
done_check_true:
    lw ra, 0(sp)
    addi sp, sp, 40
    li a0, 1
    jr ra
done_check_false:
    lw ra, 0(sp)
    addi sp, sp, 40
    li a0, 0
    jr ra
exit:
    lw ra, 0(sp)
    addi sp, sp, 12
    jr ra
    .size sudoku_2x2_asm, .-sudoku_2x2_asm