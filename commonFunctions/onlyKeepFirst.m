function  tableOut = onlyKeepFirst(table1,table2)

mixedData = outerjoin(table1,table2);

table1joined = mixedData(:,1:width(table1));

table2joined = mixedData(:,width(table1)+1:end);

table2modified =  fillmissing(table2joined,'linear');
table1joined(isnan(table2array(table1joined(:,1))),:)=[];

tableOut = innerjoin(table1joined,table2modified);

end

