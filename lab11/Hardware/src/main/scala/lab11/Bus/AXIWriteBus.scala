package AXILite

import chisel3._
import chisel3.util._
import AXI._

class writeMaster(val idWidth: Int, val addrWidth: Int, val dataWidth: Int) extends Bundle {
  val writeAddr = Flipped(Decoupled(new Axi4Request(idWidth, addrWidth, dataWidth)))
  val writeData = Flipped(Decoupled(new Axi4WriteData(dataWidth)))
  val writeResp = Decoupled(new Axi4WriteResp(idWidth))
}
class writeSlave(val idWidth: Int, val addrWidth: Int, val dataWidth: Int) extends Bundle {
  val writeAddr = Decoupled(new Axi4Request(idWidth, addrWidth, dataWidth))
  val writeData = Decoupled(new Axi4WriteData(dataWidth))
  val writeResp = Flipped(Decoupled(new Axi4WriteResp(idWidth)))
}


class AXIWriteBus(val mSlaves: Int, val idWidth: Int, val addrWidth: Int, val dataWidth: Int, val addrMap: Seq[(Int,Int)]) extends Module {
  val io = IO(new Bundle {
    val master = new writeMaster(idWidth, addrWidth, dataWidth)
    val slave = Vec(mSlaves, new writeSlave(idWidth, addrWidth, dataWidth))
  })

  // demux logic to decide the port to be routed
  // For example: addrMap.zipWithIndex.map will return List((false,0), (true,1)) to MuxCase
  val write_port = MuxCase(0.U, addrMap.zipWithIndex.map { case ((startAddress, size), index) =>
    (io.master.writeAddr.bits.addr >= startAddress.U && io.master.writeAddr.bits.addr < (startAddress + size).U) -> index.U
  })

  val write_port_reg = RegInit(0.U(addrMap.length.W))       // write port register

  val write_addr_reg = RegInit(0.U(addrWidth.W))            // address register
  val write_addr_reg_valid = RegInit(false.B)               // address valid register
  val write_addr_reg_id = RegInit(0.U(idWidth.W))           // id register
  val write_addr_reg_size = RegInit(0.U(3.W))               // size register
  val write_addr_reg_burst = RegInit(0.U(2.W))              // write burst register
  val write_addr_reg_len = RegInit(0.U(8.W)) 

  val write_data_reg = RegInit(0.U(dataWidth.W))            // data register
  val write_data_reg_valid = RegInit(false.B)               // data valid register
  val write_data_reg_strb = RegInit(0.U((dataWidth / 8).W)) // data strb register
  val write_data_reg_last = RegInit(false.B)                // data last register

  val write_resp_reg = RegInit(0.U(idWidth.W))              // write response register
  val write_resp_reg_valid = RegInit(false.B)               // write response valid register
  val write_resp_reg_id = RegInit(0.U(idWidth.W))           // write response id register

  // outstanding request refers to a data request that has not been resolved or serviced yet
  val w_outstanding = RegInit(false.B) // true for write data arriving
  val aw_outstanding = RegInit(false.B) // true for write address arriving
  val b_outstanding = RegInit(false.B) // true for write response arriving

  // signal initialization
  for (i <- 0 until mSlaves) {
    io.slave(i).writeData.valid := false.B
    io.slave(i).writeData.bits.data := 0.U
    io.slave(i).writeData.bits.strb := 0.U
    io.slave(i).writeData.bits.last := 0.U
    io.slave(i).writeAddr.valid := false.B
    io.slave(i).writeAddr.bits.addr := 0.U
    io.slave(i).writeAddr.bits.id := 0.U
    io.slave(i).writeAddr.bits.region := DontCare
    io.slave(i).writeAddr.bits.len := 0.U
    io.slave(i).writeAddr.bits.size := 0.U
    io.slave(i).writeAddr.bits.burst := 0.U
    io.slave(i).writeAddr.bits.lock := DontCare
    io.slave(i).writeAddr.bits.cache := DontCare
    io.slave(i).writeAddr.bits.prot := DontCare
    io.slave(i).writeAddr.bits.qos := DontCare
    io.slave(i).writeResp.ready := false.B
  }

  io.master.writeData.ready := ~w_outstanding       // when receiving write data, bus will not be ready for write data
  io.master.writeAddr.ready := ~aw_outstanding      // when receiving write address, bus will not be ready for write address
  io.master.writeResp.valid := write_resp_reg_valid
  io.master.writeResp.bits.resp := write_resp_reg
  io.master.writeResp.bits.id := write_resp_reg_id

  // The purpose of this code is to ensure correctness when data and address may not arrive simultaneously
  // When handshaking is done bus will save the data and set outstanding signal
  when(io.master.writeAddr.fire) {
    aw_outstanding := true.B
    write_port_reg := write_port
    write_addr_reg := io.master.writeAddr.bits.addr
    write_addr_reg_valid := true.B
    write_addr_reg_id := io.master.writeAddr.bits.id
    write_addr_reg_size := io.master.writeAddr.bits.size
    write_addr_reg_burst := io.master.writeAddr.bits.burst
    write_addr_reg_len := io.master.writeAddr.bits.len
  }
  when(io.master.writeData.fire) {
    w_outstanding := true.B
    write_data_reg_strb := io.master.writeData.bits.strb
    write_data_reg := io.master.writeData.bits.data
    write_data_reg_valid := true.B
    write_data_reg_last := io.master.writeData.bits.last
  }

  // when slave receive data or address, set valid to 0
  when(write_addr_reg_valid && io.slave(write_port_reg).writeAddr.ready) {
      write_addr_reg_valid := false.B
  }
  when(write_data_reg_valid && io.slave(write_port_reg).writeData.ready) {
      write_data_reg_valid := false.B
  }

  // when write response valid which means the write transaction is completed
  when(aw_outstanding && w_outstanding && write_resp_reg_valid && io.master.writeResp.ready) {
      write_resp_reg_valid := false.B
      aw_outstanding := false.B
      w_outstanding := false.B
      b_outstanding := false.B
  }

  when(aw_outstanding) {
    // handle write response handshaking
    when(io.slave(write_port_reg).writeResp.fire){
      b_outstanding := true.B
      write_resp_reg_valid := true.B
      write_resp_reg := io.slave(write_port_reg).writeResp.bits.resp
      write_resp_reg_id := io.slave(write_port_reg).writeResp.bits.id
    }
    // forward address and data related signals to selected port
    io.slave(write_port_reg).writeAddr.bits.addr := write_addr_reg
    io.slave(write_port_reg).writeAddr.valid := write_addr_reg_valid
    io.slave(write_port_reg).writeAddr.bits.id := write_addr_reg_id
    io.slave(write_port_reg).writeAddr.bits.size := write_addr_reg_size
    io.slave(write_port_reg).writeAddr.bits.burst := write_addr_reg_burst
    io.slave(write_port_reg).writeAddr.bits.len := write_addr_reg_len
    io.slave(write_port_reg).writeData.bits.data := write_data_reg
    io.slave(write_port_reg).writeData.bits.strb := write_data_reg_strb
    io.slave(write_port_reg).writeData.valid := write_data_reg_valid
    io.slave(write_port_reg).writeData.bits.last := write_data_reg_last
    io.slave(write_port_reg).writeResp.ready := ~b_outstanding
  }

}
