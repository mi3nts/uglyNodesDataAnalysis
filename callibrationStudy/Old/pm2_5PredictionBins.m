function prediction = pm2_5PredictionBins(mdl,inputFormat)

coeffients = mdl.Coefficients.Estimate(:);
bins = inputFormat(:,[1:4]);
prediction = table2array(getTableWithoutDate(timetable2table(bins)))*coeffients;

end

