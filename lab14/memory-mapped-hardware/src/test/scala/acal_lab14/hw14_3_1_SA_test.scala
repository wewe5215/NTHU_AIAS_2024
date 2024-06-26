package acal_lab14.topSystolicArray

import scala.io.Source
import chisel3.iotesters.{PeekPokeTester, Driver}
import scala.language.implicitConversions
import scala.io.Source
import Config._
import acal_lab14.AXI._
import acal_lab14.AXILite._
import Utils.AXITester

class top_14_3_1_SA_Test(dut: top_Hw14_3_1_SA) extends PeekPokeTester(dut) with AXITester{
    val idWidth = Hw14_3_1_SA_Config.s_id_width
    val addrWidth = Hw14_3_1_SA_Config.addr_width
    val dataWidth = Hw14_3_1_SA_Config.data_width
    implicit def bigint2boolean(b: BigInt): Boolean = if (b > 0) true else false

    // val filename = "./src/main/resource/Hw14-1/inst.asm"
    val lines = Source.fromFile(Hw14_3_1_SA_Config.instr_asm_path).getLines().toList

    while (!peek(dut.io.Hcf)) {
        var current_pc = peek(dut.io.pc).toInt
        var cycle      = peek(dut.io.cycle_count).toInt
        println(
            s"[Cycle ]${"%8d".format(cycle)}"
        )
        println(
            s"[current_pc ]${"%8d".format(current_pc)}"
        )
        println(
        s"[Inst] ${"%-25s".format(lines(current_pc >> 2))}"
        )
        println("==============================")
        step(1)
    }
    step(1)
    println("Inst:Hcf")
    println("This is the end of the program!!")
    println("==============================================")

    var cycle      = peek(dut.io.cycle_count).toInt
    println(
        s"[Cycle ]${"%8d".format(cycle)}"
    )
    println("Value in the RegFile :")
    for (i <- 0 until 4) {
        var value_0 = String
        .format("%" + 8 + "s", peek(dut.io.regs(8 * i + 0)).toInt.toHexString)
        .replace(' ', '0')
        var value_1 = String
        .format("%" + 8 + "s", peek(dut.io.regs(8 * i + 1)).toInt.toHexString)
        .replace(' ', '0')
        var value_2 = String
        .format("%" + 8 + "s", peek(dut.io.regs(8 * i + 2)).toInt.toHexString)
        .replace(' ', '0')
        var value_3 = String
        .format("%" + 8 + "s", peek(dut.io.regs(8 * i + 3)).toInt.toHexString)
        .replace(' ', '0')
        var value_4 = String
        .format("%" + 8 + "s", peek(dut.io.regs(8 * i + 4)).toInt.toHexString)
        .replace(' ', '0')
        var value_5 = String
        .format("%" + 8 + "s", peek(dut.io.regs(8 * i + 5)).toInt.toHexString)
        .replace(' ', '0')
        var value_6 = String
        .format("%" + 8 + "s", peek(dut.io.regs(8 * i + 6)).toInt.toHexString)
        .replace(' ', '0')
        var value_7 = String
        .format("%" + 8 + "s", peek(dut.io.regs(8 * i + 7)).toInt.toHexString)
        .replace(' ', '0')

        println(
            s"reg[${"%02d".format(8 * i + 0)}]：${value_0} " +
            s"reg[${"%02d".format(8 * i + 1)}]：${value_1} " +
            s"reg[${"%02d".format(8 * i + 2)}]：${value_2} " +
            s"reg[${"%02d".format(8 * i + 3)}]：${value_3} " +
            s"reg[${"%02d".format(8 * i + 4)}]：${value_4} " +
            s"reg[${"%02d".format(8 * i + 5)}]：${value_5} " +
            s"reg[${"%02d".format(8 * i + 6)}]：${value_6} " +
            s"reg[${"%02d".format(8 * i + 7)}]：${value_7} "
        )
    }

