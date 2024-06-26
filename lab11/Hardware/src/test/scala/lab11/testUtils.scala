package Utils

import chisel3._
import chisel3.experimental.BundleLiterals._
import AXI._
import Config._

// Functions for generating test vectors
trait AXITester {
    def genAXIAddr(addr: BigInt): Axi4Request = {
        val req = new Axi4Request(AXI_Config.s_id_width, AXI_Config.addr_width, AXI_Config.data_width).Lit(
            _.addr -> addr.U,
            _.burst -> 0.U, // burst mode : FIXED
            _.cache -> 0.U,
            _.id    -> 0.U,
            _.len   -> 0.U, // one beat for burst
            _.lock  -> 0.U,
            _.prot  -> 0.U,
            _.qos   -> 0.U,
            _.region -> 0.U,
            _.size  -> 2.U
        )
        req
    }

    def genAXIAddr_burst(addr: BigInt, len: Int, burst: Int, size: Int): Axi4Request = {
        val req = new Axi4Request(AXI_Config.s_id_width, AXI_Config.addr_width, AXI_Config.data_width).Lit(
            _.addr -> addr.U,
            _.burst -> burst.U, // burst mode : FIXED
            _.cache -> 0.U,
            _.id    -> 0.U,
            _.len   -> len.U, // one beat for burst
            _.lock  -> 0.U,
            _.prot  -> 0.U,
            _.qos   -> 0.U,
            _.region -> 0.U,
            _.size  -> 2.U
        )
        req
    }

    def genAXIWriteData(id: Int, data: Int, strb: String, last: Boolean): Axi4WriteData = {
        val ret = new Axi4WriteData(AXI_Config.data_width).Lit(
            _.data -> data.U,
            _.strb -> strb.U,
            _.last -> last.B
        )
        ret
    }
    def genAXIReadData(id: Int, data: Int, last: Boolean): Axi4ReadData = {
        val ret = new Axi4ReadData(AXI_Config.s_id_width, AXI_Config.data_width).Lit(
            _.id -> id.U,
            _.data -> data.U,
            _.resp -> 0.U,
            _.last -> last.B
        )
        ret
    }
    def genAXIWriteResp(id: Int): Axi4WriteResp = {
        val ret = new Axi4WriteResp(AXI_Config.s_id_width).Lit(
            _.id -> id.U,
            _.resp -> 0.U
        )
        ret
    }
}

