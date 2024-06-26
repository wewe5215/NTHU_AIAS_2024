## fibonacci.S

    .text                          # code section 
    .global fibonacci_asm          # declar the sum_asm function as a  global function
    .type fibonacci_asm, @function # define sum_asm as a function 
fibonacci_asm:
prologue:
    addi sp,sp, -16
    sw ra,0(sp)
    sw s0,4(sp)
    sw s1,8(sp)
    sw s2,12(sp)
    # Write your assembly code funtion here.
    # Please notice the rules of calling convention.
    jal    fibonacci           # 開始進行 fibonacci 運算
    j      exit
fibonacci:
## fibonacci function
    addi   sp, sp, -12         # 進行 stack pointer 的移動
    sw     ra, 0(sp)          # 儲存 return address
    sw     a0, 4(sp)          # 儲存 temp data
    sw     a1, 8(sp)

    li     t0, 0
    beq    a0, t0, ret_zero   # 檢查是否運算到 n=0

    li     t0, 1
    beq    a0, t0, ret_one    # 檢查是否運算到 n=1

    addi   a0, a0, -1         # fibonacci(n-1)
    jal    fibonacci
    sw     a1, 8(sp)

    lw     a0, 4(sp)
    addi   a0, a0, -2         # fibonacci(n-2)
    jal    fibonacci
    lw     a0, 4(sp)
    lw     t0, 8(sp)          # load result of fibonacci(n-1) from stack
    add    a1, t0, a1
    j      done

ret_zero:
	li	   a1, 0
    j      done

ret_one:
    li     a1, 1

done:
    lw     ra, 0(sp)
    addi   sp, sp, 12
    jr     ra
exit:
    mv a0, a1
    lw ra,0(sp)
    lw s0,4(sp)
    lw s1,8(sp)
    lw s2,12(sp)
    addi sp,sp,16
    jr ra

    .size fibonacci_asm, .-fibonacci_asm