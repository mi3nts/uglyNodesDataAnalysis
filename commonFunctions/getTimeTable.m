function [ nodeTable ] = getTimeTable(nodeData)

timeStamps= unique(nodeData.timestamp);
headers = ["dateTime";unique(nodeData.sensor)];

for tmRows=1:100
    tmRows
    currentTable = nodeData(nodeData.timestamp==timeStamps(tmRows),:);
    
    for snRows =1: height(currentTable)
        currentSensor = currentTable.sensor(snRows);
%         currentData = currentTable.H(snRows);
        nodeTable(tmRows).dateTime = currentTable.timestamp(1); 
        
        eval(strcat("nodeTable(",string(tmRows),").",currentSensor,"=currentTable.value_hrf(",string(snRows),");"))
        
    end

end

% nodeTable.dateTime = datetime(nodeTable.dateTime,'InputFormat','yyyy/MM/dd HH:mm:ss');
% nodeTable = table2timetable(nodeTable);
% nodeTable = fillmissing(nodeTable,'nearest');
end

