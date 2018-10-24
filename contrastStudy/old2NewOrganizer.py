#!/usr/bin/python3

# convcerting from old CSV structure to new
# author: Lakitha Wijeratne
# date: October 23th 2018
from operator import itemgetter
import os
import csv
import sys, getopt
import time
from os import listdir
import pprint



def main():

    print('Beginning GASP Data Download')

    # url = 'https://www.mcs.anl.gov/research/projects/waggle/downloads/datasets/GASP.complete.latest.tar'
    dataFolderOld    = '../../../data/cabinetNodes'
    dataFolderNew    = '../../../data/uglyNodes'
    # localLocation = dataFolder + 'uglyNodes/dailyDownload/GASP.complete.latest.tar'
    # datesLocation = dataFolder + 'uglyNodes/dailyDownload/GASP.complete/dates/'
    # dataToolsPath = dataFolder + 'uglyNodes/completeDataSet/data-tools-master/'
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

    # nodeList =   ['lk']
    # # nodeList =   ['001e0610c2e9','001e0610c5fa','001e0610c2dd','001e0610c2ed', \
    # nodeList =   ['001e0610c2e1','001e0610c2d7','001e0610c06b','001e0610c429', \
    #               '001e0610c2df','001e0610c42e','001e0610c2e3','001e0610c6f4',\
    nodeList = [ '001e0610c2eb','001e0610c042','001e0610c2e5','001e0610c219',\
                  '001e0610c040','001e0610c0ea','001e0610c069','001e0610c2db']

    start = time.time()
    writeAllOrganizedData(nodeList,dataFolderOld,dataFolderNew,keys)
    timeTaken('Data Organized in ',start)


def writeAllOrganizedData(nodeList,dataFolderOld,dataFolderNew,keys):
    for nodeID in nodeList:
        print('-------------------------------------')
        dateList = getCSVList(dataFolderOld+'/'+nodeID)

        for dates in dateList:
            print('-------------------------------------')
            currentPath = getPathforUglyNode(dataFolderOld,nodeID,dates,)
            print(currentPath)
            start = time.time()
            reader = getListDictionaryFromPath(currentPath)
            # printPretty(reader,2)
            organizedData = getOrganizedData(reader)
            timeTaken("data read and Organized in ",start)
            # printPretty(organizedData,2)
            writeOrganizedCSV(nodeID,dates,organizedData,dataFolderOld,dataFolderNew,keys)
            # else:
            #     print("No data for" + currentPath )

def printPretty(dataIN,indent=4):
    pp = pprint.PrettyPrinter(indent)
    pp.pprint(dataIN)

def getPathforUglyNode(dataFolder,nodeID,dates):
    currentPath = dataFolder+'/'+nodeID+'/'+ dates
    return currentPath

def getListDictionaryFromPath(dirPath):

    print('Reading from :' + dirPath)
    reader = csv.DictReader(open(dirPath),fieldnames=[\
        'node_id',\
        'timestamp',\
        'subsystem',\
        'preParametor',\
        'sensor_1',\
        'sensor_2',\
        'value_hrf'\
        ], \
        delimiter=';'
        )

    reader = [v for v in reader if v['sensor_1'] != 'checksum']
    reader = [v for v in reader if v['sensor_1'] != 'mtof']
    reader = [v for v in reader if v['sensor_1'] != 'HMC5883L']
    reader = [v for v in reader if v['sensor_1'] != 'MMA8452Q']
    reader = [v for v in reader if v['sensor_1'] != 'Coresense ID']
    for rows in reader:
        rows.pop('preParametor')
        rows.pop('node_id')
        rows.pop('subsystem')
        rows['sensor'] = rows['sensor_1']+"_"+rows['sensor_2']
        rows['sensor'] = rows['sensor'].lower().replace("-", "_").replace("bins_", "opc_n2_bin").replace("pm_", "opc_n2_pm").replace("tsl250rd_as_intensity", "tsl250rd_intensity").replace(".", "_")
        rows.pop('sensor_1')
        rows.pop('sensor_2')

    reader = [v for v in reader if v['sensor'] != 'tsl250rd_as_intensity']
    reader = [v for v in reader if v['sensor'] != 'tsl250rd_ls_intensity']
    # reader = [v for v in reader if v['sensor'] != 'mlx75305_intensity']

    reader = sorted(reader, key=itemgetter('timestamp'))
    return list(reader);

