clc
clear all 
close all 

%% Definitions 
% % tic
% tStart = datetime(2018,04,28);
% tEnd   = datetime(2018,05,5);
% nodeID = '001e0610c2e5' ;
% % toc


%% Definitions 
tStart = datetime(2018,04,28);
tEnd   = datetime(2018,05,05);

nodeList = ["001e0610c429",   "001e0610c42e","001e0610c5fa","001e0610c2ed","001e0610c2d7",...
                "001e0610c06b","001e0610c2df",...
                 "001e0610c6f4","001e0610c2e5"]


timeUnit = 20 ;           
%% Spectrometor Data 
spectometorFNPrefix = 'Spectrometor_Edited_6';
spectrometorData = getSpectrometorData(spectometorFNPrefix,tStart,tEnd);

%% Node Data
tEnd   = datetime(2018,04,28);



for nodeIndex = 1:length(nodeList)
    
    
    nodeID =  nodeList(nodeIndex)
    
    uglyNodeData = getUglyNodeData(tStart,tEnd,nodeID);

    %% Mixing Data 
    trainingData = tableMixer(spectrometorData,uglyNodeData,timeUnit);

    %% Saving Data 

    dataSaver(nodeID,strcat("trainingData",string(timeUnit)),"trainingData","trainingData/uglyNodes",trainingData);



end



