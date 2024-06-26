package SoC

import chisel3._
import chisel3.util._
import AXI._
import DMA._
import AXILite._
import Memory._
import acal_lab09._

// CPU <-> Bus <-> Memory
object SystemConfig {
    val nMasters: Int = 2
    val nSlaves: Int = 3
    val DMABaseAddr: Int = 0
    val DMASize: Int = 100
    val LocalMemBaseAddr: Int = 0x1000
    val LocalMemSize: Map[String, Int] = Map(
    "Size" -> 8192, // Height x Width
    "Height" -> 256, // The Number of bytes
    "Width" -> 32 // unit: 32 bits
    )
    val LocalMemLatency: Int = 1
    val LocalMemInitFilePath: String =
    "./src/main/resource/data1.hex" // Provide the file path
    val GlobalMemBaseAddr: Int = 0x8000 // Provide the base address
    val GlobalMemSize: Map[String, Int] = Map(
    "Size" -> 0x8000, // Height x Width
    "Height" -> 1024, // The Number of bytes
    "Width" -> 32 // unit: 32 bits
    )
    val GlobalMemLatency: Int = 8
    val GlobalMemInitFilePath: String =
    "./src/main/resource/data.hex" // Provide the file path
}
class top_SoC(idWidth: Int, addrWidth: Int, dataWidth: Int) extends Module {
    val io = IO(new Bundle{
        val regs = Output(Vec(32,UInt(dataWidth.W)))
        val Hcf = Output(Bool())

        //for sure that IM and DM will be synthesized
        val inst = Output(UInt(32.W))
        val rdata = Output(UInt(32.W))
        val wdata  = Output(UInt(32.W))

        val Dump_Mem = Input(Bool())
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
        // val waddr = Output(UInt(32.W))
        val WB_rd = Output(UInt(5.W))
        val WB_wdata = Output(UInt(32.W))
        val EXE_Jump = Output(Bool())
        val EXE_Branch = Output(Bool())
        val mState = Output(UInt(3.W))
        // for debugging
        // val len    = Output(UInt(8.W))
        // val now_addr_state = Output(UInt(2.W))
        // val EXE_LOAD_STORE = Output(Bool())
        val data_written = Output(UInt(32.W))
        // val data_plan_to_write = Output(UInt(32.W))
        val DMA_master_state = Output(UInt(3.W))
        val DMA_Rstate = Output(UInt(2.W))
        val DMA_Wstate = Output(UInt(2.W))
        val wData_DMA = Output(UInt(32.W))
        // val enable_out = Output(UInt(dataWidth.W))
        // val source_info_out = Output(UInt(dataWidth.W))
        // val dest_info_out = Output(UInt(dataWidth.W))
        // val size_cfg_out = Output(UInt(dataWidth.W))
        // val done_out = Output(UInt(dataWidth.W))
        val now_read_state_global = Output(UInt(2.W))
        val now_write_state_global = Output(UInt(3.W))
        val now_read_state_local = Output(UInt(2.W))
        val now_write_state_local = Output(UInt(3.W))
        val is_last_out   = Output(Bool())
    })
    val five_stage_cpu = Module(new top(idWidth, addrWidth, dataWidth))
    // Initialization
    io.Hcf := five_stage_cpu.io.Hcf
    io.inst := five_stage_cpu.io.inst
    io.rdata := five_stage_cpu.io.rdata
    io.wdata := five_stage_cpu.io.wdata
    io.mState := five_stage_cpu.io.now_state
    io.E_Branch_taken := five_stage_cpu.io.E_Branch_taken
    io.Flush := five_stage_cpu.io.Flush
    io.Stall_MA := five_stage_cpu.io.Stall_MA
    io.Stall_DH := five_stage_cpu.io.Stall_DH
    io.IF_PC := five_stage_cpu.io.IF_PC
    io.ID_PC := five_stage_cpu.io.ID_PC
    io.EXE_PC := five_stage_cpu.io.EXE_PC
    io.MEM_PC := five_stage_cpu.io.MEM_PC
    io.WB_PC := five_stage_cpu.io.WB_PC
    io.EXE_alu_out := five_stage_cpu.io.EXE_alu_out
    io.EXE_src1 := five_stage_cpu.io.EXE_src1
    io.EXE_src2 := five_stage_cpu.io.EXE_src2
    io.ALU_src1 := five_stage_cpu.io.ALU_src1
    io.ALU_src2 := five_stage_cpu.io.ALU_src2
    io.raddr := five_stage_cpu.io.raddr
    // io.waddr := five_stage_cpu.io.waddr
    io.WB_rd := five_stage_cpu.io.WB_rd
    io.WB_wdata := five_stage_cpu.io.WB_wdata
    io.EXE_Jump := five_stage_cpu.io.EXE_Jump
    io.EXE_Branch := five_stage_cpu.io.EXE_Branch
    // io.EXE_LOAD_STORE := five_stage_cpu.io.EXE_LOAD_STORE
    // io.now_addr_state := five_stage_cpu.io.now_addr_state
    // io.mState := five_stage_cpu.io.now_state
    // send data between dma and cpu
    val dma = Module(new DMA(idWidth, addrWidth, dataWidth, 0))
    io.data_written := dma.io.data_written
    // io.data_plan_to_write := dma.io.data_plan_to_write
    io.DMA_master_state := dma.io.now_state
    io.DMA_Rstate := dma.io.now_read_state
    io.DMA_Wstate := dma.io.now_write_state
    io.wData_DMA := dma.io.wData_DMA
    io.is_last_out := dma.io.is_last_out
    // io.enable_out := dma.io.enable_out
    // io.source_info_out := dma.io.source_info_out
    // io.dest_info_out := dma.io.dest_info_out
    // io.size_cfg_out := dma.io.size_cfg_out
    // io.done_out := dma.io.done_out
    // io.len := dma.io.now_len
    // bus
    val bus = Module(
        new AXILiteXBar(
        SystemConfig.nMasters,
        SystemConfig.nSlaves,
        idWidth,
        addrWidth,
        dataWidth,
        Seq(
            (SystemConfig.DMABaseAddr, SystemConfig.DMASize),
            (SystemConfig.LocalMemBaseAddr, SystemConfig.LocalMemSize("Size")),
            (SystemConfig.GlobalMemBaseAddr, SystemConfig.GlobalMemSize("Size"))
        )
        )
    )
    val localMem = Module(
        new DataMem(
        SystemConfig.LocalMemSize("Width"),
        SystemConfig.LocalMemSize("Height"),
        idWidth,
        addrWidth,
        dataWidth,
        SystemConfig.LocalMemBaseAddr,
        SystemConfig.LocalMemLatency,
        SystemConfig.LocalMemInitFilePath
        )
    )
    val globalMem = Module(
        new DataMem(
        SystemConfig.GlobalMemSize("Width"),
        SystemConfig.GlobalMemSize("Height"),
        idWidth,
        addrWidth,
        dataWidth,
        SystemConfig.GlobalMemBaseAddr,
        SystemConfig.GlobalMemLatency,
        SystemConfig.GlobalMemInitFilePath
        )
    )
    io.now_read_state_global  := globalMem.io.now_read_state
    io.now_write_state_global := globalMem.io.now_write_state
    io.now_read_state_local   := localMem.io.now_read_state
    io.now_write_state_local  := localMem.io.now_write_state
    bus.io.masters(0) <> five_stage_cpu.io.master
    bus.io.masters(1) <> dma.io.master
    bus.io.slaves(0) <> dma.io.slave
    bus.io.slaves(1) <> localMem.io.slave
    bus.io.slaves(2) <> globalMem.io.slave
    localMem.io.dump := io.Dump_Mem //false.B
    globalMem.io.dump := io.Dump_Mem //false.B
    // Initialize the registers with 0
    for (i <- 0 until 32) {
        io.regs(i) := five_stage_cpu.io.regs(i)
    }
}