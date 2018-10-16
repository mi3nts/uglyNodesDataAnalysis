
clc
clear all
close all 

%% Assignments 
% 
startTime = datetime(2016,01,01,0,0,0);
% % endTime   = datetime(2018,09,15,0,0,0);
% 
% startTime = datetime(2018,09,15,0,0,0);
endTime   = datetime(2018,10,15,0,0,0);


timeRange= [startTime:day(1):endTime]


fileNamePrefix = 'Spectrometor_Edited_6'

nodeID = "001e0610c2e5"


for dayRange=1:length(timeRange)
    
    year =  string(timeRange.Year(dayRange));
    month = sprintf('%02s',string(timeRange.Month(dayRange)));
    day   = sprintf('%02s',string(timeRange.Day(dayRange)));
   
    fileName = strcat(nodeID,"-",year,"-",month,"-",day,"-Organized.csv");
    filePath = strcat("../../../data/uglyNodes/",nodeID,"/",year,"/",month,"/",fileName);
    if(isfile(filePath))
        currentTable = csvToTable(filePath);
        nodeData = tableToTT(currentTable) ;
        if (timeRange(dayRange)<=datetime(2018,04,10))
            nodeData.gps_altitude(:)  =  220.675;
            nodeData.gps_latitude(:)  =  32.992006; 
            nodeData.gps_longitude(:) = -96.757806;
        else
            nodeData.gps_altitude(:) = 224.9 ; 
            nodeData.gps_latitude(:) = 35.0427;
            nodeData.gps_longitude(:) = -85.3057;
        end                
        currentStructure  = table2struct(timetable2table(nodeData)) ;
        existFolder = strsplit(filePath,'-Organized.csv')       ;
        outPut =strcat(existFolder{1},'.mat') 
        save(outPut,'nodeData')      ;
    end
    
    
    
end












