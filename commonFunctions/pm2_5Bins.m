function pm2_5Bins = pm2_5Bins(CalibrationData)

pm2_5Bins = table(...
              CalibrationData.opc_n2_bin0,...
              CalibrationData.opc_n2_bin1,...
              CalibrationData.opc_n2_bin2,...
              CalibrationData.opc_n2_bin3,...
              CalibrationData.pm2_5_Spectrometor...
                );
            
            
pm2_5Bins.Properties.VariableNames = [ {'opc_n2_bin0'}, ...
                                             {'opc_n2_bin1'}, ...
                                             {'opc_n2_bin2'}, ...
                                             {'opc_n2_bin3'}, ...
                                             {'pm2_5_Spectrometor'} ];
end

