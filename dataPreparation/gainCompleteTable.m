
clc
clear all
close all 

%% Assignments 

startTime = datetime(2018,01,23,0,0,0);
endTime   = datetime(2018,01,29,0,0,0);

fileNamePrefix = 'Spectrometor_Edited_6'

nodeID = "c040"


%% Get Spectrometor Data 

fileName=strcat(fileNamePrefix,'_',string(year(startTime)),'_',...
         string(month(startTime)),'_',string(day(startTime)),'_to_',...
         string(year(endTime)),'_',string(month(endTime)),'_',string(day(endTime)));

spectrometorData = getSpectrometorData(fileName);


%% Get Ugly Node Data 

uglyNodeData     = getUglyNodeCSVData(nodeID);
uglyNodeData     = getUglyNodeData(uglyNodeData);


%% Sychronizing Data 

completeData = synchronize(spectrometorData,uglyNodeData,'intersection');


save(strcat('../../../Data/001e0610',nodeID,'Complete_',string(year(startTime)),'_',...
         string(month(startTime)),'_',string(day(startTime)),'_to_',...
         string(year(endTime)),'_',string(month(endTime)),'_',string(day(endTime)),'.mat'),'completeData')



clear all 
