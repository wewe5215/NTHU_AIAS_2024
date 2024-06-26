package acal_lab09.PiplinedCPU.Controller

import chisel3._
import chisel3.util._

import acal_lab09.PiplinedCPU.opcode_map._
import acal_lab09.PiplinedCPU.condition._
import acal_lab09.PiplinedCPU.inst_type._
import acal_lab09.PiplinedCPU.alu_op_map._
import acal_lab09.PiplinedCPU.pc_sel_map._
import acal_lab09.PiplinedCPU.wb_sel_map._
import acal_lab09.PiplinedCPU.forwarding_sel_map._

class Controller(memAddrWidth: Int) extends Module {
  val io = IO(new Bundle {
    // Memory control signal interface
    val IM_Mem_R = Output(Bool())
    val IM_Mem_W = Output(Bool())
    val IM_Length = Output(UInt(4.W))
    val IM_Valid = Input(Bool())

    val DM_Mem_R = Output(Bool())
    val DM_Mem_W = Output(Bool())
    val DM_Length = Output(UInt(4.W))
    val DM_Valid = Input(Bool())

    // branch Comp.
    val E_BrEq = Input(Bool())
    val E_BrLT = Input(Bool())

    // Branch Prediction
    val E_Branch_taken = Output(Bool())
    val E_En = Output(Bool())

    val ID_pc = Input(UInt(memAddrWidth.W))
    val EXE_target_pc = Input(UInt(memAddrWidth.W))

    // Flush
    val Flush_DH = Output(Bool()) //TBD
    val Flush_BH = Output(Bool()) //TBD

    // Stall
    // To Be Modified
    val Stall_DH = Output(Bool()) //TBD
    val Stall_MA = Output(Bool()) //TBD

    // inst
    val IF_Inst = Input(UInt(32.W))
    val ID_Inst = Input(UInt(32.W))
    val EXE_Inst = Input(UInt(32.W))
    val MEM_Inst = Input(UInt(32.W))
    val WB_Inst = Input(UInt(32.W))

    // sel
    val PCSel = Output(UInt(2.W))
    val D_ImmSel = Output(UInt(3.W))
    val W_RegWEn = Output(Bool())
    val E_BrUn = Output(Bool())
    val E_ASel = Output(UInt(2.W))
    val E_BSel = Output(UInt(1.W))
    val E_ALUSel = Output(UInt(15.W))
    val W_WBSel = Output(UInt(2.W))

    val Hcf = Output(Bool())
  })
  // Inst Decode for each stage
  val IF_opcode = io.IF_Inst(6, 0)

  val ID_opcode = io.ID_Inst(6, 0)
  val ID_rs1 = io.ID_Inst(19,15) // get rs1 for data hazard
  val ID_rs2 = io.ID_Inst(24,20) // get rs2 for data hazard


  val EXE_opcode = io.EXE_Inst(6, 0)
  val EXE_funct3 = io.EXE_Inst(14, 12)
  val EXE_funct7 = io.EXE_Inst(31, 25)
  val EXE_rd = io.EXE_Inst(11, 7) // get rd for data hazard
  val EXE_rs1 = io.EXE_Inst(19,15) // get rs1 for data hazard
  val EXE_rs2 = io.EXE_Inst(24,20) // get rs2 for data hazard

  val MEM_opcode = io.MEM_Inst(6, 0)
  val MEM_funct3 = io.MEM_Inst(14, 12)
  val MEM_rd = io.MEM_Inst(11, 7) // get rd for data hazard

  val WB_opcode = io.WB_Inst(6, 0)
  val WB_rd = io.WB_Inst(11, 7) // get rd for data hazard

  // Control signal - Branch/Jump
  val E_En = Wire(Bool())
  E_En := (EXE_opcode===BRANCH || EXE_opcode===JAL || EXE_opcode===JALR)         // To Be Modified
  val E_Branch_taken = Wire(Bool())
  E_Branch_taken := MuxLookup(EXE_opcode, false.B, Seq(
          BRANCH -> MuxLookup(EXE_funct3, false.B, Seq(
            EQ  -> io.E_BrEq.asUInt,  // BEQ
            NE  -> !io.E_BrEq.asUInt, // BNE
            LT  -> io.E_BrLT.asUInt,  // BLT
            GE  -> !io.E_BrLT.asUInt, // BGE
            LTU -> io.E_BrLT.asUInt,  // BLTU
            GEU -> !io.E_BrLT.asUInt  // BGEU
          )),
          JAL -> true.B,
          JALR -> true.B
        ))    // To Be Modified***

