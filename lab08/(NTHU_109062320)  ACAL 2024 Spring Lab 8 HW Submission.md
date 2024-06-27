(NTHU_109062320_朱季葳)  ACAL 2024 Spring Lab 8 HW Submission
===


[toc]

## Gitlab code link


- Gitlab link - https://course.playlab.tw/git/wewe5215/lab08

## Hw 8-0 Instruction Expansion (U-type: Lui)
- 你的架構圖：
    ![](https://course.playlab.tw/md/uploads/bcf80521-4286-4d39-8024-75ca7ac6f746.png)


- 將Lui Datapath與Control signal繪製於你設計的CPU上，<font color=#f00>以其他顏色標明Lui所經過的blocks，以及**可能會**新增的blocks和wires。</font>
    ![](https://course.playlab.tw/md/uploads/c17ba485-803c-4e15-8696-137664410ef4.png)

- tester 結果
    ![](https://course.playlab.tw/md/uploads/b778c79e-dd3a-4cb4-ac0c-320b2692c8fa.png)



## Hw 8-1-1 - Control Signal Table
### Control Signal Table
- Table of Control Signal 
  | Instrs. | PCSel      | ImmSel | RegWEn | BrUn | ASel | Bsel | ALUSel | MemRW | WBSel   |
  | ------- | ---------- | ------ | ------ | ---- | ---- | ---- | ------ | ----- | ------- |
  | xor     | +4         | R-imm  | True   | x    | Reg1 | Reg2 | xor    | Read  | ALU_out |
  | addi    | +4         | I-imm  | True   | x    | Reg1 | imm  | add    | Read  | ALU_out |
  | lw      | +4         | I-imm  | True   | x    | Reg1 | imm  | add    | Read  | mem     |
  | sw      | +4         | S-imm  | False  | x    | Reg1 | imm  | add    | Write | x       |
  | bne     | io.alu_out | B-imm  | False  | False| pc   | imm  | add    | Read  | x       |
  | bltu    | io.alu_out | B-imm  | False  | True | pc   | imm  | add    | Read  | x       |
  | jal     | io.alu_out | J-imm  | True   | x    | pc   | imm  | add    | Read  | pc + 4  |
  | jalr    | io.alu_out | I-imm  | True   | x    | Reg1   | imm  | add    | Read  | pc + 4  |
  | lui     | +4         | U-imm  | True   | x    | 0    | imm  | add    | Read  | ALU_out |

- 設計想法：
    - Ans：在這個部分是照著助教給的圖設計的。
## Hw 8-1-2 Control Logic Chisel Module Design
- Lab4已完成這部分..
    - https://course.playlab.tw/md/s/v1zCULqaT
## Hw 8-1-3 Single-Cycle CPU Design
- tester結果：
    - ![](https://course.playlab.tw/md/uploads/0a2073e4-d2c5-41ec-9c3c-5d18613042a7.png)


## Hw 8-2 Testbench Generator for RV32I Base Instruction Set
- 執行結果
    ![](https://course.playlab.tw/md/uploads/7f6efb8c-bb76-4de7-932c-3e6f71f5bfc3.png)



## Hw 8-3 Bitmanip Extension (Group Assignment)
### Gitlab code link
- Gitlab link of your branch - 
    - https://course.playlab.tw/git/cylin1128/lab09/-/tree/dev/wewe5215?ref_type=heads
- Gitlab link of your group project repo - 
    - https://course.playlab.tw/git/cylin1128/lab09

### 硬體架構圖：
- 小組選擇的base CPU架構圖，是誰的呢?
    - ![](https://course.playlab.tw/md/uploads/4e311a5e-3d87-431e-9028-c88cee9a53fa.png)

    - 我們是直接按照spec上面給的那張圖來實作的


- Option 2 - 有其他分工方式的組別
   我主要負責的部分是Num = 1~14的instruction的testbench，不過在Full test的部分都是我負責的，而我負責的細項有下列幾點：
   1. [新增在Emulator中Num = 1~14的instruction的部分](https://course.playlab.tw/git/cylin1128/lab09/-/commit/911de0c17dbdddd3d4107bf94f017b81b6ce66d3)
   2. [ensure Emulator的正確性(因為有組員提到elf gcc有bug所以會導致一些測資在compile之後丟到Emulator會出錯，所以我有再把我們的測資丟回lab7的emulator gen正確答案並進行二次比對)](https://course.playlab.tw/git/cylin1128/lab09/-/commit/f9126a64328d48a76c3eb71789914cfb18422955)
   3. [generate**所有**instruction的fulltest](https://course.playlab.tw/git/cylin1128/lab09/-/tree/dev/wewe5215/riscv-test/rv32ui_FullTest?ref_type=heads)
       - 在這其中我使用我們這組在lab7就已經弄過的python script以及riscv-test-suite來取得測資以及generate正確答案，並把測資以及正確答案用[新的python script](https://course.playlab.tw/git/cylin1128/lab09/-/blob/dev/wewe5215/riscv-test/Gen_full_testcase.py?ref_type=heads)來生成符合fulltest格式的測資，[其中在fulltest那邊的headerfile也有加一些新東西來配合新的test type](https://course.playlab.tw/git/cylin1128/lab09/-/blob/dev/wewe5215/riscv-test/macros/scalar/test_macros.h?ref_type=heads)

## 測試結果
- 測試檔案1
    - ``Lab08/Emulator/example_code/Hw4_inst.asm``
- 測試結果1
    - ![](https://course.playlab.tw/md/uploads/c1a4f944-60f5-4b7a-980e-cb49e24a495b.png)
- 測試檔案2
    - 在下列連結當中從clz到bclr的測試(因為這個部分的測資都是我負責的所以就擷取這段)
    - https://course.playlab.tw/git/cylin1128/lab09/-/tree/dev/wewe5215/riscv-test/rv32ui_SingleTest?ref_type=heads
- 測試結果2
    - 在我們的testbench當中有使用一個python script去檢查Emulator跟Hardware跑出來之後所有register的值有沒有一致
    - ![](https://course.playlab.tw/md/uploads/ab15f66f-ba12-4d1c-bd54-77a5a8990c74.png)



## 小組最後完成CPU架構圖
- ![](https://course.playlab.tw/md/uploads/b1303432-4ae2-47a9-80e8-d6d10a354803.png)



