clc
clear all 
close all 

%% Definitions 
tic
tStart = datetime(2018,04,28);
tEnd   = datetime(2018,05,5);

nodeID = '001e0610c2e5' ;

spectometorFNPrefix = 'Spectrometor_Edited_6';


%% Get Spectrometor Data 

spectrometorData = getSpectrometorData(spectometorFNPrefix,tStart,tEnd);


%% Get Node Data 

uglyNodeData = getUglyNodeData(tStart,tEnd,nodeID);







% %% Mixing Data 
% mixedData = tableMixer(spectrometorData,uglyNodeData);
% 
% % Saving Data 
% dataSaver(nodeID,"trainingData","trainingData",mixedData);
% 
% 
% reducedData = upperLimitCrop(mixedData,'pm2_5_Spectrometor',35);
% 
%  
% dataSaver(nodeID,"trainingDataReduced","trainingData",reducedData);
% 
% [trainedModel2_5, validationRMSE] = trainRegressionModel(pm2_5Trainer);
% 
% prediction = trainedModel2_5.predictFcn(input);
% 
% 
% plot(prediction,output);
% 
% 
% 
% 
% 
