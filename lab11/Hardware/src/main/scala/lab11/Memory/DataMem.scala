package Memory

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFileInline
import AXI._

class DataMem(
    width: Int,
    height: Int,
    idWidth: Int,
    addrWidth: Int,
    dataWidth: Int,
    baseAddr: BigInt,
    latency: Int,
    filePath: String
) extends Module {
  val io = IO(new Bundle {
    val slave = new Axi4SlaveIF(idWidth, addrWidth, dataWidth, 2)
    val dump = Input(Bool())
    val now_read_state = Output(UInt(2.W))
    val now_write_state = Output(UInt(3.W))
  })
  val memory = Mem(height, UInt(width.W))
  loadMemoryFromFileInline(memory, filePath)
  // aw channel
  io.slave.aw.ready := false.B

  // w channel
  io.slave.w.ready := false.B

  // b channel
  io.slave.b.bits.id := 0.U
  io.slave.b.bits.resp := 0.U
  io.slave.b.valid := false.B

  // ar channel
  io.slave.ar.ready := false.B

  // r channel
  io.slave.r.bits.id := 0.U
  io.slave.r.bits.data := 0.U
  io.slave.r.bits.resp := 0.U
  io.slave.r.bits.last := false.B
  io.slave.r.valid := false.B

  val readID = RegInit(0.U(idWidth.W))
  val rAddrOffset = RegInit(0.U(addrWidth.W))
  val wAddrOffset = WireDefault(
    ((io.slave.aw.bits.addr - baseAddr.U) & ~(3.U(width.W))) >> 2.U
  )
  val writeAddressReg = RegInit(0.U(addrWidth.W))
  val writeID = RegInit(0.U(idWidth.W))
  val sIdle :: sReady :: sWLatency :: sFinish :: sWaitData :: Nil = Enum(5)
  val sRead :: sRLatency :: sResp :: Nil = Enum(3)
  val writeState = RegInit(sIdle)
  val readState = RegInit(sRead)
  io.now_read_state := readState
  io.now_write_state := writeState
  val rLatencyCounter = RegInit(0.U(8.W))
  val wLatencyCounter = RegInit(0.U(8.W))
  val init = RegInit(true.B)
  val init_write = RegInit(true.B)
  val len_reg = RegInit(0.U(8.W))
  val len_reg_write = RegInit(0.U(8.W))
  val burst_reg = RegInit(0.U(2.W))
  val burst_reg_write = RegInit(0.U(2.W))
  val now_count = RegInit(0.U(8.W))
  val now_count_write = RegInit(0.U(8.W))
  val after_burst = RegInit(false.B)

  switch(readState) {
    is(sRead) {
      when(io.slave.ar.fire || ~init) {
        when(latency.U === 1.U) {
          readState := sResp
        }
        .otherwise {
          readState := sRLatency
        }
      }
    }
    is(sRLatency) {
      when(rLatencyCounter === (latency - 1).U) {
        readState := sResp
      }
    }
    is(sResp) {
      when(io.slave.r.fire) {
        readState := sRead
      }
    }
  }

  when(readState === sRead) {
    io.slave.ar.ready := true.B
    io.slave.r.valid := false.B
    rAddrOffset := ((io.slave.ar.bits.addr - baseAddr.U) & ~(3.U(width.W))) >> 2.U
    readID := io.slave.ar.bits.id
    len_reg := io.slave.ar.bits.len
    burst_reg := io.slave.ar.bits.burst
  }
  .elsewhen(readState === sRLatency) {
    rLatencyCounter := rLatencyCounter + 1.U
  }
  .elsewhen(readState === sResp) {
    rLatencyCounter := 0.U
    io.slave.ar.ready := false.B
    io.slave.r.valid := true.B
    when(burst_reg === 0.U){
      io.slave.r.bits.data := memory(rAddrOffset)
    }
    .otherwise{
      io.slave.r.bits.data := memory((rAddrOffset + now_count).asUInt)
    }
    io.slave.r.bits.id := readID
    io.slave.r.bits.resp := 0.U
    when((now_count + 1.U) === len_reg){
      now_count := 0.U
      init := true.B
      io.slave.r.bits.last := true.B
    }
    .otherwise{
      when(io.slave.r.fire){
        now_count := now_count + 1.U
      }
      io.slave.r.bits.last := false.B
      init := false.B
    }
  }

  switch(writeState) {
    is(sIdle) {
      writeState := sReady
    }
    is(sReady) {
      when(io.slave.aw.valid && io.slave.w.valid) {
        when(latency.U === 1.U) {
          writeState := sFinish
        }.otherwise {
          writeState := sWLatency
        }
      }
      .elsewhen(io.slave.aw.valid && after_burst === false.B) {
        writeState := sWaitData
      }
    }
    is(sWaitData) {
      when(io.slave.w.valid) {
        when(latency.U === 1.U) {
          writeState := sFinish
        }.otherwise {
          writeState := sWLatency
        }
      }
    }
    is(sWLatency) {
      when(wLatencyCounter === (latency - 1).U){
        writeState := sFinish
      }
    }
    is(sFinish) {
      when(io.slave.b.ready) {
        when(io.slave.w.bits.last){
          writeState := sReady
        }
        .otherwise{
          writeState := sWaitData
        }
      }
    }
  }

  val writeData = WireDefault(VecInit(Seq.fill(dataWidth / 8)(0.U(8.W))))
  List.range(0, dataWidth / 8).map { x =>
    when(io.slave.w.bits.strb(x) === 1.U) {
      writeData(x) := io.slave.w.bits.data(x * 8 + 7, x * 8)
    }.otherwise {
      when(burst_reg_write === 0.U){
        writeData(x) := memory(wAddrOffset)(x * 8 + 7, x * 8)
      }
      .otherwise{
        writeData(x) := memory(wAddrOffset + now_count_write)(x * 8 + 7, x * 8)
      }
    }
  }

  when(writeState === sIdle) {
    io.slave.aw.ready := false.B
    io.slave.w.ready := false.B
    io.slave.b.bits.resp := 0.U
    io.slave.b.valid := false.B
  }
  .elsewhen(writeState === sReady) {
    len_reg_write := io.slave.aw.bits.len
    burst_reg_write := io.slave.aw.bits.burst
    wAddrOffset := ((io.slave.aw.bits.addr - baseAddr.U) & ~(3.U(width.W))) >> 2.U
    io.slave.aw.ready := true.B
    io.slave.w.ready := true.B
    when(io.slave.aw.valid && after_burst){
      after_burst := false.B
    }
    when(io.slave.aw.valid && io.slave.w.valid) {
      memory(wAddrOffset) := writeData.asUInt()
      // val data = writeData.asUInt()
      // printf(
      //   p"writeState === sReady, addr = ${Hexadecimal(io.slave.aw.bits.addr)}]= ${Hexadecimal(data)}\n"
      // )
      writeAddressReg := wAddrOffset
      writeID := io.slave.aw.bits.id
    }
    .elsewhen(io.slave.aw.valid) {
      writeAddressReg := wAddrOffset
      writeID := io.slave.aw.bits.id
    }
    io.slave.b.bits.resp := 0.U
    io.slave.b.valid := false.B

  }
  .elsewhen(writeState === sWaitData) {
    io.slave.aw.ready := false.B
    io.slave.w.ready := true.B
    io.slave.b.bits.resp := 0.U
    io.slave.b.valid := false.B
    when(io.slave.w.valid) {
      when(burst_reg_write === 0.U){
        memory(writeAddressReg) := writeData.asUInt()
      }
      .otherwise{
        memory(writeAddressReg + now_count_write) := writeData.asUInt()
      }
    }
  }
  .elsewhen(writeState === sWLatency) {
    wLatencyCounter := wLatencyCounter + 1.U
  }
  .elsewhen(writeState === sFinish) {
    wLatencyCounter := 0.U
    io.slave.aw.ready := false.B
    io.slave.w.ready := false.B
    io.slave.b.bits.resp := 0.U
    io.slave.b.bits.id := writeID
    io.slave.b.valid := true.B
    when(io.slave.b.ready){
      when((now_count_write + 1.U) === len_reg_write){
        now_count_write := 0.U
        after_burst := true.B
      }
      .otherwise{
        now_count_write := now_count_write + 1.U
      }
    }
  }

  when(io.dump) {
    /* Dump Memory */
    printf("\t\t======== Data Memory Dump ========\n")
    printf(p"\t\tFrom base address ${baseAddr}\n")
    for (i <- 36 until 46) {
      val indexAddr = (baseAddr + i * 4).asUInt
      val data = memory(i.U).asSInt
      printf(
        p"\t\tDataMem[0x${Hexadecimal(indexAddr)}] (address = ${indexAddr}, idx = ${i}) = 0x${Hexadecimal(data)} (${data})\n"
      )
    }
    printf("\n")
  }

}


