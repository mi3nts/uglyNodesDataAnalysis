function mixedData = tableMixerNow(spectrometorData,uglyNodeData,period)
% mixedDataPre = outerjoin(spectrometorData,uglyNodeData);
tic
    alphaSenseData     =   uglyNodeData(:,1:21);
    coreSenseData      =   uglyNodeData(:,22:end);


    %     alphaAndCoreData   =   onlyKeepFirst(alphaSenseData,coreSenseData );
%     alphaAndCoreData   =  timeNearest(alphaAndCoreData,period);
   lk =  "Nearest Check"
    spectrometorData   =  timeNearest(spectrometorData,period);
    alphaSenseData     =  timeNearest(alphaSenseData,period);
    coreSenseData2      =  timeNearest(coreSenseData ,period);
    %% Getting Unique Datetimes 

    lk =  "Getting Unique Table - Spectrometor"
    spectrometorData   =  getUniqueTable(spectrometorData);
    
    lk =  "Getting Unique Table - Alpha Sensor"
    alphaSenseData     =  getUniqueTable(alphaSenseData);
     lk =  "Getting Unique Table - Core Sensor"
    coreSenseData      =  getUniqueTable(coreSenseData2 );          
    
     lk =  "Inner Join Alpha and Core"   
alphaAndCoreData   =   innerjoin(alphaSenseData ,coreSenseData);
     lk =  "Inner Join Spectrometor"   
mixedData          =   innerjoin(alphaAndCoreData,spectrometorData);


% spectrometorData 


end

