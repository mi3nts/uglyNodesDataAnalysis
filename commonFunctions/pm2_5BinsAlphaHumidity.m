function pm2_5bins = pm2_5BinsAlphaWeather(trainingData)

pm2_5bins = getTableWithoutDate(timetable2table(trainingData(:,[7:10,24,37,38,29,2])));

end

