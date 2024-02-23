import numpy as np

def euclidean_distance(point1, point2):
    sub = np.subtract(point1, point2)
    sqr = [x**2 for x in sub]
    return np.sqrt(np.sum(sqr))

if __name__ == "__main__":
    point1 = np.array([1, 2, 3])
    point2 = np.array([4, 5, 6])
    print(euclidean_distance(point1, point2))