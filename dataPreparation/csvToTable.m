function [currentTable] = csvToTable(filePath)
%CSVTOTABLE Summary of this function goes here
%   Detailed explanation goes here

% [fileDirectory,fileName,fileExtension]=fileparts(filePath)

currentTable = readtable(filePath,'Format','%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f');


% currentStructure =  table2struct(currentTable);

end

