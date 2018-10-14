
clc
clear all 
close all 


%% loading the Data 
tStart = datetime(2018,09,1);
tEnd   = datetime(2018,09,2);


nodeID = '001e0610c040';

load(strcat('../../../data/trainingData/',nodeID,'trainingDataReduced.mat'))
inputFormat = trainingDataReduced(:,7:47);



%% With Just the Bins  

trainingData = pm2_5bins(trainingDataReduced);
% PM 2.5
modelFun = @(b,x)b(1)*x(:,1)+b(2)*x(:,2)+ b(3)*x(:,3)+ b(4)*x(:,4);          
InitialEstimate = [1 1 1 1];
mdlPm2_5Bins = fitnlm(trainingData,modelFun,InitialEstimate)
pm2_5PredictionwithBins = pm2_5PredictionBins(mdlPm2_5Bins,inputFormat);


%% Bins+Alpha Sensor Value 

trainingData = pm2_5BinsAlpha(trainingDataReduced);
% PM 2.5
modelFun = @(b,x)b(1)*x(:,1)+ b(2)*x(:,2)+ b(3)*x(:,3)+ b(4)*x(:,4)+ b(5)*x(:,5);          
InitialEstimate = [1 1 1 1 1];
mdlPm2_5BinsAlpha = fitnlm(trainingData,modelFun,InitialEstimate)
pm2_5PredictionwithBinsAlpha = pm2_5PredictionBinsAlpha(mdlPm2_5BinsAlpha,inputFormat);

% 
%% Bins+Alpha Sensor Value 

trainingData = pm2_5BinsAlphaWeather(trainingDataReduced);
% PM 2.5
modelFun = @(b,x)b(1)*x(:,1)+ b(2)*x(:,2)+ b(3)*x(:,3)+ b(4)*x(:,4)+ b(5)*x(:,5)+ b(6)*x(:,6)+ b(7)*x(:,7)+ b(8)*x(:,8);          
InitialEstimate = [1 1 1 1 1 1 1 1];
mdlPm2_5BinsAlphaWeather        = fitnlm(trainingData,modelFun,InitialEstimate)
pm2_5PredictionwithBinsAlphaWeather = pm2_5PredictionBinsAlphaWeather(mdlPm2_5BinsAlphaWeather,inputFormat);


% Get Ugly Node Data 

uglyNodeData          = properTable(getUglyNodeData(tStart,tEnd,nodeID));
currentPredictionBins = pm2_5PredictionBins(mdlPm2_5Bins,uglyNodeData);
currentPredictionBinsAlpha = pm2_5PredictionBinsAlpha(mdlPm2_5BinsAlpha,uglyNodeData);
currentPredictionBinsAlphaWeather = pm2_5PredictionBinsAlphaWeather(mdlPm2_5BinsAlphaWeather,uglyNodeData);



% % PM 2.5
% modelFun = @(b,x)b(1)*x(:,1)  +b(2)*x(:,2)+ b(3)*x(:,3)+ b(4)*x(:,4)+ b(5)*x(:,5);
%              
% InitialEstimate = [1 1 1 1 1];
% mdlPm2_5 = fitnlm(pm2_5training,modelFun,InitialEstimate)
% 
% pm2_5CoeffientsWA = mdlPm2_5.Coefficients.Estimate(:);
% pm2_5BinsWA = trainingDataReduced(:,[7:10,24]);
% pm2_5PredictionWA = table2array(getTableWithoutDate(timetable2table(pm2_5BinsWA)))*pm2_5CoeffientsWA;
% 
% 
% %% With Alpha Sensor Inputs + Temprature, Humidity and Pressure
%  
% pm1training   = getTableWithoutDate(timetable2table(trainingDataReduced(:,[7:8,23,1])));
% pm2_5training = getTableWithoutDate(timetable2table(trainingDataReduced(:,[7:10,24,2])));
% pm10training  = getTableWithoutDate(timetable2table(trainingDataReduced(:,[7:16,25,3])));
% 
% modelFun = @(b,x)b(1)*x(:,1)  +b(2)*x(:,2)+ b(3)*x(:,3)+ b(4)*x(:,4);
%              
% InitialEstimate = [1 0 0 0];
% mdlPm2_5 = fitnlm(pm2_5training,modelFun,InitialEstimate)
% 
% pm2_5Coeffients = mdlPm2_5.Coefficients.Estimate(:);
% pm2_5Bins = trainingDataReduced(:,[7:10]);
% 
% pm2_5Prediction = table2array(getTableWithoutDate(timetable2table(pm2_5Bins)))*pm2_5Coeffients;
% 









