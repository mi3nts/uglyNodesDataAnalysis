function mixedData = tableMixerUglyNode(uglyNodeData)


    alphaSenseData     =   uglyNodeData(:,1:21);
    coreSenseData      =   uglyNodeData(:,22:end);
    mixedData          =   onlyKeepFirst(alphaSenseData,coreSenseData );
    
    
end