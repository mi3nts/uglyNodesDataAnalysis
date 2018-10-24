clc
clear all 
close all 


nodeID     = "001e0610c5fa";
dataFolder = "../../../data" 
timeUnit=20;




trainingData = loadUglyNodeTraining(nodeID,dataFolder,timeUnit);

%timePlotter2x(times,Data1,Data2,yLabel,displayName1,displayName2,nodeID,estimator,titlePre,saveNamePre)

timePlotter2x(trainingData.dateTime,...
    trainingData.pm2_5_Spectrometor,trainingData.opc_n2_pm2_5,...
    "pm2.5","Spectrometor","AlphaSensor",nodeID,"pm2.5","Training Data","TrainingData")







