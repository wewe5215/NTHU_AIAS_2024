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
  // val one = RegInit(1.U(4.W))
  val not_in_2 = ~io.in_2
  val FA_Array = Array.fill(4)(Module(new FullAdder()).io)
  val carry = Wire(Vec(4+1, UInt(1.W)))
  val sum   = Wire(Vec(4, Bool()))

  //please implement your code below
  when(io.op === false.B){
    carry(0) := RegInit(0.U(4.W))
    for(i <- 0 until 4){
      FA_Array(i).A := io.in_1(i)
      FA_Array(i).B := io.in_2(i)
      FA_Array(i).Cin := carry(i)
      carry(i+1) := FA_Array(i).Cout
      sum(i) := FA_Array(i).Sum
    }
    when((io.in_1(3) === io.in_2(3)) && (sum(3) =/= io.in_2(3))){
      io.o_f := true.B
    }
    .otherwise{
      io.o_f := false.B
    }
  }
  .otherwise{
    carry(0) := RegInit(1.U(4.W))
    for(i <- 0 until 4){
      FA_Array(i).A := io.in_1(i)
      FA_Array(i).B := not_in_2(i)
      FA_Array(i).Cin := carry(i)
      carry(i+1) := FA_Array(i).Cout
      sum(i) := FA_Array(i).Sum
    }
    when((io.in_1(3) === not_in_2(3)) && (sum(3) =/= not_in_2(3))){
      io.o_f := true.B
    }
    .otherwise{
      io.o_f := false.B
    }
  }
  io.out := sum.asUInt
}
