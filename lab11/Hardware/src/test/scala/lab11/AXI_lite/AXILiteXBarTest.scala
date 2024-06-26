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

class AXILiteXBarTest
    extends AnyFlatSpec
    with ChiselScalatestTester
    with AXITester {

  "Masters" should "send/read data to each Slaves according to addr" in {
    test(
      new AXILiteXBar(
        AXI_Config.master_num,
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
      // * masters
      for (i <- 0 until AXI_Config.master_num) {
        // input port
        dut.io.masters(i).ar.initSource().setSourceClock(dut.clock)
        dut.io.masters(i).aw.initSource().setSourceClock(dut.clock)
        dut.io.masters(i).w.initSource().setSourceClock(dut.clock)

        // output ports
        dut.io.masters(i).r.initSink().setSinkClock(dut.clock)
        dut.io.masters(i).b.initSink().setSinkClock(dut.clock)
      }
      // * slaves
      for (i <- 0 until AXI_Config.slave_num) {
        // input port
        dut.io.slaves(i).r.initSource().setSourceClock(dut.clock)
        dut.io.slaves(i).b.initSource().setSourceClock(dut.clock)

        // output ports
        dut.io.slaves(i).ar.initSink().setSinkClock(dut.clock)
        dut.io.slaves(i).aw.initSink().setSinkClock(dut.clock)
        dut.io.slaves(i).w.initSink().setSinkClock(dut.clock)
      }

      println("----START TEST----")

      println("[Test 1] AXI cross bar READ test")
      println("[Test 1]: Masters read from each slave according to addr")
      println("[Test 1]: Slaves respond data to each master")

      fork {
        dut.io.slaves(0).ar.expectDequeue(genAXIAddr(BigInt("9000", 16).toInt))
        dut.io.slaves(0).ar.expectDequeue(genAXIAddr(BigInt("9008", 16).toInt))
      }.fork {
        dut.io.slaves(1).ar.expectDequeue(genAXIAddr(BigInt("19000", 16).toInt))
        dut.io.slaves(1).ar.expectDequeue(genAXIAddr(BigInt("19008", 16).toInt))
      }.fork {
        dut.io
          .masters(0)
          .r
          .expectDequeue(genAXIReadData(0, BigInt("00010203", 16).toInt, true))
        dut.io
          .masters(0)
          .r
          .expectDequeue(genAXIReadData(0, BigInt("04050607", 16).toInt, true))
      }.fork {
        dut.io
          .masters(1)
          .r
          .expectDequeue(genAXIReadData(0, BigInt("08090a0b", 16).toInt, true))
        dut.io
          .masters(1)
          .r
          .expectDequeue(genAXIReadData(0, BigInt("0c0d0e0f", 16).toInt, true))
      }.fork {
        dut.io
          .slaves(0)
          .r
          .enqueue(genAXIReadData(0, BigInt("00010203", 16).toInt, true))
        dut.io
          .slaves(0)
          .r
          .enqueue(genAXIReadData(0, BigInt("0c0d0e0f", 16).toInt, true))
      }.fork {
        dut.io
          .slaves(1)
          .r
          .enqueue(genAXIReadData(0, BigInt("08090a0b", 16).toInt, true))
        dut.io
          .slaves(1)
          .r
          .enqueue(genAXIReadData(0, BigInt("04050607", 16).toInt, true))
      }.fork {
        dut.io.masters(0).ar.enqueue(genAXIAddr(BigInt("9000", 16).toInt))
        dut.io.masters(0).ar.enqueue(genAXIAddr(BigInt("19008", 16).toInt))
      }.fork {
        dut.io.masters(1).ar.enqueue(genAXIAddr(BigInt("19000", 16).toInt))
        dut.io.masters(1).ar.enqueue(genAXIAddr(BigInt("9008", 16).toInt))
      }.join()

      dut.clock.step(1)

      println("--------")
      println("[Test 2] AXI cross bar WRITE test")
      println("[Test 2]: Masters write data to each slave according to addr")
      println("[Test 2]: Slaves respond after handshake")

      fork {
        dut.io.slaves(0).aw.expectDequeue(genAXIAddr(BigInt("9000", 16).toInt))
        dut.io.slaves(0).aw.expectDequeue(genAXIAddr(BigInt("9008", 16).toInt))
      }.fork {
        dut.io.slaves(1).aw.expectDequeue(genAXIAddr(BigInt("19000", 16).toInt))
        dut.io.slaves(1).aw.expectDequeue(genAXIAddr(BigInt("19008", 16).toInt))
      }.fork {
        dut.io
          .slaves(0)
          .w
          .expectDequeue(
            genAXIWriteData(0, BigInt("00010203", 16).toInt, "b1111", true)
          )
        dut.io
          .slaves(0)
          .w
          .expectDequeue(
            genAXIWriteData(0, BigInt("04050607", 16).toInt, "b1111", true)
          )
      }.fork {
        dut.io
          .slaves(1)
          .w
          .expectDequeue(
            genAXIWriteData(0, BigInt("08090a0b", 16).toInt, "b1111", true)
          )
        dut.io
          .slaves(1)
          .w
          .expectDequeue(
            genAXIWriteData(0, BigInt("0c0d0e0f", 16).toInt, "b1111", true)
          )
      }.fork {
        dut.io.masters(0).b.expectDequeue(genAXIWriteResp(0))
        dut.io.masters(0).b.expectDequeue(genAXIWriteResp(0))
      }.fork {
        dut.io.masters(1).b.expectDequeue(genAXIWriteResp(0))
        dut.io.masters(1).b.expectDequeue(genAXIWriteResp(0))
      }.fork {
        dut.io.masters(0).aw.enqueue(genAXIAddr(BigInt("9000", 16).toInt))
        dut.io.masters(0).aw.enqueue(genAXIAddr(BigInt("19008", 16).toInt))
      }.fork {
        dut.io.masters(1).aw.enqueue(genAXIAddr(BigInt("19000", 16).toInt))
        dut.io.masters(1).aw.enqueue(genAXIAddr(BigInt("9008", 16).toInt))
      }.fork {
        dut.io
          .masters(0)
          .w
          .enqueue(
            genAXIWriteData(0, BigInt("00010203", 16).toInt, "b1111", true)
          )
        dut.io
          .masters(0)
          .w
          .enqueue(
            genAXIWriteData(0, BigInt("0c0d0e0f", 16).toInt, "b1111", true)
          )
      }.fork {
        dut.io
          .masters(1)
          .w
          .enqueue(
            genAXIWriteData(0, BigInt("08090a0b", 16).toInt, "b1111", true)
          )
        dut.io
          .masters(1)
          .w
          .enqueue(
            genAXIWriteData(0, BigInt("04050607", 16).toInt, "b1111", true)
          )
      }.fork {
        for (i <- 0 until 2) {
          fork
            .withRegion(Monitor) {
              while (
                !dut.io
                  .slaves(0)
                  .aw
                  .valid
                  .peek()
                  .litToBoolean || !dut.io.slaves(0).w.valid.peek().litToBoolean
              )
                dut.clock.step(1)
            }
            .joinAndStep(dut.clock)
          dut.io.slaves(0).b.enqueue(genAXIWriteResp(0))
        }
      }.fork {
        for (i <- 0 until 2) {
          fork
            .withRegion(Monitor) {
              while (
                !dut.io
                  .slaves(1)
                  .aw
                  .valid
                  .peek()
                  .litToBoolean || !dut.io.slaves(1).w.valid.peek().litToBoolean
              )
                dut.clock.step(1)
            }
            .joinAndStep(dut.clock)
          dut.io.slaves(1).b.enqueue(genAXIWriteResp(0))
        }
      }.join()

      println("--------")
      println("[Test 3] AXI cross bar READ arbitration test")
      println("[Test 3]: Masters read data to same slave (slave0)")
      println("[Test 3]: Slave 0 respond data to each master accordingly")

      fork {
        dut.io.slaves(0).ar.expectDequeue(genAXIAddr(BigInt("9000", 16).toInt))
        dut.io.slaves(0).ar.expectDequeue(genAXIAddr(BigInt("9016", 16).toInt))
        dut.io.slaves(0).ar.expectDequeue(genAXIAddr(BigInt("9008", 16).toInt))
        dut.io.slaves(0).ar.expectDequeue(genAXIAddr(BigInt("9024", 16).toInt))
      }.fork {
        dut.io
          .masters(0)
          .r
          .expectDequeue(genAXIReadData(0, BigInt("00010203", 16).toInt, true))
        dut.io
          .masters(0)
          .r
          .expectDequeue(genAXIReadData(0, BigInt("08090a0b", 16).toInt, true))
      }.fork {
        dut.io
          .masters(1)
          .r
          .expectDequeue(genAXIReadData(0, BigInt("04050607", 16).toInt, true))
        dut.io
          .masters(1)
          .r
          .expectDequeue(genAXIReadData(0, BigInt("0c0d0e0f", 16).toInt, true))
      }.fork {
        dut.io
          .slaves(0)
          .r
          .enqueue(genAXIReadData(0, BigInt("00010203", 16).toInt, true))
        dut.io
          .slaves(0)
          .r
          .enqueue(genAXIReadData(0, BigInt("04050607", 16).toInt, true))
        dut.io
          .slaves(0)
          .r
          .enqueue(genAXIReadData(0, BigInt("08090a0b", 16).toInt, true))
        dut.io
          .slaves(0)
          .r
          .enqueue(genAXIReadData(0, BigInt("0c0d0e0f", 16).toInt, true))
      }.fork {
        dut.io.masters(0).ar.enqueue(genAXIAddr(BigInt("9000", 16).toInt))
        dut.io.masters(0).ar.enqueue(genAXIAddr(BigInt("9008", 16).toInt))
      }.fork {
        dut.io.masters(1).ar.enqueue(genAXIAddr(BigInt("9016", 16).toInt))
        dut.io.masters(1).ar.enqueue(genAXIAddr(BigInt("9024", 16).toInt))
      }.join()

      dut.clock.step(1)

      println("--------")
      println("[Test 4] AXI cross bar WRITE arbitration test")
      println("[Test 4]: Masters write data to same slave (slave1)")
      println("[Test 4]: Slave 1 respond after handshake accordingly")

      fork {
        dut.io.slaves(1).aw.expectDequeue(genAXIAddr(BigInt("19016", 16).toInt))
        dut.io.slaves(1).aw.expectDequeue(genAXIAddr(BigInt("19000", 16).toInt))
        dut.io.slaves(1).aw.expectDequeue(genAXIAddr(BigInt("19024", 16).toInt))
        dut.io.slaves(1).aw.expectDequeue(genAXIAddr(BigInt("19008", 16).toInt))
      }.fork {
        dut.io
          .slaves(1)
          .w
          .expectDequeue(
            genAXIWriteData(0, BigInt("08090a0b", 16).toInt, "b1111", true)
          )
        dut.io
          .slaves(1)
          .w
          .expectDequeue(
            genAXIWriteData(0, BigInt("00010203", 16).toInt, "b1111", true)
          )
        dut.io
          .slaves(1)
          .w
          .expectDequeue(
            genAXIWriteData(0, BigInt("0c0d0e0f", 16).toInt, "b1111", true)
          )
        dut.io
          .slaves(1)
          .w
          .expectDequeue(
            genAXIWriteData(0, BigInt("04050607", 16).toInt, "b1111", true)
          )
      }.fork {
        dut.io.masters(0).b.expectDequeue(genAXIWriteResp(0))
        dut.io.masters(0).b.expectDequeue(genAXIWriteResp(0))
      }.fork {
        dut.io.masters(1).b.expectDequeue(genAXIWriteResp(0))
        dut.io.masters(1).b.expectDequeue(genAXIWriteResp(0))
      }.fork {
        dut.io.masters(0).aw.enqueue(genAXIAddr(BigInt("19000", 16).toInt))
        dut.io.masters(0).aw.enqueue(genAXIAddr(BigInt("19008", 16).toInt))
      }.fork {
        dut.io.masters(1).aw.enqueue(genAXIAddr(BigInt("19016", 16).toInt))
        dut.io.masters(1).aw.enqueue(genAXIAddr(BigInt("19024", 16).toInt))
      }.fork {
        dut.io
          .masters(0)
          .w
          .enqueue(
            genAXIWriteData(0, BigInt("00010203", 16).toInt, "b1111", true)
          )
        dut.io
          .masters(0)
          .w
          .enqueue(
            genAXIWriteData(0, BigInt("04050607", 16).toInt, "b1111", true)
          )
      }.fork {
        dut.io
          .masters(1)
          .w
          .enqueue(
            genAXIWriteData(0, BigInt("08090a0b", 16).toInt, "b1111", true)
          )
        dut.io
          .masters(1)
          .w
          .enqueue(
            genAXIWriteData(0, BigInt("0c0d0e0f", 16).toInt, "b1111", true)
          )
      }.fork {
        for (i <- 0 until 4) {
          fork
            .withRegion(Monitor) {
              while (
                !dut.io
                  .slaves(1)
                  .aw
                  .valid
                  .peek()
                  .litToBoolean || !dut.io.slaves(1).w.valid.peek().litToBoolean
              )
                dut.clock.step(1)
            }
            .joinAndStep(dut.clock)
          dut.io.slaves(1).b.enqueue(genAXIWriteResp(0))
        }
      }.join()

      dut.clock.step(1)

      println("--------")
      println("[Test 5] AXI cross bar READ & WRITE same slave at the same time")
      println("[Test 5]: Master0 read data from slave0")
      println("[Test 5]: Master1 write data to slave0")
      println("[Test 5]: Slave 0 respond at the same time")

      fork {
        dut.io.slaves(0).ar.expectDequeue(genAXIAddr(BigInt("9000", 16).toInt))
      }.fork {
        dut.io.slaves(0).aw.expectDequeue(genAXIAddr(BigInt("9000", 16).toInt))
      }.fork {
        dut.io
          .slaves(0)
          .w
          .expectDequeue(
            genAXIWriteData(0, BigInt("1EADBEEF", 16).toInt, "b1111", true)
          )
      }.fork {
        dut.io
          .masters(0)
          .r
          .expectDequeue(genAXIReadData(0, BigInt("1AFEBABE", 16).toInt, true))
      }.fork {
        dut.io.masters(1).b.expectDequeue(genAXIWriteResp(0))
      }.fork {
        dut.io.masters(0).ar.enqueue(genAXIAddr(BigInt("9000", 16).toInt))
      }.fork {
        dut.io
          .slaves(0)
          .r
          .enqueue(genAXIReadData(0, BigInt("1AFEBABE", 16).toInt, true))
      }.fork {
        dut.io.masters(1).aw.enqueue(genAXIAddr(BigInt("9000", 16).toInt))
      }.fork {
        dut.io
          .masters(1)
          .w
          .enqueue(
            genAXIWriteData(0, BigInt("1EADBEEF", 16).toInt, "b1111", true)
          )
      }.fork {
        fork
          .withRegion(Monitor) {
            while (
              !dut.io
                .slaves(0)
                .aw
                .valid
                .peek()
                .litToBoolean || !dut.io.slaves(0).w.valid.peek().litToBoolean
            )
              dut.clock.step(1)
          }
          .joinAndStep(dut.clock)
        dut.io.slaves(0).b.enqueue(genAXIWriteResp(0))
      }.join()

      dut.clock.step(1)

      println("----TEST END----")
    }
  }
}
