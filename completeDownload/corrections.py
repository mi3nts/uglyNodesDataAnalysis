

import urllib.request
import time
import tarfile
import os
import datetime
import csv
from os import listdir
import shutil
from os import walk
import os
from fnmatch import fnmatch

def main():



    dataFolder    = '../../../data/'
    subFolder  = dataFolder + "uglyNodes/"
    # nodeList = ['001e0610c040','001e0610c2e5','001e0610c2dd',\
    # '001e0610c5fa','001e0610c069','001e0610c0ea','001e0610c219',\
    # '001e0610c042','001e0610c776','001e0610c0ef','001e0610c762',\
    # '001e0610c2eb','001e0610c2e9','001e0610c2e3','001e0610c42e',\
    # '001e0610c2df','001e0610c429','001e0610c06b','001e0610c2db',\
    # '001e0610c6f4','001e0610c2d7','001e0610c2e1','001e0610c2ed',\
    # '001e0610c2a9','001e0610c046','001e0610c044','001e0610c2e7',\
    # '001e0610c03e','001e0610c5ed','001e0610c216']

    keys = (['dateTime',\
             'opc_n2_bin0','opc_n2_bin1','opc_n2_bin2','opc_n2_bin3','opc_n2_bin4','opc_n2_bin5',\
             'opc_n2_bin6','opc_n2_bin7','opc_n2_bin8','opc_n2_bin9','opc_n2_bin10',\
             'opc_n2_bin11','opc_n2_bin12','opc_n2_bin13','opc_n2_bin14','opc_n2_bin15',\
             'opc_n2_pm1','opc_n2_pm2_5','opc_n2_pm10','opc_n2_sampling_period','opc_n2_sample_flow_rate',\
             'apds_9006_020_intensity', \
             'bmp180_pressure', 'bmp180_temperature',\
             'gps_altitude', \
             'gps_longitude', \
             'gps_latitude', \
             'hih4030_humidity',\
             'hih6130_humidity','hih6130_temperature',\
             'htu21d_humidity','htu21d_temperature',\
             'ml8511_intensity','mlx75305_intensity',\
             'pr103j2_temperature',\
             'spv1840lr5h_b_intensity',\
             'tmp112_temperature',\
             'tmp421_temperature',\
             'tsl250rd_intensity',\
             'tsl260rd_intensity',\
             'tsys01_temperature',\
             ])

    nodeID = '001e0610c2e5'
    csvList   =  getFilePathsforOrganizedNodes(nodeID,subFolder)
    for currentCSV in csvList:
        dateInfo = getDateDataOrganized(currentCSV,nodeID)
        if datetime.date(2018,5,1)<=datetime.date(int(dateInfo[0]),int(dateInfo[1]),int(dateInfo[2])):
            print('Editing ',currentCSV)
            currentDictionary =  getListDictionaryFromPath(currentCSV)
            if len(currentDictionary)>0:
                print(currentDictionary)
                currentDictionary = fixCSV('gps_latitude' ,35.0427 ,currentDictionary)
                currentDictionary = fixCSV('gps_longitude',-85.3057,currentDictionary)
                currentDictionary = fixCSV('altitude'     ,224.9   ,currentDictionary)
                csvWriter(currentCSV,currentDictionary,keys)
    #
    # nodeID = '001e0610c2e5'
    # csvList   =  getFilePathsforOrganizedNodes(nodeID,subFolder)
    # for currentCSV in csvList:
    #     dateInfo = getDateDataOrganized(currentCSV,nodeID)
    #     if datetime.date(2018,5,1)<=datetime.date(int(dateInfo[0]),int(dateInfo[1]),int(dateInfo[2])):
    #         print('Editing ',currentCSV)
    #         currentDictionary =  getListDictionaryFromPath(currentCSV)
    #         currentDictionary = fixCSV('gps_latitude' ,33.027222 ,currentDictionary)
    #         currentDictionary = fixCSV('gps_longitude',-96.750639,currentDictionary)
    #         currentDictionary = fixCSV('altitude'     ,219       ,currentDictionary)
    #         csvWriter(currentCSV,currentDictionary,keys)





def getListDictionaryFromPath(dirPath):
    print("Reading : "+ dirPath)
    reader = csv.DictReader(open(dirPath))
    reader = list(reader)



def fixCSV(keyIn,valueIn,currentDictionary):
    editedList       = editDictionaryList(currentDictionary,keyIn,valueIn)
    return editedList


def editDictionaryList(dictionaryListIn,keyIn,valueIn):
    for dictionaryIn in dictionaryListIn:
        dictionaryIn[keyIn] = valueIn

    return dictionaryListIn





def getDateDataOrganized(currentCSV,nodeID):
    currentCSVName = os.path.basename(currentCSV)
    nameOnly = currentCSVName.split('-Organized.')
    dateOnly = nameOnly[0].split(nodeID+'-')
    print(dateOnly)
    dateInfo = dateOnly[1].split('-')
    print(dateInfo)
    return dateInfo






def getFilePathsforOrganizedNodes(nodeID,subFolder):
    nodeFolder = subFolder+ nodeID+'/';
    pattern = "*Organized.csv"
    fileList = [];
    for path, subdirs, files in os.walk(nodeFolder):
        for name in files:
            if fnmatch(name, pattern):
                fileList.append(os.path.join(path, name))
    return sorted(fileList)


def getLocationList(directory, suffix=".csv"):
    filenames = listdir(directory)
    dateList = [ filename for filename in filenames if filename.endswith( suffix ) ]
    return sorted(dateList)



def getListDictionaryCSV(inputPath):
    # the path will depend on the node ID
    reader = csv.DictReader(open(inputPath))
    reader = list(reader)
    return reader


def writeCSV(reader,keys,outputPath):
    directoryCheck(outputPath)
    csvWriter(outputPath,reader,keys)

def directoryCheck(outputPath):
    directoryIn = os.path.dirname(outputPath)
    if not os.path.exists(directoryIn):
        os.makedirs(directoryIn)


def csvWriter(writePath,organizedData,keys):
    with open(writePath,'w') as output_file:
        writer = csv.DictWriter(output_file, fieldnames=keys)
        writer.writeheader()
        writer.writerows(organizedData)


def gainDirectoryInfo(dailyDownloadLocation):
    directoryPaths = []
    directoryNames = []
    directoryFiles = []
    for (dirpath, dirnames, filenames) in walk(dailyDownloadLocation):
        directoryPaths.extend(dirpath)
        directoryNames.extend(dirnames)
        directoryFiles.extend(filenames)

    return directoryPaths,directoryNames,directoryFiles;



if __name__ == "__main__":
   main()
