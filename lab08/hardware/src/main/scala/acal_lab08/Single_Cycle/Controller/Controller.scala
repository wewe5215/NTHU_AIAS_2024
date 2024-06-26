package acal_lab08.Single_Cycle.Controller

import chisel3._
import chisel3.util._


object opcode_map {
    val LOAD      = "b0000011".U
    val STORE     = "b0100011".U
    val BRANCH    = "b1100011".U
    val JALR      = "b1100111".U
    val JAL       = "b1101111".U
    val OP_IMM    = "b0010011".U
    val OP        = "b0110011".U
    val AUIPC     = "b0010111".U
    val LUI       = "b0110111".U
    val HCF       = "b0001011".U
}

object ALU_op{
  val ADD  = 0.U
  val SLL  = 1.U
  val SLT  = 2.U
  val SLTU = 3.U
  val XOR  = 4.U
  val SRL  = 5.U
  val OR   = 6.U
  val AND  = 7.U
  val SUB  = 8.U
  val SRA  = 13.U
}

object condition{
  val EQ = "b000".U
  val NE = "b001".U
  val LT = "b100".U
  val GE = "b101".U
  val LTU = "b110".U
  val GEU = "b111".U
}

import opcode_map._,condition._,ALU_op._

class Controller extends Module {
    val io = IO(new Bundle{
        val Inst = Input(UInt(32.W))
        val BrEq = Input(Bool())
        val BrLT = Input(Bool())

        val PCSel = Output(Bool())
        val ImmSel = Output(UInt(3.W))
        val RegWEn = Output(Bool())
        val BrUn = Output(Bool())
        val BSel = Output(Bool())
        val ASel = Output(Bool())
        val ALUSel = Output(UInt(4.W))
        val MemRW = Output(Bool())
        val WBSel = Output(UInt(2.W))

        //new
        val Lui = Output(Bool())
        val Hcf = Output(Bool())
    })

    val opcode = Wire(UInt(7.W))
    opcode := io.Inst(6,0)

    val funct3 = Wire(UInt(3.W))
    funct3 := io.Inst(14,12)

    val funct7 = Wire(UInt(7.W))
    funct7 := io.Inst(31,25)

    //Control signal
    io.RegWEn := MuxLookup(opcode,true.B,Seq(
        STORE -> false.B,
        BRANCH -> false.B
    ))
    io.ASel := MuxLookup(opcode,false.B,Seq(
        BRANCH -> true.B,
        AUIPC -> true.B,
        JAL -> true.B
    ))
    io.BSel := MuxLookup(opcode,true.B,Seq(
        OP -> false.B
    ))
    io.BrUn := Mux(
      opcode === BRANCH,
      MuxLookup(funct3,false.B,Seq(
          LTU -> true.B,
          GEU -> true.B
      )),
      false.B
    )
    io.MemRW := Mux(
      opcode === STORE,
      true.B,
      false.B
    )
    io.ImmSel := MuxLookup(opcode,0.U,Seq(
        OP -> 0.U,
        OP_IMM -> 1.U,
        LOAD -> 1.U,
        STORE -> 2.U,
        BRANCH -> 3.U,
        JALR -> 1.U,
        JAL -> 4.U,
        AUIPC -> 5.U,
        LUI -> 5.U,

    ))
    io.ALUSel := MuxLookup(opcode,0.U,Seq(
      LOAD -> ADD,
      STORE -> ADD,
      BRANCH -> ADD,
      JALR -> ADD,
      JAL -> ADD,
      OP_IMM -> MuxLookup(funct3,0.U,Seq(
        ADD -> ADD,
        SLL -> SLL,
        SLT -> SLT,
        SLTU -> SLTU,
        XOR -> XOR,
        SRL -> Mux(
          funct7 === "b0000000".U,
          SRL,
          SRA
        ),
        OR -> OR,
        AND -> AND,

      )),
      OP -> MuxLookup(funct3,0.U,Seq(
        ADD -> Mux(
          funct7 === "b0000000".U,
          ADD,
          SUB
        ),
        SLL -> SLL,
        SLT -> SLT,
        SLTU -> SLTU,
        XOR -> XOR,
        SRL -> Mux(
          funct7 === "b0000000".U,
          SRL,
          SRA
        ),
        OR -> OR,
        AND -> AND,

      )),
      AUIPC -> ADD,
      LUI -> ADD
    ))
    io.PCSel := MuxLookup(opcode,false.B,Seq(
      BRANCH -> true.B,
      JALR -> true.B,
      JAL -> true.B,
    ))
    io.WBSel := MuxLookup(opcode,1.U(2.W),Seq(
      OP -> 1.U,
      OP_IMM -> 1.U,
      LOAD -> 0.U,
      BRANCH -> 2.U,
      JAL -> 2.U,
      JALR -> 2.U
    ))
    io.Lui := opcode === LUI
    io.Hcf := opcode === HCF
}