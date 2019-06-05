import matplotlib as plt
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
        return False  # not a number


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


# file names
rawDataFile = "output_1559680727.33.txt"
cleanDataFile = "clean_output_1559680727.33.txt"

# open files, force ascii encoding
raw_data = open(rawDataFile, "r", encoding="ascii", errors='ignore')
clean_data = open(cleanDataFile, "w", encoding="ascii")

# create headers in clean_data
headers = "millis ampHours volts amps speed distance degreesC rpm humanWatts nmRiderTorque throttleIn throttleOut " \
          "acceleration flag1 brakeFlag"
for item in headers.split():
    clean_data.write("%s\t" % item)
clean_data.seek(clean_data.tell() - 1, os.SEEK_SET)
clean_data.write("\n")

# write formatted row from raw_data to clean_data
for line in raw_data:
    clean_data.write(format_line(line))

raw_data.close()
clean_data.close()

# create pandas DataFrame from
df = pd.read_csv(cleanDataFile, sep="\t", header=0)

# delete unnecessary columns (all values are constant)
df = df.drop(columns="degreesC")
df = df.drop(columns="humanWatts")
df = df.drop(columns="nmRiderTorque")
df = df.drop(columns="acceleration")
df = df.drop(columns="flag1")
