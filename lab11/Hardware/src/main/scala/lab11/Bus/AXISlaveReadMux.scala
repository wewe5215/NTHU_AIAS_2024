package AXILite

import chisel3._
import chisel3.util._
import chisel3.experimental.BundleLiterals._
import AXI._

class readOut(val idWidth: Int, val addrWidth: Int, val dataWidth: Int) extends Bundle {
  val readAddr = Decoupled(new Axi4Request(idWidth, addrWidth, dataWidth)) // output address(from read bus) to slave
  val readData = Flipped(Decoupled(new Axi4ReadData(idWidth, dataWidth)))  // input read data from slave
}
class readIn(val idWidth: Int, val addrWidth: Int, val dataWidth: Int) extends Bundle {
  val readAddr = Flipped(Decoupled(new Axi4Request(idWidth, addrWidth, dataWidth))) // input address from readbus
  val readData = Decoupled(new Axi4ReadData(idWidth, dataWidth))                    // output read data(from slave) to readbus
}

class AXISlaveReadMux(val nMasters: Int, val idWidth: Int, val addrWidth: Int, val dataWidth: Int) extends Module {
  val io = IO(new Bundle {
    val out = new readOut(idWidth, addrWidth, dataWidth)
    val in = Vec(nMasters, new readIn(idWidth, addrWidth, dataWidth))
  })

  // each bit in this mask is corresponded to each input for arbiter
  val mask = WireDefault(VecInit(Seq.fill(nMasters)(1.U(1.W))))

  // state enum
  val sIdle :: sWaitResp :: sReturn :: Nil = Enum(3)

  // state register
  val state = RegInit(sIdle)

  // when outstanding is true, meaning that at least a request exists
  val outstanding = WireDefault((0 until nMasters).map(i => io.in(i).readAddr.valid).reduce(_ | _))

  val arbiter = Module(new RRArbiter(Bool(), nMasters))
  val chosen_reg = RegInit(0.U)        // to save chosen bit in arbiter
  val ar_determined = RegInit(false.B) // true for read address determined
  val stay = RegInit(false.B)
  val address_reg = RegInit(new Axi4Request(idWidth, addrWidth, dataWidth).Lit(
    _.addr -> 0.U,
    _.id    -> 0.U,
    _.size  -> 0.U,
    _.burst -> 0.U,
    _.len -> 0.U
  ))
  val data_reg = RegInit((new Axi4ReadData(idWidth, dataWidth).Lit(
    _.id   -> 0.U,     // DontCare in AXILite
    _.data -> 0.U,
    _.resp -> 0.U,
    _.last -> false.B, // DontCare in AXILite
  )))

  // signal initialization
  io.out.readAddr.bits.qos := DontCare
  io.out.readAddr.bits.len := 0.U
  io.out.readAddr.bits.cache := DontCare
  io.out.readAddr.bits.lock := DontCare
  io.out.readAddr.bits.size := 0.U
  io.out.readAddr.bits.id := 0.U
  io.out.readAddr.bits.prot := DontCare
  io.out.readAddr.bits.region := DontCare
  io.out.readAddr.bits.burst := 0.U
  io.out.readData.ready := false.B
  arbiter.io.out.ready := true.B

  for (i <- 0 until nMasters) {
    io.in(i).readData.bits.data := 0.U
    io.in(i).readData.valid := false.B
    io.in(i).readData.bits.resp := 0.U
    io.in(i).readData.bits.id := 0.U
    io.in(i).readData.bits.last := true.B
  }

  for (i <- 0 until nMasters) {
    io.in(i).readAddr.ready := arbiter.io.in(i).ready & mask(i)
    arbiter.io.in(i).valid := io.in(i).readAddr.valid & mask(i)
    arbiter.io.in(i).bits := false.B  // DontCare
  }

  io.out.readAddr.valid := ar_determined // after arbitration, set valid bit to 1

  switch(state){
    is(sIdle){
      when(outstanding){   // when receiving a request, transfer to the next state
        state := sWaitResp
      }
    }
    is(sWaitResp){ // fire() is true when both valid and ready are true
      when(io.out.readData.fire){ // after slave receiving the return data, transfer to the next state
        state := sReturn
      }
    }
    is(sReturn){
      when(io.in(chosen_reg).readData.fire && io.in(chosen_reg).readData.bits.last){ // after the master which gets the grant for arbitration receives the return data, transfer to the idle state
        state := sIdle
      }
      .elsewhen(io.in(chosen_reg).readData.fire && ~io.in(chosen_reg).readData.bits.last){
        state := sWaitResp
      }
    }
  }
  when(state === sIdle){
    mask.foreach(_ := 1.U)  // set all mask bits to 1 in the idle state; otherwise, set them to 0
    when(arbiter.io.out.valid){
      chosen_reg := arbiter.io.chosen
      address_reg <> io.in(arbiter.io.chosen).readAddr.bits
      ar_determined := true.B
    }
    io.out.readData.ready := false.B
  }
  .elsewhen(state === sWaitResp){  // In waitResp state, waiting for read data handshaking
      mask.foreach(_ := 0.U)
      when(io.out.readAddr.fire){
        ar_determined := false.B
      }
      when(io.out.readData.fire){
        data_reg <> io.out.readData.bits
      }
      io.out.readData.ready := true.B
  }
  .elsewhen(state === sReturn){  // In sReturn state, waiting for master side(read bus) handshaking
    mask.foreach(_ := 0.U)
    io.in(chosen_reg).readData.valid := true.B
  }

  io.out.readAddr.bits <> address_reg
  io.in(chosen_reg).readData.bits <> data_reg
}
