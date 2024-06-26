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

  //operation
  val weight = Wire(Vec(width/2, UInt(3.W)))
  val partial_product = Wire(Vec(width/2, SInt((2*width).W)))
  weight(0) := Cat(io.in2(1), io.in2(0), 0.U)
  for(i <- 1 until width/2){
    weight(i) := Cat(io.in2(2*i + 1), io.in2(2*i + 0), io.in2(2*i - 1))
  }
  for(i <- 0 until width / 2) {
    partial_product(i) := 0.S((2 * width).W).asSInt
  }
  val accumulation = Wire(Vec(width/2 - 1, SInt((2*width).W)))
  //partial product
  for(i <- 0 until (width/2)){
    switch(weight(i)){
      is(0.U){
        partial_product(i) := 0.S((2 * width).W)
      }
      is(1.U){
        partial_product(i) := (io.in1).asSInt.pad(2 * width) << (i*2)
      }
      is(2.U){
        partial_product(i) := (io.in1).asSInt.pad(2 * width) << (i*2)
      }
      is(3.U){
        partial_product(i) := ((io.in1)).asSInt.pad(2 * width) << 1 << (i*2)
      }
      is(4.U){
        partial_product(i) := (((~io.in1)).asSInt.pad(2 * width) + 1.S((2 * width).W)) << 1 << (i*2)
      }
      is(5.U){
        partial_product(i) := (((~(io.in1))).asSInt.pad(2 * width) + 1.S((2 * width).W)) << (i*2)
      }
      is(6.U){
        partial_product(i) := ((~(io.in1)).asSInt.pad(2 * width) + 1.S((2 * width).W)) << (i*2)
      }
      is(7.U){
        partial_product(i) := 0.S((2 * width).W)
      }
    }
  }
  accumulation(0) := partial_product(0) + partial_product(1)
  for(i <- 1 until (width/2 - 1)){
    accumulation(i) := accumulation(i - 1) + partial_product(i + 1)
  }
  io.out := accumulation((width/2-1) - 1).asUInt
}

