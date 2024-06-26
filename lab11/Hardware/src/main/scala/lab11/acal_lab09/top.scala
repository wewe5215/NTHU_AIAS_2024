package acal_lab09

import chisel3._
import chisel3.util._

import acal_lab09.PiplinedCPU._
import acal_lab09.Memory._
import acal_lab09.MemIF._
import SoC._
import AXI._
import DMA._
import AXILite._
import Memory._
import acal_lab09.PiplinedCPU.wide._
class top(idWidth: Int, addrWidth: Int, dataWidth: Int) extends Module {
    val io = IO(new Bundle{
        val regs = Output(Vec(32,UInt(32.W)))
        val Hcf = Output(Bool())

        //for sure that IM and DM will be synthesized
        val inst = Output(UInt(32.W))
        val rdata = Output(UInt(32.W))
        val wdata = Output(UInt(32.W))

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
        val EXE_LOAD_STORE = Output(Bool())
        val master = new Axi4MasterIF(idWidth, addrWidth, dataWidth, 2)
        val now_state = Output(UInt(3.W))
        val now_addr_state = Output(UInt(2.W))

    })

    val cpu = Module(new PiplinedCPU(15,32))
    val im = Module(new InstMem(15))
    val data_buffer    = RegInit(0.U(dataWidth.W))
    val data_wire    = WireDefault(0.U(dataWidth.W))
    val rData_mask     = WireDefault(0.U(4.W))
    val mask_width     = WireDefault(0.U(4.W))
    val source_offset  = RegInit(0.U(2.W))
    val rData          = WireDefault(VecInit(Seq.fill(4)(0.U(8.W))))
    val dest_offset = WireDefault(cpu.io.DataMem.waddr(1,0))

    // Piplined CPU
    cpu.io.InstMem.rdata := im.io.inst
    // TODO : revise to data received
    cpu.io.DataMem.rdata := 0.U

    cpu.io.InstMem.Valid := true.B // Direct to Mem
    // DataMem is Valid only if data is received
    when(cpu.io.DataMem.Mem_R === true.B || cpu.io.DataMem.Mem_W === true.B){
      cpu.io.DataMem.Valid := false.B // Direct to Mem
    }
    .otherwise{
      cpu.io.DataMem.Valid := true.B
    }

    // Insruction Memory
    im.io.raddr := cpu.io.InstMem.raddr

    //System
    io.regs := cpu.io.regs
    io.Hcf := cpu.io.Hcf
    io.inst := im.io.inst
    // initialize
    io.rdata := 0.U
    io.wdata := 0.U
    // io.waddr := 0.U
    // Test
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
    io.raddr := cpu.io.DataMem.raddr
    io.WB_rd := cpu.io.WB_rd
    io.WB_wdata := cpu.io.WB_wdata
    io.EXE_Jump := cpu.io.EXE_Jump
    io.EXE_Branch := cpu.io.EXE_Branch
    io.EXE_LOAD_STORE := cpu.io.EXE_LOAD_STORE
    // Master state machine
    val mIdle :: mReadSend :: mReadResp :: mWriteSend :: mWriteResp :: Nil = Enum(5)
    val mLocal :: mDMA :: mGlobal :: Nil = Enum(3)
    val mState = RegInit(mIdle)
    val mAddrState = RegInit(mLocal)
    when(cpu.io.EXE_LOAD_STORE === true.B){
      when(cpu.io.EXE_alu_out.asUInt < SystemConfig.LocalMemBaseAddr.asUInt){
        mAddrState := mDMA
      }
      .elsewhen(cpu.io.EXE_alu_out.asUInt < SystemConfig.GlobalMemBaseAddr.asUInt){
        mAddrState := mLocal
      }
      .otherwise{
        mAddrState := mGlobal
      }
    }
    io.now_state := mState
    io.now_addr_state := mAddrState
    val mWriteAddrSent = RegInit(false.B) // true for write address is sent through master interface
    val mWriteDataSent = RegInit(false.B) // true for write data is sent through master interface
    // Master interface signal
    io.master.aw.valid       := mState === mWriteSend && !mWriteAddrSent
    io.master.aw.bits.addr   := 0.U
    io.master.aw.bits.burst  := 0.U
    io.master.aw.bits.len    := 1.U
    io.master.aw.bits.size   := 2.U
    io.master.aw.bits.cache  := 0.U
    io.master.aw.bits.id     := 0.U
    io.master.aw.bits.prot   := 0.U
    io.master.aw.bits.lock   := 0.U
    io.master.aw.bits.qos    := 0.U
    io.master.aw.bits.region := 0.U

    io.master.ar.valid       := mState === mReadSend
    io.master.ar.bits.addr   := 0.U
    io.master.ar.bits.burst  := 0.U
    io.master.ar.bits.len    := 1.U
    io.master.ar.bits.size   := 2.U
    io.master.ar.bits.cache  := 0.U
    io.master.ar.bits.id     := 0.U
    io.master.ar.bits.prot   := 0.U
    io.master.ar.bits.lock   := 0.U
    io.master.ar.bits.qos    := 0.U
    io.master.ar.bits.region := 0.U

    io.master.w.valid     := mState === mWriteSend && !mWriteDataSent
    io.master.w.bits.data := 0.U
    io.master.w.bits.strb := "b1111".U
    io.master.w.bits.last := true.B

    io.master.r.ready := mState === mReadResp

    io.master.b.ready := mState === mWriteResp

