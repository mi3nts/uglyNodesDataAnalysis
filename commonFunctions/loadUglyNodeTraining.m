function trainingData = loadUglyNodeTraining(nodeID,dataFolder,timeUnit,pm2_5CutOff)

    pathToFile = strcat(dataFolder,"/trainingData/uglyNodes/",nodeID,"/",nodeID,"trainingData",string(timeUnit),".mat");
    load(pathToFile);
    trainingData(trainingData.pm2_5_Spectrometor>=pm2_5CutOff,:)=[]; 
end

