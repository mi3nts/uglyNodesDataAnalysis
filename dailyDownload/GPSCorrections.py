
from shutil import copyfile

from datetime import date
import urllib.request
import time
import tarfile
import os
import datetime
import csv
from os import listdir
import shutil
from os import walk
import numpy as np
from pprint import pprint
from operator import itemgetter

def main():
    dataFolder    = '../../../data/'
    subFolder  = dataFolder + "uglyNodes/"
    # sendPath   = subFolder + "testingAir/"
    sendPathAir    = '/run/user/1000/gvfs/smb-share:server=djlnas2.local,share=lakitha/MINTS/Air/'
    sendPathLabAir = '/run/user/1000/gvfs/smb-share:server=djlnas2.local,share=lakitha/MINTS/LabAir/'

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


    nodeListLabAir = ['001e0610c2dd',\
    '001e0610c5fa','001e0610c069','001e0610c0ea','001e0610c219',\
    '001e0610c042','001e0610c776','001e0610c0ef','001e0610c762',\
    '001e0610c2eb','001e0610c2e9','001e0610c2e3','001e0610c42e',\
    '001e0610c2df','001e0610c429','001e0610c06b','001e0610c2db',\
    '001e0610c6f4','001e0610c2d7','001e0610c2e1','001e0610c2ed',\
    '001e0610c2a9','001e0610c046','001e0610c044','001e0610c2e7',\
    '001e0610c03e','001e0610c5ed','001e0610c216']

# Correcting CO40
    nodeID = "001e0610c040"
    dateList=  gainDirectoryInfoSubFolder(subFolder,nodeID,"Organized.csv")
    print(nodeID)
    for dateCSV in dateList:
        # yearIn,monthIn,dayIn = getDateDataOrganized(dateCSV)
        if (getDateDataOrganized(dateCSV)>=date(2018,4,10)):
            reader = getListDictionaryFromPathOrganized(dateCSV)
            readerOut = updateListOfDictionaries(reader,'gps_altitude','224.9 ')
            readerOut = updateListOfDictionaries(reader,'gps_latitude','35.0427')
            readerOut = updateListOfDictionaries(reader,'gps_longitude','-85.3057')
            writeOrganizedCSVCorrections(nodeID,dateCSV,readerOut,subFolder,keys,sendPathAir)

        else:
            reader = getListDictionaryFromPathOrganized(dateCSV)
            readerOut = updateListOfDictionaries(reader,'gps_altitude','226 ')
            readerOut = updateListOfDictionaries(reader,'gps_latitude','32.99193634570803')
            readerOut = updateListOfDictionaries(reader,'gps_longitude','-96.757809519767')
            writeOrganizedCSVCorrections(nodeID,dateCSV,readerOut,subFolder,keys,sendPathLabAir)




# Correcting C2e5
    nodeID = "001e0610c2e5"
    dateList=  gainDirectoryInfoSubFolder(subFolder,nodeID,"Organized.csv")
    print(nodeID)
    for dateCSV in dateList:
        # yearIn,monthIn,dayIn = getDateDataOrganized(dateCSV)
        if (getDateDataOrganized(dateCSV)>=date(2018,9,13)):
            reader = getListDictionaryFromPathOrganized(dateCSV)
            readerOut = updateListOfDictionaries(reader,'gps_altitude','219 ')
            readerOut = updateListOfDictionaries(reader,'gps_latitude','33.027222')
            readerOut = updateListOfDictionaries(reader,'gps_longitude','-96.750639')
            writeOrganizedCSVCorrections(nodeID,dateCSV,readerOut,subFolder,keys,sendPathAir)
        else:
            reader = getListDictionaryFromPathOrganized(dateCSV)
            readerOut = updateListOfDictionaries(reader,'gps_altitude','226 ')
            readerOut = updateListOfDictionaries(reader,'gps_latitude','32.99193634570803')
            readerOut = updateListOfDictionaries(reader,'gps_longitude','-96.757809519767')
            writeOrganizedCSVCorrections(nodeID,dateCSV,readerOut,subFolder,keys,sendPathLabAir)


    for nodeID in nodeListLabAir:
        print(nodeID)
        dateList=  gainDirectoryInfoSubFolder(subFolder,nodeID,"Organized.csv")
        for dateCSV in dateList:
            reader = getListDictionaryFromPathOrganized(dateCSV)
            readerOut = updateListOfDictionaries(reader,'gps_altitude','226 ')
            readerOut = updateListOfDictionaries(reader,'gps_latitude','32.99193634570803')
            readerOut = updateListOfDictionaries(reader,'gps_longitude','-96.757809519767')
            writeOrganizedCSVCorrections(nodeID,dateCSV,readerOut,subFolder,keys,sendPathLabAir)


