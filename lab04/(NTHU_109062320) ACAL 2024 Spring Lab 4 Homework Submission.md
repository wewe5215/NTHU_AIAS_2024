# (NTHU_109062320_朱季葳) ACAL 2024 Spring Lab 4 Homework Submission


[toc]

## Gitlab code link

- Gitlab link - https://course.playlab.tw/git/wewe5215/lab04
## Hw4-1 Mix Adder
### Scala Code
```scala=
package acal_lab04.Hw1

import chisel3._
import acal_lab04.Lab._

class MixAdder (n:Int) extends Module{
  val io = IO(new Bundle{
      val Cin = Input(UInt(1.W))
      val in1 = Input(UInt((4*n).W))
      val in2 = Input(UInt((4*n).W))
      val Sum = Output(UInt((4*n).W))
      val Cout = Output(UInt(1.W))
  })
  //please implement your code below
  // 在這裡基本上就是把lab4-2的code進行改編，如同spec所述，
  // 用8個4-bit CLAdder來兜出32-bit的adder，
  // 所以在這裡只需要把相對應的input(每4個4個一組)傳入作為CLAdder的input，
  // 然後再把上一個CLAdder的carry傳入作為Cin，即可串接一個一個的CLAdder
  val CLAdder_arr = Array.fill(n)(Module(new CLAdder).io)
  val carry = Wire(Vec(n+1, UInt(1.W)))
  val sum   = Wire(Vec(n, UInt(4.W)))
  carry(0) := io.Cin
  for(i <- 0 until n){
    CLAdder_arr(i).in1 := io.in1(4*i + 3, 4*i)
    CLAdder_arr(i).in2 := io.in2(4*i + 3, 4*i)
    CLAdder_arr(i).Cin := carry(i)
    carry(i+1) := CLAdder_arr(i).Cout
    sum(i) := CLAdder_arr(i).Sum
  }
  io.Sum := sum.asUInt
  io.Cout := carry(n - 1)
}

```
### Test Result
![](https://course.playlab.tw/md/uploads/a393ab85-1a85-4a39-b2b1-0222e86afa43.png)


## Hw4-2 Add-Suber
### Scala Code
```scala=
package acal_lab04.Hw2

import chisel3._
import chisel3.util._
import acal_lab04.Lab._

class Add_Suber extends Module{
  val io = IO(new Bundle{
  val in_1 = Input(UInt(4.W))
	val in_2 = Input(UInt(4.W))
	val op = Input(Bool()) // 0:ADD 1:SUB
	val out = Output(UInt(4.W))
	val o_f = Output(Bool())
  })
  val not_in_2 = ~io.in_2
  val FA_Array = Array.fill(4)(Module(new FullAdder()).io)
  val carry = Wire(Vec(4+1, UInt(1.W)))
  val sum   = Wire(Vec(4, Bool()))

  //please implement your code below
  // Adder
  when(io.op === false.B){
    carry(0) := RegInit(0.U(4.W))
    for(i <- 0 until 4){
      FA_Array(i).A := io.in_1(i)
      FA_Array(i).B := io.in_2(i)
      FA_Array(i).Cin := carry(i)
      carry(i+1) := FA_Array(i).Cout
      sum(i) := FA_Array(i).Sum
    }
    // check overflow
    // 當兩個input是同號的情況下，output也必為同號
    // 如果output是異號則代表overflow了
    when((io.in_1(3) === io.in_2(3)) && (sum(3) =/= io.in_2(3))){
      io.o_f := true.B
    }
    .otherwise{
      io.o_f := false.B
    }
  }
  // Suber
  .otherwise{
    // 因為使用2's complement作轉換所以需要在做negation之後加1
    // 所以在這裡把carry(0)設為1來當作
    // least significant bit的addition的Cin
    carry(0) := RegInit(1.U(4.W))
    for(i <- 0 until 4){
      FA_Array(i).A := io.in_1(i)
      FA_Array(i).B := not_in_2(i)
      FA_Array(i).Cin := carry(i)
      carry(i+1) := FA_Array(i).Cout
      sum(i) := FA_Array(i).Sum
    }
    // check overflow
    when((io.in_1(3) === not_in_2(3)) && (sum(3) =/= not_in_2(3))){
      io.o_f := true.B
    }
    .otherwise{
      io.o_f := false.B
    }
  }
  io.out := sum.asUInt
}

```
### Test Result
![](https://course.playlab.tw/md/uploads/440fac04-d051-471d-8a03-0484bfb81649.png)


## Hw4-3 Booth Multiplier
### Scala Code
> 請放上你的程式碼並加上註解(中英文不限)，讓 TA明白你是如何完成的。
```scala=
package acal_lab04.Hw3

import chisel3._
import chisel3.util._
import scala.annotation.switch

//------------------Radix 4---------------------
class Booth_Mul(width:Int) extends Module {
  val io = IO(new Bundle{
    val in1 = Input(UInt(width.W))      //Multiplicand
    val in2 = Input(UInt(width.W))      //Multiplier
    val out = Output(UInt((2*width).W)) //product
  })
  //please implement your code below

  // operation
  // 把Multiplier用大小為3的sliding window掃過一次並
  // assign他的pattern到相對應的wire
  // 此外，因為sliding window的stride=2，所以以每個sliding window最左邊對應到的位置的index來說，
  // 第i個sliding window會對應到io.in(2*i+1)
  // 當width = 16時，most significant bit的index為15
  // 而2*i+1 = 15, i = 7, 所以總共會有0~7共8個weight
  // 所以我們需要width/2條wire來record pattern
  val weight = Wire(Vec(width/2, UInt(3.W)))
  // 在下面的實作我會直接依據該partial product所對應的weight的pattern
  // 去對io.in1的值乘上權重並assign到partial prduct的wire
  val partial_product = Wire(Vec(width/2, SInt((2*width).W)))
  weight(0) := Cat(io.in2(1), io.in2(0), 0.U)
  for(i <- 1 until width/2){
    weight(i) := Cat(io.in2(2*i + 1), io.in2(2*i + 0), io.in2(2*i - 1))
  }
  // initialization for fear of RefNotInitializedException
  // 在這裡我覺得蠻奇怪的點是我下面已經ensure所有wire都有被接上相對應的data了，
  // 但是如果不加這個就一定會報錯，跟寫verilog的時候不太一樣
  for(i <- 0 until width / 2) {
    partial_product(i) := 0.S((2 * width).W).asSInt
  }
  val accumulation = Wire(Vec(width/2 - 1, SInt((2*width).W)))
  //partial product
  // 依據pattern所對應的權重來對io.in1做操作，
  // 其中我會先將其專為SInt再做sign extension到2*width之後再shift
  for(i <- 0 until (width/2)){
    switch(weight(i)){
      // * 0
      is(0.U){
        partial_product(i) := 0.S((2 * width).W)
      }
      // * 1
      is(1.U){
        partial_product(i) := (io.in1).asSInt.pad(2 * width) << (i*2)
      }
      // * 1
      is(2.U){
        partial_product(i) := (io.in1).asSInt.pad(2 * width) << (i*2)
      }
      // * 2
      is(3.U){
        partial_product(i) := ((io.in1)).asSInt.pad(2 * width) << 1 << (i*2)
      }
      // * (-2)
      is(4.U){
        partial_product(i) := (((~io.in1)).asSInt.pad(2 * width) + 1.S((2 * width).W)) << 1 << (i*2)
      }
      // * (-1)
      is(5.U){
        partial_product(i) := (((~(io.in1))).asSInt.pad(2 * width) + 1.S((2 * width).W)) << (i*2)
      }
      // * (-1)
      is(6.U){
        partial_product(i) := ((~(io.in1)).asSInt.pad(2 * width) + 1.S((2 * width).W)) << (i*2)
      }
      // * 0
      is(7.U){
        partial_product(i) := 0.S((2 * width).W)
      }
    }
  }
  // 連加並得到所求
  accumulation(0) := partial_product(0) + partial_product(1)
  for(i <- 1 until (width/2 - 1)){
    accumulation(i) := accumulation(i - 1) + partial_product(i + 1)
  }
  io.out := accumulation((width/2-1) - 1).asUInt
}

```
### Test Result
![](https://course.playlab.tw/md/uploads/7239606b-bcbf-4c2a-bdf2-e21ed1c61869.png)


## Hw4-4 Datapath Implementation for (3、4、7)
### PC
#### Scala Code
```scala=
val pcReg = RegInit(0.U(32.W))
    when(io.brtaken === true.B || io.jmptaken === true.B){
        // 為了預防offset與地址沒有對齊，需要無條件捨去offset的末兩位(改為0)
        pcReg := Cat(io.offset(31,2), 0.U(2.W))
    }.otherwise{
        pcReg := pcReg + 4.U
    }
    io.pc := pcReg
```
#### Test Result
![](https://course.playlab.tw/md/uploads/6242f9a9-bef6-4258-80ee-9e9611c94781.png)

### Decoder
#### Scala Code
```scala=
package acal_lab04.Hw4

import chisel3._
import chisel3.util._

object opcode_map {
    val LOAD      = "b0000011".U
    val STORE     = "b0100011".U
    val BRANCH    = "b1100011".U
    val JALR      = "b1100111".U
    val JAL       = "b1101111".U
    val OP_IMM    = "b0010011".U
    val OP        = "b0110011".U
    val AUIPC     = "b0010111".U
    val LUI       = "b0110111".U
}

import opcode_map._

class Decoder extends Module{
    val io = IO(new Bundle{
        val inst = Input(UInt(32.W))

        //Please fill in the blanks by yourself
        val funct3 = Output(UInt(3.W))
        val funct7 = Output(UInt(7.W))
        val rs1 = Output(UInt(5.W))
        val rs2 = Output(UInt(5.W))
        //Please fill in the blanks by yourself
        val rd = Output(UInt(5.W))
        val opcode = Output(UInt(7.W))
        val imm = Output(SInt(32.W))

        val ctrl_RegWEn = Output(Bool()) // for Reg write back
        val ctrl_ASel = Output(Bool()) // for alu src1
        val ctrl_BSel = Output(Bool()) // for alu src2
        val ctrl_Br = Output(Bool()) // for branch inst.
        val ctrl_Jmp = Output(Bool()) // for jump inst.
        val ctrl_Lui = Output(Bool()) // for lui inst.
        val ctrl_MemRW = Output(Bool()) // for L/S inst
        val ctrl_WBSel = Output(UInt(2.W))
    })

    io.funct3 := io.inst(14,12)
    io.funct7 := io.inst(31,25)
    io.rs1 := io.inst(19,15)
    io.rs2 := io.inst(24,20)
    io.rd := io.inst(11,7)
    io.opcode := io.inst(6,0)

    //ImmGen
    io.imm := MuxLookup(io.opcode,0.S,Seq(
        //R-type
        // inst[31,25]  inst[24,20]  inst[19,15]  inst[14,12]  inst[11,7]  inst[6,0]
        //  funct7         rs2          rs1          funct3        rd        opcode

        OP -> 0.S,
        //I-type
        // inst[31,20]  inst[19,15]  inst[14,12]  inst[11,7]  inst[6,0]
        // imm[11,0]      rs1          funct3        rd        opcode

        OP_IMM -> (io.inst(31,20)).asSInt,

        //B-type
        // inst[31]  inst[30,25]    inst[24,20]   inst[19,15]   inst[14,12]   inst[11,8]  inst[7]   inst[6,0]
        // imm[12]    imm[10,5]         rs2          rs1          funct3       imm[4,1]   imm[11]    opcode

        BRANCH -> (Cat(io.inst(31), io.inst(7), io.inst(30, 25), io.inst(11, 8), 0.U)).asSInt,
        //  Load --> I-type
        //  inst[31,20]  inst[19,15]  inst[14,12]  inst[11,7]  inst[6,0]
        //  imm[11,0]      rs1          funct3        rd        opcode

        LOAD -> (io.inst(31,20)).asSInt,
        //S-type
        // inst[31,25]  inst[24,20]  inst[19,15]  inst[14,12]  inst[11,7]   inst[6,0]
        //  imm[11,5]       rs2          rs1        funct3      imm[4,0]     opcode

        STORE -> (Cat(io.inst(31, 25), io.inst(11, 7))).asSInt,
        //U-type
        // inst[31,12]    inst[11,7]   inst[6,0]
        //  imm[31:12]      rd            opcode
        AUIPC -> (io.inst(31,12) << 12).asSInt,
        LUI -> (io.inst(31,12) << 12).asSInt,
        //J-type
        // inst[31,20]   inst[19,15]   inst[14,12]   inst[11,7]    inst[6,0]
        //  imm[11,0]      rs1           funct3         rd          opcode

        JALR -> (io.inst(31,20)).asSInt,
        // inst[31]  inst[30,21]    inst[20]   inst[19,12]   inst[11,7]     inst[6,0]
        //  imm[20]   imm[10,1]      imm[11]    imm[19,12]       rd          opcode

        JAL -> (Cat(io.inst(31), io.inst(19, 12), io.inst(20), io.inst(30, 21), 0.U)).asSInt,

    ))

    //Controller, 基本上就是照著助教的圖還有那個UCB的投影片去刻
    // true --> w/ rd, false --> wo/ rd
    io.ctrl_RegWEn := MuxLookup(io.opcode,true.B,Seq(
        STORE -> false.B,
        BRANCH -> false.B
    ))
    // true --> rs1, false --> pc
    io.ctrl_ASel := MuxLookup(io.opcode,true.B,Seq(
        BRANCH -> false.B,
        AUIPC -> false.B,
        JAL -> false.B
    ))
    // true --> rs2, false --> imm
    io.ctrl_BSel := MuxLookup(io.opcode,false.B,Seq(
        OP -> true.B
    ))
    io.ctrl_Br := Mux(
        io.opcode === BRANCH,
        true.B,
        false.B
    )
    io.ctrl_Jmp := Mux(
        io.opcode === JALR || io.opcode === JAL,
        true.B,
        false.B
    )
    io.ctrl_Lui := Mux(
        io.opcode === LUI,
        true.B,
        false.B
    )
    io.ctrl_MemRW := Mux(
        io.opcode === STORE,
        true.B,
        false.B
    )
    io.ctrl_WBSel := MuxLookup(io.opcode,1.U,Seq(
        LOAD -> 0.U,
        STORE -> 1.U, // don't care, since ctrl_RegWEn is false
        BRANCH -> 2.U,
        JALR   -> 2.U,
        JAL    -> 2.U

    ))
    //true: from alu , false: from dm , another source?
}

```
#### Test Result
![](https://course.playlab.tw/md/uploads/25d040a0-71e7-436f-a136-dd3d092d1720.png)

### BranchComp
#### Scala Code
```scala=
## scala code & comment
## make sure your have passed the `BranchCompTest.scala` test
package acal_lab04.Hw4

import chisel3._
import chisel3.util._

object condition{
  val EQ = "b000".U
  val NE = "b001".U
  val LT = "b100".U
  val GE = "b101".U
  val LTU = "b110".U
  val GEU = "b111".U
}

import condition._

class BranchComp extends Module{
    val io = IO(new Bundle{
        val en = Input(Bool())
        val funct3 = Input(UInt(3.W))
        val src1 = Input(UInt(32.W))
        val src2 = Input(UInt(32.W))

        val brtaken = Output(Bool()) //for pc.io.brtaken
    })
    // if instruction is B-type, io.en = true
    when(io.en === true.B){
      io.brtaken := MuxLookup(io.funct3,false.B,Seq(
        EQ -> Mux(
          io.src1.asSInt === io.src2.asSInt,
          true.B,
          false.B
        ),
        NE -> Mux(
          io.src1.asSInt =/= io.src2.asSInt,
          true.B,
          false.B
        ),
        LT -> Mux(
          io.src1.asSInt < io.src2.asSInt,
          true.B,
          false.B
        ),
        GE -> Mux(
          io.src1.asSInt >= io.src2.asSInt,
          true.B,
          false.B
        ),
        LTU -> Mux(
          io.src1.asUInt < io.src2.asUInt,
          true.B,
          false.B
        ),
        GEU -> Mux(
          io.src1.asUInt >= io.src2.asUInt,
          true.B,
          false.B
        ),
      ))
    }
    .otherwise{
      io.brtaken := false.B
    }
}
```
#### Test Result
![](https://course.playlab.tw/md/uploads/db890eba-5eb1-4fc5-9720-8ddddd17073e.png)

## Hw4-4 Datapath Implementation for (1、2、6、8、9)
### InstMem_wc.txt
```=
//wc: with comment

//Hw5-4-1 I-type testing 
// inst[31,20]  inst[19,15]  inst[14,12]  inst[11,7]  inst[6,0]
// imm[11,0]      rs1          funct3        rd        opcode
111111111111 00101 000 00001 0010011 //addi x1 x5 -1
000000000010 00011 001 00010 0010011 //slli x2, x3, 2 --> 12
000000000101 00100 010 00100 0010011 //slti x4, x4, 5 --> 1
000000000100 00100 010 00100 0010011 //slti x4, x4, 4 --> 0
000000000011 00100 010 00100 0010011 //slti x4, x4, 3 --> 0
111111111100 00100 010 00100 0010011 //slti x4, x4, -4 --> 0
000000000101 00101 011 00101 0010011 //sltiu x5, x5, 5 --> 0
000000000100 00101 011 00101 0010011 //sltiu x5, x5, 4 --> 0
000000000011 00101 011 00101 0010011 //sltiu x5, x5, 3 --> 0
000000000010 00110 100 00111 0010011 //xori x7, x6, 2 --> 4
000000000000 00110 100 00111 0010011 //xori x7, x6, 0 --> 6
111111111111 00110 100 00111 0010011 //xori x7, x6, -1 --> -7
000000000010 00110 101 00111 0010011 //srli x7, x6, 2 --> 1
000000000000 00110 101 00111 0010011 //srli x7, x6, 0 --> 6
000000011111 00110 101 00111 0010011 //srli x7, x6, -1 --> 0
010000000010 00110 101 00111 0010011 //srai x7, x6, 2 --> 1
010000000000 00110 101 00111 0010011 //srai x7, x6, 0 --> 6
010000011111 00110 101 00111 0010011 //srai x7, x6, -1 --> 0
000000000010 00110 110 00111 0010011 //ori x7, x6, 2 --> 6
111111111111 00110 110 00111 0010011 //ori x7, x6, -1 --> -1
000000000000 00110 110 00111 0010011 //ori x7, x6, 0 --> 6
000000000010 00110 111 00111 0010011 //andi x7, x6, 2 --> 2
111111111111 00110 111 00111 0010011 //andi x7, x6, -1 --> 6
000000000000 00110 111 00111 0010011 //andi x7, x6, 0 --> 0

//Hw5-4-2 R-type testing
// inst[31,25]  inst[24,20]  inst[19,15]  inst[14,12]  inst[11,7]  inst[6,0]
//  funct7         rs2          rs1          funct3        rd        opcode
0000000 11111 00011 000 11111 0110011 //add x31, x3, x31 --> 34
0100000 11111 00011 000 11111 0110011 //sub x31, x3, x31 --> -28
0100000 00011 00100 000 00011 0110011 //sub x3, x4, x3 --> 1
0100000 00100 00100 000 00011 0110011 //sub x3, x4, x4 --> 0
0000000 00011 00100 001 00011 0110011 //sll x3, x4, x3 --> 32
0000000 00001 00100 001 00011 0110011 //sll x3, x4, x1 --> 8
0000000 11111 00100 001 00011 0110011 //sll x3, x4, x31 --> 0
0000000 11111 00100 010 00011 0110011 //slt x3, x4, x31 --> 1
0000000 00100 11111 010 00011 0110011 //slt x3, x31, x4 --> 0
0000000 00100 00100 010 00011 0110011 //slt x3, x4, x4 --> 0
0000000 11111 00100 011 00011 0110011 //sltu x3, x4, x31 --> 1
0000000 00100 11111 011 00011 0110011 //sltu x3, x31, x4 --> 0
0000000 00100 00100 011 00011 0110011 //sltu x3, x4, x4 --> 0
0000000 00100 00000 011 00011 0110011 //sltu x3, x0, x4 --> 1
0000000 11111 00011 100 11111 0110011 //xor x31, x3, x31 --> 28
0000000 00100 01101 101 10000 0110011 //srl x16, x13, x4 --> 0
0100000 00101 01111 101 10001 0110011 //sra x17, x15, x5 --> 0
0000000 11111 00011 110 11111 0110011 //or x31, x3, x31 --> 31
0000000 11111 11110 111 11111 0110011 //and x31, x30, x31 --> 30

//Hw5-4-6 Load/Store inst. testing
//  inst[31,20]  inst[19,15]  inst[14,12]  inst[11,7]  inst[6,0]
//  imm[11,0]      rs1          funct3        rd        opcode
000000000000 00000 000 00001 0000011 //lb x1 x0 0
000000000010 00000 001 00001 0000011 //lh x1 x0 2
000000000000 00000 010 00001 0000011 //lw x1 x0 0
000000000011 00000 100 00001 0000011 //lbu x1 x0 3
000000000000 00000 101 00001 0000011 //lhu x1 x0 0

// inst[31,25]  inst[24,20]  inst[19,15]  inst[14,12]  inst[11,7]   inst[6,0]
//  imm[11,5]       rs2          rs1        funct3      imm[4,0]     opcode 
0000000 00001 00000 000 00000 0100011 //sb x1 x0 0
0000000 00001 00000 001 00010 0100011 //sh x1 x0 2
0000000 00001 00000 010 00000 0100011 //sw x1 x0 0

//Hw5-4-8 B-type testing
// inst[31]  inst[30,25]    inst[24,20]   inst[19,15]   inst[14,12]   inst[11,8]  inst[7]   inst[6,0]
// imm[12]    imm[10,5]         rs2          rs1          funct3       imm[4,1]   imm[11]    opcode
0 000000 00001 00001 000 1100 0 1100011 //beq x1 x1 24  --> 0 0 000000 1100 0
0 000000 00001 00001 001 1010 0 1100011 //bne x1 x1 20  --> 0 0 000000 1010 0
0 000000 00010 00001 100 1000 0 1100011 //blt x1 x2 16  --> 0 0 000000 1000 0
0 000000 00000 00001 101 0110 0 1100011 //bge x1 x0 12  --> 0 0 000000 0110 0
0 000000 00001 00001 110 0100 0 1100011 //bltu x1 x1 8  --> 0 0 000000 0100 0
0 000000 00001 00001 111 0010 0 1100011 //bgeu x1 x1 4  --> 0 0 000000 0010 0

//Hw5-4-9 J-type testing
// inst[31]  inst[30,21]    inst[20]   inst[19,12]   inst[11,7]     inst[6,0]
//  imm[20]   imm[10,1]      imm[11]    imm[19,12]       rd          opcode
1 1111110110 1 11111111 00000 1101111 //jal x0 -20 --> 1 11111111 1 1111110110 0
// inst[31,20]   inst[19,15]   inst[14,12]   inst[11,7]    inst[6,0]
//  imm[11,0]      rs1           funct3         rd          opcode
000000010000 00100 000 00000 1100111 //jalr x0 x4 16
```

### Scala Code
- top
```scala=
## scala code & comment
## make sure you have comfirm the correctness of every type of instructions by yourself
package acal_lab04.Hw4

import chisel3._
import chisel3.util._

class top extends Module {
    val io = IO(new Bundle{
        val pc_out = Output(UInt(32.W))
        val alu_out = Output(UInt(32.W))
        val rf_wdata_out = Output(UInt(32.W))
        val brtaken_out = Output(Bool())
        val jmptaken_out = Output(Bool())
        val funct3  = Output(UInt(3.W))
        val funct7 = Output(UInt(7.W))
        val inst = Output(UInt(32.W))
        // for debugging
    })

    val pc = Module(new PC())
    val im = Module(new InstMem())
    val dc = Module(new Decoder())
    val rf = Module(new RegFile(2))
    val alu = Module(new ALU())
    val bc = Module(new BranchComp())
    val dm = Module(new DataMem())

    //PC
    pc.io.jmptaken := false.B // Don't modify
    pc.io.brtaken := false.B // Don't modify
    pc.io.offset := 0.U // Don't modify

    //Insruction Memory
    im.io.raddr := pc.io.pc

    //Decoder
    dc.io.inst := im.io.rdata

    //RegFile
    rf.io.raddr(0) := dc.io.rs1
    rf.io.raddr(1) := dc.io.rs2
    rf.io.wdata := MuxLookup(dc.io.ctrl_WBSel, dm.io.rdata.asUInt, Seq(
        0.U -> dm.io.rdata.asUInt, // data load from memory
        1.U -> alu.io.out.asUInt, // ALU output
        2.U -> (pc.io.pc + 4.U(32.W)).asUInt // pc + 4 (B-type, J-type)
    ))

    rf.io.waddr := 0.U  // Don't modify
    rf.io.wen := false.B // Don't modify

    //ALU
    val rdata_or_zero = WireDefault(0.U(32.W))
    alu.io.src1 := Mux(
        dc.io.ctrl_ASel,
        rf.io.rdata(0),
        pc.io.pc // B-type, JAL, Lui
    )
    alu.io.src2 := Mux(
        dc.io.ctrl_BSel,
        rf.io.rdata(1), // R-type
        dc.io.imm.asUInt
    )
    alu.io.funct3 := dc.io.funct3
    alu.io.funct7 := dc.io.funct7
    alu.io.opcode := dc.io.opcode

    //Data Memory
    dm.io.funct3 := dc.io.funct3
    dm.io.raddr :=  (rf.io.rdata(0) + dc.io.imm.asUInt)(9,0)
    dm.io.wen := dc.io.ctrl_MemRW
    dm.io.waddr := (rf.io.rdata(0) + dc.io.imm.asUInt)(9,0)
    dm.io.wdata := rf.io.rdata(1)
    //Branch Comparator
    bc.io.en := dc.io.ctrl_Br
    bc.io.funct3 := dc.io.funct3
    bc.io.src1 := rf.io.rdata(0)
    bc.io.src2 := rf.io.rdata(1)


    //Check Ports
    io.pc_out := pc.io.pc
    io.alu_out := alu.io.out
    io.rf_wdata_out := rf.io.wdata
    io.brtaken_out := bc.io.brtaken
    io.jmptaken_out := dc.io.ctrl_Jmp 
    // for debugging
    io.funct3 := dc.io.funct3
    io.funct7 := dc.io.funct7
    io.inst := im.io.rdata
}
```
### Test Result
- R-type
    ![](https://course.playlab.tw/md/uploads/b7888d25-bb0d-463d-a417-620960789650.png)
    ![](https://course.playlab.tw/md/uploads/985de112-5302-4bd1-89f4-af9e7ce6e67b.png)
    ![](https://course.playlab.tw/md/uploads/8a7c095e-787b-4c6b-9e10-11e1cf4fd9fb.png)
- I-type
    ![](https://course.playlab.tw/md/uploads/33fb00d8-b2a0-4ebd-910f-40f446642d26.png)
    ![](https://course.playlab.tw/md/uploads/d9dcba7b-13ac-4b2c-8210-023a1a16dadb.png)
    ![](https://course.playlab.tw/md/uploads/4b7dd5b2-94db-454c-8842-a85424dd6b50.png)

- Load
    ![](https://course.playlab.tw/md/uploads/070d41d2-8df7-4344-9b71-2cbdde4913e3.png)
- S-type:在這裡我直接在DataMem.scala那邊把記憶體裡面的data全部印出來，並且在RegFile那邊把x1的值改為0x87654321並與spec上的範例相對應
    - [Inst:sb x1 x0 0]從下圖可以看到**PC=20**的時候，沒有任何在memory裡面的data被改動，而在**PC=24**的時候可以看到`Memory[0] = 21`, 符合在spec中`mem(0)存入0x21`的敘述
    ![](https://course.playlab.tw/md/uploads/88379620-c5d7-4137-a800-bc725a47e4d3.png)
    - [Inst:sh x1 x0 2]從下圖可以看到**PC=28**時`mem(2)存入0x21 mem(3)存入0x43`
    ![](https://course.playlab.tw/md/uploads/42ecf7fe-0a42-46be-939a-c6567a370023.png)
    - [Inst:sw x1 x0 0]從下圖可以看到**PC=32**時`mem(0)存入0x21, mem(1)存入0x43, mem(2)存入0x65, mem(3)存入0x87`(截圖此結果的時候還沒有實作B-type所以下圖beq的部分只是拿來check sw有沒有運作正確而已)
    ![](https://course.playlab.tw/md/uploads/87bbb255-df03-4f68-96c0-cfb44969fa59.png)

- B-type
    - 在spec上面好像沒有對B-type的wbdata有描述所以應該是don't care，不過我在這裡就直接把他歸類跟J-type一樣回傳pc+4作為WBdata
    ![](https://course.playlab.tw/md/uploads/c39357a1-1100-4259-844e-ce24cb17cc69.png)



- J-type
    ![](https://course.playlab.tw/md/uploads/34ef436f-7943-4e84-8ee8-c20828c045e4.png)



## 文件中的問答題
- Q1:哪兩種type的指令需要仰賴ALU最多的功能呢？對於其他type的指令而言，ALU的功能是？ (Hw4-4)
    - Ans1:R-type跟I-type需要仰賴ALU最多的功能，對於其他指令來說ALU就只是用來做相加，例如對於lw來說，ALU是用來算地址用的，甚至可以不使用ALU然後自己在外面算地址，在我Hw4-4中lw的地址就沒有透過ALU來算，但是Hw8的就有，不過都不影響結果。
- Q2:Branch情況發生時，**pc+offset**會從哪裡傳回pc呢？Beq x0 x0 imm 可以完全取代 jal x0 imm嗎？如果不行，為什麼?(Hw4-4)
    - Ans2:
        - 1. ALU
        - 2. 不行，因為如果是jal的話會把pc+4存回rd但是beq不會
- Q3:假設我用int存取src1和src2，由於int是signed的方式存取，比大小(-1<3)自然能夠成立。有沒有什麼方式是**不需透過轉換Dtype**，就能夠實現Unsigned的比較方式呢?比如說，該如何驗證BGEU呢？(可以用pseudo code或者你認為你能表達清楚你的想法，用文字呈現也行。)(Hw4-4)
    - Ans3:因為在signed的時候most significant bit可以代表正負，所以會有四種排列組合，分別是正正、負負、正負、負正，而在Unsigned的時候原本是負的會變成更大的正數，所以在正負和負正得情況之下就直接選擇負的那個。在正正的時候照原本的就可以了，而在負負的時候也可以直接照原本的，因為在2's complement的表示法之下，以-1, -127為例，-1的binary是1111 1111, 而-127是1000 0001，如果是在unsigned的狀態之下-1的binary代表的數值也會比-127大。

## 意見回饋和心得(可填可不填)
