.data
success1: .string "found  "
success2: .string " at index "
fail_string1: .string "search element "
fail_string2: .string " not found "
array:   .word 1, 3, 4, 6, 9, 12, 14, 15, 17, 19, 24
array_size: .word 11
search_element: .word 13
.text
main:
    addi t0, zero, 0
    la   t1, array_size  
    lw   t1, 0(t1)
    addi t1, t1, -1
    add  s10,t1,zero   
    addi a5, zero, -1
    la   s2, search_element
    lw   s2, 0(s2)             
    la   s0, array           
    jal  ra, binary_search
    bltz a5, Fail				
    j exit
binary_search:
    add  a2, t0, t1
    srli a2, a2, 1
    blt s10,a2,Fail
    bltz a2,Fail
    add  t2, a2, zero
    slli t2, t2, 2
    add  t2, t2, s0 
    lw   t2, 0(t2)
    beq  t2, s2, Find
    beq t0,t1,Fail
    blt  s2, t2, less
greater:
    addi t0,a2,1
    j binary_search
less:
    addi t1,a2,-1
    j binary_search
    ret
Fail:
    addi a5,zero,-1
    la  a1, fail_string1
    li  a0, 4
    ecall

    mv       a1, s2
    li       a0, 1
    ecall

    la  a1, fail_string2
    li  a0, 4
    ecall
    j exit
Find:
    add a5,a2,zero
    la  a1, success1
    li  a0, 4
    ecall

    mv       a1, s2
    li       a0, 1
    ecall

    la  a1, success2
    li  a0, 4
    ecall

    mv       a1, a5
    li       a0, 1
    ecall
    
    j exit
exit: