

clc 
clear all 
close all 

nodeID     = "001e0610c5fa";
dataFolder = "../../../data" 

loadUglyNodeTraining(nodeID,dataFolder)

scatterPlotter1x(xData,yData,xLimit,yLimit,xLabel,yLabel,nodeID,estimator,titlePre,saveNamePre,dataFolder)