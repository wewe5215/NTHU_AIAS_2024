from pathlib import Path
import sys
testcases = (
    "mul",
    "mulhu",
    "rem",
    "remu"
)
IMMSZ = 12
IMMSGN = IMMSZ - 1
IMMMSK = (1 << IMMSZ) - 1

def bit(x, n):
    return (x >> n) & 1

def sext_imm(x):
    # Extract the lower 12 bits
    lower_bits = x & IMMMSK
    # Check the sign bit and extend it if necessary
    if bit(x, IMMSGN):
        return lower_bits | (-1 << IMMSZ)
    else:
        return lower_bits

for testcase in testcases:
    filename = f'test_ans/{testcase}/{testcase}-01.txt'
    ans_file_name = f'test_ans/{testcase}/{testcase}_ans.txt'
    answer = []
    with open(ans_file_name, "r") as ans_file:
        ans_lines = ans_file.readlines()
        for line in ans_lines:
            if 'test' in line:
                answer.append((line.split(" ")[1]).split('\n')[0])
    with open(filename, "r") as file:
        lines = file.readlines()
        tests = []
        count = 0
        for line in lines:
            if "TEST_RR_OP" in line:
                tests.append(line.strip("TEST_RR_OP()\n"))
                count = count + 1
            if count == 50:
                break
        # generate assembly code
        instructions = []
        # instructions.append("   .text")
        # instructions.append("   .global test_asm")
        # instructions.append("   .type test_asm, @function")
        # instructions.append("test_asm:")
        # instructions.append("prologue:")
        # instructions.append("   addi sp, sp, -12")
        # instructions.append("   sw ra, 0(sp)")
        # instructions.append("   sw a0, 4(sp)")
        # instructions.append(f"   addi t3, x0, 0")
        # instructions.append("test:")
        instructions.append("main:")
        index = 0
        count = 0
        for test in tests:
            parts = test.split(", ")
            op = parts[0]
            op1 = parts[2]
            op2 = parts[1]
            dest = parts[1]
            op1val = parts[5]
            op2val = parts[6]
            op1val = sext_imm(int(op1val, 16))
            op2val = sext_imm(int(op2val, 16))
            instructions.append(f"addi t1, x0, {op1val}")
            instructions.append(f"addi t2, x0, {op2val}")
            instructions.append(f"{op} t0, t1, t2")
            count = count + 1
            # instructions.append(f"   slli t4, t3, 2")
            # instructions.append(f"   add t5, a0, t4")
            # instructions.append(f"   sw t0, 0(t5)")
            # instructions.append(f"   addi t3, t3, 1")
        # instructions.append("epilogue:")
        # instructions.append("   lw ra, 0(sp)")
        # instructions.append("   lw a0, 4(sp)")
        # instructions.append("   addi sp, sp, 12")
        # instructions.append("   jr ra")
        # instructions.append("   .size test_asm, .-test_asm")
        instructions.append("hcf")
        output_file = f'test_assembly/test_{testcase.upper()}.txt'
        with open(output_file, "w") as written_file:
            written_file.write('\n'.join(instructions))
        # for inst in instructions:
        #     print(inst)