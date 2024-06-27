(NTHU_109062320_朱季葳) ACAL 2024 Spring Lab 11 HW Submission
===


[TOC]



## Homework 11-1 SoC Integration with CPU

- [Hw 11-1 Commit link](https://course.playlab.tw/git/wewe5215/lab11/-/tree/hw11-1?ref_type=heads)

1. Revise system configuration and design address mapping scheme(Explain how you design)


2. Integrate CPU, bus and memory 
    :::info
    **Bandwidth Configuration**
    **CPU** <= *32bits* => **AXI_IF** <= *32 bits* => **AXI Bus** <= *32 bits* => **DataMem**
    :::
    - 1. Modify `Hardware/Lab/src/main/scala/acal_lab11/top_SoC.scala`
    ```scala=
    // 我在這裡沒有另外再開一個AXI_IF的module，
    // 因為我直接把那裡的內容寫在cpu那邊的top module了，
    // 因為他會在top module去instantiate pipelined cpu
    // 所以我直接在那裡去做完AXI_IF該做的事情了。
    // 而在top_SoC.scala這邊主要就是把cpu那邊的訊號拉出來
    // 然後再instantiate DataMem(在這裡稱為LocalMem)以及bus
    // 然後接好master/slave ports，基本上就是參照lab11/top.scala下去做的
    package SoC

    import chisel3._
    import chisel3.util._
    import AXI._
    import DMA._
    import AXILite._
    import Memory._
    import acal_lab09._

    // CPU <-> Bus <-> Memory
    object SystemConfig {
        val nMasters: Int = 1
        val nSlaves: Int = 1
        val DMABaseAddr: Int = 0
        val DMASize: Int = 100
        val LocalMemBaseAddr: Int = 0x8000
        val LocalMemSize: Map[String, Int] = Map(
        "Size" -> 8192, // Height x Width
        "Height" -> 256, // The Number of bytes
        "Width" -> 32 // unit: 32 bits
        )
        val LocalMemLatency: Int = 8
        val LocalMemInitFilePath: String =
        "./src/main/resource/data.hex" // Provide the file path
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
    class top_SoC(idWidth: Int, addrWidth: Int, dataWidth: Int) extends Module {
        val io = IO(new Bundle{
            val regs = Output(Vec(32,UInt(dataWidth.W)))
            val Hcf = Output(Bool())

            //for sure that IM and DM will be synthesized
            val inst = Output(UInt(32.W))
            val rdata = Output(UInt(32.W))
            val wdata  = Output(UInt(32.W))

            val Dump_Mem = Input(Bool())
            // Test
            val E_Branch_taken = Output(Bool())
            val Flush = Output(Bool())
            val Stall_MA = Output(Bool())
            val Stall_DH = Output(Bool())
            val IF_PC = Output(UInt(32.W))
            val ID_PC = Output(UInt(32.W))
            val EXE_PC = Output(UInt(32.W))
            val MEM_PC = Output(UInt(32.W))
            val WB_PC = Output(UInt(32.W))
            val EXE_alu_out = Output(UInt(32.W))
            val EXE_src1 = Output(UInt(32.W))
            val EXE_src2 = Output(UInt(32.W))
            val ALU_src1 = Output(UInt(32.W))
            val ALU_src2 = Output(UInt(32.W))
            val raddr = Output(UInt(32.W))
            val WB_rd = Output(UInt(5.W))
            val WB_wdata = Output(UInt(32.W))
            val EXE_Jump = Output(Bool())
            val EXE_Branch = Output(Bool())
            val mState = Output(UInt(3.W))
        })
        val five_stage_cpu = Module(new top(idWidth, addrWidth, dataWidth))
        // Initialization
        io.Hcf := five_stage_cpu.io.Hcf
        io.inst := five_stage_cpu.io.inst
        io.rdata := five_stage_cpu.io.rdata
        io.wdata := five_stage_cpu.io.wdata
        io.mState := five_stage_cpu.io.now_state
        io.E_Branch_taken := five_stage_cpu.io.E_Branch_taken
        io.Flush := five_stage_cpu.io.Flush
        io.Stall_MA := five_stage_cpu.io.Stall_MA
        io.Stall_DH := five_stage_cpu.io.Stall_DH
        io.IF_PC := five_stage_cpu.io.IF_PC
        io.ID_PC := five_stage_cpu.io.ID_PC
        io.EXE_PC := five_stage_cpu.io.EXE_PC
        io.MEM_PC := five_stage_cpu.io.MEM_PC
        io.WB_PC := five_stage_cpu.io.WB_PC
        io.EXE_alu_out := five_stage_cpu.io.EXE_alu_out
        io.EXE_src1 := five_stage_cpu.io.EXE_src1
        io.EXE_src2 := five_stage_cpu.io.EXE_src2
        io.ALU_src1 := five_stage_cpu.io.ALU_src1
        io.ALU_src2 := five_stage_cpu.io.ALU_src2
        io.raddr := five_stage_cpu.io.raddr
        io.WB_rd := five_stage_cpu.io.WB_rd
        io.WB_wdata := five_stage_cpu.io.WB_wdata
        io.EXE_Jump := five_stage_cpu.io.EXE_Jump
        io.EXE_Branch := five_stage_cpu.io.EXE_Branch
        val bus = Module(
            new AXILiteXBar(
            SystemConfig.nMasters,
            SystemConfig.nSlaves,
            idWidth,
            addrWidth,
            dataWidth,
            Seq(
                (SystemConfig.LocalMemBaseAddr, SystemConfig.LocalMemSize("Size"))
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
        bus.io.masters(0) <> five_stage_cpu.io.master
        bus.io.slaves(0) <> localMem.io.slave
        localMem.io.dump := io.Dump_Mem
        for (i <- 0 until 32) {
            io.regs(i) := five_stage_cpu.io.regs(i)
        }
    }
    ```
    - 2. Build up `AXI_IF.scala` to support AXI_lite handshaking
    ```scala=
    // 在這裡如同前面所述，我直接在cpu這邊的top實作完相關的功能了
    // 而在這個部分的實作主要是參考DMA作為master那邊的FSM，
    // 並且在有load/store的時候把stall_MA拉起來直到read/write到datamem的部分完成
    package acal_lab09

    import chisel3._
    import chisel3.util._

    import acal_lab09.PiplinedCPU._
    import acal_lab09.Memory._
    import acal_lab09.MemIF._
    import SoC._
    import AXI._
    import DMA._
    import AXILite._
    import Memory._
    import acal_lab09.PiplinedCPU.wide._
    class top(idWidth: Int, addrWidth: Int, dataWidth: Int) extends Module {
        val io = IO(new Bundle{
            val regs = Output(Vec(32,UInt(32.W)))
            val Hcf = Output(Bool())

            //for sure that IM and DM will be synthesized
            val inst = Output(UInt(32.W))
            val rdata = Output(UInt(32.W))
            val wdata = Output(UInt(32.W))

            // Test
            val E_Branch_taken = Output(Bool())
            val Flush = Output(Bool())
            val Stall_MA = Output(Bool())
            val Stall_DH = Output(Bool())
            val IF_PC = Output(UInt(32.W))
            val ID_PC = Output(UInt(32.W))
            val EXE_PC = Output(UInt(32.W))
            val MEM_PC = Output(UInt(32.W))
            val WB_PC = Output(UInt(32.W))
            val EXE_alu_out = Output(UInt(32.W))
            val EXE_src1 = Output(UInt(32.W))
            val EXE_src2 = Output(UInt(32.W))
            val ALU_src1 = Output(UInt(32.W))
            val ALU_src2 = Output(UInt(32.W))
            val raddr = Output(UInt(32.W))
            // val waddr = Output(UInt(32.W))
            val WB_rd = Output(UInt(5.W))
            val WB_wdata = Output(UInt(32.W))
            val EXE_Jump = Output(Bool())
            val EXE_Branch = Output(Bool())

            val master = new Axi4MasterIF(idWidth, addrWidth, dataWidth, 2)
            val now_state = Output(UInt(3.W))

        })

        val cpu = Module(new PiplinedCPU(15,32))
        val im = Module(new InstMem(15))
        val data_buffer    = RegInit(0.U(dataWidth.W))
        val data_wire    = WireDefault(0.U(dataWidth.W))
        val rData_mask     = WireDefault(0.U(4.W))
        val mask_width     = WireDefault(0.U(4.W))
        val source_offset  = RegInit(0.U(2.W))
        val rData          = WireDefault(VecInit(Seq.fill(4)(0.U(8.W))))
        val dest_offset = WireDefault(cpu.io.DataMem.waddr(1,0))

        // Piplined CPU
        cpu.io.InstMem.rdata := im.io.inst
        // TODO : revise to data received
        cpu.io.DataMem.rdata := 0.U

        cpu.io.InstMem.Valid := true.B // Direct to Mem
        // DataMem is Valid only if data is received
        when(cpu.io.DataMem.Mem_R === true.B || cpu.io.DataMem.Mem_W === true.B){
          cpu.io.DataMem.Valid := false.B // Direct to Mem
        }
        .otherwise{
          cpu.io.DataMem.Valid := true.B
        }

        // Insruction Memory
        im.io.raddr := cpu.io.InstMem.raddr
        //System
        io.regs := cpu.io.regs
        io.Hcf := cpu.io.Hcf
        io.inst := im.io.inst
        // initialize
        io.rdata := 0.U
        io.wdata := 0.U
        // io.waddr := 0.U
        // Test
        io.E_Branch_taken := cpu.io.E_Branch_taken
        io.Flush := cpu.io.Flush
        io.Stall_MA := cpu.io.Stall_MA
        io.Stall_DH := cpu.io.Stall_DH
        io.IF_PC := cpu.io.IF_PC
        io.ID_PC := cpu.io.ID_PC
        io.EXE_PC := cpu.io.EXE_PC
        io.MEM_PC := cpu.io.MEM_PC
        io.WB_PC := cpu.io.WB_PC
        io.EXE_alu_out := cpu.io.EXE_alu_out
        io.EXE_src1 := cpu.io.EXE_src1
        io.EXE_src2 := cpu.io.EXE_src2
        io.ALU_src1 := cpu.io.ALU_src1
        io.ALU_src2 := cpu.io.ALU_src2
        io.raddr := cpu.io.DataMem.raddr
        io.WB_rd := cpu.io.WB_rd
        io.WB_wdata := cpu.io.WB_wdata
        io.EXE_Jump := cpu.io.EXE_Jump
        io.EXE_Branch := cpu.io.EXE_Branch

        // Master state machine
        val mIdle :: mReadSend :: mReadResp :: mWriteSend :: mWriteResp :: Nil = Enum(5)
        val mState = RegInit(mIdle)
        io.now_state := mState
        val mWriteAddrSent = RegInit(false.B) // true for write address is sent through master interface
        val mWriteDataSent = RegInit(false.B) // true for write data is sent through master interface
        // Master interface signal
        io.master.aw.valid       := mState === mWriteSend && !mWriteAddrSent
        io.master.aw.bits.addr   := 0.U
        io.master.aw.bits.burst  := 0.U
        io.master.aw.bits.len    := 0.U
        io.master.aw.bits.size   := 2.U
        io.master.aw.bits.cache  := 0.U
        io.master.aw.bits.id     := 0.U
        io.master.aw.bits.prot   := 0.U
        io.master.aw.bits.lock   := 0.U
        io.master.aw.bits.qos    := 0.U
        io.master.aw.bits.region := 0.U

        io.master.ar.valid       := mState === mReadSend
        io.master.ar.bits.addr   := 0.U
        io.master.ar.bits.burst  := 0.U
        io.master.ar.bits.len    := 0.U
        io.master.ar.bits.size   := 2.U
        io.master.ar.bits.cache  := 0.U
        io.master.ar.bits.id     := 0.U
        io.master.ar.bits.prot   := 0.U
        io.master.ar.bits.lock   := 0.U
        io.master.ar.bits.qos    := 0.U
        io.master.ar.bits.region := 0.U

        io.master.w.valid     := mState === mWriteSend && !mWriteDataSent
        io.master.w.bits.data := 0.U
        io.master.w.bits.strb := "b1111".U
        io.master.w.bits.last := true.B

        io.master.r.ready := mState === mReadResp

        io.master.b.ready := mState === mWriteResp

        // Master State Controller
        switch(mState) {
          is(mIdle) {
            when(cpu.io.DataMem.Mem_R === true.B) {
              mState := mReadSend
            }
            .elsewhen(cpu.io.DataMem.Mem_W === true.B){
              mState := mWriteSend
            }
          }
          is(mReadSend) {
            // When the ARREady signal is asserted, the slave accepts the
            // request and the master will move the the mReadResp state
            // and wait for read response
            when(io.master.ar.ready) {
              mState := mReadResp
            }
          }
          is(mReadResp) {
            // whe tne RValid is assert, the data response returns and
            // DMA starts to write the data to the desitnation, issuing
            // write request
            when(io.master.r.valid) {
              mState := mIdle
            }
          }
          is(mWriteSend) {
            // when all the write data are sent, wait for write response
            when(mWriteAddrSent && mWriteDataSent) {
              mState := mWriteResp
            }
          }
          is(mWriteResp) {
            // When receiving write response (BValid is assert), complete the DMA operation and return the mIDLE state
            when(io.master.b.valid) {
              mState := mIdle
            }
          }
        }
        // master port datapath
        when(mState === mReadSend) {
          // calculate read request address
          // base address = n * stride
          io.master.ar.bits.addr := SystemConfig.LocalMemBaseAddr.asUInt + Cat(0.U(16.W), cpu.io.DataMem.raddr)
          source_offset := cpu.io.DataMem.raddr(1,0)
        }

        when(mState === mReadResp && io.master.r.valid) {
          when(cpu.io.DataMem.Length === Byte){
            mask_width := MuxLookup(source_offset,"b1111".U,Seq(
              0.U -> "b0001".U,
              1.U -> "b0010".U,
              2.U -> "b0100".U,
              3.U -> "b1000".U
            ))
          }
          .elsewhen(cpu.io.DataMem.Length === Half){
            mask_width := MuxLookup(source_offset,"b1111".U,Seq(
              0.U -> "b0011".U,
              1.U -> "b0110".U,
              2.U -> "b1100".U,
              3.U -> "b1000".U
            ))
          }
          .elsewhen(cpu.io.DataMem.Length === Word){
            mask_width := "b1111".U
          }

          // When we read data back in 32-byte chunks, we design rData_mask to mask out the data we don't need
          rData_mask := mask_width
          // printf(p"mask_width = ${Hexadecimal(mask_width)}\n")
          // get read data value
          List.range(0, 4).map { x =>
            when(rData_mask(x) === 1.U) {
              rData(x) := io.master.r.bits.data(x * 8 + 7, x * 8)
            }
            .otherwise {
              rData(x) := 0.U(8.W)
            }
          }
          // printf(p"io.master.r.bits.data = ${Hexadecimal(io.master.r.bits.data)}\n")
          // printf(p"rData = ${Hexadecimal(rData.asUInt)}\n")
          // adjust the data order to shift souce_offset * 1 byte
          data_wire := MuxLookup(rData_mask, rData.asUInt,Seq(
              "b0010".U -> ((rData.asUInt) >> 8),
              "b0100".U -> ((rData.asUInt) >> 16),
              "b1000".U -> ((rData.asUInt) >> 24),
              "b0110".U -> ((rData.asUInt) >> 8),
              "b1100".U -> ((rData.asUInt) >> 16)
            ))
          cpu.io.DataMem.rdata := data_wire
          io.rdata := data_wire
          cpu.io.DataMem.Valid := true.B // Direct to Mem
        }

        when(mState === mWriteSend) {
          // calculate write request address
          // base address = n * stride
          io.master.aw.bits.addr := SystemConfig.LocalMemBaseAddr.asUInt + Cat(0.U(16.W), cpu.io.DataMem.waddr)
          dest_offset := cpu.io.DataMem.waddr(1,0)
          when(cpu.io.DataMem.Length === Byte){
            mask_width := MuxLookup(dest_offset,"b1111".U,Seq(
                0.U -> "b0001".U,
                1.U -> "b0010".U,
                2.U -> "b0100".U,
                3.U -> "b1000".U
            ))
          }
          .elsewhen(cpu.io.DataMem.Length === Word){
            mask_width := "b1111".U
          }
          io.master.w.bits.strb := mask_width
          // adjust data to match write config(destination width)
          io.master.w.bits.data := cpu.io.DataMem.wdata << (dest_offset << 3.U)
          io.wdata := cpu.io.DataMem.wdata

        }
        when(mState === mWriteResp && io.master.b.valid) {
          cpu.io.DataMem.Valid := true.B // Direct to Mem

          // io.waddr := cpu.io.DataMem.waddr
        }
        when(mState === mWriteSend) {
          when(io.master.w.ready) {
            mWriteDataSent := true.B
          }
          when(io.master.aw.ready) {
            mWriteAddrSent := true.B
          }
        }.otherwise {
          mWriteAddrSent := false.B
          mWriteDataSent := false.B
        }

    }



    ```
3. Run the **Emulator/test_code/scalar_Convolution_2D.S** and paste the result(Screenshot)
![](https://course.playlab.tw/md/uploads/329ec176-bb8b-4468-ae80-a11e8338c678.png)


## Homework 11-2 Performance Enhancement Using DMA

- [Hw 11-2 Branch link](https://course.playlab.tw/git/wewe5215/lab11/-/tree/hw11-2?ref_type=heads)

1. Revise system configuration and design address mapping scheme(Explain how you design)
    在這個部分我想主要的更動大概就是[top.scala](https://course.playlab.tw/git/wewe5215/lab11/-/blob/hw11-2/Hardware/src/main/scala/lab11/acal_lab09/top.scala?ref_type=heads)的部分，因為多了DMA需要與cpu進行互動，所以在address上面要加上DMA的base address

2. Integrate CPU, bus, memory and dma 
    在這個部分不太確定要不要貼code不過我直接貼連結在這裡好了[top_SoC.scala](https://course.playlab.tw/git/wewe5215/lab11/-/blob/hw11-2/Hardware/src/main/scala/lab11/top_SoC.scala?ref_type=heads)
    這裡主要就是掛上DMA, local, global memory然後接上bus而已
3. Revise software program and generate binary files using emulator(Explain how you revise the program)
    在這個部分我是在要jump到conv2D跟第二次做完conv2D的時候加上相關的machine code先讓CPU與DMA做互動，接著讓DMA把data從global memory寫到local memory或者從local memory寫到global memory。
    因為我發現在11-2的branch忘了推上去修改過的scala_Convolution.S了，所以在這裡附上我推到11-3的branch的部分:[scalar_Convolution.S](https://course.playlab.tw/git/wewe5215/lab11/-/blob/hw11-3/Emulator/test_code/scalar_Convolution.S?ref_type=heads)
    - jump到conv2D之前：
    ```asm=
    ## t0 --> dma base address
    li t0, 0x0
    ## 1. Program SOURCE_INFO reg
    li t1, 0x4
    add t1, t1, t0
    li s0, 0x8000
    sw s0, 0(t1)
    ## 2. Program DEST_INFO reg
    li t1, 0x8
    add t1, t1, t0
    li s3, 0x1000
    sw s3, 0(t1)
    ## 3. Program SIZE_CFG reg
    li t1, 0xc
    add t1, t1, t0
    li t2, 0x04040425
    sw t2, 0(t1)
    ## 4. Enable DMA
    li t1, 0
    add t1, t1, t0
    li t2, 0x01
    sw t2, 0(t1)
    wait_dma1:
    li t1, 0x14
    add t1, t1, t0
    lw t2, 0(t1)
    beq t2, x0, wait_dma1
    ## reset DONE reg in DMA
    sw x0, 0(t1)
    jal ra, Conv2D

    ```
    - 第二次做完conv2D的時候:
    ```asm=
    jal ra,Conv2D
    ## t0 --> dma base address
    li t0, 0x0
    ## 1. Program SOURCE_INFO reg
    li t1, 0x4
    add t1, t1, t0
    li s0, 0x1090
    sw s0, 0(t1)
    ## 2. Program DEST_INFO reg
    li t1, 0x8
    add t1, t1, t0
    li s3, 0x8090
    sw s3, 0(t1)
    ## 3. Program SIZE_CFG reg
    li t1, 0xc
    add t1, t1, t0
    li t2, 0x04040425
    sw t2, 0(t1)
    ## 4. Enable DMA
    li t1, 0
    add t1, t1, t0
    li t2, 0x01
    sw t2, 0(t1)
    wait_dma2:
    li t1, 0x14
    add t1, t1, t0
    lw t2, 0(t1)
    beq t2, x0, wait_dma2
    ## reset DONE reg in DMA
    sw x0, 0(t1)
    lw ra,0(sp)

    ```
4. Run the **Emulator/test_code/scalar_Convolution_2D.S** and paste the result(Screenshot)
![](https://course.playlab.tw/md/uploads/c17c42bc-d101-4ef7-9b2e-59425772d03a.png)




## Homework 11-3 Support and AXI Bus Implemention with Burst Mode

- [Hw 11-3 Branch link](https://course.playlab.tw/git/wewe5215/lab11/-/tree/hw11-3?ref_type=heads)

1. Upgrade your AXI bus design
    - 1. Explain your design and how you test your AXI bus.
        - `AXIReadBus.scala`, `AXIWriteBus.scala` ：主要的改動就只是接線而已
        - `AXISlaveReadMux.scala` ,`AXISlaveWriteMux.scala`：主要的改動是為了讓address不用再經過handshake才能夠進下一個state，所以在看到data.last不是true的時候要直接跳到fetch data的state，而在這個部分因為`AXIWriteBus.scala`那邊在原本的template接signal的時候有綁address.fire，所以變成[AXISlaveWriteMux.scala](https://course.playlab.tw/git/wewe5215/lab11/-/blob/hw11-3/Hardware/src/main/scala/lab11/Bus/AXISlaveWriteMux.scala?ref_type=heads)那邊也還是要收到address是fire的訊號才會動，然後因為這樣所以在一個burst mode過後我有再用一個register叫`wait_last`來檢查現在傳來的address是不是last是true之後的，並在原本被選擇的master又傳來address的訊號的時候才把`wait_last`降下來，否則就會進入等data的那個state但是卻遲遲沒有data傳來，整個系統就會停在那邊不動。
    - 2. Provide your testbench command. Paste the result here (Screenshot).
        ```
        sbt 'testOnly AXILite.AXISlaveReadMuxBurstTest'
        ```
        ![](https://course.playlab.tw/md/uploads/5d317e51-6f1f-4771-bece-c4367565461d.png)
        ```
        sbt 'testOnly AXILite.AXISlaveWriteMuxBurstTest'
        ```
        ![](https://course.playlab.tw/md/uploads/3bebf6a5-fd81-4604-ab2e-f3930014d266.png)

2. Modify **Data memory**, and **DMA controller (Interface)** to support **AXI Burst Mode**.
    - 1. Modify `AXI_IF.scala`. Use FSM to record and count the transaction address in the burst mode.
        我在這裡是直接在[DMA.scala](https://course.playlab.tw/git/wewe5215/lab11/-/blob/hw11-3/Hardware/src/main/scala/lab11/DMA/DMA.scala?ref_type=heads)那邊加上burst mode所需要的burst, len, last訊號並固定傳過去的address，以及修改部分state的condition使得不用address handshake也可以在burst mode的情況下繼續傳/收data，還有把request_counter改成在寫完之後才會增加。而在這個部分有一點值得注意的是在read的時候last是收Datamem那邊傳過來的，而write的時候last是要由master這邊來控制的，所以我會暫存在read state收到的last訊號然後在write state的時候傳給slave，此外由於這次作業沒有限定是哪個burst mode，所以我直接by default設incr mode了。
    - 2. Modify `Hardware/Lab/src/main/scala/acal_lab11/Memory/DataMem_AXI.scala`. Use FSM to record and count the transaction address in the burst mode.
        - read:在這個部分因為只有第一次傳address需要handshake所以我也用一個register(init)去記錄他是不是第一次傳過來，如果不是第一次的話，即使address的訊號沒有handshake，也讓state跳到`sResp`或者`sRLatnecy`，然後再用一個register(now_count)去紀錄現在傳完第幾個data了，如果傳完了就把init跟last升起來。
        - write:在這裡因為收address跟Data有分state所以在不是last之前，在respond的訊號ready之後就直接跳到等data的state，然後因為bus那邊的問題(如前面writeBus的部分所述)，所以要再加上一個稱為after_burst的register去確保現在傳過來的address不是前一個burst mode的，但其實因為在Mux那邊有處理過了所以這裡其實可以忽略掉。


3. Do performance analysis to explain why the AXI Burst mode helps the performance.
 ![](https://course.playlab.tw/md/uploads/4716565b-c6da-4e70-a09f-e48f52fbe386.png)
如同前面所述，因為address只有一開始需要傳然後進行handshake，所以可以省掉handshake的那些時間，然後讓總cycle數減少。

## Homework 11-4 Performance Analysis and Comparison

> This section requires you to answer the questions in the document. You can directly analyze the results or experiment with different hardware configurations or software programs to analyze the results and then write down your thoughts.
- Do you think the results are reasonable? Does it match your expectation?
    我覺得是合理的，因為我只有在要做conv2D之前跟之後讓global, local memory的資料互相交換，所以有透過burst mode是incr進行傳資料的部分就沒有很多，再加上省下來的也只是一開始address handshake的時間，所以整體上的performance提升並不會到非常多。
- Are you satisfied with the performance enhancement or not? If not, what can you do to further improve the performance?
    我覺得因為global/local memory的latency是不一樣的，所以如果慢的那一方有一個fifo可以對資料進行暫存，然後讓快的那一方可以不用等慢的那一方寫完資料才能再傳資料的話應該可以很有效的提升performance。另外一點就是bus的寬度，如果datawidth可以設比較寬然後一次讀寫多筆data的話，對於效能也會有很顯著的提升。


