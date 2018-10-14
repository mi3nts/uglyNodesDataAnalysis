function prediction = pm2_5PredictionBinsAlpha(mdl,trainingData)

coeffients = mdl.Coefficients.Estimate(:);
bins = trainingData(:,[1:4,18]);
prediction = table2array(getTableWithoutDate(timetable2table(bins)))*coeffients;

end

