function [trainTable,valTable,testTable] = trainTestSplitTable(inputTable,trainRatio,valRatio,testRatio)

 [trainIndexes,valIndexes, testIndexes] =  divideint(height(inputTable),trainRatio,valRatio,testRatio);

 trainTable =  inputTable(trainIndexes,:);
 valTable   =  inputTable(valIndexes,:);
 testTable  =  inputTable(testIndexes,:);

end