    println("==============================")
    println("Value in Systolic Array Memory (in decimal)")
    poke(dut.io.tb_en, true)
    for(i <- 0 until 4) {
        if(i==0)
            println("Matrix A :")
        poke(dut.io.tb_slave.r.ready, true)
        val req = genAXIAddr(BigInt(Hw14_3_1_SA_Config.Mem_Base_ADDR + 4 * i))
        poke(dut.io.tb_slave.ar.valid, true)
        poke(dut.io.tb_slave.ar.bits.addr, req.addr)
        poke(dut.io.tb_slave.ar.bits.burst, req.burst)
        poke(dut.io.tb_slave.ar.bits.cache, req.cache)
        poke(dut.io.tb_slave.ar.bits.id, req.id)
        poke(dut.io.tb_slave.ar.bits.len, req.len)
        poke(dut.io.tb_slave.ar.bits.lock, req.lock)
        poke(dut.io.tb_slave.ar.bits.prot, req.prot)
        poke(dut.io.tb_slave.ar.bits.qos, req.qos)
        poke(dut.io.tb_slave.ar.bits.region, req.region)
        poke(dut.io.tb_slave.ar.bits.size, req.size)
        step(1)
        val addr = (Hw14_3_1_SA_Config.Mem_Base_ADDR + 4 * i).toHexString
        while(!peek(dut.io.tb_slave.r.valid)) {
            step(1)
        }
        var value : String = ""
        val data = peek(dut.io.tb_slave.r.bits.data)
        for (j <- 0 until 4) {  // Adjust loop to cover all bytes in a 32-bit data word
            val byteValue = (data >> (8 * j)) & 0xFF
            value += byteValue.toString//f"$byteValue%02x"
            if (j < 3) {
                value += " " // Add a space between bytes for readability
            }
        }
        println(s"mem[0x${addr}] = ${value}")
    }

    for(i <- 0 until 4) {
        if(i==0)
            println("Matrix B :")
        poke(dut.io.tb_slave.r.ready, true)
        val req = genAXIAddr(BigInt(Hw14_3_1_SA_Config.Mem_Base_ADDR + 4 * 4 + 4 * i))
        poke(dut.io.tb_slave.ar.valid, true)
        poke(dut.io.tb_slave.ar.bits.addr, req.addr)
        poke(dut.io.tb_slave.ar.bits.burst, req.burst)
        poke(dut.io.tb_slave.ar.bits.cache, req.cache)
        poke(dut.io.tb_slave.ar.bits.id, req.id)
        poke(dut.io.tb_slave.ar.bits.len, req.len)
        poke(dut.io.tb_slave.ar.bits.lock, req.lock)
        poke(dut.io.tb_slave.ar.bits.prot, req.prot)
        poke(dut.io.tb_slave.ar.bits.qos, req.qos)
        poke(dut.io.tb_slave.ar.bits.region, req.region)
        poke(dut.io.tb_slave.ar.bits.size, req.size)
        step(1)
        val addr = (Hw14_3_1_SA_Config.Mem_Base_ADDR + 4 * 4 + 4 * i).toHexString
        while(!peek(dut.io.tb_slave.r.valid)) {
            step(1)
        }
        var value : String = ""
        val data = peek(dut.io.tb_slave.r.bits.data)
        for (j <- 0 until 4) {  // Adjust loop to cover all bytes in a 32-bit data word
            val byteValue = (data >> (8 * j)) & 0xFF
            value += byteValue.toString//f"$byteValue%02x"
            if (j < 3) {
                value += " " // Add a space between bytes for readability
            }
        }
        println(s"mem[0x${addr}] = ${value}")
    }

    for(i <- 0 until 4) {
        if(i==0)
            println("Output Matrix :")
        poke(dut.io.tb_slave.r.ready, true)
        val req = genAXIAddr(BigInt(Hw14_3_1_SA_Config.Mem_Base_ADDR + 4 * 8 + 4 * i))
        poke(dut.io.tb_slave.ar.valid, true)
        poke(dut.io.tb_slave.ar.bits.addr, req.addr)
        poke(dut.io.tb_slave.ar.bits.burst, req.burst)
        poke(dut.io.tb_slave.ar.bits.cache, req.cache)
        poke(dut.io.tb_slave.ar.bits.id, req.id)
        poke(dut.io.tb_slave.ar.bits.len, req.len)
        poke(dut.io.tb_slave.ar.bits.lock, req.lock)
        poke(dut.io.tb_slave.ar.bits.prot, req.prot)
        poke(dut.io.tb_slave.ar.bits.qos, req.qos)
        poke(dut.io.tb_slave.ar.bits.region, req.region)
        poke(dut.io.tb_slave.ar.bits.size, req.size)
        step(1)
        val addr = (Hw14_3_1_SA_Config.Mem_Base_ADDR + 4 * 8 + 4 * i).toHexString
        while(!peek(dut.io.tb_slave.r.valid)) {
            step(1)
        }
        var value : String = ""
        val data = peek(dut.io.tb_slave.r.bits.data)
        for (j <- 0 until 4) {  // Adjust loop to cover all bytes in a 32-bit data word
            val byteValue = (data >> (8 * j)) & 0xFF
            value += byteValue.toString//f"$byteValue%02x"
            if (j < 3) {
                value += " " // Add a space between bytes for readability
            }
        }
        println(s"mem[0x${addr}] = ${value}")
    }
}

object top_14_3_1_SA_Test extends App {
  Driver.execute(
    args,
    () =>
      new top_Hw14_3_1_SA()
  ) { c: top_Hw14_3_1_SA =>
    new top_14_3_1_SA_Test(c)
  }
}
