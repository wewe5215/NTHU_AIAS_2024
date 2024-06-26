instruction_names = (
    "mul",
    "mulhu",
    "rem",
    "remu"
)
for instruction_name in instruction_names:
    folder = 'test_ans/' + instruction_name + '/'
    ans_file_name = folder + instruction_name + '_ans.txt'
    output_file_name = folder + instruction_name + '_output.txt'
    ans_lines = []
    answer = []
    output_lines = []
    operand1 = []
    operand2 = []
    output = []
    with open(ans_file_name, "r") as ans_file:
        ans_lines = ans_file.readlines()
        for line in ans_lines:
            if 'test' in line:
                answer.append((line.split(" ")[1]).split('\n')[0])
    with open(output_file_name, "r") as output_file:
        output_lines = output_file.readlines()
        need_to_record_output = False
        for line in output_lines:
            if 'Next: addi t1, x0,' in line:
                # operand1.append(line.split(", ")[2])
                operand1.append((line.split(', ')[2]).split('\n')[0])
                need_to_record_output = False
            elif 'Next: addi t2, x0,' in line:
                # operand1.append(line.split(", ")[2])
                operand2.append((line.split(', ')[2]).split('\n')[0])
            elif 't0, t1, t2' in line:
                need_to_record_output = True
            if need_to_record_output == True:
                if '>> rf[' in line:
                    output.append((line.split(' ')[4]).split('\n')[0])
    correct = True
    for i in range(50):
        if output[i] != answer[i]:
            print(f'testcase {i} incorrect with target is:')
            print(f' {operand1[i]} {instruction_name} {operand2[i]} = {answer[i]}')
            print(f'but the output is {output[i]}')
            correct = False
    if correct == True:
        print(f'{instruction_name} pass all the testcases')