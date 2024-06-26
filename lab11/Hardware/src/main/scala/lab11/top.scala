package SoC

import chisel3._
import chisel3.util._

import AXI._
import DMA._
import AXILite._
import Memory._

/*
 DMA < - > Bus - > memory
            |
            V
          memory
*/
class top(idWidth: Int, addrWidth: Int, dataWidth: Int) extends Module {
  val io = IO(new Bundle {
    val Hcf = Output(Bool())
    val slave = new Axi4SlaveIF(idWidth, addrWidth, dataWidth, 2)
    val globalMemDump = Input(Bool())
    val localMemDump = Input(Bool())
  })

  object SystemConfig {
    val nMasters: Int = 1
    val nSlaves: Int = 2
    val DMABaseAddr: Int = 0
    val DMASize: Int = 100
    val LocalMemBaseAddr: Int = 100
    val LocalMemSize: Map[String, Int] = Map(
      "Size" -> 1024, // Height x Width
      "Height" -> 32, // The Number of bytes
      "Width" -> 32 // unit: 32 bits
    )
    val LocalMemLatency: Int = 1
    val LocalMemInitFilePath: String =
      "./src/main/resource/data0.hex" // Provide the file path
    val GlobalMemBaseAddr: Int = 1124 // Provide the base address
    val GlobalMemSize: Map[String, Int] = Map(
      "Size" -> 1024, // Height x Width
      "Height" -> 32, // The Number of bytes
      "Width" -> 32 // unit: 32 bits
    )
    val GlobalMemLatency: Int = 1
    val GlobalMemInitFilePath: String =
      "./src/main/resource/data1.hex" // Provide the file path
  }

  // Module
  val dma = Module(new DMA(idWidth, addrWidth, dataWidth, 0))
  val bus = Module(
    new AXILiteXBar(
      SystemConfig.nMasters,
      SystemConfig.nSlaves,
      idWidth,
      addrWidth,
      dataWidth,
      Seq(
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

  // wire
  val Hcf = Wire(Bool())

  // connect dma and mem through bus
  bus.io.masters(0) <> dma.io.master
  bus.io.slaves(0) <> localMem.io.slave
  bus.io.slaves(1) <> globalMem.io.slave

  // Hcf
  Hcf := dma.io.Hcf

  // io
  io.slave <> dma.io.slave
  io.Hcf := Hcf

  // memory dump signal
  localMem.io.dump := io.localMemDump
  globalMem.io.dump := io.globalMemDump
}
