package acal_lab14.topSystolicArray

import scala.io.Source
import chisel3.iotesters.{PeekPokeTester, Driver}
import scala.language.implicitConversions
import scala.io.Source
import Config._
import acal_lab14.AXI._
import acal_lab14.AXILite._
import Utils.AXITester


class top_14_4_SA_Test(dut: top_Hw14_4) extends PeekPokeTester(dut) with AXITester{
  val idWidth = Hw14_4_SA_Config.s_id_width
  val addrWidth = Hw14_4_SA_Config.addr_width
  val dataWidth = Hw14_4_SA_Config.data_width
  implicit def bigint2boolean(b: BigInt): Boolean = if (b > 0) true else false

  val lines    = Source.fromFile(Hw14_4_SA_Config.instr_asm_path).getLines.toList

  /* Lab 9_3 performance counter */
  var Cycle_Count = 0
  var Inst_Count = 0
  var Conditional_Branch_Count = 0
  var Unconditional_Branch_Count = 0
  var Conditional_Branch_Hit_Count = 0
  var Unconditional_Branch_Hit_Count = 0
  var Flush_Count = 0
  /* Lab 9_3 performance counter */

  while (!peek(dut.io.Hcf)) {
    var PC_IF = peek(dut.io.IF_PC).toInt
    var PC_ID = peek(dut.io.ID_PC).toInt
    var PC_EXE = peek(dut.io.EXE_PC).toInt
    var PC_MEM = peek(dut.io.MEM_PC).toInt
    var PC_WB = peek(dut.io.WB_PC).toInt

    var E_BT = peek(dut.io.E_Branch_taken).toInt
    var Flush = peek(dut.io.Flush).toInt
    var Stall_MA = peek(dut.io.Stall_MA).toInt
    var Stall_DH = peek(dut.io.Stall_DH).toInt
    var alu_out = (peek(dut.io.EXE_alu_out).toInt.toHexString).replace(' ', '0')
    var EXE_src1 = (peek(dut.io.EXE_src1).toInt.toHexString).replace(' ', '0')
    var EXE_src2 = (peek(dut.io.EXE_src2).toInt.toHexString).replace(' ', '0')
    var ALU_src1 = (peek(dut.io.ALU_src1).toInt.toHexString).replace(' ', '0')
    var ALU_src2 = (peek(dut.io.ALU_src2).toInt.toHexString).replace(' ', '0')
    var DM_rdata = (peek(dut.io.rdata).toInt.toHexString).replace(' ', '0')
    var DM_raddr = (peek(dut.io.raddr).toInt.toHexString).replace(' ', '0')
    var WB_reg = peek(dut.io.WB_rd).toInt
    var WB_wdata = (peek(dut.io.WB_wdata).toInt.toHexString).replace(' ', '0')

    var EXE_Jump = peek(dut.io.EXE_Jump).toInt
    var EXE_Branch = peek(dut.io.EXE_Branch).toInt
    println(
      s"[PC_IF ]${"%8d".format(PC_IF)} [Inst] ${"%-25s".format(lines(PC_IF >> 2))} "
    )
    println(
      s"[PC_ID ]${"%8d".format(PC_ID)} [Inst] ${"%-25s".format(lines(PC_ID >> 2))} "
    )
    println(
      s"[PC_EXE]${"%8d".format(PC_EXE)} [Inst] ${"%-25s".format(lines(PC_EXE >> 2))} " +
        s"[EXE src1]${"%8s".format(EXE_src1)} [EXE src2]${"%8s".format(EXE_src2)} " +
        s"[Br taken] ${"%1d".format(E_BT)} "
    )
    println(
      s"                                                  " +
        s"[ALU src1]${"%8s".format(ALU_src1)} [ALU src2]${"%8s".format(ALU_src2)} " +
        s"[ALU Out]${"%8s".format(alu_out)}"
    )
    println(
      s"[PC_MEM]${"%8d".format(PC_MEM)} [Inst] ${"%-25s".format(lines(PC_MEM >> 2))} " +
        s"[DM Raddr]${"%8s".format(DM_raddr)} [DM Rdata]${"%8s".format(DM_rdata)}"
    )
    println(
      s"[PC_WB ]${"%8d".format(PC_WB)} [Inst] ${"%-25s".format(lines(PC_WB >> 2))} " +
        s"[ WB reg ]${"%8d".format(WB_reg)} [WB  data]${"%8s".format(WB_wdata)}"
    )
    println(s"[Flush ] ${"%1d".format(Flush)} [Stall_MA ] ${"%1d"
        .format(Stall_MA)} [Stall_DH ] ${"%1d".format(Stall_DH)} ")
    println("==============================================")

    /* Lab 9_3 performance counter */
    Cycle_Count += 1 // Cycle
    if (Stall_MA == 0 && Stall_DH == 0) {
      Inst_Count += 1 // Not Stall, read inst

      if (EXE_Branch == 1) {
        Conditional_Branch_Count += 1
        if (Flush == 0) {
          Conditional_Branch_Hit_Count += 1
        } else {
          Flush_Count += 1
        }
      }
      if (EXE_Jump == 1) {
        Unconditional_Branch_Count += 1
        if (Flush == 0) {
          Unconditional_Branch_Hit_Count += 1
        } else {
          Flush_Count += 1
        }
      }
    }
    /* Lab 9_3 performance counter */

    step(1)
  }
  step(1)
  println("Inst:Hcf")
  println("This is the end of the program!!")
  println("==============================================")

