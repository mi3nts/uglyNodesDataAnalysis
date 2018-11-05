function meanRow = getTimeTableAverage(timeTableIn)
%GETTIMETABLEAVERAGE Summary of this function goes here
%   Detailed explanation goes here

meanRow                           =   varfun(@mean,timeTableIn);
meanRow.Properties.VariableNames  =   timeTableIn.Properties.VariableNames;
meanRow.dateTime              =   getMidTimefromTimeTable(timeTableIn);





end

