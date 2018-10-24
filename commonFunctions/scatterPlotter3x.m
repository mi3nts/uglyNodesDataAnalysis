function [RValue,RMSE] = scatterPlotter3x(xData1,yData1,xLimit,yLimit,xLabel,yLabel,nodeID,estimator,titlePre,saveNamePre)

% Initially draw y=t plot

%% Individual Figure for All the Data Uncalibrated  
figureAll = figure(...
    'NumberTitle','off',...
    'units','normalized','outerposition',[0 0 1 1],...
    'Visible','off');


plot1=plot([1:xLimit],[1:yLimit])
set(plot1,'DisplayName','Y = T','LineStyle',':','Color',[0 0 0]);

hold on 

% Fit model to data.
% Set up fittype and options. 

%% We make a fit for all data

ft = fittype( 'poly1' ); 
opts = fitoptions( 'Method', 'LinearLeastSquares' ); 
opts.Lower = [0.6 -Inf];
opts.Upper = [1.4 Inf];

[fitresult, gof] = fit(...
    xData1,...
    yData1,...
    ft);

RValue = sqrt(gof.rsquare)
%% We draw for both data sets 
% RMS_All_fit_f = gof.rmse
RMSE  = rms(...
    xData1 - ...
    yData1 ...
    )

plot2 = plot(fitresult)
set(plot2,'DisplayName','Fit','LineWidth',2,'Color',[0 1 1]);

plot3 = plot(...
        xData1, ...
        yData1);
    
set(plot3,'Marker','o',...
    'LineStyle','none','Color',[0 0 1]);


yl=strcat(yLabel,'~=',string(fitresult.p1),'*',xLabel,'+',string(fitresult.p2))
ylabel(yl,'FontWeight','bold','FontSize',10);

% Create xlabel
xlabel(xLabel,'FontWeight','bold','FontSize',12);

% Create title
tl= string(titlePre) +  newline + ...
     strcat(nodeID,...
    " (",...
    estimator,...
    "), R = ",string(sqrt(gof.rsquare)),...
    " & RMSE = ",string(RMSE))

title(tl,'FontWeight','bold','FontSize',12);

% Uncomment the following line to preserve the X-limits of the axes
xlim([0 xLimit]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim([0 yLimit]);
box('on');
axis('square');
% Create legend
legend1 = legend('show');
set(legend1,'Location','northwest');


Fig_name = strcat('../../../data/plots/',nodeID,'/',saveNamePre,nodeID,...
           'Scatter.jpg')
saveas(figureAll,char(Fig_name));

Fig_name = strcat('../../../data/plots/',nodeID,'/',saveNamePre,nodeID,...
           'Scatter.fig')
saveas(figureAll,char(Fig_name));
close all 
end

