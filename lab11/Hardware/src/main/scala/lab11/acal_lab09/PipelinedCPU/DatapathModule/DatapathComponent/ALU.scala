package acal_lab09.PiplinedCPU.DatapathModule.DatapathComponent

import chisel3._
import chisel3.util._

import acal_lab09.PiplinedCPU.opcode_map._
import acal_lab09.PiplinedCPU.alu_op_map._

class ALUIO extends Bundle{
  val src1    = Input(UInt(32.W))
  val src2    = Input(UInt(32.W))
  val ALUSel  = Input(UInt(15.W))
  val out  = Output(UInt(32.W))
}

class ALU extends Module{
  val io = IO(new ALUIO)
  
  val result = Wire(Vec(5, Bool()))
  val val16  = Wire(UInt(16.W))
  val val8   = Wire(UInt(8.W))
  val val4   = Wire(UInt(4.W))

  result(0) := 0.U
  result(1) := 0.U
  result(2) := 0.U
  result(3) := 0.U
  result(4) := 0.U
  val16  := 0.U
  val8   := 0.U
  val4   := 0.U

  io.out := 0.U
  switch(io.ALUSel){
    is(ADD ){io.out := io.src1+io.src2}
    is(SLL ){io.out := io.src1 << io.src2(4,0)}
    is(SLT ){io.out := Mux(io.src1.asSInt < io.src2.asSInt,1.U,0.U)}
    is(SLTU){io.out := Mux(io.src1 < io.src2              ,1.U,0.U)}
    is(XOR ){io.out := io.src1 ^ io.src2}
    is(SRL ){io.out := io.src1 >> io.src2(4,0)}
    is(OR  ){io.out := io.src1 | io.src2}
    is(AND ){io.out := io.src1 & io.src2}
    is(SUB ){io.out := io.src1 - io.src2}
    is(SRA ){io.out := (io.src1.asSInt >> io.src2(4,0)).asUInt}
    is(CLZ ){
      result(4) := (io.src1(31,16) === 0.U)
      val16     := Mux(result(4), io.src1(15,0), io.src1(31,16))
      result(3) := (val16(15,8) === 0.U)
      val8      := Mux(result(3), val16(7,0), val16(15,8))
      result(2) := (val8(7,4) === 0.U)
      val4      := Mux(result(2), val8(3,0), val8(7,4))
      result(1) := (val4(3,2) === 0.U)
      result(0) := Mux(result(1), ~val4(1), ~val4(3))
      io.out := Cat(result(4), result(3), result(2), result(1), result(0)).asUInt
    }
    is(CTZ ){
      result(4) := (io.src1(15,0) === 0.U)
      val16     := Mux(result(4), io.src1(31,16), io.src1(15,0))
      result(3) := (val16(7,0) === 0.U)
      val8      := Mux(result(3), val16(15,8), val16(7,0))
      result(2) := (val8(3,0) === 0.U)
      val4      := Mux(result(2), val8(7,4), val8(3,0))
      result(1) := (val4(1,0) === 0.U)
      result(0) := Mux(result(1), val4(3), val4(1))
      io.out := Cat(result(4), result(3), result(2), result(1), result(0)).asUInt
    }
    is(CPOP){
      val result = Wire(UInt(5.W))
      result := PopCount(io.src1)
      io.out := result
    }
    is(ANDN){io.out := io.src1 & ~io.src2}
    is(ORN ){io.out := io.src1 | ~io.src2}
    is(XNOR){io.out := io.src1 ^ ~io.src2}
    is(MIN ){io.out := Mux(io.src1.asSInt < io.src2.asSInt, io.src1, io.src2)}
    is(MAX ){io.out := Mux(io.src1.asSInt < io.src2.asSInt, io.src2, io.src1)}
    is(MINU){io.out := Mux(io.src1 < io.src2              , io.src1, io.src2)}
    is(MAXU){io.out := Mux(io.src1 < io.src2              , io.src2, io.src1)}
    is(SEXT_B){io.out := Cat(Fill(24, io.src1(7)), io.src1(7,0)).asUInt}
    is(SEXT_H){io.out := Cat(Fill(16, io.src1(15)), io.src1(15,0)).asUInt}
    is(BSET ){io.out := io.src1 | (1.U << (io.src2(4,0) & 31.U))}
    is(BCLR ){io.out := io.src1 & ~(1.U << (io.src2(4,0) & 31.U))}

    is(BINV ){io.out := io.src1 ^ (1.U << (io.src2(4,0) & 31.U))}
    is(BEXT ){io.out := (io.src1 >> (io.src2(4,0) & 31.U))(0)}
    is(ROR  ){io.out := (io.src1 >> (io.src2(4,0) & 31.U)) | (io.src1 << (32.U - (io.src2(4,0) & 31.U)))}
    is(ROL  ){io.out := (io.src1 << (io.src2(4,0) & 31.U)) | (io.src1 >> (32.U - (io.src2(4,0) & 31.U)))}
    is(SH1ADD){io.out := io.src2 + (io.src1 << 1.U)}
    is(SH2ADD){io.out := io.src2 + (io.src1 << 2.U)}
    is(SH3ADD){io.out := io.src2 + (io.src1 << 3.U)}
    is(REV8  ){io.out := Cat(io.src1(7,0), io.src1(15,8), io.src1(23,16), io.src1(31,24))}
    is(ZEXT_H){io.out := io.src1 & 0xFFFF.U}
    is(ORC_B ){io.out := Cat(
      Mux(((io.src1(31, 24) & 0xFF.U) === 0.U), 0.U, 0xFF.U),
      Mux(((io.src1(23, 16) & 0xFF.U) === 0.U), 0.U, 0xFF.U),
      Mux(((io.src1(15, 8) & 0xFF.U) === 0.U), 0.U, 0xFF.U),
      Mux(((io.src1(7, 0) & 0xFF.U) === 0.U), 0.U, 0xFF.U),
    )}

    is(MUL  ){io.out := io.src1 * io.src2}
  }
}

