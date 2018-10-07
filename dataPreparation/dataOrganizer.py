#!/usr/bin/python3

# uglyNodes(Waggle) Data Organizer
# auther: Lakitha Wijeratne
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


def getListDictionary(nodeID):

    dirPath = "../../../Data/001e0610" + nodeID +".csv"
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
    keys.add('dateTime')
    keys = list(keys)

    reader = [v for v in reader if v['value_hrf'] != 'NA']
    reader = [v for v in reader if v['sensor'] != 'metsense_id']
    return reader,keys;

def getOrganizedData(reader):
    organizedData = []
    currentRowsequence = {}
    for rows, nextRow in zip(reader, reader[1:]+[reader[0]]):
        currentRowsequence[rows['sensor']] = rows['value_hrf']
        if(rows['timestamp'] != nextRow['timestamp']):
            currentRowsequence['dateTime'] = rows['timestamp']
            organizedData.append(currentRowsequence)
            currentRowsequence = {}

    return organizedData


def writeCSV(organizedData,keys,nodeID):
    with open("../../../Data/001e0610" + str(nodeID)+"Organized.csv",'w') as output_file:
        myFields = list(keys)
        writer = csv.DictWriter(output_file, fieldnames=myFields)
        writer.writeheader()
        writer.writerows(organizedData)


if __name__ == "__main__":
   main(sys.argv[1:])
