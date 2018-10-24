
function inputTable = timeNearest(inputTable,interval)

inputTable.dateTime.Second(:)= round((inputTable.dateTime.Second(:)/interval))*interval;

end

