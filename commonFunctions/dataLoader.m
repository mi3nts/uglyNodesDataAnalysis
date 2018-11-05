function dataOut = dataLoader(pathIn,variableName)

    filePath = strcat("../../../data/",pathIn);
    load(filePath);
    dataOut = [];
    eval(strcat("dataOut=",variableName,";"))


end

