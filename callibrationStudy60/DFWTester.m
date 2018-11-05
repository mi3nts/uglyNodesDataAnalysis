% clc 
% clear all 
% close all 


%% Data Input 
% nodeID     = "001e0610c2e5";
% dataFolder = "../../../data"; 
% tStart = datetime(2018,10,1);
% tEnd   = datetime(2018,10,28);
% 
% 
binBoundries = [.75, 1.7 , 2.2 ,  2.7, 3.3,...
                3.8, 4.7 , 6.6 ,  8.5, 10.5,...
                13.4,16.4, 20.5, 24.8, 29.3,...
                34.4,40.0] ;  

%% radiusOut = getRadiusFromBinDiametor(bins)
radiusOut   =getRadiusFromBinDiametorBounds(binBoundries);


% 
% %% Getting Current Ugly Node Data 
% 
% uglyNodeData1         =  getUglyNodeData(tStart,tEnd,nodeID);
% uglyNodeData2         =  tableMixerUglyNode(uglyNodeData1);
% 
% %% Moving Average Data 
% 
% uglyNodeData3         = getMovingAverageTable(uglyNodeData2,60);

%% loadingRawData 
% 
% dataOut = dataLoaderExplicit(nodeID,dataFolder,path,matName,varName)
pm = dataLoaderExplicit(nodeID,dataFolder,"rawData","rawData","pm")



 for n = 1:length(pm)
    %dataOut = dataLoaderExplicit(nodeID,dataFolder,path,matName,varName)
     mdl =  dataLoaderExplicit(nodeID,dataFolder,"predictors",pm(n).nlmID,"mdl");

 
     eval(strcat("inputCurrent = binsOnly",pm(n).label,"(uglyNodeData3);"));
    
     predictionCurrent = nlmPredictor(mdl,...
                                  inputCurrent(1:end,:),...
                                  pm(n).radiusTaken);
% 
% scatterPlotter1x(xData,yData,xLimit,yLimit,xLabel,yLabel,nodeID,estimator,label,titlePre,saveNamePre,dataFolder)
scatterPlotter1x(eval(strcat("uglyNodeData3.opc_n2_",pm(n).label)),...
                predictionCurrent,...
                100,100,...
                "Alpha Sensor",...
                "Linear Regression Prediction",...
                nodeID,...
                pm(n).name,...
                pm(n).label,...
                "Linear Regression Prediction - Feild Data - Bins as Inputs",...
                "LinearRegressionPredictionFeildDataBinsasInputs",...
                dataFolder)


% timePlotter2x(times,Data1,Data2,yLabel,displayName1,displayName2,nodeID,estimator,titlePre,saveNamePre)

uglyNodeData4 = uglyNodeData3(uglyNodeData3.opc_n2_pm10<150,:);
predictionCurrent2 =    predictionCurrent(uglyNodeData3.opc_n2_pm10<150,:);
timePlotter2x(...
    uglyNodeData4.dateTime,...
    eval(strcat("uglyNodeData4.opc_n2_",pm(n).label)),...
    predictionCurrent2,...
    pm(n).name,...
    "Alpha Sensor",...
    "Linear Regression Prediction",...
    nodeID,...
     pm(n).name,...
     pm(n).label,...
    "Linear Regression Prediction - Feild Data - Bins as Inputs",...
    "LinearRegressionPredictionFeildDataBinsasInputs")










% 
% plot(uglyNodeData3.dateTime,eval(strcat("uglyNodeData3.opc_n2_",pm(n).label)))
% 
% hold on 
% plot(uglyNodeData3.dateTime,predictionCurrent,'r')                                 


 end            
 
 
 
 
 
 
 
 
 
 
 
 
                                  