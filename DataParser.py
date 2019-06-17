import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import os
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
            # if data.count("\t") is 16:  # check if number of columns is 17
            if data.count("\t") is 14:  # check if number of columns if 15
                return data
    return ""


def real_round(n):
    if n - math.floor(n) < 0.5:
        return math.floor(n)
    return math.ceil(n)


# ####change this to parse new file#### #
rawInputFile = "one_session_test.txt"

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
          "acceleration flag1 brakeFlag assist light"
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
# millis ampHours volts amps speed distance rpm throttleIn throttleOut brakeFlag assist light

new_data_indexes = []  # initialize list of new session indexes
length = len(df)
seconds_between = np.empty(length)
seconds_between[0] = 0
for i in range(length-1):
    seconds_between[i + 1] = real_round((df.iloc[i + 1, 0] - df.iloc[i, 0]) / 1000)  # find difference between millis
    if seconds_between[i + 1] > 10 or seconds_between[i + 1] < 0:
        new_data_indexes.append(i+1)

sessions = []  # initialize list of session DataFrames
new_data_indexes.insert(0, 0)
new_data_indexes.append(length)
for i in range(len(new_data_indexes) - 1):
    sessions.append(df[new_data_indexes[i]:new_data_indexes[i+1]])  # split df into sessions

# use this to check number of sessions
"""if len(sessions) == 1:
    print("There is 1 recorded session")
else:
    print("There are %s recorded sessions" % (len(sessions)))"""

# TODO: create plots for each session
"""for i in range(len(sessions)):  # create graphs for each session
    sessions[i].plot()"""
