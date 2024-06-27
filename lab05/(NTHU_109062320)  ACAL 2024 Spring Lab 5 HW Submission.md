(NTHU_109062320_朱季葳)  ACAL 2024 Spring Lab 5 HW Submission
===

[toc]

## Gitlab code link

- Gitlab link - https://course.playlab.tw/git/wewe5215/lab05

## Hw5-1 TrafficLight with Pedestrian button
### Scala Code
> 請放上你的程式碼並加上註解(中英文不限)，讓 TA明白你是如何完成的。
```scala=
package acal_lab05.Hw1

import chisel3._
import chisel3.util._

class TrafficLight_p(Ytime:Int, Gtime:Int, Ptime:Int) extends Module{
  val io = IO(new Bundle{
    val P_button = Input(Bool())
    val H_traffic = Output(UInt(2.W))
    val V_traffic = Output(UInt(2.W))
    val P_traffic = Output(UInt(2.W))
    val timer     = Output(UInt(5.W))
  })

  io.H_traffic := 0.U
  io.V_traffic := 0.U
  io.P_traffic := 0.U
  io.timer := 0.U
  //parameter declaration
  val Off = 0.U
  val Red = 1.U
  val Yellow = 2.U
  val Green = 3.U

  val sIdle :: sHGVR :: sHYVR :: sHRVG :: sHRVY :: sPG :: Nil = Enum(6)

  //State register
  val state = RegInit(sIdle)
  // record last state for sPG to decide 
  // which state to turn back
  val last_state = RegInit(sIdle)
  val is_p_button = RegInit(0.U(1.W))
  val last_is_p_button = RegInit(0.U(1.W))
  //Counter============================
  val cntMode = WireDefault(0.U(2.W))
  val cntReg = RegInit(0.U(4.W))
  val cntDone = Wire(Bool())
  cntDone := cntReg === 0.U


  when(cntDone){
    when(cntMode === 0.U){
      cntReg := (Gtime-1).U
    }.elsewhen(cntMode === 1.U){
      cntReg := (Ytime-1).U
    }.elsewhen(cntMode === 2.U){
      cntReg := (Ptime-1).U
    }
  }
  .otherwise{
    when(io.P_button){
      // countdown for the states except sPG when io.P_button
      when(state =/= sPG){
        cntReg := (Ptime-1).U
      }.otherwise{
        cntReg := cntReg - 1.U
      }
    }
    .otherwise{
      cntReg := cntReg - 1.U
    }
  }

  when(io.P_button){
    // in order to distinguish the following situation:
    // 1. (P_button == 1) for all the other states 
    // 2. (cntDone == 1) when state == sHRVY
    when(state =/= sPG){
      is_p_button := 1.U(1.W)
    }
    .otherwise{
      is_p_button := 0.U(1.W)
    }
  }
  .otherwise{
    when(state === sPG){
      is_p_button := is_p_button
    }
    .otherwise{
      is_p_button := 0.U(1.W)
    }
  }
  //Counter end========================


  //Next State Decoder
  switch(state){
    is(sIdle){
      state := sHGVR
      last_state := sIdle
    }
    is(sHGVR){
      when(io.P_button){
        state := sPG
        last_state := sHGVR
      }
      .otherwise{
        when(cntDone) {
          state := sHYVR
          last_state := sHGVR
        }
      }
    }
    is(sHYVR){
      when(io.P_button){
        state := sPG
        last_state := sHYVR
      }
      .otherwise{
        when(cntDone) {
          state := sHRVG
          last_state := sHYVR
        }
      }
    }
    is(sHRVG){
      when(io.P_button){
        state := sPG
        last_state := sHRVG
      }
      .otherwise{
        when(cntDone) {
          state := sHRVY
          last_state := sHRVG
        }
      }
    }
    is(sHRVY){
      when(io.P_button){
        state := sPG
        last_state := sHRVY
      }
      .otherwise{
        when(cntDone) {
          state := sPG
          last_state := sHRVY
        }
      }
    }
    is(sPG){
      when(cntDone) {
        when(is_p_button === 1.U){
          state := last_state
          last_state := sPG
        }
        .otherwise{
          state := sHGVR
          last_state := sPG
        }
      }
    }
  }

  //Output Decoder
  //Default statement
  cntMode := 0.U
  io.H_traffic := Off
  io.V_traffic := Off

  switch(state){
    is(sHGVR){
      cntMode := 1.U
      io.H_traffic := Green
      io.V_traffic := Red
      io.P_traffic := Red
    }
    is(sHYVR){
      cntMode := 0.U
      io.H_traffic := Yellow
      io.V_traffic := Red
      io.P_traffic := Red
    }
    is(sHRVG){
      cntMode := 1.U
      io.H_traffic := Red
      io.V_traffic := Green
      io.P_traffic := Red
    }
    is(sHRVY){
      cntMode := 2.U
      io.H_traffic := Red
      io.V_traffic := Yellow
      io.P_traffic := Red
    }
    is(sPG){
      cntMode := 0.U
      io.H_traffic := Red
      io.V_traffic := Red
      io.P_traffic := Green
    }
  }

  io.timer := cntReg
}
```
![](https://course.playlab.tw/md/uploads/3cc45448-7489-4002-99fa-4aa8c8789025.png)

### Waveform
1. 前25個cycle維持原樣
![](https://course.playlab.tw/md/uploads/0f607703-c463-4c07-9a97-09c706875251.png)
2. p_putton pressed under two different situation:
    - state =/= sPG --> change to sPG (90ns), and turn back to original state (99ns)
    - state === sPG --> nothing change (125ns)
![](https://course.playlab.tw/md/uploads/48e29ff3-ecc1-4d26-abb7-da82bfdbf095.png)




## Hw5-2-1 Negative Integer Generator
### Scala Code
```scala=
package acal_lab05.Hw2

import chisel3._
import chisel3.util._

class NegIntGen extends Module{
    val io = IO(new Bundle{
        val key_in = Input(UInt(4.W))
        val value = Output(Valid(UInt(32.W)))
    })

    val equal = WireDefault(false.B)
    val l_paren = WireDefault(false.B)
    val r_paren = WireDefault(false.B)
    val neg = WireDefault(false.B)
    neg := io.key_in === 11.U
    l_paren := io.key_in === 13.U
    r_paren := io.key_in === 14.U
    equal := io.key_in === 15.U

    val sIdle :: sLParen :: sRParen :: sNeg :: sAccept :: sEqual :: Nil = Enum(6)
    val state = RegInit(sIdle)
    val is_neg = RegInit(false.B)
    val last_is_neg = RegInit(false.B)
    // record that this number is negative, cancel this condition after right parenthesis is detected(state == sRParen)
    when(state === sNeg){
        is_neg := true.B
    }
    .otherwise{
        when(state === sRParen){
            is_neg := false.B
        }
        .otherwise{
            is_neg := is_neg
        }
    }
    //Next State Decoder
    // 最後有附上state diagram所以在這裡就不贅述了，
    // 基本上就是基於原本的再加上sNeg, sLParen, sRParen
    switch(state){
        is(sIdle){
            when(l_paren) {
                state := sLParen
            }
            .otherwise{
                state := sAccept
            }
        }
        is(sAccept){
            when(r_paren){
                state := sRParen
            }
            .elsewhen(l_paren) {
                state := sLParen
            }
            .elsewhen(equal) {
                state := sEqual
            }
        }
        is(sLParen){
            when(neg){
                state := sNeg
            }
            .otherwise{
                state := sAccept
            }
        }
        is(sRParen){
            when(equal) {
                state := sEqual
            }
        }
        is(sNeg){
            state := sAccept
        }
        is(sEqual){
            state := sAccept
        }
    }

    val in_buffer = RegNext(io.key_in)

    val number = RegInit(0.U(32.W))
    when(state === sAccept){
        number := (number<<3.U) + (number<<1.U) + in_buffer
    }
    // turn the number to negative
    .elsewhen(state === sRParen){
        when(is_neg){
            number := ~(number) + 1.U(32.W)
        }
    }
    // reset
    .elsewhen(state === sEqual){
        in_buffer := 0.U
        number := 0.U
    }

    io.value.valid := Mux(state === sEqual,true.B,false.B)
    io.value.bits := number
}
```
![](https://course.playlab.tw/md/uploads/127747fe-78fe-4c2c-8f21-e97d66124e3e.png)

### Test Result

![](https://course.playlab.tw/md/uploads/48be6294-0d49-4627-a178-37ad8f3611bd.png)

![](https://course.playlab.tw/md/uploads/3bbf4dbe-212d-4097-b2a4-2b0cf695648f.png)
在紅線標注的部分可以看到數字成功被轉成負數(在state == 2, aka sRParen 且is_neg == true的cycle處理，並在最後state == 5, aka sEqual的時候順利轉為負數並輸出)

## Hw5-2-2 N operands N-1 operators(+、-)
### Scala Code
```scala=
package acal_lab05.Hw2

import chisel3._
import chisel3.util._

class LongCal extends Module{
    val io = IO(new Bundle{
        val key_in = Input(UInt(4.W))
        val value = Output(Valid(UInt(32.W)))
    })

    val equal = WireDefault(false.B)
    val l_paren = WireDefault(false.B)
    val r_paren = WireDefault(false.B)
    val neg = WireDefault(false.B)
    val operator = WireDefault(false.B)
    val num = WireDefault(false.B)

    neg := io.key_in === 11.U
    l_paren := io.key_in === 13.U
    r_paren := io.key_in === 14.U
    equal := io.key_in === 15.U
    operator := io.key_in >= 10.U && io.key_in <= 12.U
    num := io.key_in < 10.U

    val sIdle :: sLParen :: sRParen :: sNeg :: sSrc1 :: sOp :: sEqual :: Nil = Enum(7)
    val state = RegInit(sIdle)
    val is_neg = RegInit(false.B)
    val none = 0.U
    val add = 1.U
    val sub = 2.U
    val mul = 3.U
    // 延續5-2-1的實作方式
    when(state === sNeg){
        is_neg := true.B
    }
    .otherwise{
        when(state === sRParen){
            is_neg := false.B
        }
        .otherwise{
            is_neg := is_neg
        }
    }
    // 最後有附上state diagram所以在這裡就不贅述了
    switch(state){
        is(sIdle){
            when(l_paren) {
                state := sLParen
            }
            .otherwise{
                state := sSrc1
            }
        }
        is(sSrc1){
            when(r_paren){
                state := sRParen
            }
            .elsewhen(operator){
                state := sOp
            }
            .elsewhen(equal) {
                state := sEqual
            }
        }
        is(sLParen){
            when(neg){
                state := sNeg
            }
            .otherwise{
                state := sSrc1
            }
        }
        is(sRParen){
            when(equal) {
                state := sEqual
            }
            .elsewhen(operator){
                state := sOp
            }
        }
        is(sOp){
            when(num){
                state := sSrc1
            }
            .elsewhen(l_paren){
                state := sLParen
            }
        }
        is(sNeg){
            state := sSrc1
        }
        is(sEqual){
            when(l_paren) {
                state := sLParen
            }
            .elsewhen(num){
                state := sSrc1
            }
        }
    }

    val in_buffer = RegNext(io.key_in)
    val src1 = RegInit(0.U(32.W))
    val op = RegInit(0.U(2.W))
    val src2 = RegInit(0.U(32.W))

    val number = RegInit(0.U(32.W))
    when(state === sSrc1){
        src1 := (src1<<3.U) + (src1<<1.U) + in_buffer
    }
    when(state === sRParen){
        when(is_neg){
            src1 := ~(src1) + 1.U(32.W)
        }
    }
    // 因為在這題的operator不會有precedence的問題，
    // 所以一直把取到的數字連加/減到一個register(number)即可
    when(state === sOp){
        when(op === none){
            number := src1
        }
        .elsewhen(op === add){
            number := number + src1
        }
        .elsewhen(op === sub){
            number := number - src1
        }
        .elsewhen(op === mul){
            number := number * src1
        }
        src1 := 0.U
        op := in_buffer - 9.U
    }

    when(state === sEqual){
        in_buffer := 0.U
        number := 0.U
        src1 := 0.U
        op := 0.U
        is_neg := false.B
        state := sIdle
    }

    io.value.valid := Mux(state === sEqual,true.B,false.B)
    io.value.bits := MuxLookup(op,0.U,Seq(
        none -> src1,
        add -> (number + src1),
        sub -> (number - src1),
        mul -> (number * src1)
    ))
}
```
![](https://course.playlab.tw/md/uploads/f2c4019b-af33-4813-9a2b-2b00109a3d67.png)


### Test Result
![](https://course.playlab.tw/md/uploads/c4482561-74ea-48f1-9e53-9ef8985b2e40.png)

## Hw5-2-3 Order of Operation (+、-、*、(、))
- **如果你有完成Bonus部分，請在此註明。**
### Scala Code
> 請放上你的程式碼並加上註解(中英文不限)，讓 TA明白你是如何完成的。
```scala=
package acal_lab05.Hw2

import chisel3._
import chisel3.util._

class Stack(val depth: Int) extends Module {
  val io = IO(new Bundle {
    val push    = Input(Bool())
    val pop     = Input(Bool())
    val en      = Input(Bool())
    val dataIn  = Input(UInt(32.W))
    val dataOut = Output(UInt(32.W))
    val stack_elem_cnt = Output(UInt(32.W))
  })

  val stack_mem = Mem(depth, UInt(32.W))
  val sp        = RegInit(0.U(log2Ceil(depth+1).W))
  val out       = RegInit(0.U(32.W))

  when (io.en) {
    when(io.push && (sp < depth.asUInt)) {
      stack_mem(sp) := io.dataIn
      sp := sp + 1.U
    } .elsewhen(io.pop && (sp > 0.U)) {
      sp := sp - 1.U
    }
    when (sp > 0.U) {
      out := stack_mem(sp - 1.U)
    }
  }

  io.dataOut := out
  io.stack_elem_cnt := sp
}

class CpxCal extends Module{
    val io = IO(new Bundle{
        val key_in = Input(UInt(4.W))
        val value = Output(Valid(UInt(32.W)))
    })

    //please implement your code below
    io.value.valid := false.B
    io.value.bits := 0.U
    val myStack = Module(new Stack(10))
    val equal = WireDefault(false.B)
    val l_paren = WireDefault(false.B)
    val r_paren = WireDefault(false.B)
    val neg = WireDefault(false.B)
    val operator = WireDefault(false.B)
    val num = WireDefault(false.B)
    val op_is_add_sub = WireDefault(false.B)
    val key_in_is_add_sub = WireDefault(false.B)

    // initialization
    myStack.io.pop := false.B
    myStack.io.dataIn := 0.U
    myStack.io.push := false.B
    myStack.io.en := true.B

    neg := io.key_in === 11.U
    l_paren := io.key_in === 13.U
    r_paren := io.key_in === 14.U
    equal := io.key_in === 15.U
    operator := io.key_in >= 10.U && io.key_in <= 12.U
    num := io.key_in < 10.U

    val sIdle :: sLParen :: sRParen :: sNeg :: sSrc1 :: sSrc2 :: sOp :: sEqual :: Nil = Enum(8)
    val state = RegInit(sIdle)
    val is_neg = RegInit(false.B)
    val turn_neg = RegInit(0.U(2.W))
    val turn_src1_neg = 1.U
    val turn_src2_neg = 2.U
    val stack_elem_cnt = RegInit(0.U(32.W))
    val none = 0.U
    val add = 1.U
    val sub = 2.U
    val mul = 3.U
    val same_priority = RegInit(false.B)
    val left_priority_higher = RegInit(false.B)
    val in_paren = RegInit(0.U(32.W))
    val in_buffer = RegNext(io.key_in)
    val src1 = RegInit(0.U(32.W))
    val op = RegInit(0.U(32.W))
    val op_poped = RegInit(0.U(32.W))
    val last_op = RegInit(0.U(32.W)) // for fear of popping the operator immediately after push it
    val op_to_be_push = RegInit(0.U(32.W))
    val src2 = RegInit(0.U(32.W))
    val need_push_op = RegInit(false.B)
    val need_pop_src = RegInit(false.B)
    val pushed_op_type = RegInit(0.U(32.W))
    when(state === sNeg){
        is_neg := true.B
    }
    .otherwise{
        when(state === sRParen){
            is_neg := false.B
        }
        .otherwise{
            is_neg := is_neg
        }
    }

    when(is_neg){
        when(state === sSrc1){
            turn_neg := turn_src1_neg
        }
        .elsewhen(state === sSrc2){
            turn_neg := turn_src2_neg
        }
        .otherwise{
            turn_neg := turn_neg
        }
    }
    .otherwise{
        turn_neg := none
    }
    // 最下面有附上state diagram所以在這裡不再贅述了
    switch(state){
        is(sIdle){
            when(l_paren) {
                state := sLParen
            }
            .elsewhen(num){
                state := sSrc1
            }
        }
        is(sSrc1){
            when(r_paren){
                state := sRParen
            }
            .elsewhen(operator){
                state := sOp
            }
            .elsewhen(equal) {
                state := sEqual
            }
        }
        is(sSrc2){
            when(r_paren){
                state := sRParen
            }
            .elsewhen(operator){
                state := sOp
            }
            .elsewhen(equal) {
                state := sEqual
            }
        }
        is(sLParen){
            when(neg){
                state := sNeg
            }
            .elsewhen(num){
                state := sSrc1
                in_paren := in_paren + 1.U
            }
        }
        is(sRParen){
            when(equal) {
                state := sEqual
            }
            .elsewhen(operator){
                state := sOp
            }
            when(!is_neg){
                in_paren := in_paren - 1.U
            }
        }
        is(sOp){
            when(num){
                state := sSrc2
            }
            .elsewhen(l_paren){
                state := sLParen
            }
        }
        is(sNeg){
            when(src1 === 0.U){
                state := sSrc1
            }
            .otherwise{
                state := sSrc2
            }
        }
        is(sEqual){
            when(l_paren) {
                state := sLParen
            }
            .elsewhen(num){
                state := sSrc1
            }
        }
    }

    val number = RegInit(0.U(32.W))
    when(state === sSrc1){
        when(r_paren){
            src1 := ~((src1<<3.U) + (src1<<1.U) + in_buffer) + 1.U(32.W)
        }
        .otherwise{
            src1 := (src1<<3.U) + (src1<<1.U) + in_buffer
        }
    }
    // 在sSrc2的時候如果確認下一個state會換成另一個state，
    // 就依據operator的不同來提前進行運算
    .elsewhen(state === sSrc2){
        when(r_paren || operator || equal){
            // mul的precedence高，所以不會受影響，可以直接進行運算，
            // 如果是add/sub就可能會發生以下情況: 
            // A + B * C, src1 = A, src2 = B，所以直接做A +/- B會出錯
            when(op === mul){
                when(is_neg){
                    src1 := src1 * (~((src2<<3.U) + (src2<<1.U) + in_buffer) + 1.U(32.W))
                }
                .otherwise{
                    src1 := src1 * ((src2<<3.U) + (src2<<1.U) + in_buffer)
                }
                src2 := 0.U
            }
            // 但是當src1, src2的operation是被括號包起來的 e.g. (A + B) * C, 就可以在這裡先做
            .elsewhen(op === add && !is_neg){
                src1 := src1 + ((src2<<3.U) + (src2<<1.U) + in_buffer)
                src2 := 0.U
            }
            .elsewhen(op === sub && !is_neg){
                src1 := src1 - ((src2<<3.U) + (src2<<1.U) + in_buffer)
                src2 := 0.U
            }
            // 其餘狀況把值存到src2並於下一個state再決定要不要計算
            .otherwise{
                when(is_neg){
                    src2 := (~((src2<<3.U) + (src2<<1.U) + in_buffer) + 1.U(32.W))
                }
                .otherwise{
                    src2 := ((src2<<3.U) + (src2<<1.U) + in_buffer)
                }
            }
        }
        .otherwise{
            src2 := (src2<<3.U) + (src2<<1.U) + in_buffer
        }
    }
    .elsewhen(state === sRParen){
        // for the situation like A + (-B) - C,
        // there's no precedence problem
        when(io.key_in =/= 12.U){
            when(op === add && is_neg){
                src1 := src1 + src2
                src2 := 0.U
            }
            .elsewhen(op === sub && is_neg){
                src1 := src1 - src2
                src2 := 0.U
            }
        }
    }
    .elsewhen(state === sEqual){
        in_buffer := 0.U
        number := 0.U
        src1 := 0.U
        src2 := 0.U
        op := 0.U
        is_neg := false.B
        state := sIdle
    }

    // push element to stack : '+', '-', or '()'
    key_in_is_add_sub := io.key_in >= 10.U && io.key_in <= 11.U
    op_is_add_sub := op === add || op === sub
    when(operator){
        // 前後的operator是同樣的precedence就把same_priority升起
        when((key_in_is_add_sub && op_is_add_sub) || (io.key_in === 12.U && op === mul)){
            same_priority := true.B
        }
        .otherwise{
            same_priority := false.B
        }
        // 如果左邊的priority比較高，像是(A + B) * C這樣的情況
        // 就把left_priority_higher升起
        when(state === sRParen && io.key_in === 12.U && !is_neg){
            left_priority_higher := true.B
        }
        .otherwise{
            left_priority_higher := false.B
        }
    }
    .otherwise{
        same_priority := same_priority
        left_priority_higher := left_priority_higher
    }
    // 因為在sOP的時候，如果前面的operation沒有precedence問題的話，就都已經做完運算了，
    // 所以在這裡可以決定要不要把前面算好的答案或者前面因為precedence問題沒有做運算的值放進stack
    // 當前後priority不相同，左邊priority也沒有比較高，
    // 且op是none時(最一開始沒有後面的資訊可以判斷所以要檢查op是不是none來避免誤放)，
    // 把src1放進stack, switch src1, src2 
    // e.g. for A + B * C, 
    // in this cycle, src1 = A, src2 = B;
    // after this cycle, src1 = B, and expect src2 to be C, 
    // then do the operation B * C
    when(state === sOp){
        when((!same_priority && op =/= none && !left_priority_higher)){
            myStack.io.push := true.B
            myStack.io.pop := false.B
            myStack.io.dataIn := src1
            stack_elem_cnt := stack_elem_cnt + 1.U
            op_to_be_push := in_buffer
            src1 := src2
            src2 := 0.U
            // 在下一個cycle把operator放進stack
            need_push_op := true.B
        }
        op := in_buffer - 9.U
    }
    // e.g. under the situation : A * (B + C), push A to stack 
    // then do the operation B + C
    .elsewhen(state === sLParen){
        when(num && op =/= none){
            myStack.io.push := true.B
            myStack.io.pop := false.B
            myStack.io.dataIn := src1
            stack_elem_cnt := stack_elem_cnt + 1.U
            src1 := 0.U
            src2 := 0.U
            need_push_op := true.B
        }
    }

    when(need_push_op){
        myStack.io.push := true.B
        myStack.io.pop := false.B
        myStack.io.dataIn := op_to_be_push
        // 記錄下last_op, 因為要完整push資料到stack裡面必須要經過至少兩個cycle，
        // 有時候可能後面precedence比較高的operation太早做完
        // 就會在資料還沒完整push到stack之前就pop
        last_op := op + 9.U
        stack_elem_cnt := stack_elem_cnt + 1.U
        need_push_op := false.B
        // for fear of wrong operation
        op := none
    }

    // pop elements from stack
    when((state === sSrc2 && ((!is_neg && r_paren) && (io.key_in < 12.U && operator))) || state === sOp){
        when(stack_elem_cnt >= 2.U && !need_pop_src){
            myStack.io.push := false.B
            myStack.io.pop := true.B
            // 因為有可能資料還沒完整push到stack之前就pop，
            // 所以在這裡檢查stack裡面的element數量，如果是奇數(因為都是成對接續放進去的)，
            // 就代表這樣的情況發生了，所以在這裡直接assign last_op給op_poped並在之後做運算
            when(myStack.io.stack_elem_cnt % 2.U === 1.U){
                op_poped := last_op
            }
            .otherwise{
                op_poped := myStack.io.dataOut
            }
            stack_elem_cnt := stack_elem_cnt - 1.U
            need_pop_src := true.B
        }
    }

    // for the situation 11 * (12 - 3), when state == sSrc2 && pop operator
    // (12 - 3) is calculated and stored to src1
    // when pop and get 11, it should be stored to src2
    // then do the operation : src1 = src2 op src1
    when(need_pop_src){
        when(state === sRParen && ((operator && (io.key_in <= op_poped)) || equal)){
            myStack.io.push := false.B
            myStack.io.pop := true.B
            stack_elem_cnt := stack_elem_cnt - 1.U
            need_pop_src := false.B
            op_poped := none
            when(op_poped - 9.U === add){
                src1 := myStack.io.dataOut + src1
                src2 := 0.U
            }
            .elsewhen(op_poped - 9.U === sub){
                src1 := myStack.io.dataOut - src1
                src2 := 0.U
            }
            .elsewhen(op_poped - 9.U === mul){
                src1 := myStack.io.dataOut * src1
                src2 := 0.U
            }
        }
    }
    io.value.valid := Mux(state === sEqual,true.B,false.B)
    io.value.bits := src1
}
```
![](https://course.playlab.tw/md/uploads/6f3a4b97-780f-4d5b-941a-49e44a930e8e.png)

### Test Result
![](https://course.playlab.tw/md/uploads/0153c642-b43f-4d5e-9384-0a5ed1afd880.png)


## Hw5-3-1 Pseudo Random Number Generator
### Scala Code
> 請放上你的程式碼並加上註解(中英文不限)，讓 TA明白你是如何完成的。
```scala=
package acal_lab05.Hw3

import chisel3._
import chisel3.util._
import acal_lab05.Lab3._
class PRNG(seed:Int) extends Module{
    val io = IO(new Bundle{
        val gen = Input(Bool())
        val puzzle = Output(Vec(4,UInt(4.W)))
        val ready = Output(Bool())
    })

    val _LFSR = Module(new LFSR_Galois(16))
    val num_random = Wire(Vec(4, UInt(4.W)))
    val num_generated = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
    _LFSR.io.seed.valid := io.gen
    _LFSR.io.seed.bits := seed.asUInt
    num_random(0) := _LFSR.io.rndNum(3, 0)
    num_random(1) := _LFSR.io.rndNum(7, 4)
    num_random(2) := _LFSR.io.rndNum(11, 8)
    num_random(3) := _LFSR.io.rndNum(15, 12)
    val sIdle :: sGen_num1 :: sGen_num2 :: sGen_num3 :: sGen_num4 :: sDone :: Nil = Enum(6)
    val state = RegInit(sIdle)

    // 基本上在這裡的做法就是很Naive的去檢查做modulo之後的數值跟前面有沒有重複，
    // 沒有的話才進下一個state，
    // 如果是要用很general的做法的話可以在外面改成for loop
    // 但是因為1A2B固定是要gen四個不同的random number所以就直接寫死了
    switch(state){
        is(sIdle){
            state := sGen_num1
        }
        is(sGen_num1){
            num_generated(0) := num_random(0)%10.U
            state := sGen_num2
        }
        is(sGen_num2){
            when(num_generated(0) =/= num_random(0)%10.U){
                num_generated(1) := num_random(0)%10.U
                state := sGen_num3
            }
            .elsewhen(num_generated(0) =/= num_random(1)%10.U){
                num_generated(1) := num_random(1)%10.U
                state := sGen_num3
            }
            .elsewhen(num_generated(0) =/= num_random(2)%10.U){
                num_generated(1) := num_random(2)%10.U
                state := sGen_num3
            }
            .elsewhen(num_generated(0) =/= num_random(3)%10.U){
                num_generated(1) := num_random(3)%10.U
                state := sGen_num3
            }
            .otherwise{
                state := sGen_num2
            }
        }
        is(sGen_num3){
            when((num_generated(0) =/= num_random(0)%10.U) && (num_generated(1) =/= num_random(0)%10.U)){
                num_generated(2) := num_random(0)%10.U
                state := sGen_num4
            }
            .elsewhen((num_generated(0) =/= num_random(1)%10.U) && (num_generated(1) =/= num_random(1)%10.U)){
                num_generated(2) := num_random(1)%10.U
                state := sGen_num4
            }
            .elsewhen((num_generated(0) =/= num_random(2)%10.U) && (num_generated(1) =/= num_random(2)%10.U)){
                num_generated(2) := num_random(2)%10.U
                state := sGen_num4
            }
            .elsewhen((num_generated(0) =/= num_random(3)%10.U) && (num_generated(1) =/= num_random(3)%10.U)){
                num_generated(2) := num_random(3)%10.U
                state := sGen_num4
            }
            .otherwise{
                state := sGen_num3
            }
        }
        is(sGen_num4){
            when((num_generated(0) =/= num_random(0)%10.U) && (num_generated(1) =/= num_random(0)%10.U) && (num_generated(2) =/= num_random(0)%10.U)){
                num_generated(3) := num_random(0)%10.U
                state := sDone
            }
            .elsewhen((num_generated(0) =/= num_random(1)%10.U) && (num_generated(1) =/= num_random(1)%10.U) && (num_generated(2) =/= num_random(1)%10.U)){
                num_generated(3) := num_random(1)%10.U
                state := sDone
            }
            .elsewhen((num_generated(0) =/= num_random(2)%10.U) && (num_generated(1) =/= num_random(2)%10.U) && (num_generated(2) =/= num_random(2)%10.U)){
                num_generated(3) := num_random(2)%10.U
                state := sDone
            }
            .elsewhen((num_generated(0) =/= num_random(3)%10.U) && (num_generated(1) =/= num_random(3)%10.U) && (num_generated(2) =/= num_random(3)%10.U)){
                num_generated(3) := num_random(3)%10.U
                state := sDone
            }
            .otherwise{
                state := sGen_num4
            }
        }
        is(sDone){
            state := sIdle
        }
    }
    for(i <- 0 until 4) {
        io.puzzle(i) := num_generated(i)
    }
    when(state === sDone){
        for(i <- 0 until 4) {
            num_generated(i) := 0.U
        }
        io.ready := true.B
    }
    .otherwise{
        io.ready := false.B
    }
}

```
![](https://course.playlab.tw/md/uploads/6e8ab4be-8d77-499f-a042-f5bf84ec9586.png)

### Test Result
![](https://course.playlab.tw/md/uploads/128719b9-a17a-48b7-a439-ee8c86a030eb.png)


## Hw5-3-2 1A2B game quiz
### Scala Code
```scala=
package acal_lab05.Hw3

import chisel3._
import chisel3.util._

class NumGuess(seed:Int = 1) extends Module{
    require (seed > 0 , "Seed cannot be 0")

    val io  = IO(new Bundle{
        val gen = Input(Bool())
        val guess = Input(UInt(16.W))
        val puzzle = Output(Vec(4,UInt(4.W)))
        val ready  = Output(Bool())
        val g_valid  = Output(Bool())
        val A      = Output(UInt(3.W))
        val B      = Output(UInt(3.W))

        //don't care at Hw6-3-2 but should be considered at Bonus
        val s_valid = Input(Bool())
    })

    val generator = Module(new PRNG(seed))
    val sIdle :: sCheck_num1 :: sCheck_num2 :: sCheck_num3 :: sCheck_num4 :: sDone :: Nil = Enum(6)
    val state = RegInit(sIdle)
    val count_A = RegInit(0.U(3.W))
    val count_B = RegInit(0.U(3.W))
    val digit_guessed = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
    val the_puzzle = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
    val gen_new = RegInit(false.B)
    when(io.gen){
        gen_new := true.B
    }
    generator.io.gen := io.gen
    io.puzzle := generator.io.puzzle
    io.ready  := generator.io.ready
    when(generator.io.ready && gen_new){
        the_puzzle(0) := generator.io.puzzle(0)
        the_puzzle(1) := generator.io.puzzle(1)
        the_puzzle(2) := generator.io.puzzle(2)
        the_puzzle(3) := generator.io.puzzle(3)
        gen_new := false.B
    }
    when(generator.io.ready){
        digit_guessed(0) := io.guess(3, 0)
        digit_guessed(1) := io.guess(7, 4)
        digit_guessed(2) := io.guess(11, 8)
        digit_guessed(3) := io.guess(15, 12)
    }
    // 在這裡基本上就是在ready之後接續檢查每個digit是A還是B或者都沒有
    // 然後去更新count_A, count_B
    switch(state){
        is(sIdle){
            when(generator.io.ready || io.g_valid){
                state := sCheck_num1
            }
        }
        is(sCheck_num1){
            // calculate A, B
            when(digit_guessed(0) === the_puzzle(0)){
                count_A := count_A + 1.U
            }
            .elsewhen(digit_guessed(0) === the_puzzle(1)){
                count_B := count_B + 1.U
            }
            .elsewhen(digit_guessed(0) === the_puzzle(2)){
                count_B := count_B + 1.U
            }
            .elsewhen(digit_guessed(0) === the_puzzle(3)){
                count_B := count_B + 1.U
            }
            state := sCheck_num2
        }
        is(sCheck_num2){
            // calculate A, B
            when(digit_guessed(1) === the_puzzle(0)){
                count_B := count_B + 1.U
            }
            .elsewhen(digit_guessed(1) === the_puzzle(1)){
                count_A := count_A + 1.U
            }
            .elsewhen(digit_guessed(1) === the_puzzle(2)){
                count_B := count_B + 1.U
            }
            .elsewhen(digit_guessed(1) === the_puzzle(3)){
                count_B := count_B + 1.U
            }
            state := sCheck_num3
        }
        is(sCheck_num3){
            // calculate A, B
            when(digit_guessed(2) === the_puzzle(0)){
                count_B := count_B + 1.U
            }
            .elsewhen(digit_guessed(2) === the_puzzle(1)){
                count_B := count_B + 1.U
            }
            .elsewhen(digit_guessed(2) === the_puzzle(2)){
                count_A := count_A + 1.U
            }
            .elsewhen(digit_guessed(2) === the_puzzle(3)){
                count_B := count_B + 1.U
            }
            state := sCheck_num4
        }
        is(sCheck_num4){
            // calculate A, B
            when(digit_guessed(3) === the_puzzle(0)){
                count_B := count_B + 1.U
            }
            .elsewhen(digit_guessed(3) === the_puzzle(1)){
                count_B := count_B + 1.U
            }
            .elsewhen(digit_guessed(3) === the_puzzle(2)){
                count_B := count_B + 1.U
            }
            .elsewhen(digit_guessed(3) === the_puzzle(3)){
                count_A := count_A + 1.U
            }
            state := sDone
        }
        is(sDone){
            state := sIdle
        }
    }
    when(state === sDone){
        io.g_valid  := true.B
        io.A      := count_A
        io.B      := count_B
        count_A := 0.U
        count_B := 0.U
    }
    .otherwise{
        io.g_valid  := false.B
        io.A      := 0.U
        io.B      := 0.U
    }
}
```
![](https://course.playlab.tw/md/uploads/20c4f596-b0c2-4fe0-8eec-a09c68f30733.png)

### Test Result
![](https://course.playlab.tw/md/uploads/5fa0b2a3-546e-4c67-a405-0e917ea42c55.png)


## Bonus : 1A2B hardware solver [Optional]
### Scala Code
> 請放上你的程式碼並加上註解(中英文不限)，讓 TA明白你是如何完成的。
```scala=
## scala code & comment
```
### Test Result
> 請放上你通過test的結果，驗證程式碼的正確性。(螢幕截圖即可)


## 文件中的問答題
- Q1:Hw5-2-2(長算式)以及Lab5-2-2(短算式)，需要的暫存器數量是否有差別？如果有，是差在哪裡呢？
    - Ans1:我有多用一個register去紀錄src是不是negative，至於number, src1還有src1, src2就只是加的方式不同(我後來沒有用上src2而是另外再弄一個register叫number去記錄累加的答案)，在數量上沒有差距，其實也可以把src1當作number然後state不斷在sSrc2那邊做處理就是了，基本上就是意義上不太一樣
- Q2:你是如何處理**Hw5-2-3**有提到的關於**編碼衝突**的問題呢?
    - Ans2:我的實作不會有編碼衝突的問題，因為我一定是以operator以及source為一組接續放進去stack裡面
- Q3:你是如何處理**Hw5-3-1**1A2B題目產生時**數字重複**的問題呢?
    - Ans3:基本上就是很Naive的一個一個去檢查跟前面已經gen出來的數字有沒有不一樣。


## 意見回饋和心得(可填可不填)

