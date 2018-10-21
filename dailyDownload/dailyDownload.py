
import urllib.request
import time
import tarfile
import os
import datetime
import csv
from os import listdir
import shutil


def main():

    print('Beginning GASP Data Download')

    url = 'https://www.mcs.anl.gov/research/projects/waggle/downloads/datasets/GASP.complete.latest.tar'
    dataFolder    = '../../../data/'
    localLocation = dataFolder + 'uglyNodes/dailyDownload/GASP.complete.latest.tar'
    datesLocation = dataFolder + 'uglyNodes/dailyDownload/GASP.complete/dates/'
    dataToolsPath = dataFolder + 'uglyNodes/completeDataSet/data-tools-master/'

    nodeList = ['001e0610c040','001e0610c2e5','001e0610c2dd',\
    '001e0610c5fa','001e0610c069','001e0610c0ea','001e0610c219',\
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
             ])

    start = time.time()
    downloadFile(url,localLocation)
    timeTaken('Data Downloaded in ',start)

    start = time.time()
    unzipFile(localLocation)
    timeTaken('Data Extracted in ',start)

    start = time.time()
    dateList = getLastDaysData(dataToolsPath,localLocation)
    timeTaken('latest data cropped in ',start)
    # dateList = sorted(getLocationList(datesLocation))

    start = time.time()
    splitAlldates2Nodes(nodeList,dateList,datesLocation)
    timeTaken('Nodes split in ',start)

    start = time.time()
    splitAlldates2Nodes(nodeList,dateList,datesLocation)
    timeTaken('Nodes split in ',start)

    start = time.time()
    writeAllOrganizedData(nodeList,dateList,dataFolder,keys)
    timeTaken('Data Organized in ',start)


def writeAllOrganizedData(nodeList,dateList,dataFolder,keys):
    for nodeID in nodeList:
        for dates in dateList:
            currentPath = getPathforUglyNode(nodeID,dates,dataFolder)
            if os.path.isfile(currentPath):
                reader = getListDictionaryFromPath(currentPath)
                organizedData = getOrganizedData(reader)
                writeOrganizedCSV(nodeID,dates,organizedData,dataFolder,keys)
            else:
                print("No data for" + currentPath )


def splitAlldates2Nodes(nodeList,dateList,datesLocation):
    for node in nodeList:
        for dates in dateList:
            nodeSplit(node,datesLocation,dates)

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


def writeOrganizedCSV(nodeID,dates,organizedData,dataFolder,keys):
    [year,month,day] = getDateData(dates)
    writePath = dataFolder +'uglyNodes/'+nodeID+'/'+year+'/'+month + '/'+ nodeID + '-'+ year+'-'+month+'-'+day+'-Organized.csv'
    with open(writePath,'w') as output_file:
        writer = csv.DictWriter(output_file, fieldnames=keys)
        writer.writeheader()
        writer.writerows(organizedData)

def getPathforUglyNode(nodeID,dates,dataFolder):
    [year,month,day] = getDateData(dates)
    currentPath = dataFolder +'uglyNodes/'+nodeID+'/'+year+'/'+month + '/'+ nodeID + '-'+ year+'-'+month+'-'+day+'.csv'
    return currentPath

def nodeSplit(nodeID,datesDirectory,CurrentDate):
    inputPath  = datesDirectory + CurrentDate
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


def getDateData(currentCSV):
    nameOnly = currentCSV.split('.')
    dateInfo = nameOnly[0].split('-')
    return dateInfo


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


def getYearMonthUnique(dateList):
    years = set()
    months = set()
    for currentCSV in dateList:
        dateData = getDateData(currentCSV)
        years.add(dateData[0])
        months.add(dateData[1])
    return list(years),list(months);


def downloadFile(url,localLocation):
    urllib.request.urlretrieve(url,localLocation)


def unzipper(localLocation):
  tar = tarfile.open(localLocation, "r:")
  tar.extractall(os.path.dirname(localLocation))
  tar.close()


def unzipFile(localLocation):
  unzipper(localLocation)
  sourceName = os.path.dirname(localLocation)+'/GASP.complete.'+datetime.datetime.utcnow().strftime('%Y-%m-%d')
  destinationName = os.path.dirname(localLocation)+'/GASP.complete'
  if os.path.exists(destinationName):
      print("The folder does exist")
      shutil.rmtree(destinationName)
  else:
      print("The folder does not exist")
  os.rename(sourceName, destinationName)


def gzExtractor(gzLocation):
    os.system('gzip -f ' +gzLocation)


def getLastDaysData(dataToolsPath,localLocation):
    sliceToolPath=dataToolsPath +  'slice-date-range/split-into-dates.py'
    destinationName = os.path.dirname(localLocation)+'/GASP.complete'
    os.system('python3 ' +sliceToolPath +' -n 3 '+destinationName )
    csvLocation= destinationName+'/dates/'
    fileDeleter(csvLocation,'.csv')
    csvList = getLocationList(csvLocation, suffix=".csv.gz")
    for locations in csvList:
        pathName = csvLocation+locations
        os.system('gzip -d --keep '+pathName)
    return getLocationList(csvLocation)


def getLocationList(directory, suffix=".csv"):
    filenames = listdir(directory)
    dateList = [ filename for filename in filenames if filename.endswith( suffix ) ]
    return sorted(dateList)


def fileDeleter(fileDirectory,fileExtension):
    files = os.listdir(fileDirectory)
    for item in files:
        if item.endswith(fileExtension):
            os.remove(os.path.join(fileDirectory, item))


def timeTaken(message,start):
    print(message+str(time.time()-start)+' Seconds')


if __name__ == "__main__":
   main()
