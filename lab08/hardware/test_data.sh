#!/bin/bash

if [ -n "$1" ]
then
    if [ "$1" = "Lab1" ]
    then
        cp ./src/main/resource/Lab1_inst.asm ./src/main/resource/inst.asm
        cp ./src/main/resource/Lab1_m_code.hex ./src/main/resource/m_code.hex
    elif [ "$1" = "Lab2" ]
    then
        cp ./src/main/resource/Lab2_inst.asm ./src/main/resource/inst.asm
        cp ./src/main/resource/Lab2_m_code.hex ./src/main/resource/m_code.hex
    elif [ "$1" = "Hw2" ]
    then
        cp ./src/main/resource/Hw2_inst.asm ./src/main/resource/inst.asm
        cp ./src/main/resource/Hw2_m_code.hex ./src/main/resource/m_code.hex
    else
        echo "[Error] parameter 1 is wrong"
    fi
else
    echo "[Error] usage should be: ./test_data.sh <which Lab>"
fi