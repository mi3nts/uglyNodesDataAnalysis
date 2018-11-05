function averagedTimeTable = timeAveragedTableUnique(timeTableIn,period)
%% TIMEAVERAGEDTABLEUNIQUE
% For any time Table this will give an averaged time table 
% which is averaged to within the period mentioned
% Only Works for seconds 

    averagedTimeTable   =  timeNearest(timeTableIn,period);
    averagedTimeTable   =  getUniqueTable(averagedTimeTable);
                    
end

