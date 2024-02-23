# def validate_submatrix_sum(matrix, target_sum):
#     for i in range(0, len(matrix), 2):
#         for j in range(0, len(matrix), 2):
#             # Calculate the sum of the 2x2 block starting at (i, j)
#             sum_ = matrix[i][j] + matrix[i+1][j] + matrix[i][j+1] + matrix[i+1][j+1]
#             # Check if the sum equals 6 and print "true" if it does.
#             if sum_ == 6:
#                 return True  # Your implementation
#             else:
#                 return False
def validate_submatrix_sum(matrix, target_sum):
    # Get the dimensions of the matrix
    rows = len(matrix)
    if rows == 0:
        return False  # Empty matrix, cannot have a 2x2 sub-matrix
    cols = len(matrix[0])
    
    # Iterate through each possible starting point of a 2x2 sub-matrix
    for i in range(rows - 1):  # Subtract 1 to avoid out-of-bounds access
        for j in range(cols - 1):
            # Calculate the sum of the current 2x2 sub-matrix
            current_sum = matrix[i][j] + matrix[i+1][j] + matrix[i][j+1] + matrix[i+1][j+1]
            # If the sum doesn't match the target, return False
            if current_sum != target_sum:
                return False
    # If we've checked all 2x2 sub-matrices and haven't returned False, return True
    return True
if __name__ == "__main__":
    matrix1 = [
        [1, 2, 1, 2],
        [2, 1, 2, 1],
        [1, 2, 1, 2],
        [2, 1, 2, 1]
    ]

    target_sum1 = 6

    matrix2 = [
        [1, 1, 2, 2],
        [1, 1, 2, 2],
        [2, 2, 1, 1],
        [2, 2, 1, 1]
    ]
    target_sum2 = 6

    print(validate_submatrix_sum(matrix1, target_sum1))  # Should output True
    print(validate_submatrix_sum(matrix2, target_sum2))  # Should output False