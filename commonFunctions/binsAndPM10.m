function pm10Out = binsAndPM10(CalibrationData)

pm10Out = table(...
              CalibrationData.opc_n2_bin0,...
              CalibrationData.opc_n2_bin1,...
              CalibrationData.opc_n2_bin2,...
              CalibrationData.opc_n2_bin3,...
              CalibrationData.opc_n2_bin4,...
              CalibrationData.opc_n2_bin5,...
              CalibrationData.opc_n2_bin6,...
              CalibrationData.opc_n2_bin7,...
              CalibrationData.opc_n2_bin8,...
              CalibrationData.opc_n2_bin9,...
              CalibrationData.pm10_Spectrometor...
                );
            
            
pm10Out.Properties.VariableNames = [ {'opc_n2_bin0'}, ...
                                     {'opc_n2_bin1'}, ...
                                     {'opc_n2_bin2'}, ...
                                     {'opc_n2_bin3'}, ...
                                     {'opc_n2_bin4'}, ...
                                     {'opc_n2_bin5'}, ...
                                     {'opc_n2_bin6'}, ...
                                     {'opc_n2_bin7'}, ...
                                     {'opc_n2_bin8'}, ...
                                     {'opc_n2_bin9'}, ...
                                     {'pm10_Spectrometor'} ];
end
