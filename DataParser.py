import pandas as pd
import os
import numpy as np
import math


def is_int(c):
    """
    Checks if a character is an integer
    :param char c: character to check
    :rtype: boolean
    """
    try:
        int(c)
        return True
    except ValueError:
        return False  # not an int


def format_line(data):
    """
    Ignores bad data, formats good data to be tab-separated
    :param string data: string to reformat
    :rtype: string
    """
    if data is not None:  # check if line is not empty
        if is_int(data[0]):  # check if first character is a number
            data = data.replace(":", "").replace("\t", " ").replace(",", "").replace("  ", " ").replace(" ", "\t")
            if data.count("\t") is 14:  # check if number of columns is 15
                return data
    return ""


def round(n):
    if n - math.floor(n) < 0.5:
        return math.floor(n)
    return math.ceil(n)


# ####change this to parse new file#### #
rawInputFile = "output_1560181038.22.txt"

# set file names, open files, force read/write with ascii encoding
rawData = open(rawInputFile, "r", encoding="ascii", errors='ignore')

# extract bike ID
ID = ""
for line in rawData:
    if line[0:9] == "Bike ID: ":
        label, ID = line.split(sep=": ")
        if is_int(ID):
            ID = int(ID)
        break

# create output file cleanData
cleanOutputFile = "bike_%s_%s" % (ID, rawInputFile)
cleanData = open(cleanOutputFile, "w", encoding="ascii")

# write headers in cleanData
headers = "millis ampHours volts amps speed distance degreesC rpm humanWatts nmRiderTorque throttleIn throttleOut " \
          "acceleration flag1 brakeFlag"
for item in headers.split():
    cleanData.write("%s\t" % item)
cleanData.seek(cleanData.tell() - 1, os.SEEK_SET)  # move cursor one character back
cleanData.write("\n")  # move to new line

# write formatted row of rawData to cleanData
for line in rawData:
    cleanData.write(format_line(line))

rawData.close()
cleanData.close()

# create pandas DataFrame from cleanOutputFile
df = pd.read_csv(cleanOutputFile, sep="\t", header=0)

# delete unnecessary columns (all values are constant)
df = df.drop(columns="degreesC")
df = df.drop(columns="humanWatts")
df = df.drop(columns="nmRiderTorque")
df = df.drop(columns="acceleration")
df = df.drop(columns="flag1")
df = df.drop(columns="ampHours")
df = df.drop(columns="volts")
df = df.drop(columns="amps")
# remaining columns:
# millis ampHours volts amps speed distance rpm throttleIn throttleOut brakeFlag

new_data_indexes = []
length = len(df)
millis = np.empty(length)
millis[0] = 0
for i in range(length-1):
    millis[i+1] = round((df.iloc[i+1, 0] - df.iloc[i, 0]) / 1000)
    if millis[i+1] > 10 or millis[i+1] < 0:
        new_data_indexes.append(i+1)

sessions = []
if len(new_data_indexes) > 0:
    new_data_indexes.insert(0, 0)
    new_data_indexes.append(len(df))
    for i in range(len(new_data_indexes) - 1):
        sessions.append(df[new_data_indexes[i]:new_data_indexes[i+1]])

print("There are %s recorded sessions" % len(sessions))
