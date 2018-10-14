
import urllib.request
import time
import tarfile
import os
import datetime
import sliceDateRange
import shutil


def main():
    print('Beginning GASP Data Download')
    start = time.time()
    url = 'https://www.mcs.anl.gov/research/projects/waggle/downloads/datasets/GASP.complete.latest.tar'
    localLocation = '../../../data/uglyNodes/dailyDownload/GASP.complete.latest.tar'
    dataToolsPath = '../../../data/uglyNodes/completeDataSet/data-tools-master/'
    # downloadFile(url,localLocation)
    print('Data Downloaded in '+ str(time.time()-start) + ' secs')

    print('Extracting Data')
    start = time.time()
    unzipFile(localLocation)
    print('Data Extracted in '+ str(time.time()-start) + ' secs')
    print('Date Extracting Data')
    start = time.time()
    # getLastDaysData(dataToolsPath,localLocation)
    # print('Dates Extracted in '+ str(time.time()-start) + ' secs')

def downloadFile(url,localLocation):
    urllib.request.urlretrieve(url,localLocation)


def unzipFile(localLocation):
  tar = tarfile.open(localLocation, "r:")
  tar.extractall(os.path.dirname(localLocation))
  tar.close()
  sourceName = os.path.dirname(localLocation)+'/GASP.complete.'+datetime.datetime.today().strftime('%Y-%m-%d')
  destinationName = os.path.dirname(localLocation)+'/GASP.complete'
  if os.path.exists(destinationName):
      print("The folder does not exist")
      os.rmdir(destinationName)
  else:
      print("The folder does not exist")
  os.rename(sourceName, destinationName)

def getLastDaysData(dataToolsPath,localLocation):
    sliceToolPath=dataToolsPath +  'slice-date-range/split-into-dates.py'
    destinationName = os.path.dirname(localLocation)+'/GASP.complete'
    os.system('python3 ' +sliceToolPath +' -n 2 '+destinationName )






if __name__ == "__main__":
   main()
