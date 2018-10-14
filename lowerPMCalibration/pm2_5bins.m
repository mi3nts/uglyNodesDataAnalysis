function pm2_5bins = pm2_5bins(trainingData)

pm2_5bins = getTableWithoutDate(timetable2table(trainingData(:,[7:10,2])));

end