def getOrganizedData(reader):
    organizedData = []
    currentRowsequence = {}
    for rows, nextRow in zip(reader, reader[1:]+[reader[0]]):
        # currentRowsequence[rows['sensor']] = rows['value_hrf']
        # if(rows['sensor'] == 'opc_n2_bins'):
        #     binDataAll = rows['value_hrf']
        #     binData = binDataAll.split(',')
        #     currentRowsequence['opc_n2_bin0'] = binData[0]
        #     currentRowsequence['opc_n2_bin1'] = binData[1]
        #     currentRowsequence['opc_n2_bin2'] = binData[2]
        #     currentRowsequence['opc_n2_bin3'] = binData[3]
        #     currentRowsequence['opc_n2_bin4'] = binData[4]
        #     currentRowsequence['opc_n2_bin5'] = binData[5]
        #     currentRowsequence['opc_n2_bin6'] = binData[6]
        #     currentRowsequence['opc_n2_bin7'] = binData[7]
        #     currentRowsequence['opc_n2_bin8'] = binData[8]
        #     currentRowsequence['opc_n2_bin9'] = binData[9]
        #     currentRowsequence['opc_n2_bin10'] = binData[10]
        #     currentRowsequence['opc_n2_bin11'] = binData[11]
        #     currentRowsequence['opc_n2_bin12'] = binData[12]
        #     currentRowsequence['opc_n2_bin13'] = binData[13]
        #     currentRowsequence['opc_n2_bin14'] = binData[14]
        #     currentRowsequence['opc_n2_bin15'] = binData[15]
        # else:
        currentRowsequence[rows['sensor']] = rows['value_hrf']


        if(rows['timestamp'] != nextRow['timestamp']):
            currentRowsequence['dateTime'] = rows['timestamp']
            organizedData.append(currentRowsequence)
            currentRowsequence = {}

    return organizedData

def getDateData(currentCSV):
    nameOnly = currentCSV.split('.')
    dateInfo = nameOnly[0].split('-')
    return dateInfo

def getCSVList(dataFolder, suffix=".csv"):
    filenames = listdir(dataFolder)
    dateList = [ filename for filename in filenames if (filename.endswith( suffix ) and not(filename.endswith("Old"+suffix ))) ]
    return sorted(dateList)







def writeOrganizedCSV(nodeID,dates,organizedData,dataFolderOld,dataFolderNew,keys):
    dateInfo = getDateData(dates)
    year  =  dateInfo[0]
    month =  dateInfo[1]
    day   =  dateInfo[2]
    writePathOld = dataFolderOld +'/'+nodeID+'/'+year +'-'+month+'-'+day+'-OrganizedOld.csv'

    writePathNew = dataFolderNew +'/'+nodeID+'/'+year+'/'+month + '/'+ nodeID + '-'+ year+'-'+month+'-'+day+'-OrganizedOld.csv'

    print("oldPath:" + writePathOld)
    print("newPath:" + writePathNew)
    start = time.time()
    with open(writePathOld,'w') as output_file:
        writer = csv.DictWriter(output_file, fieldnames=keys)
        writer.writeheader()
        writer.writerows(organizedData)

    with open(writePathNew,'w') as output_file:
        writer = csv.DictWriter(output_file, fieldnames=keys)
        writer.writeheader()
        writer.writerows(organizedData)

    timeTaken("Data Written for "+nodeID+" in ",start)











def timeTaken(message,start):
    print(message+str(time.time()-start)+' Seconds')


if __name__ == "__main__":
   main()
