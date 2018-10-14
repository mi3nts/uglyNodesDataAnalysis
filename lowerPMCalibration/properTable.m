function alphaAndCoreData    = properTable(uglyNodeData)
% mixedDataPre = outerjoin(spectrometorData,uglyNodeData);
    alphaSenseData     =   uglyNodeData(:,1:21);
    coreSenseData      =   uglyNodeData(:,22:end);
    alphaAndCoreData   =   onlyKeepFirst(alphaSenseData,coreSenseData );
    alphaAndCoreData   =  timeNearest(alphaAndCoreData,10);
                    
    if(height(alphaAndCoreData)~=height(unique(alphaAndCoreData)))

        alphaAndCoreData   =  getUniqueTable(alphaAndCoreData);

    end

end

