

function Mdl= predictorLoader(nodeID,dataFolder,pm,typeOfPredictor)

pathToFile = strcat(dataFolder,"/predictors/",nodeID,"/",nodeID,pm,typeOfPredictor,".mat");

load(pathToFile);

end
