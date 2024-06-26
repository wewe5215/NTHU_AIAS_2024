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