  println("Value in the RegFile")
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

  /* Lab 9_3 performance counter */
  // Performance Counter
  println("==============================================================")
  println("Performance Counter:")
  println(s"[Cycle Count                    ] ${"%8d".format(Cycle_Count)}")
  println(s"[Inst Count                     ] ${"%8d".format(Inst_Count)}")
  println(
    s"[Conditional Branch Count       ] ${"%8d".format(Conditional_Branch_Count)}"
  )
  println(
    s"[Unconditional Branch Count     ] ${"%8d".format(Unconditional_Branch_Count)}"
  )
  println(
    s"[Conditional Branch Hit Count   ] ${"%8d".format(Conditional_Branch_Hit_Count)}"
  )
  println(
    s"[Unconditional Branch Hit Count ] ${"%8d".format(Unconditional_Branch_Hit_Count)}"
  )
  println(s"[Flush Count                    ] ${"%8d".format(Flush_Count)}")

  // Performance Analysis
  println("==============================================================")
  println("Performance Analysis:")
  println(
    s"[CPI                            ] ${"%8f".format(Cycle_Count.toFloat / Inst_Count.toFloat)}"
  )
  println("==============================================================")
  /* Lab 9_3 performance counter */

  println("Value in Systolic Array Memory (in decimal)")
  poke(dut.io.tb_en, true)
  for(i <- 0 until 20) {
        if(i==0)
            println("Matrix A :")
        // else if(i==16)
        //     println("Matrix B :")
        // else if(i==32)
        //     println("Output Matrix :")
        poke(dut.io.tb_slave.r.ready, true)
        val req = genAXIAddr(BigInt(Hw14_4_SA_Config.Mem_Base_ADDR + 4 * i))
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
        val addr = (Hw14_4_SA_Config.Mem_Base_ADDR + 4 * i).toHexString
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

    for(i <- 0 until 180) {
        if(i==0)
            println("Matrix B :")
        poke(dut.io.tb_slave.r.ready, true)
        val req = genAXIAddr(BigInt(Hw14_4_SA_Config.Mem_Base_ADDR + 4 * 64 + 4 * i))
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
        val addr = (Hw14_4_SA_Config.Mem_Base_ADDR + 4 * 64 + 4 * i).toHexString
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

    for(i <- 0 until 64) {
        if(i==0)
            println("Output Matrix :")
        poke(dut.io.tb_slave.r.ready, true)
        val req = genAXIAddr(BigInt(Hw14_4_SA_Config.Mem_Base_ADDR + 4 * 256 + 4 * i))
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
        val addr = (Hw14_4_SA_Config.Mem_Base_ADDR + 4 * 256 + 4 * i).toHexString
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
  step(1)
}

object top_14_4_SA_Test extends App {
  Driver.execute(
    args,
    () =>
      new top_Hw14_4()
  ) { c: top_Hw14_4 =>
    new top_14_4_SA_Test(c)
  }
}
