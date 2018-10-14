
function uglyNodeData = getUglyNodeData(tStart,tEnd,nodeID)
%GETUGLYNODEDATA Summary of this function goes here
%   Detailed explanation goes here
timeRange = tStart:days(1):tEnd;
uglyNodeData = timetable();


for dayRange = 1: length(timeRange)
    year =  string(timeRange.Year(dayRange));
    month = sprintf('%02s',string(timeRange.Month(dayRange)));
    day   = sprintf('%02s',string(timeRange.Day(dayRange)));
    fileName = strcat(nodeID,"-",year,"-",month,"-",day,"-Organized.mat");
    filePath = strcat("../../../data/uglyNodes/",nodeID,"/",year,"/",month,"/",fileName);
    load(filePath);
    uglyNodeData = [uglyNodeData;currentTimeTable];
    
end

