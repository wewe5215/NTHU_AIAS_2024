package AXILite

import chisel3._
import chisel3.util._
import chisel3.experimental.BundleLiterals._
import AXI._

class writeOut(val idWidth: Int, val addrWidth: Int, val dataWidth: Int) extends Bundle {
  val writeAddr = Decoupled(new Axi4Request(idWidth, addrWidth, dataWidth)) // output address to slave for writing data
  val writeData = Decoupled(new Axi4WriteData(dataWidth))                   // output data to write into slave
  val writeResp = Flipped(Decoupled(new Axi4WriteResp(idWidth)))            // response from slave to check write status
}
class writeIn(val idWidth: Int, val addrWidth: Int, val dataWidth: Int) extends Bundle {
  val writeAddr = Flipped(Decoupled(new Axi4Request(idWidth, addrWidth, dataWidth))) // input address from writebus
  val writeData = Flipped(Decoupled(new Axi4WriteData(dataWidth)))                   // input write data from  writebus
  val writeResp = Decoupled(new Axi4WriteResp(idWidth))                              // output write response(response from slave) to writebus
}

class AXISlaveWriteMux(val nMasters: Int, val idWidth: Int, val addrWidth: Int, val dataWidth: Int) extends Module {
  val io = IO(new Bundle {
    val out = new writeOut(idWidth, addrWidth, dataWidth)
    val in = Vec(nMasters, new writeIn(idWidth, addrWidth, dataWidth))
  })

  // each bit in this mask is corresponded to each input for arbiter
  val mask = WireDefault(VecInit(Seq.fill(nMasters)(1.U(1.W))))

  // state enum
  val sIdle :: sWaitData :: sWaitResp :: sReturn :: Nil = Enum(4)

  // state register
  val state = RegInit(sIdle)
  val wait_last = RegInit(false.B)
  // when outstanding is true, meaning that at least a request exists
  val outstanding = WireDefault((0 until nMasters).map(i => io.in(i).writeAddr.valid).reduce(_ | _))


  val arbiter = Module(new RRArbiter(Bool(), nMasters))
  val chosen_reg = RegInit(0.U)
  val w_determined = RegInit(false.B) // true for write data determined
  val aw_determined = RegInit(false.B) // true for write address determined

  val address_reg = RegInit(new Axi4Request(idWidth, addrWidth, dataWidth).Lit(
    _.addr -> 0.U,
    _.id    -> 0.U,
    _.size  -> 0.U,
    _.burst -> 0.U,
    _.len -> 0.U
  ))
  val data_reg = RegInit(new Axi4WriteData(dataWidth).Lit(
    _.data -> 0.U,
    _.strb -> 0.U,
    _.last -> false.B, // DontCare in AXILite
  ))
  val resp_reg = RegInit(new Axi4WriteResp(idWidth).Lit(
    _.id -> 0.U,
    _.resp -> 0.U,
  ))

  // signals initialization
  io.out.writeAddr.bits.qos := DontCare
  io.out.writeAddr.bits.len := 0.U
  io.out.writeAddr.bits.cache := DontCare
  io.out.writeAddr.bits.lock := DontCare
  io.out.writeAddr.bits.size := 0.U
  io.out.writeAddr.bits.id := 0.U
  io.out.writeAddr.bits.prot := DontCare
  io.out.writeAddr.bits.region := DontCare
  io.out.writeAddr.bits.burst := 0.U
  io.out.writeResp.ready := false.B
  arbiter.io.out.ready := true.B

  for (i <- 0 until nMasters) {
    io.in(i).writeData.ready := false.B
    io.in(i).writeResp.valid := false.B
    io.in(i).writeResp.bits.id := 0.U
    io.in(i).writeResp.bits.resp := 0.U
  }

