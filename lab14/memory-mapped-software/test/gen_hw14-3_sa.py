for i in range(4):
    for j in range(4):
        for k in range(4):
            offset_A = 0x0 + 0x40 * i + 0x4 * k         # A[i][k]
            offset_B_src = 0x0 + 0x40 * k + 0x4 * j     # B[k][j]
            offset_B_dst = 0x100 + 0x40 * k + 0x4 * j
            offset_C = 0x200 + 0x40 * i + 0x4 * j       # C[i][j]
            assem = []
            print(f'## i = {i}, j = {j}, k = {k}')
            # ==========mat_A===============
            # DMA_REG_BASE_ADDR --------
            assem.append("la t6, ACCEL_REG_BASE_ADDR")
            assem.append("lw t0, 0(t6)")
            assem.append("la t6, DMA_OFFSET_SOURCE_INFO")
            assem.append("lw t1, 0(t6)")
            assem.append("add t1, t1, t0")
            # address offset in local memory
            assem.append(f"addi t2, s0, {hex(offset_A)}")
            assem.append("sw t2, 0(t1)")
            # DMA_OFFSET_DEST_INFO --------
            assem.append("la t6, DMA_OFFSET_DEST_INFO")
            assem.append("lw t1, 0(t6)")
            assem.append("add t1, t1, t0")
            # address offset in SA local memory
            assem.append(f"addi t2, s3, {hex(offset_A)}")
            assem.append("sw t2, 0(t1)")
            # DMA_OFFSET_SIZE_CFG --------
            assem.append("la t6, DMA_OFFSET_SIZE_CFG")
            assem.append("lw t1, 0(t6)")
            assem.append("add t1, t1, t0")
            assem.append("li t2, 0x10100404")
            assem.append("sw t2, 0(t1)")
            # ENABLE
            assem.append("la t6, DMA_OFFSET_ENABLE")
            assem.append("lw t1, 0(t6)")
            assem.append("add t1, t1, t0")
            assem.append("li t2, 0x01")
            assem.append("sw t2, 0(t1)")
            # wait dma
            wait_dma_label = f'wait_dma1_{i}{j}{k}'
            assem.append(f'{wait_dma_label}:')
            assem.append("la t6, DMA_OFFSET_DONE")
            assem.append("lw t1, 0(t6)")
            assem.append("add t1, t1, t0")
            assem.append("lw t2, 0(t1)")
            assem.append(f"beq t2, x0, {wait_dma_label}")
            # reset DONE reg
            assem.append("sw x0, 0(t1)")
            # ==========mat_B===============
            # DMA_REG_BASE_ADDR --------
            assem.append("la t6, ACCEL_REG_BASE_ADDR")
            assem.append("lw t0, 0(t6)")
            assem.append("la t6, DMA_OFFSET_SOURCE_INFO")
            assem.append("lw t1, 0(t6)")
            assem.append("add t1, t1, t0")
            # address offset in local memory
            assem.append(f"addi t2, s1, {hex(offset_B_src)}")
            assem.append("sw t2, 0(t1)")
            # DMA_OFFSET_DEST_INFO --------
            assem.append("la t6, DMA_OFFSET_DEST_INFO")
            assem.append("lw t1, 0(t6)")
            assem.append("add t1, t1, t0")
            # address offset in SA local memory
            assem.append(f"addi t2, s3, {hex(offset_B_dst)}")
            assem.append("sw t2, 0(t1)")
            # DMA_OFFSET_SIZE_CFG --------
            assem.append("la t6, DMA_OFFSET_SIZE_CFG")
            assem.append("lw t1, 0(t6)")
            assem.append("add t1, t1, t0")
            assem.append("li t2, 0x10100404")
            assem.append("sw t2, 0(t1)")
            # ENABLE
            assem.append("la t6, DMA_OFFSET_ENABLE")
            assem.append("lw t1, 0(t6)")
            assem.append("add t1, t1, t0")
            assem.append("li t2, 0x01")
            assem.append("sw t2, 0(t1)")
            # wait dma
            wait_dma_label = f'wait_dma2_{i}{j}{k}'
            assem.append(f'{wait_dma_label}:')
            assem.append("la t6, DMA_OFFSET_DONE")
            assem.append("lw t1, 0(t6)")
            assem.append("add t1, t1, t0")
            assem.append("lw t2, 0(t1)")
            assem.append(f"beq t2, x0, {wait_dma_label}")
            # reset DONE reg
            assem.append("sw x0, 0(t1)")
            # =====program accelerator====
            assem.append("la t6, ACCEL_REG_BASE_ADDR")
            assem.append("lw t0, 0(t6)")
            assem.append("la t6, ACCEL_OFFSET_MATA_MEM_ADDR")
            assem.append("lw t1, 0(t6)")
            assem.append("add t1, t1, t0")
            assem.append(f"li t2, {hex(offset_A)}")
            assem.append("sw t2, 0(t1)")
            assem.append("la t6, ACCEL_OFFSET_MATB_MEM_ADDR")
            assem.append("lw t1, 0(t6)")
            assem.append("add t1, t1, t0")
            assem.append(f"li t2, {hex(offset_B_dst)}")
            assem.append("sw t2, 0(t1)")
            assem.append("la t6, ACCEL_OFFSET_MATC_MEM_ADDR")
            assem.append("lw t1, 0(t6)")
            assem.append("add t1, t1, t0")
            assem.append(f"li t2, {hex(offset_C)}")
            assem.append("sw t2, 0(t1)")
            assem.append("la t6, ACCEL_OFFSET_MAT_MEM_STRIDE")
            assem.append("lw t1, 0(t6)")
            assem.append("add t1, t1, t0")
            assem.append("li t2, 0x00040404")
            assem.append("sw t2, 0(t1)")
            assem.append("li t1, 0x0")
            assem.append("add t1, t1, t0")
            assem.append("li t2, 0x00000001")
            assem.append("sw t2, 0(t1)")
            wait_sa = f'wait_sa_{i}{j}{k}'
            assem.append(f'{wait_sa}:')
            assem.append("la t6, ACCEL_OFFSET_STATUS")
            assem.append("lw t1, 0(t6)")
            assem.append("add t1, t1, t0")
            assem.append("lw t2, 0(t1)")
            assem.append(f"beq t2, x0, {wait_sa}")
            assem.append("sw x0, 0(t1)")
            # offset_A = offset_A + 4
            # offset_B_src = offset_B_src + 64
            # offset_B_dst = offset_B_dst + 64
            for code in assem:
                print(code)

