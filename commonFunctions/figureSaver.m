function [] = figureSaver(dataFolder,nodeID,saveNamePre,inputFigure)

Fig_name = strcat(dataFolder,'/plots/',nodeID,'/',saveNamePre,nodeID,...
           'Scatter.jpg');
createDirectory(Fig_name);
saveas(inputFigure,char(Fig_name));

Fig_name = strcat(dataFolder,'/plots/',nodeID,'/',saveNamePre,nodeID,...
           'Scatter.fig');
saveas(inputFigure,char(Fig_name));
end

