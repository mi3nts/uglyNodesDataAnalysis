function spectrometorData  = getSpectrometorDataRaw(fileName,startTime,endTime)

loadName=strcat('../../../data/spectrometor/',fileName);
  
load(loadName);

Spectrometor_Data .Properties.VariableNames{'Dates_S'} = 'dateTime';

spectrometorData = table2timetable(Spectrometor_Data);

% dt = seconds(10);
% TT2 = retime(spectrometorTT,'regular','linear','TimeStep',dt,'Constant',-1);

% newTimes           = spectrometorTT.dateTime;
% newTimes.Second    = roundn(newTimes.Second, 1);




% figure
% plot(spectrometorData.dateTime,spectrometorData.pm1_Spectrometor,'r.')
% hold on 
% plot(spectrometorTT.dateTime,spectrometorTT.pm1_Spectrometor,'.b')
% 
% 
% figure
% 
% plot(spectrometorData.dateTime,spectrometorData.pm2_5_Spectrometor,'r.')
% hold on 
% plot(spectrometorTT.dateTime,spectrometorTT.pm2_5_Spectrometor,'.b')
% 
% 
% figure
% plot(spectrometorData.dateTime,spectrometorData.pm10_Spectrometor,'r.')
% hold on 
% plot(spectrometorTT.dateTime,spectrometorTT.pm10_Spectrometor,'.b')


% spectrometorData   = retime(spectrometorTT,unique(newTimes),'linear');

end

