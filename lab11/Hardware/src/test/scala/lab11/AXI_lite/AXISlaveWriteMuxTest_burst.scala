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

class AXISlaveWriteMuxBurstTest extends AnyFlatSpec with ChiselScalatestTester with AXITester{

    "Master" should "Write addr to bus & Write data to slave device" in {
        test(new AXISlaveWriteMux(
            AXI_Config.master_num,
            AXI_Config.s_id_width,
            AXI_Config.addr_width,
            AXI_Config.data_width,
        )).withAnnotations(Seq(
            WriteVcdAnnotation,
        )){ dut =>
            /* Initialize IO ports */
            for (i <- 0 until AXI_Config.master_num) {
                // input port
                dut.io.in(i).writeAddr.initSource().setSourceClock(dut.clock)
                dut.io.in(i).writeData.initSource().setSourceClock(dut.clock)

                // output ports
                dut.io.in(i).writeResp.initSink().setSinkClock(dut.clock)
            }
            dut.io.out.writeResp.initSource().setSourceClock(dut.clock)
            dut.io.out.writeAddr.initSink().setSinkClock(dut.clock)
            dut.io.out.writeData.initSink().setSinkClock(dut.clock)

            println("----START TEST----")

            println("[Test 1] Input from master 0")
            println("[Test 1]: Send address 0x1234 & data 0x4321 from master 0 to slave")

            dut.clock.step(1)
            fork{
                dut.io.out.writeAddr.expectDequeue(genAXIAddr_burst(BigInt("1234", 16), 2, 2, 2))
                dut.io.out.writeAddr.expectDequeue(genAXIAddr_burst(BigInt("1234", 16), 2, 2, 2))
            }.fork{
                dut.io.out.writeData.expectDequeue(genAXIWriteData(0, BigInt("4321", 16).toInt, "b1111", false))
                dut.io.out.writeData.expectDequeue(genAXIWriteData(0, BigInt("8765", 16).toInt, "b1111", true))
            }.fork{
                dut.io.in(0).writeResp.expectDequeue(genAXIWriteResp(0))
                dut.io.in(0).writeResp.expectDequeue(genAXIWriteResp(0))
            }.fork{
                dut.io.in(0).writeAddr.enqueue(genAXIAddr_burst(BigInt("1234", 16), 2, 2, 2))
                dut.io.in(0).writeAddr.enqueue(genAXIAddr_burst(BigInt("1234", 16), 2, 2, 2))
            }.fork{
                dut.io.in(0).writeData.enqueue(genAXIWriteData(0, BigInt("4321", 16).toInt, "b1111", false))
                dut.io.in(0).writeData.enqueue(genAXIWriteData(0, BigInt("8765", 16).toInt, "b1111", true))
            }.fork{
                fork.withRegion(Monitor){
                    while(!dut.io.out.writeAddr.valid.peek().litToBoolean || !dut.io.out.writeData.valid.peek().litToBoolean){
                        dut.clock.step(1)
                    }
                }.joinAndStep(dut.clock)
                dut.io.out.writeResp.enqueue(genAXIWriteResp(0))
                fork.withRegion(Monitor){
                    while(!dut.io.out.writeData.valid.peek().litToBoolean){
                        dut.clock.step(1)
                    }
                }.joinAndStep(dut.clock)
                dut.io.out.writeResp.enqueue(genAXIWriteResp(0))
            }.join()


            println("----TEST END----")
        }
    }
}
