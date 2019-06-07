import pandas as pd
import os


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


# ####change this to parse new file#### #
rawInputFile = "output_1559843320.39.txt"

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
