function [] = dataSaver(nodeID,fileName,variableName,path,inVariable)
%DATASAVER Summary of this function goes here
%   Detailed explanation goes here
varaible =  inVariable;
eval(strcat(variableName,'=varaible;'));
saveName = strcat("../../../data/",path,"/",nodeID,"/",nodeID,fileName,".mat");
createDirectory(saveName);
save(saveName,variableName);
end

