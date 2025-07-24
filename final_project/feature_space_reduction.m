function [X, new_bands] = feature_space_reduction(X, reduction_scale)
%FEATURE_SPACE_REDUCTION

[p, n, l] = size(X);
new_bands = l / reduction_scale;
reduced_image = zeros(p, n, new_bands);
% Get the mean for every 'new_bands', they will be the new features
for i = 1:new_bands
    band_start = (i - 1) * reduction_scale + 1;
    band_end = min(i * reduction_scale, l);

    bands_subset = X(:, :, band_start:band_end);

    reduced_image(:, :, i) = mean(bands_subset, 3);
end
X = reduced_image;
end