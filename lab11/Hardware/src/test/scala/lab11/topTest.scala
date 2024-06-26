package SoC

import org.scalatest._

import chisel3._
import chiseltest._
import chisel3.util._
import chiseltest.{WriteVcdAnnotation, VerilatorBackendAnnotation}
import org.scalatest.freespec.AnyFreeSpec

import Utils.AXITester
import Config._

/** This is a trivial example of how to run this Specification From within sbt
  * use:
  * {{{
  * testOnly SoC.SimpleTopTest
  * }}}
  * From a terminal shell use:
  * {{{
  * sbt 'testOnly SoC.SimpleTopTest'
  * }}}
  */

class SimpleTopTest
    extends AnyFreeSpec
    with ChiselScalatestTester
    with AXITester {
  /*

   */
  "System test" in {
    test(
      new top(
        AXI_Config.s_id_width,
        AXI_Config.addr_width,
        AXI_Config.data_width
      )
    )
      .withAnnotations(
        Seq(
          WriteVcdAnnotation,
          VerilatorBackendAnnotation
        )
      ) { dut =>
        // init clocks
        dut.io.slave.aw.initSource().setSourceClock(dut.clock)
        dut.io.slave.w.initSource().setSourceClock(dut.clock)
        dut.io.slave.ar.initSource().setSourceClock(dut.clock)
        dut.io.slave.r.initSink().setSinkClock(dut.clock)
        dut.io.slave.b.initSink().setSinkClock(dut.clock)

        // make requests
        val prog_source_aw = genAXIAddr(4)
        val prog_source_w = genAXIWriteData(0, 109, "b1111", true)
        val prog_source_b = genAXIWriteResp(0)

        val prog_dest_aw = genAXIAddr(8)
        val prog_dest_w =
          genAXIWriteData(0, 1134, "b1111", true)
        val prog_dest_b = genAXIWriteResp(0)

        val prog_size_aw = genAXIAddr(12)
        val prog_size_w =
          genAXIWriteData(0, BigInt("04040202", 16).toInt, "b1111", true)
        val prog_size_b = genAXIWriteResp(0)

        val prog_enable_aw = genAXIAddr(0)
        val prog_enable_w = genAXIWriteData(0, 1, "b1111", true)
        val prog_enable_b = genAXIWriteResp(0)

        val prog_done_ar = genAXIAddr(20)
        val prog_done_r = genAXIReadData(0, 1, true)

        // Program Source address 109
        fork {
          dut.io.slave.aw.enqueue(prog_source_aw)
        }.fork {
          dut.io.slave.w.enqueue(prog_source_w)
        }.fork {
          dut.io.slave.b.expectDequeue(prog_source_b)
        }.join()

        // Program Dest address 1134
        fork {
          dut.io.slave.aw.enqueue(prog_dest_aw)
        }.fork {
          dut.io.slave.w.enqueue(prog_dest_w)
        }.fork {
          dut.io.slave.b.expectDequeue(prog_dest_b)
        }.join()

        // Program Size
        // SS : 4 (bytes)
        // DS : 4 (bytes)
        // TH : 2 (bytes)
        // TW : 2 (bytes)
        fork {
          dut.io.slave.aw.enqueue(prog_size_aw)
        }.fork {
          dut.io.slave.w.enqueue(prog_size_w)
        }.fork {
          dut.io.slave.b.expectDequeue(prog_size_b)
        }.join()

        // Program start and monitor AR, AW, W, drive R, B
        fork {
          dut.io.slave.aw.enqueue(prog_enable_aw)
        }.fork {
          dut.io.slave.w.enqueue(prog_enable_w)
        }.fork {
          dut.io.slave.b.expectDequeue(prog_enable_b)
        }.join()

        while (dut.io.Hcf.peek().litToBoolean == false) { dut.clock.step(1) }

        // Read DONE bit
        fork {
          dut.io.slave.ar.enqueue(prog_done_ar)
        }.fork {
          dut.io.slave.r.expectDequeue(prog_done_r)
        }.join()

        println("Local Mem:\n")
        dut.io.localMemDump.poke(true.B)
        dut.clock.step(1)
        dut.io.localMemDump.poke(false.B)
        println("Global Mem:\n")
        dut.io.globalMemDump.poke(true.B)
        dut.clock.step(1)
        dut.io.globalMemDump.poke(false.B)
      }
  }

}
