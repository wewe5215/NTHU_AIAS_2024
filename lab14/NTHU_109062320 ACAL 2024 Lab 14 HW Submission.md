# NTHU_109062320_朱季葳 ACAL 2024 Lab 14 HW Submission 


[toc]

## Gitlab code link
- Gitlab link - https://course.playlab.tw/git/wewe5215/lab14

## Homework 14-1 - Make accelerator move data by itself
- 說明與要求：
    - 根據作業要求，同學的block diagram應如下圖所示:
    <p style="text-align:center"><img src="https://course.playlab.tw/md/uploads/1dd3c2e5-27ae-4875-a00b-4b0b4f8ce2ae.png" width=400 ></p>

    - 在address space不變的情況，請同學準備一份asm code，演示一次**SA從SRAM讀值並將運算後的結果寫回SRAM的過程**，透過emulator轉化出硬體所需的檔案，需要做的有...
        - SRAM預設初始值，可以和lab的矩陣內容相同，運算資料的儲存位置。SA透過AXI對其進行讀寫
        - MMIO_Regfile也會有預設值，一開始`ENABLE`設為high讓SA一開始就能夠進行資料讀取
    - 需要克服的點：
        - 當資料不再是每一個clock送入一筆，SA該如何因應，請同學寫下你是如何解決？要注意的是，<font color=#f00>這裡的SA讀寫資料所花的時間應假設為**未知**，而非fix-length!!</font>同學須注意FSM的設計。
    - **Ans:**
    利用在lab裡所提供的方法，可以根據`STATUS`信號，印出你SRAM裡存放輸入矩陣以及輸出矩陣的資訊，截圖貼上來。
    截圖中請包括 reference clock、SA 的 master port、及 DataMem 的 slave port 的訊號。
