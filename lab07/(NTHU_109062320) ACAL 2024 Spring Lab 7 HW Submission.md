(NTHU_109062320_朱季葳) ACAL 2024 Spring Lab 7 HW Submission
===


## Gitlab code link

- Gitlab link - https://course.playlab.tw/git/wewe5215/lab07

## Hw 7-1 - RISC-V M-Standard Extension
### C code - MUL
```cpp=
// C code you add & comment

// Instruction : MUL
// Line 51
typedef enum {
UNIMPL = 0,
  MUL,  
} instr_type;

//line 100
instr_type parse_instr(char* tok) {
  if ( streq(tok , "mul")) return MUL;
}

//line 532
switch( op ) {
    case UNIMPL: return 1;

    //instruction added
    case MUL: case MULHU: case REM: case REMU:
        if ( !o1 || !o2 || !o3 || o4 ) print_syntax_error( line,  "Invalid format" );
            i->a1.reg = parse_reg(o1 , line);
            i->a2.reg = parse_reg(o2 , line);
            i->a3.reg = parse_reg(o3 , line);
        return 1;
//line 779
switch (i.op) {
    case MUL: rf[i.a1.reg] = (int64_t)(rf[i.a2.reg] * rf[i.a3.reg]) << 32 >> 32; break;
}

```
#### Simulation Result & Assembly Code
- Assembly code to test MUL function
```mipsasm=
main:
addi t1, x0, 6     ## t1 = 6
addi t2, x0, -1365     ## t2 = -1365
mul t0, t1, t2           ## t0 = 6 mul -1365 = -8190
addi t1, x0, 1365     ## t1 = 1365
addi t2, x0, -1     ## t2 = -1
mul t0, t1, t2           ## t0 = 1365 mul -1 = -1365
addi t1, x0, 0     ## t1 = 0
addi t2, x0, 0     ## t2 = 0
mul t0, t1, t2           ## t0 = 0 mul 0 = 0
addi t1, x0, 8     ## t1 = 8
addi t2, x0, 8     ## t2 = 8
mul t0, t1, t2           ## t0 = 8 mul 8 = 64
addi t1, x0, -257     ## t1 = -257
addi t2, x0, -1     ## t2 = -1
mul t0, t1, t2           ## t0 = -257 mul -1 = 257
addi t1, x0, 4     ## t1 = 4
addi t2, x0, 0     ## t2 = 0
mul t0, t1, t2           ## t0 = 4 mul 0 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
mul t0, t1, t2           ## t0 = -1 mul -1 = 1
addi t1, x0, 9     ## t1 = 9
addi t2, x0, -1     ## t2 = -1
mul t0, t1, t2           ## t0 = 9 mul -1 = -9
addi t1, x0, 0     ## t1 = 0
addi t2, x0, -1     ## t2 = -1
mul t0, t1, t2           ## t0 = 0 mul -1 = 0
addi t1, x0, 9     ## t1 = 9
addi t2, x0, -1     ## t2 = -1
mul t0, t1, t2           ## t0 = 9 mul -1 = -9
addi t1, x0, 0     ## t1 = 0
addi t2, x0, -1     ## t2 = -1
mul t0, t1, t2           ## t0 = 0 mul -1 = 0
addi t1, x0, 819     ## t1 = 819
addi t2, x0, -1     ## t2 = -1
mul t0, t1, t2           ## t0 = 819 mul -1 = -819
addi t1, x0, 0     ## t1 = 0
addi t2, x0, -1     ## t2 = -1
mul t0, t1, t2           ## t0 = 0 mul -1 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
mul t0, t1, t2           ## t0 = -1 mul -1 = 1
addi t1, x0, 1638     ## t1 = 1638
addi t2, x0, -1     ## t2 = -1
mul t0, t1, t2           ## t0 = 1638 mul -1 = -1638
addi t1, x0, 128     ## t1 = 128
addi t2, x0, -1     ## t2 = -1
mul t0, t1, t2           ## t0 = 128 mul -1 = -128
addi t1, x0, -1366     ## t1 = -1366
addi t2, x0, -1     ## t2 = -1
mul t0, t1, t2           ## t0 = -1366 mul -1 = 1366
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
mul t0, t1, t2           ## t0 = -1 mul -1 = 1
addi t1, x0, 16     ## t1 = 16
addi t2, x0, -1     ## t2 = -1
mul t0, t1, t2           ## t0 = 16 mul -1 = -16
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
mul t0, t1, t2           ## t0 = -1 mul -1 = 1
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
mul t0, t1, t2           ## t0 = -1 mul -1 = 1
addi t1, x0, 7     ## t1 = 7
addi t2, x0, 2047     ## t2 = 2047
mul t0, t1, t2           ## t0 = 7 mul 2047 = 14329
addi t1, x0, 0     ## t1 = 0
addi t2, x0, -1025     ## t2 = -1025
mul t0, t1, t2           ## t0 = 0 mul -1025 = 0
addi t1, x0, 1639     ## t1 = 1639
addi t2, x0, -513     ## t2 = -513
mul t0, t1, t2           ## t0 = 1639 mul -513 = -840807
addi t1, x0, -4     ## t1 = -4
addi t2, x0, -257     ## t2 = -257
mul t0, t1, t2           ## t0 = -4 mul -257 = 1028
addi t1, x0, 0     ## t1 = 0
addi t2, x0, -129     ## t2 = -129
mul t0, t1, t2           ## t0 = 0 mul -129 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -65     ## t2 = -65
mul t0, t1, t2           ## t0 = -1 mul -65 = 65
addi t1, x0, 0     ## t1 = 0
addi t2, x0, -33     ## t2 = -33
mul t0, t1, t2           ## t0 = 0 mul -33 = 0
addi t1, x0, -1365     ## t1 = -1365
addi t2, x0, -17     ## t2 = -17
mul t0, t1, t2           ## t0 = -1365 mul -17 = 23205
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -9     ## t2 = -9
mul t0, t1, t2           ## t0 = -1 mul -9 = 9
addi t1, x0, 6     ## t1 = 6
addi t2, x0, -5     ## t2 = -5
mul t0, t1, t2           ## t0 = 6 mul -5 = -30
addi t1, x0, -17     ## t1 = -17
addi t2, x0, -3     ## t2 = -3
mul t0, t1, t2           ## t0 = -17 mul -3 = 51
addi t1, x0, 0     ## t1 = 0
addi t2, x0, -2     ## t2 = -2
mul t0, t1, t2           ## t0 = 0 mul -2 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 0     ## t2 = 0
mul t0, t1, t2           ## t0 = -1 mul 0 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 5     ## t2 = 5
mul t0, t1, t2           ## t0 = -1 mul 5 = -5
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 1366     ## t2 = 1366
mul t0, t1, t2           ## t0 = -1 mul 1366 = -1366
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 0     ## t2 = 0
mul t0, t1, t2           ## t0 = -1 mul 0 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
mul t0, t1, t2           ## t0 = -1 mul -1 = 1
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 820     ## t2 = 820
mul t0, t1, t2           ## t0 = -1 mul 820 = -820
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
mul t0, t1, t2           ## t0 = -1 mul -1 = 1
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
mul t0, t1, t2           ## t0 = -1 mul -1 = 1
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
mul t0, t1, t2           ## t0 = -1 mul -1 = 1
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
mul t0, t1, t2           ## t0 = -1 mul -1 = 1
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 0     ## t2 = 0
mul t0, t1, t2           ## t0 = -1 mul 0 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 0     ## t2 = 0
mul t0, t1, t2           ## t0 = -1 mul 0 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
mul t0, t1, t2           ## t0 = -1 mul -1 = 1
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
mul t0, t1, t2           ## t0 = -1 mul -1 = 1
addi t1, x0, 2047     ## t1 = 2047
addi t2, x0, 1364     ## t2 = 1364
mul t0, t1, t2           ## t0 = 2047 mul 1364 = 2792108
addi t1, x0, -1025     ## t1 = -1025
addi t2, x0, 820     ## t2 = 820
mul t0, t1, t2           ## t0 = -1025 mul 820 = -840500
addi t1, x0, -513     ## t1 = -513
addi t2, x0, 2     ## t2 = 2
mul t0, t1, t2           ## t0 = -513 mul 2 = -1026
hcf
```
- Simulation result
    在這裡我是直接寫一個python script去對比從qemu倒出來的答案，還有emulator全部執行完的結果，因為我所有的testcase都是用t1作為operator1, t2作為operator2, t0作為rd，而我倒出來的答案會放到[hw1/test_ans/mul/mul_output.txt](https://course.playlab.tw/git/wewe5215/lab07/-/blob/main/hw1/test_ans/mul/mul_output.txt?ref_type=heads)(如果助教需要測試全部的話可以直接執行[hw1/run_test.sh](https://course.playlab.tw/git/wewe5215/lab07/-/blob/main/hw1/run_test.sh?ref_type=heads)，裡面從gen_testcase到最後check testcase的script都有被執行到，其執行結果如果符合預期的話會出現下圖二的畫面)
    ![](https://course.playlab.tw/md/uploads/54b39be5-b0c9-46e6-bfd4-953aed39a514.png)
    ![](https://course.playlab.tw/md/uploads/317b6362-f655-4938-ac23-938cb8ee765d.png)





### C code - MULHU
```cpp=
// instruction : mulhu
// line 52
typedef enum {
    UNIMPL = 0,
    
    MULHU,
// line 101
if ( streq(tok, "mulhu") ) return MULHU;
//line 532
switch( op ) {
    case UNIMPL: return 1;

    //instruction added
    case MUL: case MULHU: case REM: case REMU:
        if ( !o1 || !o2 || !o3 || o4 ) print_syntax_error( line,  "Invalid format" );
            i->a1.reg = parse_reg(o1 , line);
            i->a2.reg = parse_reg(o2 , line);
            i->a3.reg = parse_reg(o3 , line);
        return 1;
// line 780
case MULHU: rf[i.a1.reg] = (int32_t)(((uint64_t)rf[i.a2.reg] * (uint64_t)rf[i.a3.reg]) >> 32); break;
```
#### Simulation Result & Assembly Code

- Assembly code to test MULHU function
```mipsasm=
main:
addi t1, x0, 0     ## t1 = 0
addi t2, x0, 64     ## t2 = 64
mulhu t0, t1, t2           ## t0 = 0 mulhu 64 = 0
addi t1, x0, 0     ## t1 = 0
addi t2, x0, -1     ## t2 = -1
mulhu t0, t1, t2           ## t0 = 0 mulhu -1 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
mulhu t0, t1, t2           ## t0 = -1 mulhu -1 = -2
addi t1, x0, 0     ## t1 = 0
addi t2, x0, 0     ## t2 = 0
mulhu t0, t1, t2           ## t0 = 0 mulhu 0 = 0
addi t1, x0, 0     ## t1 = 0
addi t2, x0, -1     ## t2 = -1
mulhu t0, t1, t2           ## t0 = 0 mulhu -1 = 0
addi t1, x0, 32     ## t1 = 32
addi t2, x0, -1     ## t2 = -1
mulhu t0, t1, t2           ## t0 = 32 mulhu -1 = 31
addi t1, x0, -65     ## t1 = -65
addi t2, x0, -1     ## t2 = -1
mulhu t0, t1, t2           ## t0 = -65 mulhu -1 = -66
addi t1, x0, 1364     ## t1 = 1364
addi t2, x0, -1     ## t2 = -1
mulhu t0, t1, t2           ## t0 = 1364 mulhu -1 = 1363
addi t1, x0, -2     ## t1 = -2
addi t2, x0, -1     ## t2 = -1
mulhu t0, t1, t2           ## t0 = -2 mulhu -1 = -3
addi t1, x0, -33     ## t1 = -33
addi t2, x0, -1     ## t2 = -1
mulhu t0, t1, t2           ## t0 = -33 mulhu -1 = -34
addi t1, x0, 818     ## t1 = 818
addi t2, x0, -1     ## t2 = -1
mulhu t0, t1, t2           ## t0 = 818 mulhu -1 = 817
addi t1, x0, 64     ## t1 = 64
addi t2, x0, -1     ## t2 = -1
mulhu t0, t1, t2           ## t0 = 64 mulhu -1 = 63
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
mulhu t0, t1, t2           ## t0 = -1 mulhu -1 = -2
addi t1, x0, 1283     ## t1 = 1283
addi t2, x0, -1     ## t2 = -1
mulhu t0, t1, t2           ## t0 = 1283 mulhu -1 = 1282
addi t1, x0, 0     ## t1 = 0
addi t2, x0, -1     ## t2 = -1
mulhu t0, t1, t2           ## t0 = 0 mulhu -1 = 0
addi t1, x0, 819     ## t1 = 819
addi t2, x0, -1     ## t2 = -1
mulhu t0, t1, t2           ## t0 = 819 mulhu -1 = 818
addi t1, x0, 17     ## t1 = 17
addi t2, x0, -1     ## t2 = -1
mulhu t0, t1, t2           ## t0 = 17 mulhu -1 = 16
addi t1, x0, -2     ## t1 = -2
addi t2, x0, -1     ## t2 = -1
mulhu t0, t1, t2           ## t0 = -2 mulhu -1 = -3
addi t1, x0, 0     ## t1 = 0
addi t2, x0, -1     ## t2 = -1
mulhu t0, t1, t2           ## t0 = 0 mulhu -1 = 0
addi t1, x0, 19     ## t1 = 19
addi t2, x0, -1     ## t2 = -1
mulhu t0, t1, t2           ## t0 = 19 mulhu -1 = 18
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
mulhu t0, t1, t2           ## t0 = -1 mulhu -1 = -2
addi t1, x0, 5     ## t1 = 5
addi t2, x0, 2047     ## t2 = 2047
mulhu t0, t1, t2           ## t0 = 5 mulhu 2047 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1025     ## t2 = -1025
mulhu t0, t1, t2           ## t0 = -1 mulhu -1025 = -1026
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -513     ## t2 = -513
mulhu t0, t1, t2           ## t0 = -1 mulhu -513 = -514
addi t1, x0, 128     ## t1 = 128
addi t2, x0, -257     ## t2 = -257
mulhu t0, t1, t2           ## t0 = 128 mulhu -257 = 127
addi t1, x0, 2047     ## t1 = 2047
addi t2, x0, -129     ## t2 = -129
mulhu t0, t1, t2           ## t0 = 2047 mulhu -129 = 2046
addi t1, x0, -513     ## t1 = -513
addi t2, x0, -65     ## t2 = -65
mulhu t0, t1, t2           ## t0 = -513 mulhu -65 = -578
addi t1, x0, -257     ## t1 = -257
addi t2, x0, -33     ## t2 = -33
mulhu t0, t1, t2           ## t0 = -257 mulhu -33 = -290
addi t1, x0, 19     ## t1 = 19
addi t2, x0, -17     ## t2 = -17
mulhu t0, t1, t2           ## t0 = 19 mulhu -17 = 18
addi t1, x0, 0     ## t1 = 0
addi t2, x0, -9     ## t2 = -9
mulhu t0, t1, t2           ## t0 = 0 mulhu -9 = 0
addi t1, x0, 1285     ## t1 = 1285
addi t2, x0, -5     ## t2 = -5
mulhu t0, t1, t2           ## t0 = 1285 mulhu -5 = 1284
addi t1, x0, -33     ## t1 = -33
addi t2, x0, -3     ## t2 = -3
mulhu t0, t1, t2           ## t0 = -33 mulhu -3 = -36
addi t1, x0, 32     ## t1 = 32
addi t2, x0, -2     ## t2 = -2
mulhu t0, t1, t2           ## t0 = 32 mulhu -2 = 31
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
mulhu t0, t1, t2           ## t0 = -1 mulhu -1 = -2
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
mulhu t0, t1, t2           ## t0 = -1 mulhu -1 = -2
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
mulhu t0, t1, t2           ## t0 = -1 mulhu -1 = -2
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
mulhu t0, t1, t2           ## t0 = -1 mulhu -1 = -2
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 0     ## t2 = 0
mulhu t0, t1, t2           ## t0 = -1 mulhu 0 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -2     ## t2 = -2
mulhu t0, t1, t2           ## t0 = -1 mulhu -2 = -3
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
mulhu t0, t1, t2           ## t0 = -1 mulhu -1 = -2
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -5     ## t2 = -5
mulhu t0, t1, t2           ## t0 = -1 mulhu -5 = -6
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
mulhu t0, t1, t2           ## t0 = -1 mulhu -1 = -2
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 0     ## t2 = 0
mulhu t0, t1, t2           ## t0 = -1 mulhu 0 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 8     ## t2 = 8
mulhu t0, t1, t2           ## t0 = -1 mulhu 8 = 7
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 0     ## t2 = 0
mulhu t0, t1, t2           ## t0 = -1 mulhu 0 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 0     ## t2 = 0
mulhu t0, t1, t2           ## t0 = -1 mulhu 0 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 0     ## t2 = 0
mulhu t0, t1, t2           ## t0 = -1 mulhu 0 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -513     ## t2 = -513
mulhu t0, t1, t2           ## t0 = -1 mulhu -513 = -514
addi t1, x0, -1025     ## t1 = -1025
addi t2, x0, 1639     ## t2 = 1639
mulhu t0, t1, t2           ## t0 = -1025 mulhu 1639 = 1638
addi t1, x0, -129     ## t1 = -129
addi t2, x0, -1     ## t2 = -1
mulhu t0, t1, t2           ## t0 = -129 mulhu -1 = -130
hcf
```
- Simulation result
我倒出來的答案會放到[hw1/test_ans/mulhu/mulhu_output.txt](https://course.playlab.tw/git/wewe5215/lab07/-/blob/main/hw1/test_ans/mulhu/mulhu_output.txt?ref_type=heads)
![](https://course.playlab.tw/md/uploads/617adc04-0b14-4db0-8b95-8a1a1685e115.png)


### C code - REM
```cpp=
// line 54
typedef enum {
	UNIMPL = 0,

	//instruction added
    MUL,
	MULHU,
	REM,
//line 532
switch( op ) {
    case UNIMPL: return 1;

    //instruction added
    case MUL: case MULHU: case REM: case REMU:
        if ( !o1 || !o2 || !o3 || o4 ) print_syntax_error( line,  "Invalid format" );
            i->a1.reg = parse_reg(o1 , line);
            i->a2.reg = parse_reg(o2 , line);
            i->a3.reg = parse_reg(o3 , line);
        return 1;
// line 102
if ( streq(tok, "rem") ) return REM;
// line 781
case REM:
    // overflow
    if(rf[i.a3.reg] == -1 && rf[i.a2.reg] == INT64_MIN)rf[i.a1.reg] = 0;
    // division by zero
    else if(rf[i.a3.reg] == 0)rf[i.a1.reg] = rf[i.a2.reg];
    else rf[i.a1.reg] = (int64_t)(((int64_t)rf[i.a2.reg] << 32 >> 32) \
        % ((int64_t)rf[i.a3.reg] << 32 >> 32)) << 32 >> 32;
    break;
```
#### Simulation Result & Assembly Code

- Assembly code to test REM function
```mipsasm=
main:
addi t1, x0, 1283     ## t1 = 1283
addi t2, x0, -1     ## t2 = -1
rem t0, t1, t2           ## t0 = 1283 rem -1 = 0
addi t1, x0, -2048     ## t1 = -2048
addi t2, x0, -1     ## t2 = -1
rem t0, t1, t2           ## t0 = -2048 rem -1 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
rem t0, t1, t2           ## t0 = -1 rem -1 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
rem t0, t1, t2           ## t0 = -1 rem -1 = 0
addi t1, x0, -257     ## t1 = -257
addi t2, x0, -1     ## t2 = -1
rem t0, t1, t2           ## t0 = -257 rem -1 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
rem t0, t1, t2           ## t0 = -1 rem -1 = 0
addi t1, x0, 818     ## t1 = 818
addi t2, x0, -1     ## t2 = -1
rem t0, t1, t2           ## t0 = 818 rem -1 = 0
addi t1, x0, 0     ## t1 = 0
addi t2, x0, 0     ## t2 = 0
rem t0, t1, t2           ## t0 = 0 rem 0 = 0
addi t1, x0, 1024     ## t1 = 1024
addi t2, x0, -1     ## t2 = -1
rem t0, t1, t2           ## t0 = 1024 rem -1 = 0
addi t1, x0, -17     ## t1 = -17
addi t2, x0, -1     ## t2 = -1
rem t0, t1, t2           ## t0 = -17 rem -1 = 0
addi t1, x0, 2     ## t1 = 2
addi t2, x0, -1     ## t2 = -1
rem t0, t1, t2           ## t0 = 2 rem -1 = 0
addi t1, x0, 0     ## t1 = 0
addi t2, x0, -1     ## t2 = -1
rem t0, t1, t2           ## t0 = 0 rem -1 = 0
addi t1, x0, 0     ## t1 = 0
addi t2, x0, -1     ## t2 = -1
rem t0, t1, t2           ## t0 = 0 rem -1 = 0
addi t1, x0, 820     ## t1 = 820
addi t2, x0, -1     ## t2 = -1
rem t0, t1, t2           ## t0 = 820 rem -1 = 0
addi t1, x0, 4     ## t1 = 4
addi t2, x0, -1     ## t2 = -1
rem t0, t1, t2           ## t0 = 4 rem -1 = 0
addi t1, x0, -1365     ## t1 = -1365
addi t2, x0, -1     ## t2 = -1
rem t0, t1, t2           ## t0 = -1365 rem -1 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
rem t0, t1, t2           ## t0 = -1 rem -1 = 0
addi t1, x0, 1365     ## t1 = 1365
addi t2, x0, -1     ## t2 = -1
rem t0, t1, t2           ## t0 = 1365 rem -1 = 0
addi t1, x0, 0     ## t1 = 0
addi t2, x0, -1     ## t2 = -1
rem t0, t1, t2           ## t0 = 0 rem -1 = 0
addi t1, x0, -1284     ## t1 = -1284
addi t2, x0, -1     ## t2 = -1
rem t0, t1, t2           ## t0 = -1284 rem -1 = 0
addi t1, x0, 0     ## t1 = 0
addi t2, x0, 2047     ## t2 = 2047
rem t0, t1, t2           ## t0 = 0 rem 2047 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1025     ## t2 = -1025
rem t0, t1, t2           ## t0 = -1 rem -1025 = -1
addi t1, x0, 819     ## t1 = 819
addi t2, x0, -513     ## t2 = -513
rem t0, t1, t2           ## t0 = 819 rem -513 = 306
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -257     ## t2 = -257
rem t0, t1, t2           ## t0 = -1 rem -257 = -1
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -129     ## t2 = -129
rem t0, t1, t2           ## t0 = -1 rem -129 = -1
addi t1, x0, 0     ## t1 = 0
addi t2, x0, -65     ## t2 = -65
rem t0, t1, t2           ## t0 = 0 rem -65 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -33     ## t2 = -33
rem t0, t1, t2           ## t0 = -1 rem -33 = -1
addi t1, x0, 8     ## t1 = 8
addi t2, x0, -17     ## t2 = -17
rem t0, t1, t2           ## t0 = 8 rem -17 = 8
addi t1, x0, 8     ## t1 = 8
addi t2, x0, -9     ## t2 = -9
rem t0, t1, t2           ## t0 = 8 rem -9 = 8
addi t1, x0, -129     ## t1 = -129
addi t2, x0, -5     ## t2 = -5
rem t0, t1, t2           ## t0 = -129 rem -5 = -4
addi t1, x0, -1365     ## t1 = -1365
addi t2, x0, -3     ## t2 = -3
rem t0, t1, t2           ## t0 = -1365 rem -3 = 0
addi t1, x0, 0     ## t1 = 0
addi t2, x0, -2     ## t2 = -2
rem t0, t1, t2           ## t0 = 0 rem -2 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
rem t0, t1, t2           ## t0 = -1 rem -1 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 2     ## t2 = 2
rem t0, t1, t2           ## t0 = -1 rem 2 = -1
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 2047     ## t2 = 2047
rem t0, t1, t2           ## t0 = -1 rem 2047 = -1
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 819     ## t2 = 819
rem t0, t1, t2           ## t0 = -1 rem 819 = -1
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 820     ## t2 = 820
rem t0, t1, t2           ## t0 = -1 rem 820 = -1
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 0     ## t2 = 0
rem t0, t1, t2           ## t0 = -1 rem 0 = -1
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 1365     ## t2 = 1365
rem t0, t1, t2           ## t0 = -1 rem 1365 = -1
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 0     ## t2 = 0
rem t0, t1, t2           ## t0 = -1 rem 0 = -1
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1284     ## t2 = -1284
rem t0, t1, t2           ## t0 = -1 rem -1284 = -1
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 0     ## t2 = 0
rem t0, t1, t2           ## t0 = -1 rem 0 = -1
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 7     ## t2 = 7
rem t0, t1, t2           ## t0 = -1 rem 7 = -1
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -4     ## t2 = -4
rem t0, t1, t2           ## t0 = -1 rem -4 = -1
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 0     ## t2 = 0
rem t0, t1, t2           ## t0 = -1 rem 0 = -1
addi t1, x0, 2047     ## t1 = 2047
addi t2, x0, 0     ## t2 = 0
rem t0, t1, t2           ## t0 = 2047 rem 0 = 2047
addi t1, x0, -1025     ## t1 = -1025
addi t2, x0, 820     ## t2 = 820
rem t0, t1, t2           ## t0 = -1025 rem 820 = -205
addi t1, x0, -513     ## t1 = -513
addi t2, x0, 0     ## t2 = 0
rem t0, t1, t2           ## t0 = -513 rem 0 = -513
addi t1, x0, -65     ## t1 = -65
addi t2, x0, 1284     ## t2 = 1284
rem t0, t1, t2           ## t0 = -65 rem 1284 = -65
addi t1, x0, -33     ## t1 = -33
addi t2, x0, -1365     ## t2 = -1365
rem t0, t1, t2           ## t0 = -33 rem -1365 = -33
hcf
```
- Simulation result
我倒出來的答案會放到[hw1/test_ans/rem/rem_output.txt](https://course.playlab.tw/git/wewe5215/lab07/-/blob/main/hw1/test_ans/rem/rem_output.txt?ref_type=heads)
![](https://course.playlab.tw/md/uploads/68c8ae04-4d40-493c-987a-6740d9365a73.png)




### C code - REMU
```cpp=
// line 55
typedef enum {
	UNIMPL = 0,

	//instruction added
	MUL,
	MULHU,
	REM,
	REMU,
// line 103
if ( streq(tok, "remu") ) return REMU;

//line 532
switch( op ) {
    case UNIMPL: return 1;

    //instruction added
    case MUL: case MULHU: case REM: case REMU:
        if ( !o1 || !o2 || !o3 || o4 ) print_syntax_error( line,  "Invalid format" );
            i->a1.reg = parse_reg(o1 , line);
            i->a2.reg = parse_reg(o2 , line);
            i->a3.reg = parse_reg(o3 , line);
        return 1;
// line 789
case REMU:
    // division by zero
    if(rf[i.a3.reg] == 0)rf[i.a1.reg] = (uint32_t)rf[i.a2.reg];
    else rf[i.a1.reg] = (uint64_t)(((uint64_t)rf[i.a2.reg] << 32 >> 32) \
        % ((uint64_t)rf[i.a3.reg] << 32 >> 32)) << 32 >> 32;
    break;
```
#### Simulation Result & Assembly Code

- Assembly code to test REMU function
```mipsasm=
main:
addi t1, x0, 32     ## t1 = 32
addi t2, x0, -513     ## t2 = -513
remu t0, t1, t2           ## t0 = 32 remu -513 = 32
addi t1, x0, 818     ## t1 = 818
addi t2, x0, -1     ## t2 = -1
remu t0, t1, t2           ## t0 = 818 remu -1 = 818
addi t1, x0, 0     ## t1 = 0
addi t2, x0, 0     ## t2 = 0
remu t0, t1, t2           ## t0 = 0 remu 0 = 0
addi t1, x0, 12     ## t1 = 12
addi t2, x0, 12     ## t2 = 12
remu t0, t1, t2           ## t0 = 12 remu 12 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
remu t0, t1, t2           ## t0 = -1 remu -1 = 0
addi t1, x0, 0     ## t1 = 0
addi t2, x0, -1     ## t2 = -1
remu t0, t1, t2           ## t0 = 0 remu -1 = 0
addi t1, x0, 1365     ## t1 = 1365
addi t2, x0, -1     ## t2 = -1
remu t0, t1, t2           ## t0 = 1365 remu -1 = 1365
addi t1, x0, 0     ## t1 = 0
addi t2, x0, -1     ## t2 = -1
remu t0, t1, t2           ## t0 = 0 remu -1 = 0
addi t1, x0, 3     ## t1 = 3
addi t2, x0, -1     ## t2 = -1
remu t0, t1, t2           ## t0 = 3 remu -1 = 3
addi t1, x0, -33     ## t1 = -33
addi t2, x0, -1     ## t2 = -1
remu t0, t1, t2           ## t0 = -33 remu -1 = -33
addi t1, x0, 16     ## t1 = 16
addi t2, x0, -1     ## t2 = -1
remu t0, t1, t2           ## t0 = 16 remu -1 = 16
addi t1, x0, -5     ## t1 = -5
addi t2, x0, 0     ## t2 = 0
remu t0, t1, t2           ## t0 = -5 remu 0 = -5
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
remu t0, t1, t2           ## t0 = -1 remu -1 = 0
addi t1, x0, 1283     ## t1 = 1283
addi t2, x0, -1     ## t2 = -1
remu t0, t1, t2           ## t0 = 1283 remu -1 = 1283
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
remu t0, t1, t2           ## t0 = -1 remu -1 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
remu t0, t1, t2           ## t0 = -1 remu -1 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
remu t0, t1, t2           ## t0 = -1 remu -1 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
remu t0, t1, t2           ## t0 = -1 remu -1 = 0
addi t1, x0, 12     ## t1 = 12
addi t2, x0, -1     ## t2 = -1
remu t0, t1, t2           ## t0 = 12 remu -1 = 12
addi t1, x0, 0     ## t1 = 0
addi t2, x0, -1     ## t2 = -1
remu t0, t1, t2           ## t0 = 0 remu -1 = 0
addi t1, x0, -9     ## t1 = -9
addi t2, x0, -1     ## t2 = -1
remu t0, t1, t2           ## t0 = -9 remu -1 = -9
addi t1, x0, 0     ## t1 = 0
addi t2, x0, 2047     ## t2 = 2047
remu t0, t1, t2           ## t0 = 0 remu 2047 = 0
addi t1, x0, 0     ## t1 = 0
addi t2, x0, -1025     ## t2 = -1025
remu t0, t1, t2           ## t0 = 0 remu -1025 = 0
addi t1, x0, -65     ## t1 = -65
addi t2, x0, -257     ## t2 = -257
remu t0, t1, t2           ## t0 = -65 remu -257 = 192
addi t1, x0, 1024     ## t1 = 1024
addi t2, x0, -129     ## t2 = -129
remu t0, t1, t2           ## t0 = 1024 remu -129 = 1024
addi t1, x0, 1     ## t1 = 1
addi t2, x0, -65     ## t2 = -65
remu t0, t1, t2           ## t0 = 1 remu -65 = 1
addi t1, x0, 818     ## t1 = 818
addi t2, x0, -33     ## t2 = -33
remu t0, t1, t2           ## t0 = 818 remu -33 = 818
addi t1, x0, -65     ## t1 = -65
addi t2, x0, -17     ## t2 = -17
remu t0, t1, t2           ## t0 = -65 remu -17 = -65
addi t1, x0, 0     ## t1 = 0
addi t2, x0, -9     ## t2 = -9
remu t0, t1, t2           ## t0 = 0 remu -9 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -5     ## t2 = -5
remu t0, t1, t2           ## t0 = -1 remu -5 = 4
addi t1, x0, -2     ## t1 = -2
addi t2, x0, -3     ## t2 = -3
remu t0, t1, t2           ## t0 = -2 remu -3 = 1
addi t1, x0, 1024     ## t1 = 1024
addi t2, x0, -2     ## t2 = -2
remu t0, t1, t2           ## t0 = 1024 remu -2 = 1024
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 0     ## t2 = 0
remu t0, t1, t2           ## t0 = -1 remu 0 = -1
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 512     ## t2 = 512
remu t0, t1, t2           ## t0 = -1 remu 512 = 511
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 1283     ## t2 = 1283
remu t0, t1, t2           ## t0 = -1 remu 1283 = 344
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -2     ## t2 = -2
remu t0, t1, t2           ## t0 = -1 remu -2 = 1
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
remu t0, t1, t2           ## t0 = -1 remu -1 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 1637     ## t2 = 1637
remu t0, t1, t2           ## t0 = -1 remu 1637 = 1498
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 18     ## t2 = 18
remu t0, t1, t2           ## t0 = -1 remu 18 = 3
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 14     ## t2 = 14
remu t0, t1, t2           ## t0 = -1 remu 14 = 3
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -65     ## t2 = -65
remu t0, t1, t2           ## t0 = -1 remu -65 = 64
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -3     ## t2 = -3
remu t0, t1, t2           ## t0 = -1 remu -3 = 2
addi t1, x0, -1     ## t1 = -1
addi t2, x0, -1     ## t2 = -1
remu t0, t1, t2           ## t0 = -1 remu -1 = 0
addi t1, x0, -1     ## t1 = -1
addi t2, x0, 10     ## t2 = 10
remu t0, t1, t2           ## t0 = -1 remu 10 = 5
addi t1, x0, 2047     ## t1 = 2047
addi t2, x0, -1     ## t2 = -1
remu t0, t1, t2           ## t0 = 2047 remu -1 = 2047
addi t1, x0, -1025     ## t1 = -1025
addi t2, x0, 4     ## t2 = 4
remu t0, t1, t2           ## t0 = -1025 remu 4 = 3
addi t1, x0, -513     ## t1 = -513
addi t2, x0, -9     ## t2 = -9
remu t0, t1, t2           ## t0 = -513 remu -9 = -513
addi t1, x0, -257     ## t1 = -257
addi t2, x0, 16     ## t2 = 16
remu t0, t1, t2           ## t0 = -257 remu 16 = 15
addi t1, x0, -129     ## t1 = -129
addi t2, x0, 0     ## t2 = 0
remu t0, t1, t2           ## t0 = -129 remu 0 = -129
addi t1, x0, -17     ## t1 = -17
addi t2, x0, 0     ## t2 = 0
remu t0, t1, t2           ## t0 = -17 remu 0 = -17
hcf
```
- Simulation result
我倒出來的答案會放到[hw1/test_ans/remu/remu_output.txt](https://course.playlab.tw/git/wewe5215/lab07/-/blob/main/hw1/test_ans/remu/remu_output.txt?ref_type=heads)
![](https://course.playlab.tw/md/uploads/74081cef-8670-41ef-84ba-14d00ce355a5.png)




## HW7-2 - RISC-V Bit Manipulation Extension
### Gitlab code link (Your own branch)
- Gitlab link of your branch - https://course.playlab.tw/git/wewe5215/lab07-group/-/tree/dev/wewe5215?ref_type=heads

- Gitlab link of your group project repo - 
https://course.playlab.tw/git/wewe5215/lab07-group



### C Code - ANDN

```cpp=
// line 54
typedef enum {
    UNIMPL = 0,

    /* Member 1 109062320
     * ANDN ~ MAX
     */
    ANDN,
// line 141
if (streq(tok, "andn")) return ANDN;
// line 742
case ANDN:  
    if (!o1 || !o2 || !o3 || o4) print_syntax_error(line, "Invalid format");
    i->a1.reg = parse_reg(o1, line);
    i->a2.reg = parse_reg(o2, line);
    i->a3.reg = parse_reg(o3, line);
    return 1;

// line 1034
switch (i.op) {
    case ANDN: rf[i.a1.reg] = rf[i.a2.reg] & ~rf[i.a3.reg]; break;

```

#### Simulation Result & Assembly Code
- Assembly code to test instruction you picked
在測資的部分我們這組是抓[riscv-test-suite/rv32i_m/B/src](https://github.com/riscv-non-isa/riscv-arch-test/tree/main/riscv-test-suite/rv32i_m/B/src)上面所提供的測資下來測的，而我們的組員有根據這些檔案裡面所提供的測資寫一個python script來generate testcase，詳細的內容在[Readme](https://course.playlab.tw/git/wewe5215/lab07-group/-/blob/master/README.md?ref_type=heads)當中有提及，在執行完[test/gen_testcases.py](https://course.playlab.tw/git/wewe5215/lab07-group/-/blob/master/test/gen_testcases.py?ref_type=heads)之後會在test_assembly放入我們所有的測資，並生成一個answers.json，裡面即為我們所預期的答案，而這個部分因為已經有cover到全部的指令了所以之後就不再贅述了


- Simulation result
![](https://course.playlab.tw/md/uploads/c43050de-4bbb-4cd7-a176-dadf39804988.png)

### C Code - CLMUL
```cpp=
// line 55
typedef enum {
    UNIMPL = 0,

    /* Member 1 109062320
     * ANDN ~ MAX
     */
    CLMUL,
// line 142
if (streq(tok, "clmul")) return CLMUL;
// line 743
case CLMUL:  
    if (!o1 || !o2 || !o3 || o4) print_syntax_error(line, "Invalid format");
    i->a1.reg = parse_reg(o1, line);
    i->a2.reg = parse_reg(o2, line);
    i->a3.reg = parse_reg(o3, line);
    return 1;

// line 1035
int x = 0;
switch (i.op) {
    // 基本上就是按照insns/clmul.adoc上面的pseudo code進行實作
    case CLMUL:
        x = 0;
        for(int idx = 0; idx < 32; idx ++){
            if((rf[i.a3.reg] >> idx) & 1){
                x ^= rf[i.a2.reg] << idx;
            }
        }
        rf[i.a1.reg] = x;
        break;


```
#### Simulation Result & Assembly Code
請看[這裡](#Simulation-Result-amp-Assembly-Code4)
### C Code - CLMULH
```cpp=
// line 56
typedef enum {
    UNIMPL = 0,

    /* Member 1 109062320
     * ANDN ~ MAX
     */
    CLMULH,
// line 142
if (streq(tok, "clmulh")) return CLMULH;
// line 744
case CLMULH:  
    if (!o1 || !o2 || !o3 || o4) print_syntax_error(line, "Invalid format");
    i->a1.reg = parse_reg(o1, line);
    i->a2.reg = parse_reg(o2, line);
    i->a3.reg = parse_reg(o3, line);
    return 1;

// line 1044
int x = 0;
switch (i.op) {
    // 基本上就是按照insns/clmulh.adoc上面的pseudo code進行實作
    case CLMULH:
        x = 0;
        for(int idx = 1; idx < 32; idx ++){
            if((rf[i.a3.reg] >> idx) & 1){
                x ^= rf[i.a2.reg] >> (32 - idx);
            }
        }
        rf[i.a1.reg] = x;
        break;



```
#### Simulation Result & Assembly Code
請看[這裡](#Simulation-Result-amp-Assembly-Code4)
### C Code - CLMULR
```cpp=
// line 57
typedef enum {
    UNIMPL = 0,

    /* Member 1 109062320
     * ANDN ~ MAX
     */
    CLMULR,
// line 143
if (streq(tok, "clmulr")) return CLMULR;
// line 745
case CLMULR:  
    if (!o1 || !o2 || !o3 || o4) print_syntax_error(line, "Invalid format");
    i->a1.reg = parse_reg(o1, line);
    i->a2.reg = parse_reg(o2, line);
    i->a3.reg = parse_reg(o3, line);
    return 1;

// line 1053
int x = 0;
switch (i.op) {
    // 基本上就是按照insns/clmulr.adoc上面的pseudo code進行實作
    case CLMULH:
        x = 0;
        for(int idx = 1; idx < 32; idx ++){
            if((rf[i.a3.reg] >> idx) & 1){
                x ^= rf[i.a2.reg] >> (32 - idx);
            }
        }
        rf[i.a1.reg] = x;
        break;



```
#### Simulation Result & Assembly Code
請看[這裡](#Simulation-Result-amp-Assembly-Code4)
### C Code - CLZ
```cpp=
// line 58
typedef enum {
    UNIMPL = 0,

    /* Member 1 109062320
     * ANDN ~ MAX
     */
    CLZ,
// line 144
if (streq(tok, "clz")) return CLZ;
// line 780
case CLZ:
case CPOP:
case CTZ:
case ZEXT_H:
case SEXT_B:
case SEXT_H:
    if (!o1 || !o2 || o3 || o4) print_syntax_error(line, "Invalid format");
    i->a1.reg = parse_reg(o1, line);
    i->a2.reg = parse_reg(o2, line);
    return 1;

// line 1053
int x = 0;
switch (i.op) {
    // 從most significant bit開始去看把該bit shift到least significant bit與1做and的結果，
    // 如果是1則代表該bit是1，而第一個出現1的那個bit從左數過來為第idx個bit, 即為所求
    case CLZ:
        x = 32;
        for(int idx = 0; idx < 32 ; idx++){
            if((rf[i.a2.reg] >> (32 - idx - 1)) & 1){
                x = idx;
                break;
            }
        }
        rf[i.a1.reg] = x;
        break;

```
#### Simulation Result & Assembly Code
請看[這裡](#Simulation-Result-amp-Assembly-Code4)
### C Code - CPOP
```cpp=
// line 59
typedef enum {
    UNIMPL = 0,

    /* Member 1 109062320
     * ANDN ~ MAX
     */
    CPOP,
// line 145
if (streq(tok, "cpop")) return CPOP;
// line 781
case CLZ:
case CPOP:
case CTZ:
case ZEXT_H:
case SEXT_B:
case SEXT_H:
    if (!o1 || !o2 || o3 || o4) print_syntax_error(line, "Invalid format");
    i->a1.reg = parse_reg(o1, line);
    i->a2.reg = parse_reg(o2, line);
    return 1;

// line 1072
int x = 0;
switch (i.op) {
    // 從least significant bit開始去看該bit與1做and的結果，如果是1則代表該bit是1，
    // 然後因為rf[i.a2.reg]是32bit, 所以實際上只會做(32 + idx)%32 bits 的shift，
    // 因此以下的operation是從least significant bit檢查到most significant bit，然後去計算檢查到該bit是1的次數極為所求(其實也可以把32拿掉，
    // 原本是想從most significant bit開始shift但是後來忘了把+ idx改成- idx - 1了)
    case CPOP:
        x = 0;
        for(int idx = 0; idx < 32; idx ++){
            if((rf[i.a2.reg] >> (32 + idx)) & 1){
                x ++;
            }
        }
        rf[i.a1.reg] = x;
        break;

```
#### Simulation Result & Assembly Code
請看[這裡](#Simulation-Result-amp-Assembly-Code4)
### C Code - CTZ
```cpp=
// line 60
typedef enum {
    UNIMPL = 0,

    /* Member 1 109062320
     * ANDN ~ MAX
     */
    CTZ,
// line 146
if (streq(tok, "ctz")) return CTZ;
// line 782
case CLZ:
case CPOP:
case CTZ:
case ZEXT_H:
case SEXT_B:
case SEXT_H:
    if (!o1 || !o2 || o3 || o4) print_syntax_error(line, "Invalid format");
    i->a1.reg = parse_reg(o1, line);
    i->a2.reg = parse_reg(o2, line);
    return 1;

// line 1072
int x = 0;
uint32_t temp = 0;
switch (i.op) {
    // 從least significant bit開始去看該bit與1做and的結果，如果是1則代表該bit是1，
    // 如果是0就繼續往most significant bit的方向把輪到的bit shift到least significant bit的位置，
    // 然後發現一個0就加1到x，然後到第一次遇到1的時候break
    case CTZ:
        x = 0;
        temp = rf[i.a2.reg];
        for (int idx = 0; idx < 32; idx++) {
            if (temp & 1) {
                break;
            } else {
                temp = temp >> 1;
                x++;
            }
        }
        rf[i.a1.reg] = x;
        break;



```
#### Simulation Result & Assembly Code
請看[這裡](#Simulation-Result-amp-Assembly-Code4)

### C Code - MAX
```cpp=
// line 61
typedef enum {
    UNIMPL = 0,

    /* Member 1 109062320
     * ANDN ~ MAX
     */
    MAX,
// line 147
if (streq(tok, "max")) return MAX;
// line 746
case MAX:  
    if (!o1 || !o2 || !o3 || o4) print_syntax_error(line, "Invalid format");
    i->a1.reg = parse_reg(o1, line);
    i->a2.reg = parse_reg(o2, line);
    i->a3.reg = parse_reg(o3, line);
    return 1;

// line 1094
int x = 0;
switch (i.op) {
    case MAX: rf[i.a1.reg] = (int32_t)rf[i.a2.reg] > (int32_t)rf[i.a3.reg] ? rf[i.a2.reg] : rf[i.a3.reg]; break;


```
#### Simulation Result & Assembly Code
請看[這裡](#Simulation-Result-amp-Assembly-Code4)
## Bonus
> Bonus請依照 lab6 document中的 bonus template進行繳交。

