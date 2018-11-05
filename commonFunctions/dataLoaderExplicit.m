function dataOut = dataLoaderExplicit(nodeID,dataFolder,path,matName,varName)

%% loads a defined variable from the data folder
% 
   pathToFile = strcat(dataFolder,"/",path,"/",nodeID,"/",nodeID,matName,".mat");
   dataOut=[];
   load(pathToFile);
   eval(strcat("dataOut=",varName))

end

