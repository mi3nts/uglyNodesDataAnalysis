
clc
clear all
close all 

%% Assignments 
% 
startTime = datetime(2018,04,28,0,0,0);
endTime   = datetime(2018,5,5,0,0,0);
 
% startTime = datetime(2018,09,15,0,0,0);
% endTime   = datetime(2018,10,15,0,0,0);


timeRange= [startTime:day(1):endTime]


fileNamePrefix = 'Spectrometor_Edited_6'

nodeList = ["001e0610c5fa","001e0610c2ed","001e0610c2d7",...
                "001e0610c06b","001e0610c429","001e0610c2df",...
                    "001e0610c42e","001e0610c6f4","001e0610c2e5"]


for nodeIndex = 1:length(nodeList)
    
    nodeID = nodeList(nodeIndex)

    for dayRange=1:length(timeRange)
        
        year =  string(timeRange.Year(dayRange));
        month = sprintf('%02s',string(timeRange.Month(dayRange)));
        day   = sprintf('%02s',string(timeRange.Day(dayRange)));

        fileName = strcat(nodeID,"-",year,"-",month,"-",day,"-OrganizedOld.csv");
        filePath = strcat("../../../data/uglyNodes/",nodeID,"/",year,"/",month,"/",fileName);
        if(isfile(filePath))
            currentTable = csvToTable(filePath);
            nodeData = tableToTT(currentTable) ;
%             if (timeRange(dayRange)<=datetime(2018,9,12))
%                 nodeData.gps_altitude(:)  =  220.675;
%                 nodeData.gps_latitude(:)  =  32.992006; 
%                 nodeData.gps_longitude(:) = -96.757806;
%             else
%                 nodeData.gps_altitude(:)  = 219.00 ; 
%                 nodeData.gps_latitude(:)  = 33.027222;
%                 nodeData.gps_longitude(:) = -96.750639;
%             end                
             %currentStructure  = table2struct(timetable2table(nodeData)) ;
             existFolder = strsplit(filePath,'-OrganizedOld.csv')       ;
             outPut =strcat(existFolder{1},'.mat') 
             save(outPut,'nodeData')      ;
         end

    end

end











