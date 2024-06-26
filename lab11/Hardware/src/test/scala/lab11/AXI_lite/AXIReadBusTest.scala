package AXILite

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import chiseltest.ChiselScalatestTester

import chiseltest.simulator.WriteVcdAnnotation
import chisel3.experimental.BundleLiterals._

import AXI._
import Config._
import Utils.AXITester

class AXIReadBusTest
    extends AnyFlatSpec
    with ChiselScalatestTester
    with AXITester {

  "Master" should "Read data from each slave according to different address" in {
    test(
      new AXIReadBus(
        AXI_Config.slave_num,
        AXI_Config.s_id_width,
        AXI_Config.addr_width,
        AXI_Config.data_width,
        AXI_Config.addr_map
      )
    ).withAnnotations(
      Seq(
        WriteVcdAnnotation
      )
    ) { dut =>
      /* Initialize IO ports */
      // * master
      for (i <- 0 until AXI_Config.master_num) {
        // input port
        dut.io.master.readAddr.initSource().setSourceClock(dut.clock)

        // output ports
        dut.io.master.readData.initSink().setSinkClock(dut.clock)
      }
      // * slave
      for (i <- 0 until AXI_Config.slave_num) {
        // input port
        dut.io.slave(i).readData.initSource().setSourceClock(dut.clock)

        // output ports
        dut.io.slave(i).readAddr.initSink().setSinkClock(dut.clock)
      }

      println("----START TEST----")

      fork {
        dut.io
          .slave(0)
          .readAddr
          .expectDequeue(genAXIAddr(BigInt("9000", 16)))
        dut.io
          .slave(0)
          .readAddr
          .expectDequeue(genAXIAddr(BigInt("9008", 16)))
      }.fork {
        dut.io
          .slave(1)
          .readAddr
          .expectDequeue(genAXIAddr(BigInt("19000", 16)))
        dut.io
          .slave(1)
          .readAddr
          .expectDequeue(genAXIAddr(BigInt("19008", 16)))
      }.fork {
        dut.io.master.readData.expectDequeue(
          genAXIReadData(0, BigInt("00010203", 16).toInt, true)
        )
        dut.io.master.readData.expectDequeue(
          genAXIReadData(0, BigInt("04050607", 16).toInt, true)
        )
        dut.io.master.readData.expectDequeue(
          genAXIReadData(0, BigInt("08090a0b", 16).toInt, true)
        )
        dut.io.master.readData.expectDequeue(
          genAXIReadData(0, BigInt("0c0d0e0f", 16).toInt, true)
        )
      }.fork {
        dut.io
          .slave(0)
          .readData
          .enqueue(genAXIReadData(0, BigInt("00010203", 16).toInt, true))
        dut.io
          .slave(0)
          .readData
          .enqueue(genAXIReadData(0, BigInt("04050607", 16).toInt, true))
      }.fork {
        dut.io
          .slave(1)
          .readData
          .enqueue(genAXIReadData(0, BigInt("08090a0b", 16).toInt, true))
        dut.io
          .slave(1)
          .readData
          .enqueue(genAXIReadData(0, BigInt("0c0d0e0f", 16).toInt, true))
      }.fork {
        dut.io.master.readAddr.enqueue(genAXIAddr(BigInt("9000", 16)))
        dut.io.master.readAddr.enqueue(genAXIAddr(BigInt("9008", 16)))
        dut.io.master.readAddr.enqueue(genAXIAddr(BigInt("19000", 16)))
        dut.io.master.readAddr.enqueue(genAXIAddr(BigInt("19008", 16)))
      }.join()
      dut.clock.step(2)

      println("----TEST END----")
    }
  }
}
