
clc
clear all
close all 

%% Assignments 

% startTime = datetime(2016,01,01,0,0,0);
% endTime   = datetime(2018,09,7,0,0,0);

startTime = datetime(2018,01,23,0,0,0);
endTime   = datetime(2018,01,29,0,0,0);


timeRange= [startTime:day(1):endTime]


fileNamePrefix = 'Spectrometor_Edited_6'

nodeID = "001e0610c040"


for dayRange=1:length(timeRange)
    
    year =  string(timeRange.Year(dayRange));
    month = sprintf('%02s',string(timeRange.Month(dayRange)));
    day   = sprintf('%02s',string(timeRange.Day(dayRange)));
   
    fileName = strcat(nodeID,"-",year,"-",month,"-",day,"-Organized.csv");
    filePath = strcat("../../../data/uglyNodes/",nodeID,"/",year,"/",month,"/",fileName)
    if(isfile(filePath))
        currentTable = csvToTable(filePath);
        currentTimeTable = tableToTT(currentTable) ;
        if (timeRange(dayRange)<=datetime(2018,04,10))
            currentTimeTable.gps_altitude(:)  =  220.675;
            currentTimeTable.gps_latitude(:)  =  32.992006; 
            currentTimeTable.gps_longitude(:) = -96.757806;
        else
            currentTimeTable.gps_altitude(:) = 224.9 ; 
            currentTimeTable.gps_latitude(:) = 35.0427;
            currentTimeTable.gps_longitude(:) = -85.3057;
        end                
        currentStructure  = table2struct(currentTimeTable) ;
        existFolder = strsplit(filePath,'.csv')       ;
        outPut =strcat(existFolder{1},'.mat') ;
        save(outPut,'currentTimeTable','currentStructure')      ;
    end
    
    
    
end












