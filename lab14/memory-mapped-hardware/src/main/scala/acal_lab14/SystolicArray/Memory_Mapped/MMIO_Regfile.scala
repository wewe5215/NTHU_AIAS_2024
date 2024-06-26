package acal_lab14.SystolicArray

import chisel3._
import chisel3.util._

import acal_lab14.AXILite._

/** MMIO_regfile module
  *
  * has totally 10 registers inside
  *
  * @param reg_width
  *   bit width of data in each registers
  */
class MMIO(val reg_width: Int) extends Bundle {
  val ENABLE_OUT     = Output(Bool())
  val STATUS_OUT     = Output(Bool())
  val MATA_SIZE      = Output(UInt(reg_width.W))
  val MATB_SIZE      = Output(UInt(reg_width.W))
  val MATC_SIZE      = Output(UInt(reg_width.W))
  val MATA_MEM_ADDR  = Output(UInt(reg_width.W))
  val MATB_MEM_ADDR  = Output(UInt(reg_width.W))
  val MATC_MEM_ADDR  = Output(UInt(reg_width.W))
  val MAT_MEM_STRIDE = Output(UInt(reg_width.W))
  val MAT_BUF        = Output(UInt(reg_width.W))
  val ENABLE_LOAD    = Output(UInt(reg_width.W))
  val DONE_LOAD      = Output(UInt(reg_width.W))
  val SRC_INFO       = Output(UInt(reg_width.W))
  val DST_INFO       = Output(UInt(reg_width.W))
  val SIZE_CFG_INFO  = Output(UInt(reg_width.W))

  val WEN       = Input(Bool())
  val ENABLE_IN = Input(Bool())
  val STATUS_IN = Input(Bool())

  override def clone = { new MMIO(reg_width).asInstanceOf[this.type] }
}

class MMIO_Regfile(addr_width: Int, reg_width: Int) extends Module {
  val io = IO(new Bundle {
    // for SystolicArray MMIO
    val mmio = new MMIO(reg_width)

    // for Memory Mapped to r/w reg value
    val raddr = Input(UInt(addr_width.W))
    val rdata = Output(UInt(reg_width.W))

    val wen   = Input(Bool())
    val waddr = Input(UInt(addr_width.W))
    val wdata = Input(UInt(reg_width.W))
    val complete_write = Input(Bool())
  })

  // this initial_table is used for lab testing
  // it may become useless when doing your homework
  val initial_table = Seq(
    // for computing
    0.U(reg_width.W),           // ENABLE
    0.U(reg_width.W),           // STATUS
    "h00030003".U(reg_width.W), // MATA_SIZE
    "h00030003".U(reg_width.W), // MATB_SIZE
    "h00030003".U(reg_width.W), // MATC_SIZE
    0.U(reg_width.W),           // MATA_MEM_ADDR
    16.U(reg_width.W),          // MATB_MEM_ADDR
    32.U(reg_width.W),          // MATC_MEM_ADDR
    "h010101".U(reg_width.W),   // MAT_MEM_STRIDE
    48.U(reg_width.W),          // MAT_BUF
    // for loading data
    0.U(reg_width.W),           // load_enable
    0.U(reg_width.W),           // source_info
    0.U(reg_width.W),           // dest_info
    0.U(reg_width.W),           // size_cfg
    0.U(reg_width.W),           // inst
    0.U(reg_width.W),           // done
  )

  // totally 10 registers
  val RegFile = RegInit(VecInit(initial_table))

  // MMIO circuit declaration
  // Output
  io.mmio.ENABLE_OUT     := RegNext(RegFile(0)(0).asBool)
  io.mmio.STATUS_OUT     := RegNext(RegFile(1)(0).asBool)
  io.mmio.MATA_SIZE      := RegNext(RegFile(2))
  io.mmio.MATB_SIZE      := RegNext(RegFile(3))
  io.mmio.MATC_SIZE      := RegNext(RegFile(4))
  io.mmio.MATA_MEM_ADDR  := RegNext(RegFile(5))
  io.mmio.MATB_MEM_ADDR  := RegNext(RegFile(6))
  io.mmio.MATC_MEM_ADDR  := RegNext(RegFile(7))
  io.mmio.MAT_MEM_STRIDE := RegNext(RegFile(8))
  io.mmio.MAT_BUF        := RegNext(RegFile(9))
  io.mmio.ENABLE_LOAD    := RegNext(RegFile(10))
  io.mmio.SRC_INFO       := RegNext(RegFile(11))
  io.mmio.DST_INFO       := RegNext(RegFile(12))
  io.mmio.SIZE_CFG_INFO  := RegNext(RegFile(13))
  io.mmio.DONE_LOAD      := RegNext(RegFile(15))

  // when io.mmio.WEN === true.B -> SA attempt to write MMIO_RegFIle
  when(io.mmio.WEN) {
    RegFile(1) := io.mmio.STATUS_IN.asUInt
    RegFile(0) := io.mmio.ENABLE_IN.asUInt
  }

  // when io.wen === true.B -> some master send request(except for SA) to r/w MMIO_RegFIle
  // SA will r/w MMIO_Regfile cross MMIO interface, not io.wen
  io.rdata := 0.U
  when(io.raddr < "h100".U){
    io.rdata := RegFile(io.raddr)
  }
  .otherwise{
    switch(io.raddr - "h100".U){
      is(0.U) {
        io.rdata := RegFile(10)
      }
      is(4.U) {
        io.rdata := RegFile(11)
      }
      is(8.U) {
        io.rdata := RegFile(12)
      }
      is(12.U) {
        io.rdata := RegFile(13)
      }
      is(16.U) {
        io.rdata := RegFile(14)
      }
      is(20.U) {
        io.rdata := RegFile(15)
      }
    }
  }
  when(io.wen) {
    when(io.waddr < "h100".U){
      RegFile(io.waddr) := io.wdata
    }
    .elsewhen(~io.complete_write && io.waddr >= "h100".U){
      switch(io.waddr - "h100".U){
        is(0.U) {
          RegFile(10) := io.wdata
        }
        is(4.U) {
          RegFile(11) := io.wdata
        }
        is(8.U) {
          RegFile(12) := io.wdata
        }
        is(12.U) {
          RegFile(13) := io.wdata
        }
        is(16.U) {
          RegFile(14) := io.wdata
        }
        is(20.U) {
          RegFile(15) := io.wdata
        }
      }
    }
    .elsewhen(io.complete_write){
      RegFile(10) := 0.U
      RegFile(15) := 1.U
    }
  }
}

object MMIO_Regfile extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(
    new MMIO_Regfile(32, 32),
    args
  )
}