- 實作方式說明:
    - SA從SRAM讀值並將運算後的結果寫回SRAM的過程：在這裡其實就只是把原本cpu要傳過去給DMA讓他搬資料的過程變成傳過去給SA而已，所以要設置的Register都是一樣的，包含`Enable, SOURCE_INFO, DEST_INFO, OFFSET_SIZE_CFG, OFFSET_DONE`，並且將reg base address改為SA的。而在這裡有一點要注意的是原本在呼叫SA讓他開始做運算的部分也有另外的Register要設置，而那些Registers的地址為0x0 ~ 0x20，所以為了避免overlap的問題，我把搬data所需要設置的那些值放在地址為0x100之後的部分，不過因為原始MMIO_Regfile的設置不是開一整塊memory給Regfile，然後原本在`Memory_Mapped.scala`的部分有再做額外的translation來讓他符合Register的編號，我在這裡就直接讓address大於0x100的直接不做translation然後留到`MMIO_Regfile`再做Register的mapping
    ```scala=
    // 以write為例
    // Memory_Mapped.scala
    // 另外在這裡report一個原本template的bug就是
    // 原本rf.io.waddr沒有減掉SA_config.ACCEL_REG_BASE_ADDR.U
    when(DoWrite) {
      when(io.slave.aw.bits.addr < SA_config.ACCEL_MEM_BASE_ADDR.U && (io.slave.aw.bits.addr - SA_config.ACCEL_REG_BASE_ADDR.U) < "h100".U){
        rf.io.waddr := (WAReg - SA_config.ACCEL_REG_BASE_ADDR.U) >> 2
      }
      .otherwise{
        rf.io.waddr := WAReg - SA_config.ACCEL_REG_BASE_ADDR.U
      }
      lm.io.waddr := WAReg - SA_config.ACCEL_MEM_BASE_ADDR.U
    }
    // MMIO_Regfile.scala
    when(io.wen) {
        when(io.waddr < "h100".U){
          RegFile(io.waddr) := io.wdata
        }
        .elsewhen(~io.complete_write && io.waddr >= "h100".U){
          switch(io.waddr - "h100".U){
            is(0.U) {
              RegFile(10) := io.wdata
            }
            is(4.U) {
              RegFile(11) := io.wdata
            }
            is(8.U) {
              RegFile(12) := io.wdata
            }
            is(12.U) {
              RegFile(13) := io.wdata
            }
            is(16.U) {
              RegFile(14) := io.wdata
            }
            is(20.U) {
              RegFile(15) := io.wdata
            }
          }
        }
        .elsewhen(io.complete_write){
          // 因為當所有的data都從SRAM搬過來的時候要把Done升起，
          // 以及把Enable降下，
          // 而在這個時候就直接從新增的input:io.complete_write來讀值
          // 並做data的更新
          RegFile(10) := 0.U
          RegFile(15) := 1.U
        }
    }
    // 最後再把得到的值assign到io.MMIO的output:
    // MMIO circuit declaration
  // Output
  io.mmio.ENABLE_OUT     := RegNext(RegFile(0)(0).asBool)
  io.mmio.STATUS_OUT     := RegNext(RegFile(1)(0).asBool)
  io.mmio.MATA_SIZE      := RegNext(RegFile(2))
  io.mmio.MATB_SIZE      := RegNext(RegFile(3))
  io.mmio.MATC_SIZE      := RegNext(RegFile(4))
  io.mmio.MATA_MEM_ADDR  := RegNext(RegFile(5))
  io.mmio.MATB_MEM_ADDR  := RegNext(RegFile(6))
  io.mmio.MATC_MEM_ADDR  := RegNext(RegFile(7))
  io.mmio.MAT_MEM_STRIDE := RegNext(RegFile(8))
  io.mmio.MAT_BUF        := RegNext(RegFile(9))
  io.mmio.ENABLE_LOAD    := RegNext(RegFile(10))
  io.mmio.SRC_INFO       := RegNext(RegFile(11))
  io.mmio.DST_INFO       := RegNext(RegFile(12))
  io.mmio.SIZE_CFG_INFO  := RegNext(RegFile(13))
  io.mmio.DONE_LOAD      := RegNext(RegFile(15))
    ```
    - SA如何搬data:在這裡基本上就是照抄DMA那邊的實作，因為前置作業完成之後我們就可以得到所需的資料，並且當`Enable == 1`的時候開始從SRAM讀Data然後寫到SA的local memory，而在這時cpu會不斷check done是否升起，並且等到升起時才會繼續往下做，否則就在迴圈裡面等(for Q:SA 如何調整設計以應對讀寫資料耗時超過 1 cycle 且不固定的情況)
        ```asm=
        # 在這裡無論是SA版還是DMA版都是一樣的，主要是差在地址
        # 而我在SA版只有把DMA_OFFSET_DONE改成符合SA Regfile所需的地址
        # 還有把base addr(存在t0)改成SA的，
        # 這裡有一點可能會造成誤會的點是我label名字沒有改，
        # 但是可以從t0是load SA的Reg base addr來看出差異
        # 關於asm file的部分會在底下(測試方式說明)的部分進行說明
        wait_dma1:
        ## t1 -> 0x14 (offset of DONE reg)
        la t6, DMA_OFFSET_DONE
        lw t1, 0(t6)
        ## t1 = 0x300000 + 0x14
        add t1, t1, t0
        ## load value of mem[0x300014]
        lw t2, 0(t1)
        beq t2, x0, wait_dma1

        ```
        而在這個部分一開始SA是作為slave來接收從cpu那邊傳來的資料並完成前置作業，接下來在Enable升起之後，換成SA作為master去跟SRAM要資料並寫到SA LocalMem，如下圖所示，旁邊藍色字代表是誰要負責這個訊號。從下圖我們可以看到以下狀況
        - 當io_mmio_ENABLE_LOAD升起之後，mState在下一個cycle進到`mReadSend`
        - 當`io.master.ar.ready`升起之後(代表現在是可以讀的)，進到`mReadResp`
        - 當`io.master.r.valid`升起之後(代表data傳過來了)，進到`mWriteSend`，並把收到的data做masking(這裡是4'b1111)並assign到data_buffer
        - 在state為`mWriteSend`時，當上一個cycle的時候`io.master.w.ready == false`(還沒傳data過去)時，把data_buffer的值傳過去，而address的部分同理。在這裡因為上一個cycle的時候`io.master.w.ready`跟`io.master.aw.ready`都是false，所以在進入`mWriteSend`的第一個cycle就可以直接把address, data傳過去了，並且在write address ready && valid(io.master.aw.fire)的時候把request_counter+1來計算目前寫入第幾個data了，並且在之後作為FSM的終止條件(回到mIdle並把Done升起，Enable降下)，如下圖2,3(圖2的時候因為讀到data的時間點是在Done升起前，所以BrEq升起，圖3的時候讀到Done升起，所以BrEq降下)
        - 在state為`mWriteResp`的時候就是等待`io.master.b.valid`(資料已經成功寫入時，SA local memory會升起的訊號)，並在升起時回到mIdle
        - 圖1![](https://course.playlab.tw/md/uploads/d6cb8d14-ac39-44bf-be80-3809c9be7d7d.png)
        - 圖2![](https://course.playlab.tw/md/uploads/6e34a70f-6334-4701-8f40-1b2c76704df9.png)
        - 圖3![](https://course.playlab.tw/md/uploads/975be07c-767f-430c-ac2d-f3451a5bfb2e.png)
        - 在這裡補上master port跟slave port相對應的訊號(因為ready/valid的訊號有一些波形圖點不出來，再加上用address跟data的值來看比較明顯所以我只有圈出這個部分)
            - read:![](https://course.playlab.tw/md/uploads/38136f43-3933-4580-b33d-71b38beae6d7.png)
            - write:![](https://course.playlab.tw/md/uploads/3451a504-0a62-405d-99d6-e016b473953c.png)





- 測試方式說明:在這裡我直接拿`matmul_demo.S`來改，diff出來的結果如下圖
    - ![](https://course.playlab.tw/md/uploads/2185f022-63b0-4298-adaa-ebd13a469cfc.png)
    - 其中我把REG的Base addr改成accelerator的，並且因為SA需要設置的register跟DMA是一樣的：`Enable, SOURCE_INFO, DEST_INFO, OFFSET_SIZE_CFG, OFFSET_DONE`，在這裡我沒有去改他名字只有改值，所以他的Label上還是寫DMA，但是實際上對到的是給accelerator的，而在這裡的地址是對應到SA那邊的regfile的，其中還會經過處理然後放到相對應的位置，但是這裡為了方便性以及避免與設置SA的部分發生地址重疊所以設到0x100之後。
- 結果(貼圖):
  ```
  sbt 'Test/runMain acal_lab14.topSystolicArray.top_Hw14_1_Test -tbn verilator'
  ```
  ![](https://course.playlab.tw/md/uploads/bb29fffc-569c-47d1-be0b-819df50c3b3b.png)






_____

## Homework 14-2 - Make the AXI bus support more masters (Accelerator)
- 說明與要求：
    - 根據作業要求，同學最後的block diagram應如下圖所示:
    <p style="text-align:center"><img src="https://course.playlab.tw/md/uploads/62ec268b-8c6e-40b3-b86a-93996fb1fd99.png" width=500 ></p>
    
    - 在 2 masters 以上的情況下，Arbiter會去決定誰在當下發出的request"算數"，方式有兩種，一種是Round-Robbin(輪流)，另一種則是Priority(index越小，優先權越大)，在Lab中所採用的機制為前者(RRArbiter)，提供給同學參考的測試情境應如下：
        - CPU接續 program DMA 與 SA 後，兩者開始透過AXI讀取SRAM的值，假設CPU並非向lab所示範那樣hang住等待SA所發出的`status`信號，假設它接下來也需要對SRAM執行讀寫，則此時會有多達3個 masters 對同一個 slave 發出 request
        - 同學必須截下當 3 masters 同時發出request的情況下中，Abiter會如何選擇，並擷取說明被選擇的那方的波形，以及沒有被選擇到的又該如何處理?
-  截圖與說明：因為read/write都是採用一樣的方式，所以在這裡我直接選擇read的部分來進行說明
    -  ![](https://course.playlab.tw/md/uploads/1332309b-e3f6-4646-b1ef-4e780dee59df.png)
    -  從上圖可以看到在state=0的時候會決定chosen_reg，而在一開始我們可以看到無論是哪一個master port都是valid的，而在arbiter裡可以看到一個register叫做lastGrant，是用來記錄上一次是輪到哪一個port的，而因為在前面都沒有任何port valid的時候arbiter一直都是選擇0這個port，所以當三個master都發出request的時候，他就會先去選擇port 1，接著再到2，然後回到0，並進行再一次的循環。而在選擇之後，被選擇的port的ready會被升起，其他的則不會，而如果master那邊看不到ready升起，就會一直待在原本的state直到被升起為止，所以在這個時候發出的request就會hang在那裡，因此不會造成影響(如下圖所示)。
    -  ![](https://course.playlab.tw/md/uploads/a88a3a4a-d4f0-454a-ad66-86a7643aa747.png)




_____

## Homework 14-3 Put Everything together to run a larger NxN (where N is 16) matrix multiplication 
- 說明與要求：
    - 測資要求與結果呈現：
        - 你是採用Option 1 還是 Option 2，說明Controller是如何設計?(Option 1)，或者資料該如何調整成硬體所能接受的樣子(資料如何存放、如何mapping)(Option 2)。
        - 同學實作出的硬體要能夠運算以下測資(自行準備並在下方說明)：[2x3]x[3x2]、[4x4]x[4x4]、[16x16]x[16x16]三筆矩陣乘法。
        - 比較使用兩種 mode (DMA fetch data / SA fetch data) 進行運算在此作業中的差異 (program 的方式有何不同? 兩者的 performance 有何差別? 造成差異的原因為何? etc.)

_____
### 採用Option 2
### [2x3]x[3x2]
- 測資
    - mat_A\begin{pmatrix}
          2 & 4 & 8\\
          4 & 5 & 1\\
        \end{pmatrix}
    - mat_B\begin{pmatrix}
          8 & 2 \\
          7 & 1 \\
          3 & 0 
        \end{pmatrix}
- 存放以及mapping:在這裡我就只是把未滿4x4的部分都補上0然後memory mapping也跟原本4x4的一樣，mat_A的data存到SA Local Memory的0x0~0x10，而mat_B的data存到0x10~0x20，接著mat_C的部分就從0x20開始到最後。
- 結果
    - DMA fetch data:
        ```
        sbt 'Test/runMain acal_lab14.topSystolicArray.top_14_3_1_DMA_Test -tbn verilator'
        ```
        ![](https://course.playlab.tw/md/uploads/e4126899-0bcc-4feb-aa7e-7e6949449a91.png)

    - SA fetch data
        ```
        sbt 'Test/runMain acal_lab14.topSystolicArray.top_14_3_1_SA_Test -tbn verilator'
        ```
        ![](https://course.playlab.tw/md/uploads/2eec156d-c125-4077-94e9-8e88a54f6de3.png)


    - Matrix Calculator 計算而得的答案截圖
        ![](https://course.playlab.tw/md/uploads/38438831-4038-4935-82e1-065744df7d83.png)

### [4x4]x[4x4]
- 測資(其實就是直接用lab2-3的測資)
    - mat_A\begin{pmatrix}
          1 & 4 & 5 & 3\\
          1 & 4 & 2 & 2\\
          5 & 5 & 3 & 3\\
          4 & 3 & 1 & 5\\
        \end{pmatrix}
    - mat_B\begin{pmatrix}
          1 & 4 & 3 & 4 \\
          5 & 5 & 5 & 2 \\
          4 & 4 & 5 & 4 \\
          3 & 4 & 3 & 5
        \end{pmatrix}
- 存放以及mapping:這裡的mapping方式就是原本的，所以就不多做贅述了。
- 結果
    - DMA fetch data:
        ```
        sbt 'Test/runMain acal_lab14.topSystolicArray.top_14_3_2_DMA_Test -tbn verilator'
        ```
        ![](https://course.playlab.tw/md/uploads/8cfff91a-6265-4234-8cf8-a00ce575aa45.png)

    - SA fetch data:
        ```
        sbt 'Test/runMain acal_lab14.topSystolicArray.top_14_3_2_SA_Test -tbn verilator'
        ```
        ![](https://course.playlab.tw/md/uploads/d600fa00-3215-4c5c-8817-091e7b32e8c9.png)


    - Matrix Calculator 計算而得的答案截圖:
        ![](https://course.playlab.tw/md/uploads/d30c98d3-6c6e-4723-9dbf-2baa1ae5523f.png)
### [16x16]x[16x16]
- 測資
    - mat_A\begin{pmatrix}
          1 & 2 & 1 & 2 & 1 & 0 & 2 & 1 & 3 & 2 & 0 & 0 & 1 & 1 & 0 & 3 \\
        2 & 0 & 2 & 3 & 2 & 0 & 0 & 2 & 2 & 0 & 1 & 3 & 2 & 1 & 3 & 0 \\
        1 & 3 & 0 & 2 & 0 & 1 & 1 & 2 & 3 & 1 & 0 & 1 & 1 & 2 & 3 & 0 \\
        2 & 2 & 2 & 0 & 1 & 0 & 3 & 0 & 2 & 1 & 1 & 0 & 1 & 3 & 2 & 1 \\
        0 & 2 & 3 & 1 & 2 & 3 & 0 & 2 & 2 & 3 & 1 & 0 & 1 & 1 & 1 & 0 \\
        1 & 3 & 0 & 2 & 1 & 1 & 3 & 1 & 2 & 0 & 1 & 2 & 0 & 2 & 1 & 1 \\
        3 & 2 & 0 & 1 & 0 & 3 & 1 & 3 & 2 & 2 & 3 & 0 & 1 & 0 & 3 & 2 \\
        0 & 1 & 3 & 0 & 2 & 2 & 0 & 3 & 1 & 3 & 1 & 2 & 0 & 2 & 1 & 1 \\
        2 & 3 & 1 & 0 & 2 & 1 & 3 & 1 & 2 & 0 & 1 & 0 & 2 & 3 & 0 & 2 \\
        3 & 0 & 1 & 2 & 3 & 0 & 1 & 2 & 0 & 3 & 2 & 0 & 1 & 1 & 1 & 2 \\
        1 & 1 & 3 & 0 & 0 & 1 & 1 & 2 & 2 & 0 & 3 & 1 & 1 & 2 & 0 & 3 \\
        0 & 2 & 1 & 3 & 1 & 1 & 2 & 1 & 2 & 0 & 2 & 3 & 1 & 3 & 1 & 0 \\
        1 & 0 & 2 & 1 & 2 & 0 & 3 & 3 & 1 & 2 & 1 & 0 & 2 & 1 & 0 & 3 \\
        3 & 3 & 0 & 1 & 1 & 2 & 1 & 2 & 3 & 0 & 2 & 3 & 0 & 1 & 2 & 0 \\
        2 & 0 & 1 & 3 & 2 & 0 & 1 & 2 & 2 & 0 & 3 & 1 & 1 & 2 & 1 & 0 \\
        0 & 3 & 2 & 1 & 2 & 1 & 3 & 2 & 0 & 1 & 1 & 2 & 0 & 2 & 1 & 0
        \end{pmatrix}
    - mat_B\begin{pmatrix}
          3 & 2 & 1 & 0 & 2 & 1 & 1 & 3 & 2 & 0 & 1 & 2 & 0 & 3 & 1 & 1 \\
        0 & 1 & 2 & 3 & 1 & 2 & 0 & 1 & 2 & 3 & 0 & 1 & 2 & 0 & 1 & 3 \\
        2 & 0 & 1 & 2 & 3 & 0 & 1 & 2 & 1 & 0 & 3 & 1 & 2 & 1 & 3 & 0 \\
        1 & 3 & 0 & 2 & 1 & 2 & 0 & 3 & 1 & 0 & 2 & 1 & 0 & 2 & 1 & 3 \\
        2 & 1 & 0 & 3 & 2 & 1 & 0 & 3 & 2 & 1 & 1 & 2 & 3 & 0 & 2 & 1 \\
        1 & 2 & 1 & 3 & 2 & 0 & 3 & 1 & 0 & 2 & 2 & 1 & 0 & 3 & 1 & 2 \\
        0 & 3 & 2 & 1 & 2 & 3 & 0 & 1 & 3 & 1 & 0 & 2 & 3 & 0 & 2 & 1 \\
        3 & 1 & 2 & 1 & 0 & 3 & 1 & 2 & 1 & 3 & 2 & 0 & 1 & 3 & 1 & 2 \\
        2 & 0 & 1 & 2 & 3 & 0 & 1 & 2 & 0 & 3 & 2 & 1 & 2 & 1 & 0 & 3 \\
        1 & 2 & 0 & 3 & 1 & 2 & 3 & 0 & 1 & 2 & 1 & 3 & 0 & 2 & 3 & 1 \\
        3 & 0 & 2 & 1 & 0 & 3 & 1 & 2 & 2 & 0 & 1 & 3 & 1 & 2 & 3 & 0 \\
        0 & 3 & 1 & 2 & 1 & 0 & 3 & 1 & 2 & 0 & 3 & 2 & 1 & 3 & 0 & 1 \\
        1 & 2 & 3 & 0 & 2 & 1 & 3 & 0 & 1 & 2 & 1 & 0 & 2 & 1 & 3 & 0 \\
        2 & 0 & 1 & 3 & 1 & 2 & 0 & 3 & 1 & 2 & 1 & 0 & 3 & 2 & 1 & 0 \\
        3 & 1 & 0 & 2 & 1 & 0 & 2 & 1 & 3 & 2 & 0 & 3 & 2 & 1 & 3 & 0 \\
        0 & 3 & 2 & 1 & 2 & 1 & 3 & 2 & 0 & 1 & 3 & 2 & 1 & 0 & 2 & 1
        \end{pmatrix}
- 存放以及mapping:在這裡因為每個matrix都有16x16=256筆data，所以mat_A的data在SA local memory的地址為0x000~0x100，而mat_B則為0x100~0x200, mat_C為0x200~0x300。並且因為硬體上固定以4x4作為運算單位，所以將mat_A, mat_B都劃分成16個區塊，舉mat_A左上角的區塊來說，他所需要拿取的data會放在SA local memory的0x0~0x4, 0x40~0x44, 0x80~0x84, 0xc0~0xc4。詳細的mapping方式可以在[gen_hw14-3_sa.py](https://course.playlab.tw/git/wewe5215/lab14/-/blob/main/memory-mapped-software/test/gen_hw14-3_sa.py?ref_type=heads)可以看得更清楚。
- 計算過程:在矩陣乘法的部分，無論是以一個數字為單位或者一個patitioned matrix為單位都會符合C\[0]\[0] = A\[0]\[0] x B\[0]\[0] + A\[0]\[1] x B\[1]\[0] + A\[0]\[2] x B\[2]\[0] + A\[0]\[3] x B\[3]\[0]的原則，所以我們在這裡只需要以4x4的小矩陣作為一個運算單位並且累加之前算好的結果就可以達到[16x16]x[16x16]的矩陣乘法會做到的事情。
- 結果(我有弄一個[python script](https://course.playlab.tw/git/wewe5215/lab14/-/blob/main/memory-mapped-hardware/compare_hw14-3_16x16_rst.py?ref_type=heads)去進行比對，如果需要的話可以用它來對答案！)
    - DMA fetch data:
        ```
        sbt 'Test/runMain acal_lab14.topSystolicArray.top_14_3_3_DMA_Test -tbn verilator'
        ```
        ![](https://course.playlab.tw/md/uploads/487fcb5e-08c6-448b-836e-c928591fb6e9.png)
        ![](https://course.playlab.tw/md/uploads/fee8e84e-26ac-42c1-aa37-9f4ea8ca632d.png)

    - SA fetch data:
        ```
        sbt 'Test/runMain acal_lab14.topSystolicArray.top_14_3_3_SA_Test -tbn verilator'
        ```
        ![](https://course.playlab.tw/md/uploads/aa4c6708-c29f-4206-8fd1-87618dc14883.png)

        ![](https://course.playlab.tw/md/uploads/495e912f-f3f8-42dd-b7e6-31f258ddd48b.png)

    - Matrix Calculator 計算而得的答案截圖:
        ![](https://course.playlab.tw/md/uploads/70d8632e-114d-4b40-ace8-c7f8f7cc6073.png)
### 比較使用兩種 mode (DMA fetch data / SA fetch data) 進行運算在此作業中的差異
在我的實作中用這兩種方法來搬data主要的差異就只有在準備要寫入或讀出regfile的data時的指令不同帶來的performance差異而已，至於拿取data存回SA local memory的部分無論是DMA還是SA所花費的cycle數也是一樣的。在最後SA的performance看起來會比較差就只是因為前面所提到的差異而已(如同下圖所示，左邊是SA，右邊是DMA)，當然這是在latency都等於1的時候才會有的情形，實際上SA要從SRAM拿Data再寫回SA的local memory跟DMA來做這件事情時，可能會因為master, slave之間的latency而造成performance有差，就像在lab11寫入local memory的latency是1但是寫到global memory是8一樣。
![](https://course.playlab.tw/md/uploads/36154bfb-645c-40a5-9b31-7a2a84e927f5.png)

### 為了support [16x16]x[16x16]而在硬體上進行的更動
在這裡因為需要累加之前所算完的結果，所以我在[SA.scala](https://course.playlab.tw/git/wewe5215/lab14/-/blob/main/memory-mapped-hardware/src/main/scala/acal_lab14/SystolicArray/SA.scala?ref_type=heads)那邊在要寫入算完的data之前把目前已經存在mat_C的data load出來，之後做完相加再放回去，而這裡有個部分比較tricky的就是因為read input data其實佔了8個cycle，但是他實際上只需要4個，所以我把剩下四個cycle拿去read mat_C的data並存在`accumulated_mat_C`裡面。
另外一項更動就是加入io.mmio.MAT_MEM_STRIDE的值來作為base_addr的輔助，因為原本是直接被寫死成`a_base_addr + (input_cnt << 2)`(以mat_A來說的話)，但是在16x16的狀況底下必須要是`a_base_addr + (input_cnt << 4)`，所以我在這裡維持了原本的部分，再乘上io.mmio.MAT_MEM_STRIDE那邊負責表示mat_A部分的區塊：`a_base_addr + (input_cnt << 2) * io.mmio.MAT_MEM_STRIDE(7,0))`，而因為這個改動，所以我把14-1~14-3裡面所有設置MAT_MEM_STRIDE的部分都改成要加上的地址除以4，因為原本就有乘以4會把它乘回來了。
## Homework 14-4 Prepare software for the Conv2D operation and compare with the result in Lab 11.
(以下cpu皆為5 stage pipeline CPU)
- Comparisons
    - CPU + SA + DM:
        ```
        sbt 'Test/runMain acal_lab14.topSystolicArray.top_14_4_SA_Test -tbn verilator'
        ```
        ![](https://course.playlab.tw/md/uploads/aca43fde-aae2-4ce4-8d6f-bc1d25fd5a2c.png)


    - HW11-1 (CPU + DM):![](https://course.playlab.tw/md/uploads/329ec176-bb8b-4468-ae80-a11e8338c678.png)
    - HW11-2 (CPU + DMA + High & Low Latency Memory):![](https://course.playlab.tw/md/uploads/c17c42bc-d101-4ef7-9b2e-59425772d03a.png)
- Correctness:![](https://course.playlab.tw/md/uploads/d21b5e14-dbf2-40af-9dc5-dc3e982096a6.png)


- Systolic array 能加速matrix multiplication 以及convolution 多少倍呢？
    - Matrix Multiplication:如果都不計算load/store以及SA的前置作業的話，以4x4的矩陣乘法來說，會需要4x4x4=64個mul跟16x(1+1+1（兩個兩個相加之後再相加）)=48個add instruction，如果是以single cycle cpu來比較的話，4x4矩陣乘法會需要花費64+48=112 cycles。而SA的版本如下圖所示，只需要12個cycle(從stateReg=sPreload到sPropagate結束)，所以總共是112/12=9.3倍的加速。![](https://course.playlab.tw/md/uploads/507e6e7d-5533-4816-909c-373a9ddf604d.png)

    - Convolution:
        - (CPU + SA + DM) vs. (HW11-1 (CPU + DM)):87884/29362 = 2.99倍
        - (CPU + SA + DM) vs. (HW11-2 (CPU + DMA + High & Low Latency Memory)):68851/29362=2.34倍
        - 因為在這裡透過SA自己來進行搬data的動作的話，我們固定從SRAM讀data的latency為1，而如果透過DMA來搬Data到global memory(在這裡是SA的local memory)的話，相較於SA自己搬data，他與自己的local memory latency=1是合乎情理的，所以在搬data上面lab11的實作就會有劣勢，再加上lab14的部分有加上SA來進行矩陣乘法的預算，根據前面的分析，也能提供顯著的performance增長。
- 實作方式：經過im2col之後，mat_A會變成1x18的kernel data，而mat_B會變成18x36的input data，加上padding補0之後變成4x20跟20x36，詳細情形可以在[matmul_demo_hw14-4_SA.S](https://course.playlab.tw/git/wewe5215/lab14/-/blob/main/memory-mapped-software/test/matmul_demo_hw14-4_SA.S?ref_type=heads)看到。接著再做patition然後分區做矩陣乘法，而這個部分的細節在14-3已經有提過所以就不再贅述了。
    - mat_A\begin{pmatrix}
          0 & 1 & 2 & 0 & 1 & 2 & 0 & 1 & 2 & 0 & 1 & 2 & 0 & 1 & 2 & 0 & 1 & 2  \\
        \end{pmatrix}
    - mat_B\begin{pmatrix}
          0 & 1 & 2 & 3 & 4 & 5 & 0 & 1 & 2 & 3 & 4 & 5 & 0 & 1 & 2 & 3 & 4 & 5 & 0 & 1 & 2 & 3 & 4 & 5 & 0 & 1 & 2 & 3 & 4 & 5 &0 & 1 & 2 & 3 & 4 & 5\\
          1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6\\
          2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7\\
          0 & 1 & 2 & 3 & 4 & 5 & 0 & 1 & 2 & 3 & 4 & 5 & 0 & 1 & 2 & 3 & 4 & 5 & 0 & 1 & 2 & 3 & 4 & 5 & 0 & 1 & 2 & 3 & 4 & 5 &0 & 1 & 2 & 3 & 4 & 5\\
          1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6\\
          2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7\\
          0 & 1 & 2 & 3 & 4 & 5 & 0 & 1 & 2 & 3 & 4 & 5 & 0 & 1 & 2 & 3 & 4 & 5 & 0 & 1 & 2 & 3 & 4 & 5 & 0 & 1 & 2 & 3 & 4 & 5 &0 & 1 & 2 & 3 & 4 & 5\\
          1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6\\
          2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7\\
          0 & 1 & 2 & 3 & 4 & 5 & 0 & 1 & 2 & 3 & 4 & 5 & 0 & 1 & 2 & 3 & 4 & 5 & 0 & 1 & 2 & 3 & 4 & 5 & 0 & 1 & 2 & 3 & 4 & 5 &0 & 1 & 2 & 3 & 4 & 5\\
          1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6\\
          2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7\\
          0 & 1 & 2 & 3 & 4 & 5 & 0 & 1 & 2 & 3 & 4 & 5 & 0 & 1 & 2 & 3 & 4 & 5 & 0 & 1 & 2 & 3 & 4 & 5 & 0 & 1 & 2 & 3 & 4 & 5 &0 & 1 & 2 & 3 & 4 & 5\\
          1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6\\
          2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7\\
          0 & 1 & 2 & 3 & 4 & 5 & 0 & 1 & 2 & 3 & 4 & 5 & 0 & 1 & 2 & 3 & 4 & 5 & 0 & 1 & 2 & 3 & 4 & 5 & 0 & 1 & 2 & 3 & 4 & 5 &0 & 1 & 2 & 3 & 4 & 5\\
          1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6 & 1 & 2 & 3 & 4 & 5 & 6\\
          2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7 & 2 & 3 & 4 & 5 & 6 & 7\\
        \end{pmatrix}
    
- 如果我們沒有限制systolic array 能增加的面積尺寸, 那這個加速的趨勢會一直下去嗎？如果不行，那加速的上限是多少呢？不行，因為還是需要對matrix進行分割，所以在呼叫SA去搬data還有啟動SA讓他做矩陣乘法也需要浪費一些時間，並且佔據了runtime大部分的時間。至於能增加的面積尺寸頂多增加到`max(# mat_A's rows, # mat_B's rows)`x `max(# mat_A's cols, # mat_B's cols)`，在這裡就是`max(4, 20)x max(20, 36)` = 20x36。因為這樣還會需要浪費很多的空間跟時間去計算data為0的那些entry，就好比mat_A來說，他有三個row都是0，因為這裡為了符合以4x4為基本單位做矩陣乘法的限制，所以需要做padding補0，而在這裡因為row跟column的數量都取了兩者之間的最大值，所以如果只想呼叫SA來做一次矩陣乘法的話，這已經是極限了，如果row或column數量再增加更多的話就只是浪費多餘的空間跟時間在don't care的data上而已。
- 如果你想要讓 acclerator performance 更好，你覺得你的 design 上能做什麼改善？（增加 PE 數量、加寬 bus bandwidth 除外）我覺得因為現在大部分的runtime都是在處理每次前置作業然後load data的部分，甚至有很多data是重複load的，因為一個partitioned matrix可能會被多次使用，所以如果可以在前置作業的時候一次把所有data都load到SA的local memory的話，效能會有很顯著的提升。

























