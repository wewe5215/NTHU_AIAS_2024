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
    //Next State Decoder
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

    .elsewhen(state === sSrc2){
        when(r_paren || operator || equal){
            when(op === mul){
                when(is_neg){
                    src1 := src1 * (~((src2<<3.U) + (src2<<1.U) + in_buffer) + 1.U(32.W))
                }
                .otherwise{
                    src1 := src1 * ((src2<<3.U) + (src2<<1.U) + in_buffer)
                }
                src2 := 0.U
            }
            .elsewhen(op === add && !is_neg){
                src1 := src1 + ((src2<<3.U) + (src2<<1.U) + in_buffer)
                src2 := 0.U
            }
            .elsewhen(op === sub && !is_neg){
                src1 := src1 - ((src2<<3.U) + (src2<<1.U) + in_buffer)
                src2 := 0.U
            }
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
        when((key_in_is_add_sub && op_is_add_sub) || (io.key_in === 12.U && op === mul)){
            same_priority := true.B
        }
        .otherwise{
            same_priority := false.B
        }

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

    when(state === sOp){
        when((!same_priority && op =/= none && !left_priority_higher)){
            myStack.io.push := true.B
            myStack.io.pop := false.B
            myStack.io.dataIn := src1
            stack_elem_cnt := stack_elem_cnt + 1.U
            op_to_be_push := in_buffer
            src1 := src2
            src2 := 0.U
            need_push_op := true.B
        }
        op := in_buffer - 9.U
    }
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
        last_op := op + 9.U
        stack_elem_cnt := stack_elem_cnt + 1.U
        need_push_op := false.B
        // TODO : use a memory array to store the operators pushed to the stack
        op := none
    }

    // pop elements from stack
    when((state === sSrc2 && ((!is_neg && r_paren) && (io.key_in < 12.U && operator))) || state === sOp){
        when(stack_elem_cnt >= 2.U && !need_pop_src){
            myStack.io.push := false.B
            myStack.io.pop := true.B
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
    //                  MuxLookup(op,0.U,Seq(
    //     none -> src1,
    //     add -> (src1 + src2),
    //     sub -> (src1 - src2),
    //     mul -> (src1 * src2)
    // ))
}