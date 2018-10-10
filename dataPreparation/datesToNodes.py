#!/usr/bin/python3

# uglyNodes(Waggle)dataOrganizer
# author: Lakitha Wijeratne
# date: October 6th 2018
import os
import csv
import sys, getopt
import time
from os import listdir
from os.path import basename
# import ../../../data/uglyNodes/completeDataSet/


def main(argv):
    try:
      opts, args = getopt.getopt(argv,"hi:",["ifile="])
    except getopt.GetoptError:
        print ('dataOrganizer.py -i <inputDirectory>')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print('dataOrganizer.py -i <inputfile>')
            sys.exit()
        elif opt in ("-i", "--ifile"):
            datesDirectory = arg
            # nodeList = ['001e0610c040','001e0610c2e5','001e0610c2dd',\
            # '001e0610c5fa','001e0610c069','001e0610c0ea','001e0610c219',\
            #  '001e0610c042'
            nodeList = ['001e0610c776','001e0610c0ef','001e0610c762',\
              '001e0610c2eb','001e0610c2e9','001e0610c2e3','001e0610c42e',\
                '001e0610c2df','001e0610c429','001e0610c06b','001e0610c2db',\
                  '001e0610c6f4','001e0610c2d7','001e0610c2e1','001e0610c2ed',\
                    '001e0610c2a9','001e0610c046','001e0610c044','001e0610c2e7',\
                       '001e0610c03e','001e0610c5ed','001e0610c216']

            # start = time.time()
            print('Listing Files')
            dateList = getCSVList(datesDirectory)
            print(dateList)
            [yearsList,monthsList]=getYearMonthUnique(dateList)
            createFolders(nodeList,yearsList,monthsList)

            # File Creation Done here :
            for node in nodeList:
                for date in dateList:
                    start = time.time()
                    nodeSplit(node,datesDirectory,date)
                    finish = time.time()
                    print("Time elapsed: " + str(finish - start))

def getCSVList(datesDirectory, suffix=".csv"):
    filenames = listdir('../../../data/uglyNodes/completeDataSet/'+datesDirectory+'/dates')
    dateList = [ filename for filename in filenames if filename.endswith( suffix ) ]
    return sorted(dateList)

def createFolders(nodeList,yearsList,monthsList):
    for node in nodeList:
        dirName= '../../../data/uglyNodes/'+node
        createDirectory(dirName)
        for year in yearsList:
            dirName= '../../../data/uglyNodes/'+node+'/'+year
            createDirectory(dirName)
            for month in monthsList:
                dirName= '../../../data/uglyNodes/'+node+'/'+year+'/'+month
                createDirectory(dirName)

def createDirectory(dirName):
    if not os.path.exists(dirName):
        os.mkdir(dirName)
        print("Directory " , dirName ,  " Created ")
    else:
        print("Directory " , dirName ,  " already exists")


def getDateData(currentCSV):
    nameOnly = currentCSV.split('.')
    dateInfo = nameOnly[0].split('-')
    return dateInfo

def getYearMonthUnique(dateList):
    years = set()
    months = set()
    for currentCSV in dateList:
        dateData = getDateData(currentCSV)
        years.add(dateData[0])
        months.add(dateData[1])
    return list(years),list(months);

def getListDictionary(inputPath,nodeID):
    reader = csv.DictReader(open(inputPath))
    reader = list(reader)
    reader = [v for v in reader if v['node_id'] == nodeID]
    keys = ['timestamp','node_id','subsystem','sensor','parameter','value_raw','value_hrf']
    return reader,keys;

def writeCSV(reader,keys,outputPath):
    with open(outputPath,'w') as output_file:
        writer = csv.DictWriter(output_file, fieldnames=keys)
        writer.writeheader()
        writer.writerows(reader)

def nodeSplit(nodeID,datesDirectory,CurrentDate):
    inputPath  = '../../../data/uglyNodes/completeDataSet/'+datesDirectory+'/dates/'+CurrentDate
    print("Input: " + inputPath)
    [reader,keys] = getListDictionary(inputPath,nodeID)
    if len(reader)>0:
        dateInfo = getDateData(CurrentDate)
        year  = dateInfo[0]
        month = dateInfo[1]
        day   = dateInfo[2]
        csvName = nodeID+'-'+year+'-'+month+'-'+day+'.csv'
        outputPath = '../../../data/uglyNodes/'+nodeID+'/'+year+'/'+month+'/'+csvName
        print("Writing CSV for Node: "+nodeID + " for " + CurrentDate.split('.')[0])
        writeCSV(reader,keys,outputPath)
    else:
        print("No Data for Node: "+nodeID + " on " + CurrentDate.split('.')[0])
        # return [ filename for filename in filenames if filename.endswith( suffix ) ]





if __name__ == "__main__":
   main(sys.argv[1:])
