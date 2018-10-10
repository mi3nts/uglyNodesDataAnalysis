function [currentTable] = csvToTable(filePath)
%CSVTOTABLE Summary of this function goes here
%   Detailed explanation goes here

% [fileDirectory,fileName,fileExtension]=fileparts(filePath)

currentTable = readtable(filePath);
% currentStructure =  table2struct(currentTable);

end