  io.E_En := E_En
  io.E_Branch_taken := E_Branch_taken

  // pc predict miss signal
  val Predict_Miss = Wire(Bool())
  Predict_Miss := (E_En && E_Branch_taken && io.ID_pc=/=io.EXE_target_pc)

  // Control signal - PC
  when(Predict_Miss){
    io.PCSel := EXE_T_PC
  }.otherwise{
    io.PCSel := IF_PC_PLUS_4
  }

  // Control signal - Branch comparator
  io.E_BrUn := (io.EXE_Inst(13) === 1.U) // Check if it is unsigned branch

  // Control signal - Immediate generator
  io.D_ImmSel := MuxLookup(ID_opcode, 0.U, Seq(
    OP_IMM -> I_type,
    JALR -> I_type,
    LOAD -> I_type,
    BRANCH -> B_type,
    STORE -> S_type,
    LUI -> U_type,
    AUIPC -> U_type,
    JAL -> J_type,
  )) // To Be Modified***

  // Control signal - Scalar ALU
  // 2: upper    1: pc    0: rs1
  // branch: rs1 input to branch comparator and pc input to ALU
  io.E_ASel := MuxLookup(EXE_opcode, 0.U, Seq(
    AUIPC -> 1.U,
    BRANCH -> 1.U,
    JAL -> 1.U,
    LUI -> 2.U,
  ))    // To Be Modified***
  // 1: imm    0: rs2
  io.E_BSel := Mux(EXE_opcode === OP, false.B, true.B)   // To Be Modified***
  
  // select funct5 is used inst(24:20) for OP_IMM
  val EXE_funct5 = Wire(UInt(5.W))
  EXE_funct5 := MuxLookup(Cat(EXE_funct7, EXE_funct3), "b11111".U, Seq(
    "b0110000_001".U -> EXE_rs2, // CLZ CTZ CPOP SEXT_B SEXT_H
    "b0110100_101".U -> EXE_rs2, // REV8
    "b0010100_101".U -> EXE_rs2, // ORC_B
  ))
  // only OP_IMM need to check ISA is use funct7 or not
  val use_funct7 = Wire(Bool())
  use_funct7 := (EXE_funct3 === "b001".U || EXE_funct3 === "b101".U)
  val zext_check = Wire(Bool())
  zext_check := (EXE_funct3 === "b100".U && EXE_funct7 === "b0000100".U && EXE_rs2 === "b00000".U)
  // select ALU operation: add, shift, xor .etc
  // default is ADD
  io.E_ALUSel := MuxLookup(EXE_opcode, (Cat(0.U(7.W), "b11111".U, 0.U(3.W))), Seq(
    OP -> (Cat(EXE_funct7, Mux(zext_check, EXE_rs2, "b11111".U), EXE_funct3)),
    OP_IMM -> Mux( use_funct7, Cat(EXE_funct7, EXE_funct5, EXE_funct3), Cat(0.U(7.W), EXE_funct5, EXE_funct3)),
  ))

  // Control signal - Data Memory
  io.DM_Mem_R := (MEM_opcode===LOAD)
  io.DM_Mem_W := (MEM_opcode===STORE)
  io.DM_Length := Cat(0.U(1.W),MEM_funct3) // length

  // Control signal - Inst Memory
  io.IM_Mem_R := true.B // always true
  io.IM_Mem_W := false.B // always false
  io.IM_Length := "b0010".U // always load a word(inst)

  // Control signal - Scalar Write Back
  // only branch and store don't need to write back
  io.W_RegWEn := MuxLookup(WB_opcode, true.B, Seq(
    BRANCH -> false.B,
    STORE -> false.B,
    HCF -> false.B,
  ))  // To Be Modified***

  // Selects whether to write the memory read from DMEM, the ALU output, or PC+4 to rd.
  io.W_WBSel := MuxLookup(WB_opcode, ALUOUT, Seq(
    LOAD -> LD_DATA,
    JAL  -> PC_PLUS_4,
    JALR -> PC_PLUS_4,
  )) // To Be Modified***

  // Control signal - Others
  io.Hcf := (IF_opcode === HCF)

  /****************** Data Hazard ******************/
  // 1. Rd in WB  stage is the same as Rs in ID stage
  // 2. Rd in MEM stage is the same as Rs in ID stage
  // 3. Rd in EXE stage is the same as Rs in ID stage
  // 4. Rd in MEM stage is the same as Rs in EXE stage // For load instruction

