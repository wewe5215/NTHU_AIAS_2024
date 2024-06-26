import re

# Matrix F provided
matrix_F = [
    [23, 33, 25, 36, 35, 29, 24, 35, 22, 32, 30, 28, 30, 21, 31, 32],
    [43, 33, 22, 38, 34, 23, 30, 44, 35, 26, 37, 33, 33, 40, 36, 26],
    [33, 28, 23, 42, 29, 27, 24, 34, 30, 41, 24, 27, 32, 32, 28, 34],
    [33, 25, 26, 38, 36, 29, 20, 37, 34, 31, 22, 32, 41, 23, 38, 20],
    [36, 24, 22, 50, 35, 26, 31, 34, 24, 38, 33, 30, 30, 34, 40, 30],
    [25, 34, 26, 41, 30, 32, 19, 38, 33, 31, 26, 30, 35, 28, 26, 33],
    [47, 38, 33, 42, 34, 37, 41, 41, 35, 42, 33, 44, 27, 45, 45, 35],
    [36, 26, 22, 49, 31, 27, 34, 36, 26, 34, 38, 32, 31, 38, 38, 24],
    [31, 31, 35, 40, 39, 35, 22, 42, 32, 37, 27, 28, 44, 25, 36, 28],
    [40, 35, 22, 36, 30, 36, 28, 43, 32, 24, 30, 39, 27, 34, 44, 22],
    [34, 24, 33, 33, 33, 29, 29, 39, 23, 27, 38, 28, 32, 31, 36, 21],
    [31, 33, 27, 46, 31, 33, 23, 42, 34, 30, 33, 30, 38, 36, 31, 31],
    [32, 36, 31, 33, 35, 37, 29, 38, 28, 30, 34, 31, 35, 27, 43, 23],
    [40, 33, 28, 44, 33, 29, 29, 43, 37, 36, 32, 37, 32, 43, 28, 37],
    [42, 26, 23, 34, 28, 33, 18, 46, 31, 23, 30, 30, 31, 36, 33, 25],
    [27, 30, 25, 45, 28, 34, 19, 35, 36, 30, 26, 30, 38, 28, 34, 26]
]

# Read the content from the text file
filename = 'hw14-3_16x16_SA_rst.txt'

with open(filename, 'r') as file:
    memory_text = file.read()

# Extracting values from the given text
pattern = re.compile(r'mem\[0x[0-9a-fA-F]+\] = ((?:\d+ ){3}\d+)')
matches = pattern.findall(memory_text)

# Convert matches to a list of integers
memory_content = []
for match in matches:
    memory_content.extend(map(int, match.split()))

# Convert the memory content to a 16x16 matrix for comparison
reconstructed_matrix_F = [memory_content[i:i+16] for i in range(0, len(memory_content), 16)]

# Check if the matrices match
if reconstructed_matrix_F == matrix_F:
    print("The memory content matches the provided matrix F.")
else:
    print("The memory content does not match the provided matrix F.")

# Print the matrices for visual verification
print("Memory Content Matrix:")
for row in reconstructed_matrix_F:
    print(row)

print("\nProvided Matrix F:")
for row in matrix_F:
    print(row)
