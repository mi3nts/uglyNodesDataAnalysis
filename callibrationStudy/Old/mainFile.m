
% timeStamps= unique(nodeData.timestamp);
% headers = ["dateTime";unique(nodeData.sensor)];
% nodeTable=table();
% 
%     rows=1
%     currentTable = nodeData(nodeData.timestamp==timeStamps(rows),:);
%% Getting the timeTable
% nodeData = getTimeTable(nodeData);
% 

% 
timeStamps= unique(nodeData.timestamp);
headers = ["dateTime";unique(nodeData.sensor)];

timeStamps= unique(nodeData.timestamp);
headers = ["dateTime";unique(nodeData.sensor)];

for tmRows=1:length(timeStamps)
    currentTable = nodeData(nodeData.timestamp==timeStamps(tmRows),:);  
    for snRows =1: height(currentTable)
        currentSensor = currentTable.sensor(snRows);
%       currentData = currentTable.H(snRows);
        nodeTable(tmRows).dateTime = currentTable.timestamp(1); 
        eval(strcat("nodeTable(",string(tmRows),").",currentSensor,"=currentTable.value_hrf(",string(snRows),");"))   
    end
end
% 
% 
% 
% 
