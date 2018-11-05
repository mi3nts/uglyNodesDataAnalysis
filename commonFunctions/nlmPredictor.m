function prediction = nlmPredictor(mdl,inputFormat,radiusOut)

coeffients = mdl.Coefficients.Estimate(:);

prediction =table2array(inputFormat)*(coeffients.*(radiusOut.^3)');

end
