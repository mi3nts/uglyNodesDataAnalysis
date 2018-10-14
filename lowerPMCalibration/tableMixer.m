function mixedData = tableMixer(spectrometorData,uglyNodeData)
% mixedDataPre = outerjoin(spectrometorData,uglyNodeData);
    alphaSenseData     =   uglyNodeData(:,1:21);
    coreSenseData      =   uglyNodeData(:,22:end);
    alphaAndCoreData   =   onlyKeepFirst(alphaSenseData,coreSenseData );
    alphaAndCoreData   =  timeNearest(alphaAndCoreData,10);
    spectrometorData   =  timeNearest(spectrometorData,10);

    %% Getting Unique Datetimes 

    spectrometorData  = getUniqueTable(spectrometorData);
                    
    if(height(alphaAndCoreData)~=height(unique(alphaAndCoreData)))

        alphaAndCoreData   =  getUniqueTable(alphaAndCoreData);

    end


mixedData          =   innerjoin(spectrometorData,alphaAndCoreData);
% spectrometorData 


end