  for (i <- 0 until nMasters) {
    io.in(i).writeAddr.ready := arbiter.io.in(i).ready & mask(i)
    arbiter.io.in(i).valid := io.in(i).writeAddr.valid & mask(i)
    arbiter.io.in(i).bits := false.B  // DontCare
  }
  // printf(p"state = ${state}\n")
  // after arbitration set valid bits
  io.out.writeAddr.valid := aw_determined
  io.out.writeData.valid := w_determined

  switch(state){
    is(sIdle){
      when(outstanding && !wait_last){
        // request and data come at the same time
        when(io.in(arbiter.io.chosen.asUInt).writeData.fire){
          state := sWaitResp
        }
        .otherwise{
          state := sWaitData
        }
      }
    }
    is(sWaitData){
      when(io.in(chosen_reg).writeData.fire){
        state := sWaitResp
      }
    }
    is(sWaitResp){
      when(io.out.writeResp.fire){
        state := sReturn
      }
    }
    is(sReturn){
      when(io.in(chosen_reg).writeResp.fire && io.in(chosen_reg).writeData.bits.last){
        state := sIdle
      }
      .elsewhen(io.in(chosen_reg).writeResp.fire && ~io.in(chosen_reg).writeData.bits.last){
        when(io.in(chosen_reg).writeData.fire){
          state := sWaitResp
        }
        .otherwise{
          state := sWaitData
        }
      }
    }
  }
  // printf(p"io.out.writeData.valid = ${io.out.writeData.valid}, io.out.writeResp.valid = ${io.out.writeResp.valid}\n")
  when(state === sIdle){
    // set all mask bits to 1 in the idle state; otherwise, set them to 0
    mask.foreach(_ := 1.U)
    when(wait_last && io.in(chosen_reg).writeAddr.valid){
      wait_last := false.B
    }
    when(arbiter.io.out.valid && !wait_last){
      io.in(arbiter.io.chosen).writeData.ready := true.B
      chosen_reg := arbiter.io.chosen                              // save arbitration chosen port
      address_reg <> io.in(arbiter.io.chosen).writeAddr.bits       // save chosen port write address
      aw_determined := true.B
      when(io.in(arbiter.io.chosen.asUInt).writeData.fire){        // when data come at the same time
        data_reg <> io.in(arbiter.io.chosen.asUInt).writeData.bits
        w_determined := true.B
      }
    }
    io.out.writeResp.ready := false.B
  }
  .elsewhen(state === sWaitData){  // In this state, write address is detemined, waiting for write data
    mask.foreach(_ := 0.U)
    when(io.in(chosen_reg).writeData.fire){
      data_reg <> io.in(chosen_reg).writeData.bits
      w_determined := true.B
    }
    when(io.out.writeAddr.fire){
      aw_determined := false.B
    }
    io.in(chosen_reg).writeData.ready := true.B
    io.out.writeResp.ready := false.B
  }
  .elsewhen(state === sWaitResp){  // In this state, handle write address/data handshaking
      mask.foreach(_ := 0.U)       // wait for write response
      when(io.out.writeAddr.fire){
        aw_determined := false.B
      }
      when(io.out.writeData.fire){
        w_determined := false.B
      }
      when(io.out.writeResp.fire){
        resp_reg <> io.out.writeResp.bits
      }
      io.out.writeResp.ready := true.B
  }
  .elsewhen(state === sReturn){   // In this state, handle write response handshaking between mux and chosen master
    mask.foreach(_ := 0.U)
    io.in(chosen_reg).writeResp.valid := true.B
    when(io.in(chosen_reg).writeResp.fire && ~io.in(chosen_reg).writeData.bits.last){
      io.out.writeResp.ready := false.B
      wait_last := true.B
      when(io.in(chosen_reg).writeData.fire){        // when data come at the same time
        data_reg <> io.in(chosen_reg).writeData.bits
        w_determined := true.B
      }
    }
  }

  io.out.writeData.bits <> data_reg
  io.out.writeAddr.bits <> address_reg
  io.in(chosen_reg).writeResp.bits <> resp_reg
}
