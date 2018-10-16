#!/usr/bin/python3

# uglyNodes(Waggle)dataOrganizer
# author: Lakitha Wijeratne
# date: October 6th 2018

import csv
import sys, getopt
import time


def main(argv):
    nodeID = ''
    try:
      opts, args = getopt.getopt(argv,"hi:",["ifile="])
    except getopt.GetoptError:
        print ('dataOrganizer.py -i <inputfile>')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print('dataOrganizer.py -i <inputfile>')
            sys.exit()
        elif opt in ("-i", "--ifile"):
            nodeID = arg
            start = time.time()
            print('Reading Node 001e0610'+nodeID)
            [reader,keys] = getListDictionary(nodeID)
            print('Geting Organized Data for Node 001e0610'+nodeID)
            organizedData = getOrganizedData(reader)
            print('Writing the Final CSV for Node 001e0610'+nodeID)
            writeCSV(organizedData,keys,nodeID)
            finish = time.time()
            print('Time elapsed for Node 001e0610'+nodeID+ ": "+ str(finish - start))

def getfileListforNode(nodeID):
    dirPath = "../../../Data/UglyNodes/'+ nodeID +".csv"



def getListDictionary(nodeID):

    dirPath = "../../../Data/UglyNodes/001e0610" + nodeID +".csv"
    reader = csv.DictReader(open(dirPath))
    reader = list(reader)
    keys = set()

    for rows in reader:
        rows['sensor'] = rows['sensor']+'_'+rows['parameter']
        rows.pop('parameter')
        rows.pop('value_raw')
        rows.pop('node_id')
        rows.pop('subsystem')
        keys.add(rows['sensor'])
    # keys.add('dateTime')
    reader = [v for v in reader if v['value_hrf'] != 'NA']
    reader = [v for v in reader if v['sensor'] != 'metsense_id']

    keys.remove('metsense_id')
    keys.remove('opc_n2_bins')
    keys.update(['opc_n2_bin0','opc_n2_bin1','opc_n2_bin2','opc_n2_bin3','opc_n2_bin4','opc_n2_bin5',\
                  'opc_n2_bin6','opc_n2_bin7','opc_n2_bin8','opc_n2_bin9','opc_n2_bin10',\
                    'opc_n2_bin11','opc_n2_bin12','opc_n2_bin13','opc_n2_bin14','opc_n2_bin15'])


    keys = list(keys)
    keys.sort()
    keys =  ['dateTime'] + keys
    print(keys)
    return reader,keys;

def getOrganizedData(reader):
    organizedData = []
    currentRowsequence = {}
    for rows, nextRow in zip(reader, reader[1:]+[reader[0]]):
        # currentRowsequence[rows['sensor']] = rows['value_hrf']
        if(rows['sensor'] == 'opc_n2_bins'):
            binDataAll = rows['value_hrf']
            binData = binDataAll.split(',')
            currentRowsequence['opc_n2_bin0'] = binData[0]
            currentRowsequence['opc_n2_bin1'] = binData[1]
            currentRowsequence['opc_n2_bin2'] = binData[2]
            currentRowsequence['opc_n2_bin3'] = binData[3]
            currentRowsequence['opc_n2_bin4'] = binData[4]
            currentRowsequence['opc_n2_bin5'] = binData[5]
            currentRowsequence['opc_n2_bin6'] = binData[6]
            currentRowsequence['opc_n2_bin7'] = binData[7]
            currentRowsequence['opc_n2_bin8'] = binData[8]
            currentRowsequence['opc_n2_bin9'] = binData[9]
            currentRowsequence['opc_n2_bin10'] = binData[10]
            currentRowsequence['opc_n2_bin11'] = binData[11]
            currentRowsequence['opc_n2_bin12'] = binData[12]
            currentRowsequence['opc_n2_bin13'] = binData[13]
            currentRowsequence['opc_n2_bin14'] = binData[14]
            currentRowsequence['opc_n2_bin15'] = binData[15]
        else:
            currentRowsequence[rows['sensor']] = rows['value_hrf']


        if(rows['timestamp'] != nextRow['timestamp']):
            currentRowsequence['dateTime'] = rows['timestamp']
            organizedData.append(currentRowsequence)
            currentRowsequence = {}

    return organizedData


def writeCSV(organizedData,keys,nodeID):
    with open("../../../Data/UglyNodes/001e0610" + str(nodeID)+"Organized.csv",'w') as output_file:
        myFields = list(keys)
        writer = csv.DictWriter(output_file, fieldnames=myFields)
        writer.writeheader()
        writer.writerows(organizedData)


if __name__ == "__main__":
   main(sys.argv[1:])
