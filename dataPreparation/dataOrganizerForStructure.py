#!/usr/bin/python3

# uglyNodes(Waggle)dataOrganizer
# author: Lakitha Wijeratne
# date: October 9th 2018

import csv
import sys, getopt
import time
from os import listdir

def main(argv):
    try:
      opts, args = getopt.getopt(argv,"hd:",["ifile="])
    except getopt.GetoptError:
        print ('dataOrganizerForStructure.py -d <datafolder>')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print('dataOrganizerForStructure.py -d <datafolder>')
            sys.exit()
        elif opt in ("-d", "--dfolder"):
            dataFolder = arg
            start = time.time()
            # nodeList = ['001e0610c040','001e0610c2e5','001e0610c2dd',\
            nodeList = ['001e0610c5fa','001e0610c069','001e0610c0ea','001e0610c219',\
            '001e0610c042','001e0610c776','001e0610c0ef','001e0610c762',\
            '001e0610c2eb','001e0610c2e9','001e0610c2e3','001e0610c42e',\
            '001e0610c2df','001e0610c429','001e0610c06b','001e0610c2db',\
            '001e0610c6f4','001e0610c2d7','001e0610c2e1','001e0610c2ed',\
            '001e0610c2a9','001e0610c046','001e0610c044','001e0610c2e7',\
            '001e0610c03e','001e0610c5ed','001e0610c216']

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
                     'pm1_Spectrometor',\
                     'pm2_5_Spectrometor',\
                     'pm10_Spectrometor',\
                     'Alveolic',\
                     'Thoracic',\
                     'Inhalable',\
                     ])

            print('Listing Files')
            dateList = getCSVList(dataFolder)
            print(dateList)
            [yearsList,monthsList]=getYearMonthUnique(dateList)
            yearsList = sorted(yearsList)
            monthsList = sorted(monthsList)
            #loop through every folder
            for node in nodeList:
                for year in yearsList:
                    for month in monthsList:
                        currentDirectory =dataFolder +'uglyNodes/'+node+'/'+year+'/'+month
                        print("Current search folder:"+ currentDirectory)
                        # Getting file list
                        currentCSVList =  getCSVListCurrentDirectory(currentDirectory, suffix=".csv")
                        currentCSVList =  [v for v in currentCSVList if "Organized" not in v]
                        currentCSVList = sorted(currentCSVList)
                        print("Current CSV List : ")
                        print(currentCSVList)
                        if len(currentCSVList)>0:
                            for currentCSV in currentCSVList:
                                start = time.time()
                                reader = getListDictionaryFromPath(currentDirectory+'/'+currentCSV)
                                organizedData = getOrganizedData(reader)
                                writeCSV(organizedData,keys,currentDirectory,currentCSV)
                                finish = time.time()
                                print('Time elapsed for ' + currentCSV +" : "+ str(finish - start))

def getCSVList(dataFolder, suffix=".csv"):
    filenames = listdir(dataFolder+'/uglyNodes/completeDataSet/GASP.complete/dates')
    dateList = [ filename for filename in filenames if filename.endswith( suffix ) ]
    return sorted(dateList)

def getCSVListCurrentDirectory(currentDirectory, suffix=".csv"):
    filenames = listdir(currentDirectory)
    dateList = [ filename for filename in filenames if filename.endswith( suffix ) ]
    return sorted(dateList)

def getYearMonthUnique(dateList):
    years = set()
    months = set()
    for currentCSV in dateList:
        dateData = getDateData(currentCSV)
        years.add(dateData[0])
        months.add(dateData[1])
    return list(years),list(months);

def getDateData(currentCSV):
    nameOnly = currentCSV.split('.')
    dateInfo = nameOnly[0].split('-')
    return dateInfo


def getListDictionaryFromPath(dirPath):

    print('Reading from :' + dirPath)
    reader = csv.DictReader(open(dirPath))
    reader = list(reader)


    for rows in reader:
        rows['sensor'] = rows['sensor']+'_'+rows['parameter']
        rows.pop('parameter')
        rows.pop('value_raw')
        rows.pop('node_id')
        rows.pop('subsystem')

    # keys.add('dateTime')
    reader = [v for v in reader if v['value_hrf'] != 'NA']
    reader = [v for v in reader if v['sensor'] != 'metsense_id']



    return reader;



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


def writeCSV(organizedData,keys,currentDirectory,currentCSV):
    writePath = currentDirectory+'/'+currentCSV.split('.')[0]+'-Organized.csv'
    with open(writePath,'w') as output_file:
        writer = csv.DictWriter(output_file, fieldnames=keys)
        writer.writeheader()
        writer.writerows(organizedData)


if __name__ == "__main__":
   main(sys.argv[1:])
