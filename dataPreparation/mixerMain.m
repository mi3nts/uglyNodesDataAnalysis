clc 
clear all
close all 

% Have to Code
startTime = datetime(2018,01,23,0,0,0);
endTime   = datetime(2018,01,29,0,0,0);

timeRange= [startTime:day(1):endTime]


fileNamePrefix = 'Spectrometor_Edited_6'

nodeID = "001e0610c040"

%% Get Spectrometor Data 

fileName=strcat(fileNamePrefix,'_',string(year(startTime)),'_',...
         string(month(startTime)),'_',string(day(startTime)),'_to_',...
         string(year(endTime)),'_',string(month(endTime)),'_',string(day(endTime)));
spectrometorData = getSpectrometorDataRaw(fileName);

daysOnly = spectrometorData.dateTime;
daysOnly.Hour(:) =0;
daysOnly.Minute(:) =0;
daysOnly.Second(:)=0; 
for dayRange=1:length(timeRange)
    
    year =  string(timeRange.Year(dayRange));
    month = sprintf('%02s',string(timeRange.Month(dayRange)));
    day   = sprintf('%02s',string(timeRange.Day(dayRange)));
   
    fileName = strcat("spectrometor-",year,"-",month,"-",day,"-cleaned.mat");
    filePath = strcat("../../../data/spectrometor/",year,"/",month,"/",fileName);
     
    currentTimeTableSpectrometor = spectrometorData(daysOnly==timeRange(dayRange),:);
    currentStructureSpectrometor = table2struct(currentTimeTableSpectrometor);
    
    
    save(fileName,'currentTimeTableSpectrometor','currentStructureSpectrometor')      ;
        
    
end

