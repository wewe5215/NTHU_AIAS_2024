import numpy as np
def select_elements(arr, indices):
    ret = [ ]
    for indice in indices:
        ret.append(arr[indice])
    return ret

if __name__ == "__main__":
    arr = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
    indices = [(0, 1), (1, 1), (2, 0)]
    print(select_elements(arr, indices))