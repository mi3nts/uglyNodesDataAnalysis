function mixedData = tableMixer(spectrometorData,uglyNodeData,period)
% mixedDataPre = outerjoin(spectrometorData,uglyNodeData);
    alphaSenseData     =   uglyNodeData(:,1:21);
    coreSenseData      =   uglyNodeData(:,22:end);
    alphaAndCoreData   =   onlyKeepFirst(alphaSenseData,coreSenseData );
    alphaAndCoreData   =  timeNearest(alphaAndCoreData,period);
    spectrometorData   =  timeNearest(spectrometorData,period);

    %% Getting Unique Datetimes 

    spectrometorData  = getUniqueTable(spectrometorData);
                    
    if(height(alphaAndCoreData)~=height(unique(alphaAndCoreData)))

        alphaAndCoreData   =  getUniqueTable(alphaAndCoreData);

    end


mixedData          =   innerjoin(alphaAndCoreData,spectrometorData);
% spectrometorData 


end

