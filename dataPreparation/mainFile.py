#! /usr/bin/python3
import csv

# def openCSV(source_path):
#     with open(source_path,mode = 'r') as csv_file:
#         csv_reader = csv.DictReader(csv_file)
#
#     return csv_reader
#
#
#
# with open("001e0610c040.csv", mode='r') as infile:
#     reader = csv.reader(infile)
# #
# with open("001e0610c040.csv", 'r') as source_file:
#     reader = DictReader(sanitize_input(source_file))

#
# if __name__ == '__main__':
#     openCSV('001e0610c040.csv')
# with open("001e0610c040.csv") as f:
#     reader = csv.DictReader(f)
reader = csv.DictReader(open("001e0610c040.csv"))
reader = list(reader)
timeStamps = set()
organozed={}
for rows in reader:
    rows['sensor'] = rows['sensor']+'_'+rows['parameter']
    rows.pop('parameter')
    rows.pop('value_raw')
    rows.pop('node_id')
    rows.pop('subsystem')

# do somethin to see if the time stamp is included


     
    # timeStamps.add(rows['timestamp'])
newRow = [v for v in reader if v['value_hrf'] != 'NA']





# # Getting the unique timestamps
# timeStamps = list(timeStamps)
# timeStamps.sort()
# print(timeStamps)

print(dicread)












# for i, v in enumerate(reader):
#    print(i, v)
# Add sensor and parametor

#
# [rows['sensor'] = rows['sensor']+'_'+rows['parameter'] rows in reader]

# for rows in reader:







#     # ('node_id', '001e0610c040'), ('subsystem', 'lightsense'), ('
#     #print(rows)
#     # print(rows['timestamp'] + ' --> ' +rows['sensor'] +' : '+ rows['value_hrf'])
# print(list(reader))
# print(len(reader))

# x = reader.get("sensor")
# print(x)
# reader.sensor = reader.sensor+ sensor.parameter
