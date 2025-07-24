function [corrcoefs] = corr_coeff_plot(X, t)
%CORR_COEFF_PLOT Summary of this function goes here
%   Detailed explanation goes here
corrcoefs = corrcoef(X);
corrcoefs = abs(corrcoefs);
figure;
imagesc(corrcoefs);
colormap("abyss");
colorbar;
title(t);

end