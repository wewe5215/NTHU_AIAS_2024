package acal_lab14.topSystolicArray

import chisel3._
import chisel3.util._

import acal_lab14.SingleCycleCPU._
import acal_lab14.Memory._
import acal_lab14.SystolicArray._
import acal_lab14.AXI._
import acal_lab14.AXILite._
import acal_lab14.DMA._
import Config._

/* ----------------------------------------------------------------------------------------------+
 * topSystolicArray consists of a single cycle CPU, SRAM, accelerator, DMA connected via AXI bus.|
 * This system demonstrates that CPU can program DMA through system bus and move data from SRAM  |
 * to local buffer in accelerator. (Lab14-2-3)                                                   |
 * ----------------------------------------------------------------------------------------------+
*/

class top_Hw14_3_2_SA extends Module {
    val io = IO(new Bundle {
        val pc          = Output(UInt(15.W))
        val regs        = Output(Vec(32, UInt(32.W)))
        val Hcf         = Output(Bool())
        val cycle_count = Output(UInt(32.W))
        val tb_slave    = new Axi4SlaveIF(Hw14_3_2_SA_Config.s_id_width, Hw14_3_2_SA_Config.addr_width, Hw14_3_2_SA_Config.data_width)
        val tb_en       = Input(Bool())
    })

    val cpu = Module(new SingleCycleCPU(Hw14_3_2_SA_Config.s_id_width, Hw14_3_2_SA_Config.addr_width, Hw14_3_2_SA_Config.data_width, Hw14_3_2_SA_Config.instr_hex_path))
    val dm  = Module(new DataMem(Hw14_3_2_SA_Config.s_id_width, Hw14_3_2_SA_Config.data_mem_size, Hw14_3_2_SA_Config.addr_width, Hw14_3_2_SA_Config.data_width, Hw14_3_2_SA_Config.data_hex_path))
    val sa  = Module(new topSA(Hw14_3_2_SA_Config.s_id_width, Hw14_3_2_SA_Config.addr_width, Hw14_3_2_SA_Config.data_width, Hw14_3_2_SA_Config.reg_width, SA_config.sa_mem_size))
    val dma = Module(new DMA(Hw14_3_2_SA_Config.s_id_width, Hw14_3_2_SA_Config.addr_width, Hw14_3_2_SA_Config.data_width, Hw14_3_2_SA_Config.Dma_Base_ADDR))
    // 2 master and 3 slaves
    val bus = Module(new AXILiteXBar(Hw14_3_2_SA_Config.nMasters, Hw14_3_2_SA_Config.nSlaves, Hw14_3_2_SA_Config.s_id_width, Hw14_3_2_SA_Config.addr_width, Hw14_3_2_SA_Config.data_width, Hw14_3_2_SA_Config.addr_map))
    // AXI Lite Bus
    bus.io.masters(0) <> cpu.io.master
    bus.io.masters(1) <> sa.io.master
    bus.io.masters(2) <> dma.io.master
    bus.io.slaves(0) <> dm.io.slave
    bus.io.slaves(1) <> sa.io.slave
    bus.io.slaves(2) <> dma.io.slave

    // System
    io.pc   := cpu.io.pc
    io.regs := cpu.io.regs
    io.Hcf  := cpu.io.Hcf

    // Statistic
    val cycle_counter = RegInit(1.U(32.W))
    cycle_counter  := cycle_counter + 1.U
    io.cycle_count := cycle_counter

    // Testbench
    io.tb_slave <> sa.io.tb_slave
    sa.io.tb_en := io.tb_en
}