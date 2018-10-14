function [] = dataSaver(nodeID,definition,path,inVariable)
%DATASAVER Summary of this function goes here
%   Detailed explanation goes here
varaible =  inVariable;
eval(strcat(definition,'=varaible;'));
saveName = strcat("../../../data/",path,"/",nodeID,definition,".mat");
save(saveName,definition);
end

