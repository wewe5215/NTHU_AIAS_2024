package acal_lab05.Bonus

import chisel3._
import chisel3.util._
import acal_lab05.Hw3.NumGuess

class top extends Module{
    val io  = IO(new Bundle{
        val gen = Input(Bool())
        val finish = Output(Bool())
    })

    io.finish := false.B
}