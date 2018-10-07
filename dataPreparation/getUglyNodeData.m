function [uglyNodeData] = getUglyNodeData(uglyNodeDataPre)
% uglyNodeDataCopy = uglyNodeData;
% Deletions
uglyNodeDataPre(:,'opc_n2_bins') = [];% Correct on the Python Code 
uglyNodeDataPre(:,'spv1840lr5h_b_intensity') = [];
uglyNodeDataPre(uglyNodeDataPre.opc_n2_pm1 == 0,:) = [];

uglyNodeDataPre.dateTime  = datetime(uglyNodeDataPre.dateTime,'InputFormat','yyyy/MM/dd HH:mm:ss');
uglyNodeDataPre = table2timetable(uglyNodeDataPre);
uglyNodeDataPre = fillmissing(uglyNodeDataPre,'linear');

uglyNodeData = getOrderedTimeTable(uglyNodeDataPre);


uglyNodeData(uglyNodeData.opc_n2_bin0 < 0,:) = [];
uglyNodeData(uglyNodeData.opc_n2_bin1 < 0,:) = [];
uglyNodeData(uglyNodeData.opc_n2_bin2 < 0,:) = [];
uglyNodeData(uglyNodeData.opc_n2_bin3 < 0,:) = [];
uglyNodeData(uglyNodeData.opc_n2_bin4 < 0,:) = [];
uglyNodeData(uglyNodeData.opc_n2_bin5 < 0,:) = [];
uglyNodeData(uglyNodeData.opc_n2_bin6 < 0,:) = [];
uglyNodeData(uglyNodeData.opc_n2_bin7 < 0,:) = [];
uglyNodeData(uglyNodeData.opc_n2_bin8 < 0,:) = [];
uglyNodeData(uglyNodeData.opc_n2_bin9 < 0,:) = [];
uglyNodeData(uglyNodeData.opc_n2_bin10 < 0,:) = [];
uglyNodeData(uglyNodeData.opc_n2_bin11 < 0,:) = [];
uglyNodeData(uglyNodeData.opc_n2_bin12 < 0,:) = [];
uglyNodeData(uglyNodeData.opc_n2_bin13 < 0,:) = [];
uglyNodeData(uglyNodeData.opc_n2_bin14 < 0,:) = [];
uglyNodeData(uglyNodeData.opc_n2_bin15 < 0,:) = [];








end

