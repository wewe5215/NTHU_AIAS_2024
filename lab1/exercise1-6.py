import numpy as np

def standardize_columns(arr):
    mean = np.mean(arr, axis=0)
    std = np.std(arr, axis=0)
    standardized_array = (arr - mean) / std
    # print(standardized_array)
    return standardized_array

if __name__ == "__main__":
    arr = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
    print(standardize_columns(arr))