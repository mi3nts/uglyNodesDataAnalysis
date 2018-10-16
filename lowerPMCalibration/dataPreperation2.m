clc
clear all 
close all 

%% Definitions 
% % tic
% tStart = datetime(2018,04,28);
% tEnd   = datetime(2018,05,5);
% nodeID = '001e0610c2e5' ;
% % toc


% % %% Definitions 
tic
tStart = datetime(2018,01,23);
tEnd   = datetime(2018,01,29);
nodeID = '001e0610c040' ;
toc

spectometorFNPrefix = 'Spectrometor_Edited_6';


%% Get Spectrometor Data 

spectrometorData = getSpectrometorData(spectometorFNPrefix,tStart,tEnd);
toc

%% Get Node Data 

uglyNodeData = getUglyNodeData(tStart,tEnd,nodeID);

% 
%% Mixing Data 

tic 
CalibrationData = tableMixer(spectrometorData,uglyNodeData,10);
toc
% % Saving Data 
dataSaver(nodeID,"CalibrationData","trainingData",CalibrationData);
% 
% 
% reducedData = upperLimitCrop(mixedData,'pm2_5_Spectrometor',35);
% 
%  
% dataSaver(nodeID,"trainingDataReduced20Sec","trainingData",reducedData);
% 
% [trainedModel2_5, validationRMSE] = trainRegressionModel(pm2_5Trainer);
% 
% prediction = trainedModel2_5.predictFcn(input);
% 
% 
% plot(prediction,output);
% % 
% 
% 
% 
% 