    // Master State Controller
    switch(mState) {
      is(mIdle) {
        when(cpu.io.DataMem.Mem_R === true.B) {
          mState := mReadSend
        }
        .elsewhen(cpu.io.DataMem.Mem_W === true.B){
          mState := mWriteSend
        }
      }
      is(mReadSend) {
        // When the ARREady signal is asserted, the slave accepts the
        // request and the master will move the the mReadResp state
        // and wait for read response
        when(io.master.ar.ready) {
          mState := mReadResp
        }
      }
      is(mReadResp) {
        // whe tne RValid is assert, the data response returns and
        // DMA starts to write the data to the desitnation, issuing
        // write request
        when(io.master.r.valid) {
          mState := mIdle
        }
      }
      is(mWriteSend) {
        // when all the write data are sent, wait for write response
        when(mWriteAddrSent && mWriteDataSent) {
          mState := mWriteResp
        }
      }
      is(mWriteResp) {
        // When receiving write response (BValid is assert), complete the DMA operation and return the mIDLE state
        when(io.master.b.valid) {
          mState := mIdle
        }
      }
    }
    // master port datapath
    when(mState === mReadSend) {
      // calculate read request address
      // base address = n * stride
      when(mAddrState === mDMA){
        io.master.ar.bits.addr := SystemConfig.DMABaseAddr.asUInt + Cat(0.U(16.W), cpu.io.DataMem.raddr)
      }
      .otherwise{
        io.master.ar.bits.addr := SystemConfig.LocalMemBaseAddr.asUInt + Cat(0.U(16.W), cpu.io.DataMem.raddr)
      }
      source_offset := cpu.io.DataMem.raddr(1,0)
    }

    when(mState === mReadResp && io.master.r.valid) {
      when(cpu.io.DataMem.Length === Byte){
        mask_width := MuxLookup(source_offset,"b1111".U,Seq(
          0.U -> "b0001".U,
          1.U -> "b0010".U,
          2.U -> "b0100".U,
          3.U -> "b1000".U
        ))
      }
      .elsewhen(cpu.io.DataMem.Length === Half){
        mask_width := MuxLookup(source_offset,"b1111".U,Seq(
          0.U -> "b0011".U,
          1.U -> "b0110".U,
          2.U -> "b1100".U,
          3.U -> "b1000".U
        ))
      }
      .elsewhen(cpu.io.DataMem.Length === Word){
        mask_width := "b1111".U
      }

      // When we read data back in 32-byte chunks, we design rData_mask to mask out the data we don't need
      rData_mask := mask_width
      // printf(p"mask_width = ${Hexadecimal(mask_width)}\n")
      // get read data value
      List.range(0, 4).map { x =>
        when(rData_mask(x) === 1.U) {
          rData(x) := io.master.r.bits.data(x * 8 + 7, x * 8)
        }
        .otherwise {
          rData(x) := 0.U(8.W)
        }
      }
      // printf(p"io.master.r.bits.data = ${Hexadecimal(io.master.r.bits.data)}\n")
      // printf(p"rData = ${Hexadecimal(rData.asUInt)}\n")
      // adjust the data order to shift souce_offset * 1 byte
      data_wire := MuxLookup(rData_mask, rData.asUInt,Seq(
          "b0010".U -> ((rData.asUInt) >> 8),
          "b0100".U -> ((rData.asUInt) >> 16),
          "b1000".U -> ((rData.asUInt) >> 24),
          "b0110".U -> ((rData.asUInt) >> 8),
          "b1100".U -> ((rData.asUInt) >> 16)
        ))
      cpu.io.DataMem.rdata := data_wire
      io.rdata := data_wire
      cpu.io.DataMem.Valid := true.B // Direct to Mem
    }

    when(mState === mWriteSend) {
      // calculate write request address
      // base address = n * stride
      when(mAddrState === mDMA){
        io.master.aw.bits.addr := SystemConfig.DMABaseAddr.asUInt + Cat(0.U(16.W), cpu.io.DataMem.waddr)
      }
      .otherwise{
        io.master.aw.bits.addr := SystemConfig.LocalMemBaseAddr.asUInt + Cat(0.U(16.W), cpu.io.DataMem.waddr)
      }
      dest_offset := cpu.io.DataMem.waddr(1,0)
      when(cpu.io.DataMem.Length === Byte){
        mask_width := MuxLookup(dest_offset,"b1111".U,Seq(
            0.U -> "b0001".U,
            1.U -> "b0010".U,
            2.U -> "b0100".U,
            3.U -> "b1000".U
        ))
      }
      .elsewhen(cpu.io.DataMem.Length === Word){
        mask_width := "b1111".U
      }
      io.master.aw.bits.len := 1.U
      io.master.aw.bits.burst := 0.U
      io.master.w.bits.strb := mask_width
      // adjust data to match write config(destination width)
      io.master.w.bits.data := cpu.io.DataMem.wdata << (dest_offset << 3.U)
      io.wdata := cpu.io.DataMem.wdata

    }
    when(mState === mWriteResp && io.master.b.valid) {
      cpu.io.DataMem.Valid := true.B // Direct to Mem

      // io.waddr := cpu.io.DataMem.waddr
    }
    when(mState === mWriteSend) {
      when(io.master.w.ready) {
        mWriteDataSent := true.B
      }
      when(io.master.aw.ready) {
        mWriteAddrSent := true.B
      }
    }.otherwise {
      mWriteAddrSent := false.B
      mWriteDataSent := false.B
    }
    
}

