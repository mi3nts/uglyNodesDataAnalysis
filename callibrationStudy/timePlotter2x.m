function [] = timePlotter2x(times,Data1,Data2,yLabel,displayName1,displayName2,nodeID,estimator,titlePre,saveNamePre)

%% Individual Figure for All the Data Uncalibrated  
figureAll = figure(...
    'NumberTitle','off',...
    'units','normalized','outerposition',[0 0 1 1],...
    'Visible','off');



plot1= plot(...
        times, ...
        Data1);
    
set(plot1,'Marker','.',...
    'LineStyle','none',...
'DisplayName',displayName1,...    
 'Color',[0 0 1]);

hold on 
plot2= plot(...
        times, ...
        Data2);
    
set(plot2,'Marker','.',...
    'DisplayName',displayName2,...    
    'LineStyle','none','Color',[0 1 0]);


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



% Create legend
legend1 = legend('show');
set(legend1,'Location','northwest');

title(tl,'FontWeight','bold','FontSize',22);

Fig_name = strcat('../../../data/plots/',nodeID,'/',saveNamePre,nodeID,...
           'Time2x.jpg')
saveas(figureAll,char(Fig_name));

Fig_name = strcat('../../../data/plots/',nodeID,'/',saveNamePre,nodeID,...
           'Time2x.fig')
saveas(figureAll,char(Fig_name));
close all 
end

