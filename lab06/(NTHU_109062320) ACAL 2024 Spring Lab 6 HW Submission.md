(NTHU_109062320_朱季葳) ACAL 2024 Spring Lab 6 HW Submission
===


## Gitlab code link
- Gitlab link - https://course.playlab.tw/git/wewe5215/lab06

## HW6-1 - Fibonacci Series
### Assembly Code
> 請放上你的程式碼並加上註解，讓 TA明白你是如何完成的。
```mipsasm=
## assembly code & comment
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

```
### Simulation Result
![](https://course.playlab.tw/md/uploads/365e6d8b-e639-42c3-8208-80064db3faae.png)


## HW6-2 - Fibonacci Series with C/Assembly Hybrid 
### Assembly Code & C Code
- `fibonacci.S`
```mipsasm=
## assembly code & comment
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
```

- `fibonacci.c`
```cpp=
#include <stdio.h>
#include <stdlib.h>


int fibonacci_c(int n) { 
    if(n == 0) {
        return 0;
    }
        
    else if(n == 1) {
        return 1;
    }
        
    else {
        return fibonacci_c(n-1)+fibonacci_c(n-2);        
    }
}

int fibonacci_asm(int n);

int main() {
    int n = 6;    // setup input value n
    int out = 0; // setup output value fibonacci(n)

    out = fibonacci_c(n);
    char str[25];
    itoa(out,str,10);
    puts("C code fibonacci_c=");
    puts(str);
    puts("\n");  
    out = fibonacci_asm(n);
    puts("ASM code fibonacci_asm=");
    itoa(out,str,10);
    puts(str);
    puts("\n");
    return 0;
}
```

### Simulation Result
![](https://course.playlab.tw/md/uploads/fc5247b1-6cfb-4849-ac00-7d218a8f2899.png)

## HW6-3 - 2x2 Sudoku
### Assembly Code & C Code
- `main.c`
```cpp=
//main.c
#include <stdio.h>
#include <stdlib.h>
// add headerfile to use sudoku_2x2_c implemented in sudoku_2x2_c.c
#include "sudoku_2x2_c.h" 

#define SIZE 16

char test_c_data[16] = { 0, 0, 2, 0, 
                         0, 0, 0, 4,
                         2, 3, 0, 0, 
                         0, 4, 0, 0 };
                      
char test_asm_data[16] = { 0, 0, 2, 0, 
                           0, 0, 0, 4,
                           2, 3, 0, 0, 
                           0, 4, 0, 0 };

void print_sudoku_result() {
    int i;
    char str[25];
    puts("Output c & assembly function result\n");
    puts("c result :\n");
    for( i=0 ; i<SIZE ; i++) {   
        int j= *(test_c_data+i);
        itoa(j, str, 10);
        puts(str);
        if((i + 1) % 4 == 0) // add newline
            puts("\n");
        else
            puts(" ");
    }

    puts("\n\nassembly result :\n");
    for( i=0 ; i<SIZE ; i++) {
        int j= *(test_asm_data+i);
        itoa(j, str, 10);
        puts(str);
        if((i + 1) % 4 == 0)
            puts("\n");
        else
            puts(" ");
    }

    int flag = 0;
    for( i=0 ; i<SIZE ; i++) {
        if (*(test_c_data+i) != *(test_asm_data+i)) {
            flag = 1;
            break;
        }
    }

    if (flag == 1){
        puts("\n\nyour c & assembly got different result ... QQ ...\n");
    }
    else {
        puts("\n\nyour c & assembly got same result!\n");
    }
}


void sudoku_2x2_asm(char *test_asm_data); // TODO, sudoku_2x2_asm.S

// void sudoku_2x2_c(char *test_c_data); // TODO, sudoku_2x2_c.S
                        
int main() {
    bool solvable = sudoku_2x2_c(test_c_data);
    sudoku_2x2_asm(test_asm_data);
    // if sudoku_2x2_c return false, the sudoku is not solvable
    // only if the sudoku is solvable will the result be printed
    if(solvable)
        print_sudoku_result();
    else
        puts("the sudoku problem is not solvable\n");
    return 0;
}
```
- `sudoku_2x2_asm.S`
```mipsasm=
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
```

- `sudoku_2x2_c.c`
```c=
#include <stdio.h>
#include <stdlib.h>
#include "sudoku_2x2_c.h"
bool check(char* set, int index){
    int idx_i = index / 4;
    int idx_j = index % 4;
    int current_cur = idx_i * 4 + idx_j;
    // same col
    for(int i = 0; i < 4; i ++){
        if(i == idx_i)continue;
        if(set[i * 4 + idx_j] == set[current_cur])return false;
    }
    // same row
    for(int j = 0; j < 4; j ++){
        if(j == idx_j)continue;
        if(set[idx_i * 4 + j] == set[current_cur])return false;
    }
    int mod_i = idx_i % 2;
    int mod_j = idx_j % 2;
    // is left_up --> (0, 0), (0, 2), (2, 0), (2, 2)
    if(mod_i == 0 && mod_j == 0){
        if( set[current_cur] == set[current_cur + 1] || \
            set[current_cur] == set[current_cur + 4] || \
            set[current_cur] == set[current_cur + 5])
            return false;
    }
    // is right_up --> (0, 1), (0, 3), (2, 1), (2, 3)
    else if(mod_i == 0 && mod_j == 1){
        if( set[current_cur] == set[current_cur - 1] || \
            set[current_cur] == set[current_cur + 3] || \
            set[current_cur] == set[current_cur + 4])
            return false;
    }
    // is left_down --> (1, 0), (1, 2), (3, 0), (3, 2)
    else if(mod_i == 1 && mod_j == 0){
        if( set[current_cur] == set[current_cur - 4] || \
            set[current_cur] == set[current_cur - 3] || \
            set[current_cur] == set[current_cur + 1])
            return false;
    }
    // is right_down --> (1, 1), (1, 3), (3, 1), (3, 3)
    else if(mod_i == 1 && mod_j == 1){
        if( set[current_cur] == set[current_cur - 5] || \
            set[current_cur] == set[current_cur - 4] || \
            set[current_cur] == set[current_cur - 1])
            return false;
    }

    return true;
}
bool solver(char* set, int index){
    if(index >= 16){
        return true;
    }

    if(*(set + index) > 0){
        return solver(set, index + 1);
    }
    else{
        for(int i = 1; i <= 4; i++){
            *(set + index) = i;
            if(check(set, index) && solver(set, index + 1)){
                return true;
            }
            *(set + index) = 0;
        }
    }
    return false;
}
bool sudoku_2x2_c(char *test_c_data){
// TODO
// Finish your sudoku algorithm in c language
    return solver(test_c_data, 0);
}
```

### Simulation Result
![](https://course.playlab.tw/md/uploads/a543761c-f58b-4dc3-802c-36cb47429b41.png)

## Bonus
### Step 1 C Implementation
> 請放上你C程式碼並加上註解，讓 TA明白你是如何完成的。
> 
### Step 2 Assembly Implementation
> 請放上你Assembly程式碼並加上註解，同時驗證程式碼的正確性。把驗證的結果截圖貼上

### Step 3 Performance Optimization
我們用Instruction Count 來代表performance 的測量metric 的話, 你能怎麼優化你的Assmbly implementation呢？


