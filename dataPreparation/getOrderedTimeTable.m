function spectrometorData = getOrderedTimeTable(timeTable)
%GETORDEREDTIMETABLE Summary of this function goes here
%   Detailed explanation goes here

% Modify to include 10, 20, 30 and 60 
newTimes           = timeTable.dateTime;
newTimes.Second    = 0;


spectrometorData   = retime(timeTable,unique(newTimes),'linear');
end

