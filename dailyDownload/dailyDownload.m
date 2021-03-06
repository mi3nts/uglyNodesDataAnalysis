
clc
clear all
close all 

timeRange = sort(datetime('today') - caldays(1:1:1000))

nodeIDs =  ["001e0610c040","001e0610c2e5","001e0610c2dd",...
    "001e0610c5fa","001e0610c069","001e0610c0ea","001e0610c219",...
    "001e0610c042","001e0610c776","001e0610c0ef","001e0610c762",...
    "001e0610c2eb","001e0610c2e9","001e0610c2e3","001e0610c42e",...
    "001e0610c2df","001e0610c429","001e0610c06b","001e0610c2db",...
    "001e0610c6f4","001e0610c2d7","001e0610c2e1","001e0610c2ed",...
    "001e0610c2a9","001e0610c046","001e0610c044","001e0610c2e7",...
    "001e0610c03e","001e0610c5ed","001e0610c216"]


for nodeIndex = 1:length(nodeIDs)
    
    nodeID = nodeIDs(nodeIndex)
    
    for dayRange=1:length(timeRange)
     
        year =  string(timeRange.Year(dayRange))
        month = sprintf('%02s',string(timeRange.Month(dayRange)))
        day   = sprintf('%02s',string(timeRange.Day(dayRange)))

        fileName = strcat(nodeID,"-",year,"-",month,"-",day,"-Organized.csv");
        filePath = strcat("../../../data/uglyNodes/",nodeID,"/",year,"/",month,"/",fileName);
        
        if(isfile(filePath))
            
            currentTable = csvToTable(filePath);
            nodeData     = tableToTT(currentTable) ;
            nodeData     = corrections(nodeID,nodeData);
            existFolder  = strsplit(filePath,'-Organized.csv')       ;
            outPut       = strcat(existFolder{1},'.mat') ;
            save(outPut,'nodeData')      ;
        
        end
        
    end
    
end










