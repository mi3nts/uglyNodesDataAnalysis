function trainingData = loadUglyNodeTraining(nodeID,dataFolder,timeUnit)

pathToFile = strcat(dataFolder,"/trainingData/uglyNodes/",nodeID,"/",nodeID,"trainingData",string(timeUnit),".mat")

load(pathToFile);

end

