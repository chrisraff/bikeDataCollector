import math
import matplotlib.pyplot as plt
import numpy as np
import os
import pandas as pd

pd.options.mode.chained_assignment = None  # hide non-critical SettingWithCopyWarning error when slicing DataFrame


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
            return data.replace(":", "").replace("\t", " ").replace(",", "").replace("  ", " ").replace(" ", "\t")
    return ""


def real_round(n):
    if n - math.floor(n) < 0.5:
        return math.floor(n)
    return math.ceil(n)


# ####change this to parse new file#### #
rawInputFile = "output_1560311576.64.txt"
number_of_columns = 15

# set file names, open files, force read/write with ascii encoding, ignore errors
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
          "acceleration flag1 brake assist light"
for item in headers.split():
    cleanData.write("%s\t" % item)
cleanData.seek(cleanData.tell() - 1, os.SEEK_SET)  # move cursor one character back
cleanData.write("\n")  # move to new line

# write formatted row of rawData to cleanData
for line in rawData:
    formatted_line = format_line(line)
    if formatted_line.count('\t') is number_of_columns - 1:
        cleanData.write(format_line(line))

# parsing of raw data completed
rawData.close()
cleanData.close()

# create DataFrame from cleanOutputFile
df = pd.read_csv(cleanOutputFile, sep="\t", header=0)
df = df.fillna(0)  # replace NaN values with 0

# delete unnecessary columns (values are always/nearly constant)
for i in list(df):  # iterate over every column
    if is_int(df.at[0, i]):  # check if first value in column is an integer
        if df[i].std() < 1e-9:  # check if standard deviation of column is less than 1e-9
            df = df.drop(columns=i)  # delete column
''' cyclotron remaining columns:
    millis ampHours volts amps speed distance rpm throttleIn throttleOut brake'''

# debug: delete any unwanted/non-essential but statistically significant columns
for i in ["ampHours", "volts", "amps", "throttleIn", "throttleOut"]:
    df = df.drop(columns=i)

# adjust data for graphing purposes
df = df.replace(to_replace={"rpm": {0: np.nan}})  # replace 0 in rpm with NaN for graphing purposes
df = df.replace(to_replace={"brake": {"r": np.nan}})  # replace r in brake with NaN for graphing purposes
df = df.replace(to_replace={"brake": {"rB": 45}})  # replace rB in brake with 1 for graphing purposes

print(df)

# determine indices of new sessions
new_data_indices = []  # initialize list of new session indices
length = len(df)
seconds_between = np.empty(length)
seconds_between[0] = 0
time_since_start = np.empty(length)
time_since_start[0] = 0
for i in range(length - 1):
    seconds_between[i + 1] = int(real_round((df.iloc[i + 1, 0] - df.iloc[i, 0]) / 1000))  # find time difference
    time_since_start[i + 1] = int(seconds_between[i + 1] + time_since_start[i])
    if seconds_between[i + 1] > 10 or seconds_between[i + 1] < 0:
        new_data_indices.append(i + 1)
        time_since_start[i + 1] = 0

sessions = []  # initialize list of session DataFrames
new_data_indices.insert(0, 0)
new_data_indices.append(length)
for i in range(len(new_data_indices) - 1):
    start, end = new_data_indices[i], new_data_indices[i + 1]
    sessions.append(df[start:end])  # split df into sessions
    sessions[i]["timeSinceStart"] = time_since_start[start:end]

# use this to check sessions
if len(sessions) == 1:
    print("There is 1 recorded session")
    # print(sessions[0])
else:
    print("There are %s recorded sessions" % (len(sessions)))
    # print(sessions[0])

# TODO: create plots for each session
for i in range(len(sessions)):  # create graphs for each session
    sessions[i].plot(x="timeSinceStart", y=["speed", "rpm", "brake"], kind="line", grid=True)
    plt.xlabel("Seconds after Start of Session")
    plt.title("Session %s/%s" % (i+1, len(sessions)))
    plt.xlim(left=0)
    plt.ylim(bottom=0)
plt.show()
