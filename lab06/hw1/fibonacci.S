## fibonacci.S
## put input n in register x10 (a0)  
## put output fibonacci(n) in register x11 (a1)
## use Venus to test correctness

main:
## write assembly code here.
## call fibonacci function and get return value.
    li     a0, 16              # 暫存器 a0 儲存 n 值，這邊設定 n=16
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
	addi a0 x0 1
    ecall                    # Terminate
