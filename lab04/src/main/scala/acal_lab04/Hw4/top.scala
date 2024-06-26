package acal_lab04.Hw4

import chisel3._
import chisel3.util._

class top extends Module {
    val io = IO(new Bundle{
        val pc_out = Output(UInt(32.W))
        val alu_out = Output(UInt(32.W))
        val rf_wdata_out = Output(UInt(32.W))
        val brtaken_out = Output(Bool())
        val jmptaken_out = Output(Bool())
        val funct3  = Output(UInt(3.W))
        val funct7 = Output(UInt(7.W))
        val inst = Output(UInt(32.W))
        val src1 = Output(UInt(32.W))
        val src2 = Output(UInt(32.W))
        // for debugging
    })

    val pc = Module(new PC())
    val im = Module(new InstMem())
    val dc = Module(new Decoder())
    val rf = Module(new RegFile(2))
    val alu = Module(new ALU())
    val bc = Module(new BranchComp())
    val dm = Module(new DataMem())

    //PC
    pc.io.jmptaken := false.B // Don't modify
    pc.io.brtaken := false.B // Don't modify
    pc.io.offset := 0.U // Don't modify

    //Insruction Memory
    im.io.raddr := pc.io.pc

    //Decoder
    dc.io.inst := im.io.rdata

    //RegFile
    rf.io.raddr(0) := dc.io.rs1
    rf.io.raddr(1) := dc.io.rs2
    rf.io.wdata := MuxLookup(dc.io.ctrl_WBSel, dm.io.rdata.asUInt, Seq(
        0.U -> dm.io.rdata.asUInt,
        1.U -> alu.io.out.asUInt,
        2.U -> (pc.io.pc + 4.U(32.W)).asUInt
    ))

    rf.io.waddr := 0.U  // Don't modify
    rf.io.wen := false.B // Don't modify

    //ALU
    val rdata_or_zero = WireDefault(0.U(32.W))
    alu.io.src1 := Mux(
        dc.io.ctrl_ASel,
        rf.io.rdata(0),
        pc.io.pc
    )
    alu.io.src2 := Mux(
        dc.io.ctrl_BSel,
        rf.io.rdata(1),
        dc.io.imm.asUInt
    )
    alu.io.funct3 := dc.io.funct3
    alu.io.funct7 := dc.io.funct7
    alu.io.opcode := dc.io.opcode

    //Data Memory
    dm.io.funct3 := dc.io.funct3
    dm.io.raddr :=  (rf.io.rdata(0) + dc.io.imm.asUInt)(9,0)
    dm.io.wen := dc.io.ctrl_MemRW
    dm.io.waddr := (rf.io.rdata(0) + dc.io.imm.asUInt)(9,0)
    dm.io.wdata := rf.io.rdata(1)
    //Branch Comparator
    bc.io.en := dc.io.ctrl_Br
    bc.io.funct3 := dc.io.funct3
    bc.io.src1 := rf.io.rdata(0)
    bc.io.src2 := rf.io.rdata(1)


    //Check Ports
    io.pc_out := pc.io.pc
    io.alu_out := alu.io.out
    io.rf_wdata_out := rf.io.wdata
    io.brtaken_out := bc.io.brtaken
    io.jmptaken_out := dc.io.ctrl_Jmp // need to be changed
    // for debugging
    io.funct3 := dc.io.funct3
    io.funct7 := dc.io.funct7
    io.inst := im.io.rdata
    io.src1 := Mux(
        dc.io.ctrl_ASel,
        rf.io.rdata(0),
        pc.io.pc
    )
    io.src2 := Mux(
        dc.io.ctrl_BSel,
        rf.io.rdata(1),
        dc.io.imm.asUInt
    )
}