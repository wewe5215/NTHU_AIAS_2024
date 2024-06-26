package DMA

import AXI._
import chisel3._
import chisel3.util._

class DMA(idWidth: Int, addrWidth: Int, dataWidth: Int, baseAddr: BigInt)
    extends Module {
      val io = dontTouch(IO(new Bundle {
        val slave  = new Axi4SlaveIF(idWidth, addrWidth, dataWidth, 2) // programed by other masters(e.g CPU)
        val master = new Axi4MasterIF(idWidth, addrWidth, dataWidth, 2)
        val Hcf    = Output(Bool())
        // for debugging
        val data_written = Output(UInt(32.W))
        // val data_plan_to_write = Output(UInt(32.W))
        val now_state = Output(UInt(3.W))
        val now_read_state = Output(UInt(2.W))
        val now_write_state = Output(UInt(2.W))
        val wData_DMA = Output(UInt(32.W))
        // val enable_out = Output(UInt(dataWidth.W))
        // val source_info_out = Output(UInt(dataWidth.W))
        // val dest_info_out = Output(UInt(dataWidth.W))
        // val size_cfg_out = Output(UInt(dataWidth.W))
        // val done_out = Output(UInt(dataWidth.W))
        // val now_len    = Output(UInt(8.W))
        val is_last_out   = Output(Bool())

  }))

  // Master state machine
  val mIdle :: mReadSend :: mReadResp :: mWriteSend :: mWriteResp :: Nil = Enum(5)
  val mState  = RegInit(mIdle)

  // Slave state machine
  val sReadIdle :: sReadResp :: Nil                 = Enum(2)
  val sWriteIdle :: sWriteExec :: sWriteResp :: Nil = Enum(3)

  val sReadState  = RegInit(sReadIdle)
  val sWriteState = RegInit(sWriteIdle)

  val sReadAddrReg     = RegInit(0.U(addrWidth.W))
  val sReadIDReg       = RegInit(0.U(idWidth.W))
  val sWriteIDReg      = RegInit(0.U(idWidth.W))
  val sWriteDataRecv   = RegInit(false.B)
  val sWriteAddrRecv   = RegInit(false.B)
  val sWriteDataReg    = RegInit(0.U(dataWidth.W))
  val sWriteAddrReg    = RegInit(0.U(addrWidth.W))
  val sWriteAddrOffset = WireDefault(sWriteAddrReg - baseAddr.U)
  val sReadAddrOffset  = WireDefault(sReadAddrReg - baseAddr.U)

  val mWriteAddrSent = RegInit(false.B) // true for write address is sent through master interface
  val mWriteDataSent = RegInit(false.B) // true for write data is sent through master interface

  // Slave MMIO Regs
  val mmio_regs         = RegInit(VecInit(Seq.fill(6)(0.U(dataWidth.W))))
  val mmio_enable       = mmio_regs(0)
  val mmio_source_info  = mmio_regs(1)
  val mmio_dest_info    = mmio_regs(2)
  val mmio_size_cfg     = mmio_regs(3)
  val mmio_inst         = mmio_regs(4)
  val mmio_done         = mmio_regs(5)
  // for debugging
  // io.enable_out := mmio_enable
  // io.source_info_out := mmio_source_info
  // io.dest_info_out := mmio_dest_info
  // io.size_cfg_out := mmio_size_cfg
  // io.done_out := mmio_done
  // Data buffer
  val data_buffer    = RegInit(0.U(dataWidth.W))
  val rData_mask     = WireDefault(0.U(4.W))
  val mask_width     = WireDefault(0.U(4.W))
  val source_offset  = RegInit(0.U(2.W))
  val rData          = WireDefault(VecInit(Seq.fill(4)(0.U(8.W))))
  val init           = RegInit(true.B)
  val is_last        = RegInit(false.B)
  io.is_last_out := is_last

  val dest_offset = WireDefault(io.master.aw.bits.addr(1,0))

  // Total number of requests counter in relation to the height field
  val request_counter = RegInit(0.U(32.W))
  // for debugging
  io.data_written := request_counter
  // io.data_plan_to_write := mmio_size_cfg(7,0)
  io.now_state := mState
  io.now_read_state := sReadState
  io.now_write_state := sWriteState
  io.wData_DMA := data_buffer
  val sReadData = WireDefault(MuxLookup(
    sReadAddrOffset,
    0.U,
    Seq(
      0.U  -> mmio_regs(0),
      4.U  -> mmio_regs(1),
      8.U  -> mmio_regs(2),
      12.U -> mmio_regs(3),
      16.U -> mmio_regs(4),
      20.U -> mmio_regs(5)
    )
  ))

  // IO signals
  io.Hcf := mmio_done

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
  io.master.w.bits.data := data_buffer
  io.master.w.bits.strb := "b1111".U
  io.master.w.bits.last := true.B

  io.master.r.ready := mState === mReadResp

  io.master.b.ready := mState === mWriteResp

  io.slave.aw.ready := (sWriteState === sWriteIdle || sWriteState === sWriteExec) && !sWriteAddrRecv
  io.slave.w.ready := (sWriteState === sWriteIdle || sWriteState === sWriteExec) && !sWriteDataRecv

  io.slave.ar.ready := sReadState === sReadIdle

  io.slave.r.valid     := sReadState === sReadResp
  io.slave.r.bits.data := sReadData
  io.slave.r.bits.id   := sReadIDReg
  io.slave.r.bits.last := true.B
  io.slave.r.bits.resp := 0.U

  io.slave.b.valid     := sWriteState === sWriteResp
  io.slave.b.bits.id   := sWriteIDReg
  io.slave.b.bits.resp := 0.U

  // Mater State Controller
  switch(mState) {
    is(mIdle) {
      // when the Enable register is set, the DMA starts to issue read request
      when(mmio_enable === 1.U) {
        mState := mReadSend
      }
    }
    is(mReadSend) {
      // When the ARREady signal is asserted, the slave accepts the
      // request and the master will move the the mReadResp state
      // and wait for read response
      when(io.master.ar.ready || ~is_last) {
        mState := mReadResp
      }
    }
    is(mReadResp) {
      // whe tne RValid is assert, the data response returns and
      // DMA starts to write the data to the desitnation, issuing
      // write request
      when(io.master.r.valid) {
        mState := mWriteSend
      }
    }
    is(mWriteSend) {
      // when all the write data are sent, wait for write response
      when(mWriteDataSent) {
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

  // Slave State Controller
  switch(sReadState) {
    is(sReadIdle) {
      when(io.slave.ar.valid) {
        sReadState := sReadResp
      }
    }
    is(sReadResp) {
      when(io.slave.r.ready) {
        sReadState := sReadIdle
      }
    }
  }

  switch(sWriteState) {
    is(sWriteIdle) {
      when(io.slave.aw.valid || io.slave.w.valid) {
        sWriteState := sWriteExec
      }
    }
    is(sWriteExec) {
      when(sWriteDataRecv && sWriteAddrRecv) {
        sWriteState := sWriteResp
      }
    }
    is(sWriteResp) {
      when(io.slave.b.ready) {
        sWriteState := sWriteIdle
      }
    }
  }

  // master port datapath
  // when(mState === mWriteSend) {
  //   when(io.master.aw.fire) {
  //     // count how many write requests are sent
  //     request_counter := request_counter + 1.U
  //   }
  // }

  when(mState === mReadSend) {
    // calculate read request address
    // base address = n * stride
    io.master.ar.bits.addr := mmio_source_info //+ (request_counter * mmio_size_cfg(31,24))
    io.master.ar.bits.len  := mmio_size_cfg(7,0)
    io.master.ar.bits.burst := 1.U
    // Due to 32-byte alignment in memory,
    // it is necessary to record the offset to determine the starting address of the data we want.
    source_offset := io.master.ar.bits.addr(1,0)
  }

  when(mState === mReadResp && io.master.r.valid) {
    // get read response byte mask
    // mask_width is determined by "width" field(source)
    mask_width := MuxLookup(mmio_size_cfg(15,8),"b1111".U,Seq(
      1.U -> "b0001".U,
      2.U -> "b0011".U,
      3.U -> "b0111".U,
      4.U -> "b1111".U
    ))

    // When we read data back in 32-byte chunks, we design rData_mask to mask out the data we don't need
    rData_mask := mask_width << source_offset

    // get read data value
    List.range(0, 4).map { x =>
      when(rData_mask(x) === 1.U) {
        rData(x) := io.master.r.bits.data(x * 8 + 7, x * 8)
      }
      .otherwise {
        rData(x) := 0.U(8.W)
      }
    }

    // adjust the data order to shift souce_offset * 1 byte
    data_buffer := rData.asUInt >> (source_offset << 3.U)
    is_last     := io.master.r.bits.last
  }

  when(mState === mWriteSend) {
    // calculate write request address
    // base address = n * stride
    io.master.aw.bits.addr := mmio_dest_info //+ (request_counter * mmio_size_cfg(23,16))
    io.master.aw.bits.len  := mmio_size_cfg(7,0)
    io.master.aw.bits.burst := 1.U
    // mask_width is determined by "width" field(destination)
    mask_width := MuxLookup(mmio_size_cfg(15,8),"b1111".U,Seq(
      1.U -> "b0001".U,
      2.U -> "b0011".U,
      3.U -> "b0111".U,
      4.U -> "b1111".U
    ))
    // calculate byte mask to mask out the data we don't write
    io.master.w.bits.strb := mask_width << dest_offset

    // adjust data to match write config(destination width)
    io.master.w.bits.data := data_buffer << (dest_offset << 3.U)
    io.master.w.bits.last := is_last

  }

  // check DMA operation completion and set signals accordingly
  when(mState === mWriteResp && io.master.b.valid) {
    when((request_counter + 1.U) === mmio_size_cfg(7,0)){
      request_counter := 0.U
      mmio_enable := 0.U
      mmio_done   := 1.U
    }
    .otherwise{
      request_counter := request_counter + 1.U
    }
  }

  // check Write Addr and Data status
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


  // slave port datapath
  // save the data received from slave interface
  when(sWriteState === sWriteIdle || sWriteState === sWriteExec) {
    when(io.slave.aw.valid) {
      sWriteAddrRecv  := true.B
      sWriteAddrReg   := Mux(
        sWriteAddrRecv,
        sWriteAddrReg,
        io.slave.aw.bits.addr
      )
      // printf(p"io.slave.aw.bits.addr = ${Hexadecimal(io.slave.aw.bits.addr)}\n")
      sWriteIDReg     := Mux(
        sWriteAddrRecv,
        sWriteIDReg,
        io.slave.aw.bits.id
      )
    }
    when(io.slave.w.valid) {
      sWriteDataRecv := true.B
      sWriteDataReg  := Mux(sWriteDataRecv, sWriteDataReg, io.slave.w.bits.data)
    }
  }.elsewhen(sWriteState === sWriteResp) {
    sWriteAddrRecv := false.B
    sWriteDataRecv := false.B
  }

  // update the mmio registers
  when(sWriteState === sWriteResp && io.slave.b.ready) {
    switch(sWriteAddrOffset) {
      is(0.U) {
        mmio_regs(0) := sWriteDataReg
      }
      is(4.U) {
        mmio_regs(1) := sWriteDataReg
      }
      is(8.U) {
        mmio_regs(2) := sWriteDataReg
      }
      is(12.U) {
        mmio_regs(3) := sWriteDataReg
      }
      is(16.U) {
        mmio_regs(4) := sWriteDataReg
      }
      is(20.U) {
        mmio_regs(5) := sWriteDataReg
      }
    }
  }
  when(sReadState === sReadIdle && io.slave.ar.valid) {
    sReadAddrReg := io.slave.ar.bits.addr
    sReadIDReg   := io.slave.ar.bits.id
  }

}
