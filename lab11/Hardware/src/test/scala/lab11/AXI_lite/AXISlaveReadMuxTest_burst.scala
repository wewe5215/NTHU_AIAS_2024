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

class AXISlaveReadMuxBurstTest extends AnyFlatSpec with ChiselScalatestTester with AXITester{

    "Master" should "Read addr from bus & Read data from slave device" in {
        test(new AXISlaveReadMux(
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
                dut.io.in(i).readAddr.initSource().setSourceClock(dut.clock)

                // output ports
                dut.io.in(i).readData.initSink().setSinkClock(dut.clock)
            }
            dut.io.out.readData.initSource().setSourceClock(dut.clock)
            dut.io.out.readAddr.initSink().setSinkClock(dut.clock)

            println("----START TEST----")

            println("[Test 1] Input address from master 0")
            println("[Test 1]: Send address 0x1234 from master 0 to slave")
            println("[Test 1]: Send address 0x1238 from master 0 to slave")
            println("[Test 1]: Respond data 0x4321 from slave")
            println("[Test 1]: Respond data 0x8765 from slave")
            
            fork{
                // Check if the address read from slave is the same as the address from master0
                dut.io.out.readAddr.expectDequeue(genAXIAddr_burst(BigInt("1234", 16), 2, 2, 2))
                // Check if the data read from master 0 is the same as the data from slave
                dut.io.in(0).readData.expectDequeue(genAXIReadData(0, BigInt("4321", 16).toInt, false))
                dut.io.in(0).readData.expectDequeue(genAXIReadData(0, BigInt("5678", 16).toInt, true))
            }.fork{
                dut.io.in(0).readAddr.enqueue(genAXIAddr_burst(BigInt("1234", 16), 2, 2, 2))
                dut.io.out.readData.enqueue(genAXIReadData(0, BigInt("4321", 16).toInt, false))   // Gen resp data from slave
                dut.io.out.readData.enqueue(genAXIReadData(0, BigInt("5678", 16).toInt, true))
            }.join()

            dut.clock.step(2)

            println("--------")
            println("[Test 2] Input address from master 0")
            println("[Test 2]: Send address 0x5678 from master 0 to slave")
            println("[Test 2]: Respond data 0x8765 from slave")

            fork{
                // Check if the address read from slave is the same as the address from master0
                dut.io.out.readAddr.expectDequeue(genAXIAddr_burst(BigInt("1238", 16), 1, 2, 2))
                // Check if the data read from master 0 is the same as the data from slave
                dut.io.in(0).readData.expectDequeue(genAXIReadData(0, BigInt("8765", 16).toInt, true))
            }.fork{
                dut.io.in(0).readAddr.enqueue(genAXIAddr_burst(BigInt("1238", 16), 1, 2, 2))
                dut.io.out.readData.enqueue(genAXIReadData(0, BigInt("8765", 16).toInt, true))
            }.join()


            println("----TEST END----")
        }

    }
}
