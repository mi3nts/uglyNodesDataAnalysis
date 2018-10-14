function pm2_5bins = pm2_5BinsAlpha(trainingData)

pm2_5bins = getTableWithoutDate(timetable2table(trainingData(:,[7:10,24,2])));

end

