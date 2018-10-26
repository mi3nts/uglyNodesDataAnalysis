clc
clear all 
close all 

tStart = datetime(2018,10,20);
tEnd   = datetime(2018,10,20);

nodeID =  "001e0610c2e5"

uglyNodeData        = getUglyNodeData(tStart,tEnd,nodeID);
uglyNodeDataPredict = tableMixerUglyNode(uglyNodeData);

predictor = predictorLoader(nodeID,dataFolder,"pm2_5","BoostedTree")