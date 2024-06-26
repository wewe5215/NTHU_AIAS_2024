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