% %% Gaining the Coefficients 
% 
% % From the t values ganned we can state that the alpha sensors used the counts in the first 3 bins to 
% % predict the pm 1 values 
% 
% % As Such we retain the first 3 bins of data to predict pm 1 using a neural
% % network 
% 
% % pm1 predictor input 
% 
% 
% pm1_Coeffients = mdl_pm_1.Coefficients.Estimate(1:3)
% 
% 
% Alpha_Sensor_Linear_Reg_tbl_pm_2_5 = table(Alpha_Histogram_Values_per_20_sec_mix(:,1),Alpha_Histogram_Values_per_20_sec_mix(:,2),...
%     Alpha_Histogram_Values_per_20_sec_mix(:,3),Alpha_Histogram_Values_per_20_sec_mix(:,4),...
%     Alpha_Histogram_Values_per_20_sec_mix(:,5),Alpha_Histogram_Values_per_20_sec_mix(:,6),...
%     Alpha_Histogram_Values_per_20_sec_mix(:,7),Alpha_Histogram_Values_per_20_sec_mix(:,8),...
%     Alpha_Histogram_Values_per_20_sec_mix(:,9),Alpha_Histogram_Values_per_20_sec_mix(:,10),...
%     Alpha_Histogram_Values_per_20_sec_mix(:,11),Alpha_Histogram_Values_per_20_sec_mix(:,12),...
%     Alpha_Histogram_Values_per_20_sec_mix(:,13),Alpha_Histogram_Values_per_20_sec_mix(:,14),...
%     Alpha_Histogram_Values_per_20_sec_mix(:,15),Alpha_Histogram_Values_per_20_sec_mix(:,16),...
%    Alpha_Sensor_pm_2_5_Measered_per_20_sec_mix);
% 
% 
% mdl_pm_2_5 = fitnlm(Alpha_Sensor_Linear_Reg_tbl_pm_2_5,modelfun,Initial_Estimate)
% 
% 
% % From the t values ganned we can state that the alpha sensors used the counts in the first 6 bins to 
% % predict the pm 1 values 
% 
% % As Such we retain the first 6 bins of data to predict pm 2.5 using a neural network 
% 
% % pm2_5 predictor input 
% 
% pm2_5_Coeffients = mdl_pm_2_5.Coefficients.Estimate(1:6)
% 
% 
% 
% 
% %% Gaining the Coefficients 
% 
% % From the t values ganned we can state that the alpha sensors used the counts in the first 3 bins to 
% % predict the pm 10 values 
% 
% % As Such we retain the first 3 bins of data to predict pm 1 using a neural
% % network 
% 
% % pm1 predictor input 
% 
% Alpha_Sensor_Linear_Reg_tbl_pm_10 = table(Alpha_Histogram_Values_per_20_sec_mix(:,1),Alpha_Histogram_Values_per_20_sec_mix(:,2),...
%     Alpha_Histogram_Values_per_20_sec_mix(:,3),Alpha_Histogram_Values_per_20_sec_mix(:,4),...
%     Alpha_Histogram_Values_per_20_sec_mix(:,5),Alpha_Histogram_Values_per_20_sec_mix(:,6),...
%     Alpha_Histogram_Values_per_20_sec_mix(:,7),Alpha_Histogram_Values_per_20_sec_mix(:,8),...
%     Alpha_Histogram_Values_per_20_sec_mix(:,9),Alpha_Histogram_Values_per_20_sec_mix(:,10),...
%     Alpha_Histogram_Values_per_20_sec_mix(:,11),Alpha_Histogram_Values_per_20_sec_mix(:,12),...
%     Alpha_Histogram_Values_per_20_sec_mix(:,13),Alpha_Histogram_Values_per_20_sec_mix(:,14),...
%     Alpha_Histogram_Values_per_20_sec_mix(:,15),Alpha_Histogram_Values_per_20_sec_mix(:,16),...
%    Alpha_Sensor_pm_10_Measered_per_20_sec_mix);
% 
% 
% mdl_pm_10 = fitnlm(Alpha_Sensor_Linear_Reg_tbl_pm_10,modelfun,Initial_Estimate)
% 
% 
% % From the t values ganned we can state that the alpha sensors used the counts in the first 10 bins to 
% % predict the pm 1 values 
% 
% % As Such we retain the first 10 bins of data to predict pm 10 using a neural network 
% 
% % pm10 predictor input 
% 
% pm10_Coeffients = mdl_pm_10.Coefficients.Estimate(1:10)
% 
% % using the pm 10 coefficients I  try to predict the coefficients for the rest of the histogram counts 
% 
% % Alpha sense centre size in diemetors  
% 
% 
% Bin_Center_in_Diemetor=[1.125 2.05 3.3 5 7.5 10.5 13.5 16.5 19.5 22.5 25.5 28.5 31.5 34.5 37.5 40.5];
% 
% Bin_Center_in_Volume = Bin_Center_in_Diemetor.^3;
% 
% %% Doing a fit between bin Center Volume and Coeffieciants 
% % 
% 
%  ft = fittype( 'poly1' ); 
% 
%  [fitresult, gof] = fit(Bin_Center_in_Volume(1:10)',pm10_Coeffients,ft);
% 
%  %RMS_lg= rms(pm10_Coeffients-Bin_Center_in_Volume(1:10))
%  
%  plot(fitresult,'r')
%  hold on 
%  plot(Bin_Center_in_Volume(1:10)',pm10_Coeffients,'ok');
%  R_Value_Training_f = sqrt(gof.rsquare)
%  RMS_lg= gof.rmse
%  
%  %% Since we have a good R value we predict the rest of the Coefficients 
% 
%  Coefficents_from_fit           = Bin_Center_in_Volume*fitresult.p1 + fitresult.p2 
% 
%  Final_Bin_Coefficients_Alpha_Sensor = [pm10_Coeffients;Coefficents_from_fit(11:16)']  
%  
%  clearvars -except Final_Bin_Coefficients_Alpha_Sensor pm1_Coeffients ... 
%  pm2_5_Coeffients pm10_Coeffients Node_Num
%   
%  Save_Name = strcat('Coefficent_Data_for_','Node_',Node_Num) 
% 
%  save(Save_Name)
%  
%  load('Final_Study_Mixed_Data_Node_11_2018_1_23_to_2018_1_29.mat')
%  clear t 
%  Save_Name = strcat('With_Coefficent_Data_','Node_',Node_Num,'_',string(year(t1)),'_',...
%     string(month(t1)),'_',string(day(t1)),'_to_',string(year(t2))...
%     ,'_',string(month(t2)),'_',string(day(t2))) 
% 
%  save(Save_Name)
%  
%  clearvars -except Node_Num t1 t2