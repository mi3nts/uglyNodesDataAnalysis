function  TTOut= getMovingAverageTable(timeTableIn,period)

 TTOut = timetable();
 
   parfor n =1 : height(timeTableIn)
        windowBegin  =  timeTableIn.dateTime(n);
        windowEnd    =  timeTableIn.dateTime(n)+minutes(period);
        currentTable =  timeTableIn((timeTableIn.dateTime<windowEnd)&...
                                (timeTableIn.dateTime>=windowBegin)...
                                ,:);
        TTOut    = [TTOut; getTimeTableAverage(currentTable)];
        TTheights(n) = height(currentTable);  
   end 

    TTOut(median(TTheights)*.95>TTheights,:)=[];







end

