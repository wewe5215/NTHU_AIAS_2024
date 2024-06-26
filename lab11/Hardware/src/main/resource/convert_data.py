import struct

def bytes_to_words(file_path):
    # Open the file in binary read mode
    byte_data = []
    with open(file_path, 'r') as file:
        lines = file.readlines()
    for line in lines:
        content = line.split("\n")[0]
        # print(f'line = {content}')
        byte_data.append(content)
    # Check if the total bytes are a multiple of 4
    if len(byte_data) % 4 != 0:
        print("Warning: The total number of bytes is not a multiple of 4. Extra bytes will be ignored.")

    # Convert bytes to 32-bit words
    words = []
    for i in range(0, int(len(byte_data)/4)):
        word = byte_data[i*4+3] + byte_data[i*4+2] + byte_data[i*4+1] + byte_data[i*4]
        words.append(word)

    return words

# Specify the path to your file
file_path = 'data.hex'
base_addr = 32768
words = bytes_to_words(file_path)
count = 0
# Print the 32-bit words
for word in words:
    now_addr = hex(base_addr)
    # print(f"{now_addr}({base_addr}) : {word}")
    print(word)
    base_addr = base_addr + 4
    count = count + 1
    if count == 50:
        break
