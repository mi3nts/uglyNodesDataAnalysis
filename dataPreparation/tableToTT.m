function uglyNodeData = tableToTT(uglyNodeDataPre)
%TABLETOTT Summary of this function goes here
%   Detailed explanation goes here
uglyNodeDataPre.dateTime  = datetime(uglyNodeDataPre.dateTime,'InputFormat','yyyy/MM/dd HH:mm:ss');
uglyNodeData = table2timetable(uglyNodeDataPre);
end