  // Use rs in ID stage
  // only JAL LUI AUIPC don't use rs1
  val is_D_use_rs1 = Wire(Bool())
  is_D_use_rs1 := MuxLookup(ID_opcode,true.B,Seq(
    JAL -> false.B,
    LUI -> false.B,
    AUIPC -> false.B,
    HCF -> false.B,
  ))   // To Be Modified***

  // only BRANCH OP STORE use rs2
  val is_D_use_rs2 = Wire(Bool())
  is_D_use_rs2 := MuxLookup(ID_opcode,false.B,Seq(
    BRANCH -> true.B,
    OP -> true.B,
    STORE -> true.B,
  ))   // To Be Modified***
  
  // Use rd in WB stage
  // only BRANCH STORE don't use rd
  val is_W_use_rd = Wire(Bool())
  is_W_use_rd := MuxLookup(WB_opcode,true.B,Seq(
    BRANCH -> false.B,
    STORE -> false.B,
    HCF -> false.B,
  ))   // To Be Modified***

  // Use rd in MEM stage
  // only BRANCH STORE don't use rd
  val is_M_use_rd = Wire(Bool())
  is_M_use_rd := MuxLookup(MEM_opcode,true.B,Seq(
    BRANCH -> false.B,
    STORE -> false.B,
    HCF -> false.B,
  )) 

  // Use rd in EXE stage
  // only BRANCH STORE don't use rd
  val is_E_use_rd = Wire(Bool())
  is_E_use_rd := MuxLookup(EXE_opcode,true.B,Seq(
    BRANCH -> false.B,
    STORE -> false.B,
    HCF -> false.B,
  )) 
  val memory_access = (MEM_opcode === LOAD)
  // Hazard condition (rd, rs overlap)
  val is_D_rs1_W_rd_overlap = Wire(Bool())
  val is_D_rs2_W_rd_overlap = Wire(Bool())
  is_D_rs1_W_rd_overlap := is_D_use_rs1 && is_W_use_rd && (ID_rs1 === WB_rd) && (WB_rd =/= 0.U(5.W))
  is_D_rs2_W_rd_overlap := is_D_use_rs2 && is_W_use_rd && (ID_rs2 === WB_rd) && (WB_rd =/= 0.U(5.W))

  val is_D_rs1_M_rd_overlap = Wire(Bool())
  val is_D_rs2_M_rd_overlap = Wire(Bool())
  is_D_rs1_M_rd_overlap := is_D_use_rs1 && is_M_use_rd && (ID_rs1 === MEM_rd) && (MEM_rd =/= 0.U(5.W))
  is_D_rs2_M_rd_overlap := is_D_use_rs2 && is_M_use_rd && (ID_rs2 === MEM_rd) && (MEM_rd =/= 0.U(5.W))

  val is_D_rs1_E_rd_overlap = Wire(Bool())
  val is_D_rs2_E_rd_overlap = Wire(Bool())
  is_D_rs1_E_rd_overlap := is_D_use_rs1 && is_E_use_rd && (ID_rs1 === EXE_rd) && (EXE_rd =/= 0.U(5.W))
  is_D_rs2_E_rd_overlap := is_D_use_rs2 && is_E_use_rd && (ID_rs2 === EXE_rd) && (EXE_rd =/= 0.U(5.W))

  // Control signal - Stall
  // Stall for Data Hazard
  io.Stall_DH := (is_D_rs1_W_rd_overlap || is_D_rs2_W_rd_overlap) || 
                 (is_D_rs1_E_rd_overlap || is_D_rs2_E_rd_overlap) || 
                 (is_D_rs1_M_rd_overlap || is_D_rs2_M_rd_overlap) 
  // Wait for Memory Access until DM is Valid
  io.Stall_MA := ~io.DM_Valid // Stall for Waiting Memory Access
  // Control signal - Flush
  io.Flush_BH := Predict_Miss // Flush for Branch Hazard
  io.Flush_DH := (is_D_rs1_W_rd_overlap || is_D_rs2_W_rd_overlap) ||
                 (is_D_rs1_E_rd_overlap || is_D_rs2_E_rd_overlap) ||
                 (is_D_rs1_M_rd_overlap || is_D_rs2_M_rd_overlap)


  // Control signal - Data Forwarding (Bonus)

  /****************** Data Hazard End******************/


}
