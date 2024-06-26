package acal_lab14.topSystolicArray

import chisel3._
import chisel3.util._
import acal_lab14.Memory._
import acal_lab14.SystolicArray._
import acal_lab14.AXI._
import acal_lab14.AXILite._
import acal_lab14.DMA._
import Config._
import acal_lab09._

class top_Hw14_4 extends Module {
    val io = IO(new Bundle{
        val regs = Output(Vec(32,UInt(Hw14_4_SA_Config.data_width.W)))
        val Hcf = Output(Bool())

        //for sure that IM and DM will be synthesized
        val inst = Output(UInt(32.W))
        val rdata = Output(UInt(32.W))
        val wdata  = Output(UInt(32.W))
        // Test
        val E_Branch_taken = Output(Bool())
        val Flush = Output(Bool())
        val Stall_MA = Output(Bool())
        val Stall_DH = Output(Bool())
        val IF_PC = Output(UInt(32.W))
        val ID_PC = Output(UInt(32.W))
        val EXE_PC = Output(UInt(32.W))
        val MEM_PC = Output(UInt(32.W))
        val WB_PC = Output(UInt(32.W))
        val EXE_alu_out = Output(UInt(32.W))
        val EXE_src1 = Output(UInt(32.W))
        val EXE_src2 = Output(UInt(32.W))
        val ALU_src1 = Output(UInt(32.W))
        val ALU_src2 = Output(UInt(32.W))
        val raddr = Output(UInt(32.W))
        val WB_rd = Output(UInt(5.W))
        val WB_wdata = Output(UInt(32.W))
        val EXE_Jump = Output(Bool())
        val EXE_Branch = Output(Bool())
        val tb_slave    = new Axi4SlaveIF(Hw14_4_SA_Config.s_id_width, Hw14_4_SA_Config.addr_width, Hw14_4_SA_Config.data_width)
        val tb_en       = Input(Bool())
    })
    val cpu = Module(new top(Hw14_4_SA_Config.s_id_width, Hw14_4_SA_Config.addr_width, Hw14_4_SA_Config.data_width, Hw14_4_SA_Config.instr_hex_path))
    // Initialization
    io.Hcf := cpu.io.Hcf
    io.inst := cpu.io.inst
    io.rdata := cpu.io.rdata
    io.wdata := cpu.io.wdata
    io.E_Branch_taken := cpu.io.E_Branch_taken
    io.Flush := cpu.io.Flush
    io.Stall_MA := cpu.io.Stall_MA
    io.Stall_DH := cpu.io.Stall_DH
    io.IF_PC := cpu.io.IF_PC
    io.ID_PC := cpu.io.ID_PC
    io.EXE_PC := cpu.io.EXE_PC
    io.MEM_PC := cpu.io.MEM_PC
    io.WB_PC := cpu.io.WB_PC
    io.EXE_alu_out := cpu.io.EXE_alu_out
    io.EXE_src1 := cpu.io.EXE_src1
    io.EXE_src2 := cpu.io.EXE_src2
    io.ALU_src1 := cpu.io.ALU_src1
    io.ALU_src2 := cpu.io.ALU_src2
    io.raddr := cpu.io.raddr
    io.WB_rd := cpu.io.WB_rd
    io.WB_wdata := cpu.io.WB_wdata
    io.EXE_Jump := cpu.io.EXE_Jump
    io.EXE_Branch := cpu.io.EXE_Branch
    val dma = Module(new DMA(Hw14_4_SA_Config.s_id_width, Hw14_4_SA_Config.addr_width, Hw14_4_SA_Config.data_width, Hw14_4_SA_Config.Dma_Base_ADDR))
    val bus = Module(new AXILiteXBar(Hw14_4_SA_Config.nMasters, Hw14_4_SA_Config.nSlaves, Hw14_4_SA_Config.s_id_width, Hw14_4_SA_Config.addr_width, Hw14_4_SA_Config.data_width, Hw14_4_SA_Config.addr_map))
    val dm  = Module(new DataMem(Hw14_4_SA_Config.s_id_width, Hw14_4_SA_Config.data_mem_size, Hw14_4_SA_Config.addr_width, Hw14_4_SA_Config.data_width, Hw14_4_SA_Config.data_hex_path))
    val sa  = Module(new topSA(Hw14_4_SA_Config.s_id_width, Hw14_4_SA_Config.addr_width, Hw14_4_SA_Config.data_width, Hw14_4_SA_Config.reg_width, SA_config.sa_mem_size))
    bus.io.masters(0) <> cpu.io.master
    bus.io.masters(1) <> sa.io.master
    bus.io.masters(2) <> dma.io.master
    bus.io.slaves(0) <> dm.io.slave
    bus.io.slaves(1) <> sa.io.slave
    bus.io.slaves(2) <> dma.io.slave
    io.tb_slave <> sa.io.tb_slave
    sa.io.tb_en := io.tb_en
    // Initialize the registers with 0
    for (i <- 0 until 32) {
        io.regs(i) := cpu.io.regs(i)
    }
}