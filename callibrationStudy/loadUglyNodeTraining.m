function trainingData = loadUglyNodeTraining(nodeID,dataFolder)


load(strcat(dataFolder,"/trainingData/uglyNodes/",nodeID,"/",nodeID,"trainingData.mat"));


end

