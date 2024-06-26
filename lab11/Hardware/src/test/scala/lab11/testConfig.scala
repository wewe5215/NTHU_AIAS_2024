package Config

import chisel3._

object AXI_Config {
  val master_num = 2 // number of masters
  val slave_num = 2 // number of slaves
  val s_id_width = 4
  val addr_width = 32
  val data_width = 32
  // allocation of 2 slaves in memory space
  val addr_map = List(
    (Integer.parseInt("8000", 16), Integer.parseInt("10000", 16)),
    (Integer.parseInt("10000", 16), Integer.parseInt("20000", 16))
  )
}

