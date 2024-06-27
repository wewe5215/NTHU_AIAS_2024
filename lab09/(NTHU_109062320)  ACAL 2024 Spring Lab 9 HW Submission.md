(NTHU_109062320_朱季葳)  ACAL 2024 Spring Lab 9 HW Submission 
===


[toc]

## Gitlab code link


- Gitlab link - https://course.playlab.tw/git/wewe5215/lab09

## Homework 9

### Homework 9-1 5-stage pipelined CPU Implementation
- Please Finish the all others rv32i instrunctions，and pass the **rv32ui_SingleTest/TestALL.S** 


(main branch是放[9-1](https://course.playlab.tw/git/wewe5215/lab09))


![](https://course.playlab.tw/md/uploads/deed72d8-e21c-48bc-a894-dc5000d7d540.png)


### Homework 9-2 Data and Controll Hazards  
- List possible data hazard scenarios and describe how to resolve the hazard in your design.
    1. Rd of instruction A in the WB stage is the same as Rs of instruction B in ID stage
    2. Rd of instruction A in MEM stage is the same as Rs of instruction B in ID stage:
    3. Rd of instruction A in EXE stage is the same as Rs of instruction B in ID stage:
    4. Rd of instruction A in MEM stage is the same as Rs of instruction B in EXE stage:
    - 在data hazard的solution的部分因為高度相似所以在這裡只拿第一個來進行解釋，基本上在檢查到instruction B的rs1或者rs2有跟instruction A的rd overlap的話就會構成data hazard發生的條件，而在這個時候就把各自情景對應到的data hazard的訊號升起來，以第一個來說就是`Stall_WB_ID_DH`，而其他的以此類推。另外在`PipelinedCPU`的module也要在檢查到有data hazard的時候把`ID`, `IF` stage stall，不然cpu就會繼續fetch新的instruction進來，此外在Exe stage的部分也要加上bubble並且等到instruction A所在的那個stage都做完了才能夠繼續讀新的instruction進來。

- Please Finish the all others RV32I instrunctions，and pass the **rv32ui_SingleTest/TestDataHazard.S** 
:::warning
Paste your gitlab branch URL link
https://course.playlab.tw/git/wewe5215/lab09/-/tree/hw9-2?ref_type=heads
:::

![](https://course.playlab.tw/md/uploads/ab26a640-5a1c-4453-8229-b3fd6c8e7318.png)

- In the result of register file，if sp(x2) is **zero**，it means you passed the test，otherwise，the value of sp(x2) is the test case that you did not passed.



### Homework 9-3 Performance Counters and Performance Analysis
1. Complete **8.~13.** performance counters listed below.
:::info
### Performance counter - HW
8. Mem Read Stall Cycle Count
Count cycles stalled due to memory read.
9. Mem Write Stall Cycle Count
Count cycles stalled due to memory write.
10. Mem Read Request Count
Count Load-type instruction.
11. Mem Write Request Count
Count Store-type instruction.
12. Mem Read Bytes Count
Count bytes read in Load-type instruction(lw/lh/lb - all 4bytes are occupied).
13. Mem Write Bytes Count
Count bytes write in Store-type instruction(sw/sh/sb - all 4bytes are occupied).
```chisel=
if(Stall_MA == 1){
    // 8. Mem Read Stall Cycle Count
    if(lines(PC_MEM>>2).contains("lb") || lines(PC_MEM>>2).contains("lh") || lines(PC_MEM>>2).contains("lw")){
        Mem_Read_Stall_Cycle_Count += 1
    }
    // 9. Mem Write Stall Cycle Count
    if(lines(PC_MEM>>2).contains("sb") || lines(PC_MEM>>2).contains("sh") || lines(PC_MEM>>2).contains("sw")){
        Mem_Write_Stall_Cycle_Count += 1
    }
}

if(lines(PC_EXE>>2).contains("lb") || lines(PC_EXE>>2).contains("lh") || lines(PC_EXE>>2).contains("lw")){
    // 10. Mem Read Request Count
    Mem_Read_Request_Count += 1
    
    // 12. Mem Read Bytes Count
    if(lines(PC_EXE>>2).contains("lb")){
        Mem_Read_Bytes_Count += 1
    }
    if(lines(PC_EXE>>2).contains("lh")){
        Mem_Read_Bytes_Count += 2
    }
    if(lines(PC_EXE>>2).contains("lw")){
        Mem_Read_Bytes_Count += 4
    }
}

if(lines(PC_EXE>>2).contains("sb") || lines(PC_EXE>>2).contains("sh") || lines(PC_EXE>>2).contains("sw")){
    // 11. Mem Write Request Count
    Mem_Write_Request_Count += 1
    // 13. Mem Write Bytes Count
    if(lines(PC_EXE>>2).contains("sb")){
        Mem_Write_Bytes_Count += 1
    }
    if(lines(PC_EXE>>2).contains("sh")){
        Mem_Write_Bytes_Count += 2
    }
    if(lines(PC_EXE>>2).contains("sw")){
        Mem_Write_Bytes_Count += 4
    }
}

```
:::
:::warning
Paste your gitlab branch URL link
https://course.playlab.tw/git/wewe5215/lab09/-/tree/hw9-3?ref_type=heads
:::
3. Complete **2.~4.** Performance analysis listed below.
:::info
### Performance analysis - HW
2. Average Mem Read Request Stall Cycle
Mem Read Stall Cycle Count/Mem Read Request Count
3. Average Mem Write Request Stall Cycle
Mem Write Stall Cycle Count/Mem Write Request Count
4. Total Bus bandwidth requiement (Read + Write, data)
Mem Read Bytes Count + Mem Write Bytes Count
:::
```chisel=

if(Mem_Read_Request_Count >= 1){
    // Average Mem Read Request Stall Cycle
    println(s"[Average Mem Read Request Stall Cycle ] ${"%8f".format(Mem_Read_Stall_Cycle_Count.toFloat/Mem_Read_Request_Count.toFloat)}")
}
else{
    // preventing from NAN
    println(s"[Average Mem Read Request Stall Cycle ] 0")
}
if(Mem_Write_Request_Count >= 1){
    // Average Mem Write Request Stall Cycle
    println(s"[Average Mem Write Request Stall Cycle] ${"%8f".format(Mem_Write_Stall_Cycle_Count.toFloat/Mem_Write_Request_Count.toFloat)}")
}
else{
    // preventing from NAN
    println(s"[Average Mem Write Request Stall Cycle] 0")
}
// Total Bus bandwidth requiement (Read + Write, data)
println(s"[Total Bus bandwidth requiement       ] ${"%8f".format(Mem_Read_Bytes_Count.toFloat + Mem_Write_Bytes_Count.toFloat)}")
println("==============================================================")
```
4. Run the **mergesort.S (no vector Extension instruction)** and post the **Performance count and analysis** result.
:::warning
Paste the result Here (Screenshot).
![](https://course.playlab.tw/md/uploads/fe3ac091-b982-48d9-91a6-7b99d94a7c8c.png)

:::
5. Explain How a 5-stage pipelined  CPU improves performance compared to a single-cycle CPU
:::warning
在5-stage pipelined CPU的部分把一個指令在cpu處理各個指令所需要經過的步驟拆成五個，分別是`IF`, `ID`, `EXE`, `MEM`, `WB`，並且每個stage在同一個cycle的時候是像流水線那樣，有不同的指令在執行，但是如果是single-cycle CPU的話，就要等一個指令都做完這五個stage之後才會去執行下一個指令，因此會造成許多資源浪費。
:::

## HW 9-4 Bitmanip Extension (Group Assignment)
因為我是做lab9當Bonus,所以這個部分可以看[我lab8那邊寫的9-4](https://course.playlab.tw/md/s/UXfDSZ2E2)