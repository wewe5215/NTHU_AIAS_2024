package acal_lab04.Hw4

import chisel3._
import chisel3.util._


object ALU_funct3{
  val ADD_SUB = 0.U
  val SLL     = 1.U
  val SLT     = 2.U
  val SLTU    = 3.U
  val XOR     = 4.U
  val SRL_SRA = 5.U
  val OR      = 6.U
  val AND     = 7.U
}

object ALU_funct7{
  val SUB_SRA = "b0100000".U
}

import ALU_funct3._,ALU_funct7._,opcode_map._

class ALUIO extends Bundle{
  val src1    = Input(UInt(32.W))
  val src2    = Input(UInt(32.W))
  val funct3  = Input(UInt(3.W))
  val funct7 = Input(UInt(7.W))
  val opcode  = Input(UInt(7.W))
  val out  = Output(UInt(32.W))
}

class ALU extends Module{
  val io = IO(new ALUIO)

  io.out := MuxLookup(io.opcode,0.U,Seq(
    OP_IMM -> MuxLookup(io.funct3,0.U,Seq(
      ADD_SUB -> (io.src1+io.src2),
      SLL     -> (io.src1 << io.src2(4, 0)),
      SLT     -> Mux(
                  io.src1.asSInt < io.src2.asSInt,
                  1.U,
                  0.U
      ),
      SLTU    -> Mux(
                  io.src1.asUInt < io.src2.asUInt,
                  1.U,
                  0.U
      ),
      XOR     -> (io.src1 ^ io.src2),
      SRL_SRA -> Mux(
                  io.funct7 === SUB_SRA,
                  (io.src1.asSInt >> io.src2(4, 0)).asUInt,
                  io.src1 >> io.src2(4, 0)

      ),
      OR      -> (io.src1 | io.src2),
      AND     -> (io.src1 & io.src2),
    )),

    OP    ->  MuxLookup(io.funct3,0.U,Seq(
      ADD_SUB -> Mux(
                  io.funct7 === SUB_SRA,
                  io.src1 - io.src2(4, 0),
                  io.src1 + io.src2(4, 0)
      ),
      SLL     -> (io.src1 << io.src2(4, 0)),
      SLT     -> Mux(
                  io.src1.asSInt < io.src2.asSInt,
                  1.U,
                  0.U
      ),
      SLTU    -> Mux(
                  io.src1.asUInt < (io.src2(4, 0)).asUInt,
                  1.U,
                  0.U
      ),
      XOR     -> (io.src1 ^ io.src2),
      SRL_SRA -> Mux(
                  io.funct7 === SUB_SRA,
                  (io.src1.asSInt >> io.src2(4, 0)).asUInt,
                  io.src1 >> io.src2(4, 0)

      ),
      OR      -> (io.src1 | io.src2),
      AND     -> (io.src1 & io.src2),
    )),
    JALR  -> (io.src1+io.src2),
    JAL   -> (io.src1+io.src2),
    BRANCH -> (io.src1+io.src2)
  ))

}