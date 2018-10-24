function uniqueOutputFinal = getUniqueTable(inputTable)
[uniqueDateTimes,index1,index2] = unique(inputTable.dateTime);
uniqueOutput = table();

   parfor n=1:max(index2)
      uniqueOutput = [uniqueOutput; retime(inputTable(index2==n,:),'secondly','mean')];
   end

uniqueOutputFinal = uniqueOutput;
end

