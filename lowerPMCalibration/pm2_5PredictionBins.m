function prediction = pm2_5PredictionBins(mdl,trainingData)

coeffients = mdl.Coefficients.Estimate(:);
bins = trainingData(:,[1:4]);
prediction = table2array(getTableWithoutDate(timetable2table(bins)))*coeffients;

end

