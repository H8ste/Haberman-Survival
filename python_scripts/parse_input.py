import numpy as np
# This script
# 1: loads haberman.data
# 2: normalizes input data from a range of 0 to 1
# 3: converts class attribute identifier from 1 and 2 to 0 and 1


def normalize(input, min, max):
    return (float(input) - float(min))/(float(max)-float(min))


file = open("../src/haberman.data", "r")
data = file.readlines()

for column in range(len(data)):
    data[column] = data[column].split(",")
    data[column][-1] = data[column][-1][0]  # removes /n in last element

for row in range(len(data[0])-1):  # 3
    # find min max
    min = 1000
    max = 0
    for column in range(len(data)):
        if (int(data[column][row]) < min):
            min = int(data[column][row])
        if (int(data[column][row]) > max):
            max = int(data[column][row])
    # normalize relative to min max
    for column in range(len(data)):
        data[column][row] = normalize(int(data[column][row]), min, max)

for column in range(len(data)):
    # change 1 to 0 and 2 to 1
    if (int(data[column][-1]) == 1):
        data[column][-1] = 1
    else:
        data[column][-1] = 2
print(data)
np.savetxt('../src/parsed_src/parsed.data', data, delimiter=',')
print("parsed file")
