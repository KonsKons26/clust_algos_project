%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script will preprocess the data and store them so the 

load Salinas_Data

% Making a two dimensional array whose rows correspond to the pixels and
% the columns to the bands, containing only the pixels with nonzero label.
[p, n, l] = size(Salinas_Image);
X_total = reshape(Salinas_Image, p * n, l);
L = reshape(Salinas_Labels, p * n, 1);
% This contains 1 in the positions corresponding to pixels with known
% class label
existed_L = (L > 0);
% px= no. of rows (pixels) and nx=no. of columns (bands)
X = X_total(existed_L, :);  % Extract relevant pixels


% Calculate the correlation to drop the bands that I deem as noise
corrcoefs = corrcoef(X);
corrcoefs = abs(corrcoefs);
rowSum = sum(corrcoefs, 2);
[~, sortedIndices] = sort(rowSum, "descend");

% Drop the bands that I deem as noise
new_dimensions = 160;
columnIndices = sortedIndices(1:new_dimensions, :);
X = X(:, columnIndices);

% Reduce the bands with the spectral binning method with mean aggregation
reduction_scale = 16;
new_bands = size(X, 2) / reduction_scale;
reduced_image = zeros(size(X, 1), new_bands);
for i = 1:new_bands
    band_start = (i - 1) * reduction_scale + 1;
    band_end = min(i * reduction_scale, size(X, 2));
    band_subset = X(:, band_start:band_end);
    reduced_image(:, i) = mean(band_subset, 2);
end
X = reduced_image;


% Plots corr coefs and PCA matrix
tt = sprintf(...
    "Correlation Coefficients -\n" + ...
    "after preprocessing,\n" + ...
    "%d new dimensions",...
    size(X, 2));
corr_coeff_plot(X, tt);
components = 6;
tt = sprintf(...
    "PCA -\n" + ...
    "Combinations of the first %d components after preprocessing,\n" + ...
    "%d new dimensions",...
    components, size(X, 2));
pca_plot(X, components, L_relevant, 2, tt);

% Save new dataset
save("preprocessed_X", "X");