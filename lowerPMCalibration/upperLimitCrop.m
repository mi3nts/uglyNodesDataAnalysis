function croppedData = upperLimitCrop(inputData,parametor,upperBound)

eval(strcat("inputData(inputData.",parametor,"(:)>",string(upperBound),",:)=[];"));

 croppedData =inputData;

end

