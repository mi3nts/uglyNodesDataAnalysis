function prediction = pm2_5PredictionBinsAlpha(mdl,inputFormat)

coeffients = mdl.Coefficients.Estimate(:);
bins = inputFormat(:,[1:4,18]);
prediction = table2array(getTableWithoutDate(timetable2table(bins)))*coeffients;
end

