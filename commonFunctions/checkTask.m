
function mixedData = checkTask(mixedData)
%ZEROCHECK Summary of this function goes here
%   Detailed explanation goes here
mixedData.opc_n2_bin0(mixedData.opc_n2_bin0(:)<0,:)=0;
mixedData.opc_n2_bin1(mixedData.opc_n2_bin1(:)<0,:)=0;
mixedData.opc_n2_bin2(mixedData.opc_n2_bin2(:)<0,:)=0;
mixedData.opc_n2_bin3(mixedData.opc_n2_bin3(:)<0,:)=0;
mixedData.opc_n2_bin4(mixedData.opc_n2_bin4(:)<0,:)=0;
mixedData.opc_n2_bin5(mixedData.opc_n2_bin5(:)<0,:)=0;
mixedData.opc_n2_bin6(mixedData.opc_n2_bin6(:)<0,:)=0;
mixedData.opc_n2_bin7(mixedData.opc_n2_bin7(:)<0,:)=0;
mixedData.opc_n2_bin8(mixedData.opc_n2_bin8(:)<0,:)=0;
mixedData.opc_n2_bin9(mixedData.opc_n2_bin9(:)<0,:)=0;
mixedData.opc_n2_bin10(mixedData.opc_n2_bin10(:)<0,:)=0;
mixedData.opc_n2_bin11(mixedData.opc_n2_bin11(:)<0,:)=0;
mixedData.opc_n2_bin12(mixedData.opc_n2_bin12(:)<0,:)=0;
mixedData.opc_n2_bin13(mixedData.opc_n2_bin13(:)<0,:)=0;
mixedData.opc_n2_bin14(mixedData.opc_n2_bin14(:)<0,:)=0;

mixedData.opc_n2_pm1(mixedData.opc_n2_pm1(:)<0,:)=0;
mixedData.opc_n2_pm2_5(mixedData.opc_n2_pm2_5(:)<0,:)=0;
mixedData.opc_n2_pm10(mixedData.opc_n2_pm10(:)<0,:)=0;

mixedData.opc_n2_bin0(:)=round(mixedData.opc_n2_bin0(:));
mixedData.opc_n2_bin1(:)=round(mixedData.opc_n2_bin1(:));
mixedData.opc_n2_bin2(:)=round(mixedData.opc_n2_bin2(:));
mixedData.opc_n2_bin3(:)=round(mixedData.opc_n2_bin3(:));
mixedData.opc_n2_bin4(:)=round(mixedData.opc_n2_bin4(:));
mixedData.opc_n2_bin5(:)=round(mixedData.opc_n2_bin5(:));
mixedData.opc_n2_bin6(:)=round(mixedData.opc_n2_bin6(:));
mixedData.opc_n2_bin7(:)=round(mixedData.opc_n2_bin7(:));
mixedData.opc_n2_bin8(:)=round(mixedData.opc_n2_bin8(:));
mixedData.opc_n2_bin9(:)=round(mixedData.opc_n2_bin9(:));
mixedData.opc_n2_bin10(:)=round(mixedData.opc_n2_bin10(:));
mixedData.opc_n2_bin11(:)=round(mixedData.opc_n2_bin11(:));
mixedData.opc_n2_bin12(:)=round(mixedData.opc_n2_bin12(:));
mixedData.opc_n2_bin13(:)=round(mixedData.opc_n2_bin13(:));
mixedData.opc_n2_bin14(:)=round(mixedData.opc_n2_bin14(:));
mixedData.opc_n2_bin15(:)=round(mixedData.opc_n2_bin15(:));



end

