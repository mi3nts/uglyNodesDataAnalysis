function [] = timePlotter(times,Data,yLabel,nodeID,estimator,titlePre,saveNamePre)


%% Individual Figure for All the Data Uncalibrated  
figureAll = figure(...
    'NumberTitle','off',...
    'units','normalized','outerposition',[0 0 1 1],...
    'Visible','off');


plotMain = plot(...
        times, ...
        Data);
    
set(plotMain,'Marker','.',...
    'LineStyle','none','Color',[0 0 1]);


yl=strcat(yLabel)
ylabel(yl,'FontWeight','bold','FontSize',20);

% Create xlabel
xlabel('Time','FontWeight','bold','FontSize',22);

% Create title
tl= string(titlePre) +  newline + ...
     strcat(nodeID,...
    " (",...
    estimator,...
    ")")

title(tl,'FontWeight','bold','FontSize',22);

Fig_name = strcat('../../../data/plots/',nodeID,'/',saveNamePre,nodeID,...
           'Time.jpg')
saveas(plotMain,char(Fig_name));

Fig_name = strcat('../../../data/plots/',nodeID,'/',saveNamePre,nodeID,...
           'Time.fig')
saveas(figureAll,char(Fig_name));
close all 
end

