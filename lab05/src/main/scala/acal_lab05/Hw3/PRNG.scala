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
