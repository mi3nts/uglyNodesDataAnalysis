function spectrometorData  = getSpectrometorDataRaw(fileNamePrefix,startTime,endTime)

fileName=strcat(fileNamePrefix,'_',string(year(startTime)),'_',...
         string(month(startTime)),'_',string(day(startTime)),'_to_',...
         string(year(endTime)),'_',string(month(endTime)),'_',string(day(endTime)));

loadName=strcat('../../../data/spectrometor/trainingData/',fileName);
  
load(loadName);

Spectrometor_Data .Properties.VariableNames{'Dates_S'} = 'dateTime';

spectrometorData = table2timetable(Spectrometor_Data);

end

