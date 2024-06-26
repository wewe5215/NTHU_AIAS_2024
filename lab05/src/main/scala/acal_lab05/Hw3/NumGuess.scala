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