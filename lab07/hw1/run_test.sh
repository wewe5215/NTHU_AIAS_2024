instructions=(
    mul
    mulhu
    rem
    remu
)
TEST_NAME="remu"
# use Gen_testcase.py to generate testcase to test_assembly
# python3 Gen_testcase.py
# use the following commented command to generate the answer file
# riscv64-unknown-elf-gcc -march=rv32im -mabi=ilp32 -nostartfiles -Tvirt.lds boot.S main.c test_ans/${TEST_NAME}/${TEST_NAME}_test_ans.S -o test_asm
# qemu-system-riscv32 -nographic -machine virt -bios none -kernel test_asm > test_ans/${TEST_NAME}/${TEST_NAME}_ans.txt
make
for target in "${instructions[@]}"; do
    yes '' | ./obj/emulator test_assembly/test_${target^^}.txt \
        > test_ans/${target}/${target}_output.txt
done
python3 test_ans/check_correctness.py