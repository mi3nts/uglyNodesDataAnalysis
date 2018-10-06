function [currentRow] = getRow(currentTable,headers)

currentRow= array2table(NaN(1,length(headers)));
currentRow.Properties.VariableNames = headers;
currentRow.dateTime =  currentTable.timestamp(1);

for rows = 1:height(currentTable)
   eval(strcat("currentRow.",currentTable.sensor(rows),"=string(currentTable.value_hrf(",string(rows),"));"))
   % eval(strcat("currentRow.",currentTable.sensor(rows),"=",string(currentTable.value_hrf(rows)),";"))
end

% currentRow= struct2table(currentRow);

end

