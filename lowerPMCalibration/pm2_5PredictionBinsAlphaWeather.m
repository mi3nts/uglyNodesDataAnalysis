function prediction = pm2_5PredictionBinsAlphaWeather(mdl,trainingData)

coeffients = mdl.Coefficients.Estimate(:);
bins = trainingData(:,[1:4,18,31,32,23]);
prediction = table2array(getTableWithoutDate(timetable2table(bins)))*coeffients;

end

