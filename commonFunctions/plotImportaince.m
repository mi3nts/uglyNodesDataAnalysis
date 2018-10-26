function [ ] = plotImportaince(predictorImportaince,variableLabels,nodeID,estimator,titlePost,saveNamePre,dataFolder)

[predictorImportainceSorted importainceInd]=sort(predictorImportaince,'descend');

       

                    
    
        for i=1:length(variableLabels)
        Labels_Sorted(i) = variableLabels(importainceInd(i));
        end


inputFigure = figure(...
    'NumberTitle','off',...
    'units','normalized','outerposition',[0 0 1 1],...
    'Visible','off');

    barPlot=barh(fliplr(predictorImportainceSorted));
     
    yLabel=strcat("Variable Importaince Rank");
    ylabel(yLabel,'FontWeight','bold','FontSize',16);

    % Create xlabel
    
    xLabel=strcat("Variable Importaince");
    xlabel(xLabel,'FontWeight','bold','FontSize',18);

% Create title
    titleLabel= "Predictor Importaince "+  newline + ...
     strcat(nodeID,...
    " (",...
    estimator,...
    ") - ",titlePost);

    title(titleLabel,'FontWeight','bold','FontSize',18);
        
        

        text((predictorImportainceSorted),[length(predictorImportainceSorted):-1:1],Labels_Sorted);
        yticks([1:length(predictorImportainceSorted)]);
        yticklabels(string([length(predictorImportainceSorted):-1:1]));
        
        figureSaver(dataFolder,nodeID,strcat("predictorImportaince",saveNamePre),inputFigure);
        
        

end

