
function radiusOut = getRadiusFromBinDiametorBounds(bins)

gaps = diff(bins)/2;

radiusOut = bins(1:end-1)+gaps;
end

