
clc
clear all 
close all 


%% loading the Data 
tStart = datetime(2018,9,16);
tEnd   = datetime(2018,10,14);


nodeID = '001e0610c2e5';

load(strcat('../../../data/trainingData/',nodeID,'CalibrationData.mat'))

inputFormat = CalibrationData(:,1:41);

%% With Just the Bins  

CalibrationDataNow = pm2_5Bins(CalibrationData);
% % PM 2.5
modelFun = @(b,x)b(1)*x(:,1)+b(2)*x(:,2)+ b(3)*x(:,3)+ b(4)*x(:,4);          
InitialEstimate = [1 1 1 1];
mdlPm2_5Bins = fitnlm(CalibrationDataNow,modelFun,InitialEstimate)
pm2_5PredictionwithBins = pm2_5PredictionBins(mdlPm2_5Bins,inputFormat);


% %% Bins+Alpha Sensor Value 
% 
CalibrationDataNow = pm2_5BinsAlpha(CalibrationData);
% PM 2.5
modelFun = @(b,x)b(1)*x(:,1)+ b(2)*x(:,2)+ b(3)*x(:,3)+ b(4)*x(:,4)+ b(5)*x(:,5);          
InitialEstimate = [1 1 1 1 1];
mdlPm2_5BinsAlpha = fitnlm(CalibrationDataNow,modelFun,InitialEstimate)
pm2_5PredictionwithBinsAlpha = pm2_5PredictionBinsAlpha(mdlPm2_5BinsAlpha,inputFormat);



%% Bins+Alpha+Weather Sensor Value 
% 
% CalibrationDataNow = pm2_5BinsAlphaWeather(CalibrationData);
% % PM 2.5
% modelFun = @(b,x)b(1)*x(:,1)+ b(2)*x(:,2)+ b(3)*x(:,3)+ b(4)*x(:,4)+ b(5)*x(:,5)+ b(6)*x(:,6)+ b(7)*x(:,7)+ b(8)*x(:,8);          
% InitialEstimate = [1 1 1 1 1 1 1 1];
% mdlPm2_5BinsAlphaWeather        = fitnlm(CalibrationDataNow,modelFun,InitialEstimate)
% pm2_5PredictionwithBinsAlphaWeather = pm2_5PredictionBinsAlphaWeather(mdlPm2_5BinsAlphaWeather,inputFormat);
% % 
% 
% 
% %% Get Ugly Node Data 
% 
uglyNodeData          = properTable(getUglyNodeData(tStart,tEnd,nodeID));
currentPredictionBins = pm2_5PredictionBins(mdlPm2_5Bins,uglyNodeData);
currentPredictionBinsAlpha = pm2_5PredictionBinsAlpha(mdlPm2_5BinsAlpha,uglyNodeData);



% currentPredictionBinsAlphaWeather = pm2_5PredictionBinsAlphaWeather(mdlPm2_5BinsAlphaWeather,uglyNodeData);
% 
% 
% 
% %% Plotting Graphs for the Training Data 
% 

scatterPlotter(CalibrationData.pm2_5_Spectrometor,...
                             CalibrationData.opc_n2_pm2_5,...
                             50,...
                             50,...
                             'Spectrometor',....
                             'Alpha Sensor',...
                             nodeID,...
                             'pm2.5',....
                             'Uncalibrated Data ',...
                             'UncalibratedData')                            
                         


 scatterPlotter(CalibrationData.pm2_5_Spectrometor,...
                             pm2_5PredictionwithBins,...
                             50,...
                             50,...
                             'Spectrometor',....
                             'Alpha Sensor',...
                             nodeID,...
                             'pm2.5',....
                             'Training Data Prediction with Bins',...
                             'CalibrationDataPredictionwithBins')                         
                         

scatterPlotter(CalibrationData.pm2_5_Spectrometor,...
                             pm2_5PredictionwithBinsAlpha,...
                             50,...
                             50,...
                             'Spectrometor',....
                             'Alpha Sensor',...
                             nodeID,...
                             'pm2.5',....
                             'Training Data Prediction with Bins and Alpha Sensor Reading',...
                             'CalibrationDataPredictionwithBinsAlphaSensorReading')  

