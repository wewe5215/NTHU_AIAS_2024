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
    .elsewhen(state === sRParen){
        when(is_neg){
            number := ~(number) + 1.U(32.W)
        }
    }
    .elsewhen(state === sEqual){
        in_buffer := 0.U
        number := 0.U
    }

    io.value.valid := Mux(state === sEqual,true.B,false.B)
    io.value.bits := number
}