def writeOrganizedCSVCorrections(nodeID,dates,organizedData,subFolder,keys,sendPath):
    [year,month,day] = getDateDataCorrections(dates)
    writePath       = subFolder +nodeID+'/'+year+'/'+month + '/'+ nodeID + '-'+ year+'-'+month+'-'+day+'-Organized.csv'
    sendPathUpdated = sendPath + nodeID+'/'+year+'/'+month + '/'+ nodeID + '-'+ year+'-'+month+'-'+day+'-Organized.csv'
    directoryCheck(writePath)
#   Apply the correction
    csvWriter(writePath,organizedData,keys)
    sendCopy(writePath,sendPathUpdated)

def updateListOfDictionaries(listIn,headerIn,valueIn):
    for d in listIn:
        d[headerIn] = valueIn
    return listIn

def gainDirectoryInfoSubFolder(subFolder,nodeID,suffix):
    nodeFolder =     subFolder + nodeID
    # directoryNames = []
    # directoryFiles = []
    allFilesIn = []
    for (dirpath, dirnames, filenames) in walk(nodeFolder):
        for file in filenames:
            if file.endswith(suffix):

                allFilesIn.append(os.path.join(dirpath, file))

    return sorted(allFilesIn);


def getDateDataOrganized(currentCSV):
    nameOnly = currentCSV.split('-Organized.csv')
    dateInfo = nameOnly[0].split('-')


    return date( int(dateInfo[1]), int(dateInfo[2]), int(dateInfo[3]));


def getDateDataCorrections(currentCSV):
    nameOnly = currentCSV.split('-Organized.csv')
    dateInfo = nameOnly[0].split('-')


    return dateInfo[1], dateInfo[2], dateInfo[3];


def getListDictionaryFromPathOrganized(dirPath):

    print('Reading from :' + dirPath)
    reader = csv.DictReader(open(dirPath))
    reader = list(reader)
    return reader

###############################################

def sendCopy(seekPath,sendPath):

    fileNameSend  = os.path.basename(seekPath)
    directorySend = os.path.dirname(sendPath)
    sendPathAddress = os.path.join(directorySend,fileNameSend)
    directoryCheck(sendPathAddress)
    # fileDeleterFromPath(sendPathAddress)
    # time.sleep(1)
    try:
        copyfile(seekPath,    sendPathAddress)
    except IOError as e:
        print("First Copy Error: %s" % e)
    try:
        copyfile(seekPath,    sendPathAddress)
    except IOError as e:
        print("Secon Copy Error: %s" % e)

def writeCSV(reader,keys,outputPath):
    directoryCheck(outputPath)
    csvWriter(outputPath,reader,keys)


def csvWriter(writePath,organizedData,keys):
    if len(organizedData)>0:
        with open(writePath,'w') as output_file:
            writer = csv.DictWriter(output_file, fieldnames=keys)
            writer.writeheader()
            writer.writerows(organizedData)

def directoryCheck(outputPath):
    directoryIn = os.path.dirname(outputPath)
    if not os.path.exists(directoryIn):
        os.makedirs(directoryIn)

if __name__ == "__main__":
   main()
