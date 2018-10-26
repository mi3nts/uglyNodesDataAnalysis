clc
clear all 
close all 


nodeList = ["001e0610c6f4","001e0610c5fa","001e0610c6f4",...
            "001e0610c2ed","001e0610c2e5","001e0610c2d7",...
            "001e0610c06b","001e0610c429","001e0610c2df",...
            "001e0610c42e",]

dataFolder = "../../../data" 
timeUnit=20;
pm1Data   = table;
pm2_5Data = table;
pm10Data  = table;


parfor nodeIndex =1:length(nodeList)
    
   nodeID = nodeList(nodeIndex)
   
   trainingData = loadUglyNodeTraining(nodeID,dataFolder,timeUnit);

   %timePlotter2x(times,Data1,Data2,yLabel,displayName1,displayName2,nodeID,estimator,titlePre,saveNamePre)
   
   timePlotter2x(trainingData.dateTime,...
                    trainingData.pm1_Spectrometor,trainingData.opc_n2_pm1,...
                      "pm1","Spectrometor","AlphaSensor",nodeID,"pm1","Training Data","TrainingDataPM1")
                  
   timePlotter2x(trainingData.dateTime,...
                    trainingData.pm2_5_Spectrometor,trainingData.opc_n2_pm2_5,...
                      "pm2.5","Spectrometor","AlphaSensor",nodeID,"pm2.5","Training Data","TrainingDataPM2.5")
                  
   timePlotter2x(trainingData.dateTime,...
                    trainingData.pm10_Spectrometor,trainingData.opc_n2_pm10	,...
                      "pm10","Spectrometor","AlphaSensor",nodeID,"pm10","Training Data","TrainingDataPM10")

%  scatterPlotter1x(xData,yData,xLimit,yLimit,xLabel,yLabel,nodeID,estimator,titlePre,saveNamePre,dataFolder)               
 
   pmData = scatterPlotter1x(trainingData.pm1_Spectrometor,trainingData.opc_n2_pm1,...
       1000,1000,...
       "Grimm Senor","Alpha Sensor",nodeID,...
       "PM1","Training Data","TrainingDataPM1",dataFolder)                     
   
    pm1Data =[pm1Data;pmData];  
   
   pmData = scatterPlotter1x(trainingData.pm2_5_Spectrometor,trainingData.opc_n2_pm2_5,...
       1000,1000,...
       "Grimm Senor","Alpha Sensor",nodeID,...
       "PM2.5","Training Data","TrainingDataPM2.5",dataFolder) 
   pm2_5Data =[pm2_5Data;pmData];
   
   pmData = scatterPlotter1x(trainingData.pm10_Spectrometor,trainingData.opc_n2_pm10,...
       1000,1000,...
       "Grimm Senor","Alpha Sensor",nodeID,...
       "PM10","Training Data","TrainingDataPM10",dataFolder) 
   pm10Data =[pm10Data;pmData];     
   
end



