function midTime = getMidTimefromTimeTable(timeTableIn)

    % GETMDTIMEFROMTIMETABLE Summary of this function goes here
    % Detailed explanation goes here
           midTime =  getMidPointTime(timeTableIn.dateTime(1), timeTableIn.dateTime(end));
end

