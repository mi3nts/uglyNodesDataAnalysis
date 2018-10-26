function [] = createDirectory(filePath)
%CREATEDIRECTORY Summary of this function goes here
%   Detailed explanation goes here

[folderPath,name,ext] = fileparts(filePath);

if (exist(folderPath)~=7 )
mkdir(folderPath) ;
end    
    
end

