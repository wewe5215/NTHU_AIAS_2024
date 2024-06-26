testcases = (
    "test_I_type",
    "test_R_type",
)
def register_to_binary(register_number):
    return f"{register_number:05b}"

def immediate_to_binary(immediate, instruction_type, bits=12):
    if instruction_type == 'slli' or instruction_type == 'srli':
        high_bits = '0000000'
        if immediate < 0:
            immediate += (1 << 5)
        return f"{high_bits}{immediate:05b}"
    elif instruction_type == 'srai':
        high_bits = '0100000'
        if immediate < 0:
            immediate += (1 << 5)
        return f"{high_bits}{immediate:05b}"
    else:
        if immediate < 0:
            immediate += (1 << bits)
        return f"{immediate:012b}"
def dealing_T_type(instructions):
    binary_list = []
    opcode = '0010011'
    for instruction in instructions:
        print(instruction)
        type = instruction.split(" ")[0]
        rd_ = ((instruction.split(" ")[1]).split(',')[0]).split('x')[1]
        rs1_ = ((instruction.split(" ")[2]).split(',')[0]).split('x')[1]
        immed_ = (instruction.split(" ")[3]).split(',')[0]
        # print(f'type = {type} rd = {rd_} rs1 = {rs1_} immed = {immed_}')
        funct3 = ''
        if type == 'slli':
            funct3 = '001'
        elif type == 'slti':
            funct3 = '010'
        elif type == 'sltiu':
            funct3 = '011'
        elif type == 'xori':
            funct3 = '100'
        elif type == 'srli':
            funct3 = '101'
        elif type == 'srai':
            funct3 = '101'
        elif type == 'ori':
            funct3 = '110'
        elif type == 'andi':
            funct3 = '111'
        rd = register_to_binary(int(rd_))
        rs1 = register_to_binary(int(rs1_))
        immed = immediate_to_binary(int(immed_), type)
        binary = f'{immed} {rs1} {funct3} {rd} {opcode}'
        binary_list.append(binary)
        # print(binary)
    return binary_list

def dealing_R_type(instructions):
    binary_list = []
    opcode = '0110011'
    for instruction in instructions:
        print(instruction)
        type = instruction.split(" ")[0]
        rd_ = ((instruction.split(" ")[1]).split(',')[0]).split('x')[1]
        rs1_ = ((instruction.split(" ")[2]).split(',')[0]).split('x')[1]
        rs2_ = ((instruction.split(" ")[3]).split(',')[0]).split('x')[1]
        print(f'type = {type} rd = {rd_} rs1 = {rs1_} rs2_ = {rs2_}')
        funct3 = ''
        funct7 = ''
        if type == 'add':
            funct3 = '000'
        elif type == 'sub':
            funct3 = '000'
        elif type == 'sll':
            funct3 = '001'
        elif type == 'slt':
            funct3 = '010'
        elif type == 'sltu':
            funct3 = '011'
        elif type == 'xor':
            funct3 = '100'
        elif type == 'srl':
            funct3 = '101'
        elif type == 'sra':
            funct3 = '101'
        elif type == 'or':
            funct3 = '110'
        elif type == 'and':
            funct3 = '111'

        if type == 'sub' or type == 'sra':
            funct7 = '0100000'
        else:
            funct7 = '0000000'
        rd = register_to_binary(int(rd_))
        rs1 = register_to_binary(int(rs1_))
        rs2 = register_to_binary(int(rs2_))
        binary = f'{funct7} {rs2} {rs1} {funct3} {rd} {opcode}'
        binary_list.append(binary)
        # print(binary)
    return binary_list
for testcase in testcases:
    filename = testcase + '.txt'
    instructions = []
    binary_list = []
    answer = []
    with open(filename, "r") as file:
        lines = file.readlines()
        for line in lines:
            if 'addi' not in line and 'hcf' not in line and 'main:' not in line:
                instructions.append(line.split("\n")[0])
        if 'I_type' in testcase:
            binary_list = dealing_T_type(instructions)
        elif 'R_type' in testcase:
            binary_list = dealing_R_type(instructions)
    # for content in instructions:
    #     print(content)
    filename = testcase + '_ans.txt'
    with open(filename, "r") as file:
        lines = file.readlines()
        read_change = False
        for line in lines:
            if 'Reached Halt' in line:
                break
            if 'Next' in line:
                if 'addi' in line:
                    read_change = False
                else:
                    read_change = True
            if read_change == True and ">> rf" in line:
                ans = (line.split('-> ')[1]).split("\n")[0]
                # print(ans)
                answer.append(ans)
    for i in range(0, len(instructions)):
        ret = binary_list[i] + ' //' + instructions[i] + ' --> ' + answer[i]
        print(ret)