%                          
%        
% scatterPlotter(CalibrationData.pm2_5_Spectrometor,...
%                              pm2_5PredictionwithBinsAlphaWeather,...
%                              50,...
%                              50,...
%                              'Spectrometor',....
%                              'Alpha Sensor',...
%                              nodeID,...
%                              'pm2.5',....
%                              'Training Data Prediction with Bins, Alpha Sensor Reading and Weather Data' ,...
%                              'CalibrationDataPredictionwithBinsAlphaSensorReadingWeatherData')  
                                            
scatterPlotter(uglyNodeData.opc_n2_pm2_5,...
                             currentPredictionBins,...
                             50,...
                             50,...
                             'Alpha Sensor',....
                             'Prediction',...
                             nodeID,...
                             'pm2.5',....
                             'Prediction with Bins ',...
                             'PredcitionWithBins')
                       
                         
 scatterPlotter(uglyNodeData.opc_n2_pm2_5,...
                             currentPredictionBinsAlpha,...
                             50,...
                             50,...
                             'Alpha Sensor',....
                             'Prediction',...
                             nodeID,...
                             'pm2.5',....
                             'Prediction with Bins and Alpha Sensor Reading ',...
                             'PredcitionWithBinsAlpha')
%                                               
% scatterPlotter(uglyNodeData.opc_n2_pm2_5,...
%                              currentPredictionBinsAlphaWeather,...
%                              50,...
%                              50,...
%                              'Alpha Sensor',....
%                              'Prediction',...
%                              nodeID,...
%                              'pm2.5',....
%                              'Prediction with Bins, Alpha Sensor Reading and Weather Data ',...
%                              'PredcitionWithBinsAlphaSensorReadingAndWeatherData')                     
                          
timePlotter(CalibrationData.dateTime,CalibrationData.opc_n2_pm2_5,'Alpha Sensor',nodeID,'pm2.5', 'Uncalibrated Data ',...
                             'UncalibratedData')
%                          
%                          
% %% 
timePlotter2x(...
    CalibrationData.dateTime ,...
    CalibrationData.pm2_5_Spectrometor,...
    CalibrationData.opc_n2_pm2_5,...
    'pm2.5',...
    'Spectrometor',...
    'Alpha Sensor',...
    nodeID,...
    'pm2.5',...
    'Uncalibrated Data',...
    'UncalibratedData')
                         

timePlotter2x(...
    uglyNodeData.dateTime,...
    currentPredictionBins,...
    currentPredictionBinsAlpha,...
    'pm2.5',...
    'Prediction with Bins',...
    'Prediction with Bins and Alpha Sensor Reading',...
    nodeID,...
    'pm2.5',...
    'Linear Regression Calibration ',...
    'LinearRegressionCalibration'...
    )
% 

timePlotter3x(...
    uglyNodeData.dateTime,...
    currentPredictionBins,...
    currentPredictionBinsAlpha,...
   uglyNodeData.opc_n2_pm2_5,...
    'pm2.5',...
    'Prediction with Bins',...
    'Prediction with Bins and Alpha Sensor Reading',...
    'Alpha Sensor Reading',...
    nodeID,...
    'pm2.5',...
    'Linear Regression Calibration ',...
    'LinearRegressionCalibrationComparison'...
   )
% 














% 
% timePlotter(CalibrationData.dateTime,CalibrationData.htu21d_humidity,...
%            'Humidity',...
%             nodeID,...
%             'Humidity',...
%             'Training Data',...
%             'HumidityRangeForCalibrationData')
% 
% 
% timePlotter(uglyNodeData.dateTime,uglyNodeData.htu21d_humidity,...
%            'Humidity',...
%             nodeID,...
%             'Humidity',...
%             'Current Data',...
%             'HumidityRangeForCurrentData')
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 