function structRow = getStruct(inputArg1,inputArg2)


currentRow.Properties.VariableNames = headers;
currentRow.dateTime =  currentTable.timestamp(1);

for rows = 1:height(currentTable)
   eval(strcat("currentRow.",currentTable.sensor(rows),"=string(currentTable.value_hrf(",string(rows),"));"))
   % eval(strcat("currentRow.",currentTable.sensor(rows),"=",string(currentTable.value_hrf(rows)),";"))
end

end

