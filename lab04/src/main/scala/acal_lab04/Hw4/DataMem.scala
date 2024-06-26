package acal_lab04.Hw4

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile


object wide {
  val Byte = 0.U
  val Half = 1.U
  val Word = 2.U
  val UByte = 4.U
  val UHalf = 5.U
}

import wide._

class DataMem extends Module {
  val io = IO(new Bundle {
    val funct3 = Input(UInt(32.W))
    val raddr = Input(UInt(10.W))
    val rdata = Output(SInt(32.W))

    val wen   = Input(Bool())
    val waddr = Input(UInt(10.W))
    val wdata = Input(UInt(32.W))
  })

  val memory = Mem(32, UInt(8.W))
  loadMemoryFromFile(memory, "./src/main/resource/DataMem.txt")
  // print out and check
  // for(i <- 0 until 32) {
  //   printf("Memory[%d] = %x\n", i.U, memory.read(i.U))
  // }

  io.rdata := 0.S

  val wa = WireDefault(0.U(10.W)) //address
  val wd = WireDefault(0.U(32.W)) //data

  wa := MuxLookup(io.funct3,0.U(10.W),Seq(
    Byte -> io.waddr,
    Half -> Cat(io.waddr(9, 1), 0.U(1.W)), // needs to be changed
    Word -> Cat(io.waddr(9, 2), 0.U(2.W)), // needs to be changed
  ))

  wd := MuxLookup(io.funct3,0.U,Seq(
    Byte -> io.wdata, // needs to be changed
    Half -> io.wdata, // needs to be changed
    Word -> io.wdata,
  ))

  when(io.wen){ //STORE
    when(io.funct3===Byte){
      memory(wa) := wd(7,0)
    }.elsewhen(io.funct3===Half){
      //Please fill in the blanks by yourself
      memory(wa) := wd(7,0)
      memory(wa+1.U) := wd(15,8)
    }.elsewhen(io.funct3===Word){
      //Please fill in the blanks by yourself
      memory(wa) := wd(7,0)
      memory(wa+1.U) := wd(15,8)
      memory(wa+2.U) := wd(23,16)
      memory(wa+3.U) := wd(31,24)
    }
  }
  .otherwise{ //LOAD
    io.rdata := MuxLookup(io.funct3,0.S,Seq(
      Byte -> memory(io.raddr).asSInt,
      Half -> Cat(memory(io.raddr+1.U)(7, 0), memory(io.raddr)(7, 0)).asSInt, // needs to be changed
      Word -> Cat(memory(io.raddr+3.U)(7, 0), memory(io.raddr+2.U)(7, 0), memory(io.raddr+1.U)(7, 0), memory(io.raddr)(7, 0)).asSInt, // needs to be changed
      UByte -> Cat(0.S(24.W), memory(io.raddr)(7, 0)).asSInt, // needs to be changed
      UHalf -> Cat(0.S(16.W), memory(io.raddr+1.U)(7, 0), memory(io.raddr)(7, 0)).asSInt // needs to be changed
    ))
  }
}