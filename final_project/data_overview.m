%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script aims to analyze the general structure of the data set.
% A custom dimensionality reduction technique is employed and the resulting
% data points are visualized using PCA. All combinations of the first 6
% components are plotted against each other to give a general idea of the
% resulting data, after the custom dimensionality reduction method.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
format compact
close all

load Salinas_Data

% Size of the Salinas cube
[p, n, l] = size(Salinas_Image);

% Making a two dimensional array whose rows correspond to the pixels and
% the columns to the bands, containing only the pixels with nonzero label.
X_total = reshape(Salinas_Image, p * n, l);
L = reshape(Salinas_Labels, p * n, 1);
% This contains 1 in the positions corresponding to pixels with known
% class label
existed_L = (L > 0);
% px= no. of rows (pixels) and nx=no. of columns (bands)
X = X_total(existed_L, :);  % Extract relevant pixels
L_relevant = L(existed_L);  % Extract relevant labels


fprintf("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n" + ...
        "OVERVIEW BEFORE DIM REDUCTION\n" + ...
        "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
% PCA
components = 6;
tt = sprintf(...
    "PCA -\n" + ...
    "Combinations of the first %d components\n" + ...
    "before any preprocessing",...
    components);
explain = pca_plot(X, components, L_relevant, 2, tt);
fprintf("Variance explained by the first %d components \n",...
    components);
disp(explain(1:components));
fprintf("\nTotal variance")
disp(sum(explain(1:components)));

% Corr coef
t = "Correlation Coefficient Matrix with Absolute Values";
first = 20;
[corrcoefs1] = corr_coeff_plot(X, t);
rowSum = sum(corrcoefs1, 2);
[~, sortedIndices1] = sort(rowSum, "ascend");
fprintf("\n%d most variant pixels\n", first);
disp(sortedIndices1(1:first));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Feature space reduction
load Salinas_Data


% 204 / 6 = 34, new feature space --> 34 dimensions, 6 times smaller
% 204 / 34 = 6, new feature space --> 6 dimensions, 34 times smaller
reduction_scale = 6;
fprintf("\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n" + ...
        "OVERVIEW AFTER DIM REDUCTION by %d times\n" + ...
        "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n", ...
        reduction_scale);

[Salinas_Image, ~] = feature_space_reduction(Salinas_Image, ...
    reduction_scale);

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
L_relevant = L(existed_L);  % Extract relevant labels



% PCA
components = 6;

tt = sprintf(...
    "PCA -\n" + ...
    "Combinations of the first %d components\n" + ...
    "after reducing the feature space to %d dimensions",...
    components, l);

explain = pca_plot(X, components, L_relevant, 5, tt);
fprintf("Variance explained by the first %d components \n",...
    components);

disp(explain(1:components));
fprintf("\nTotal variance")
disp(sum(explain(1:components)));

% Corr coef
t = sprintf("Correlation Coefficient Matrix with Absolute Values\n" + ...
    "after reducing the feature space to %d dimensions", ...
    l);
first = 10;
[corrcoefs2] = corr_coeff_plot(X, t);
rowSum = sum(corrcoefs2, 2);
[~, sortedIndices2] = sort(rowSum, "ascend");
fprintf("\n%d most variant pixels\n", first);
disp(sortedIndices2(1:first));



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% More feature space reduction
load Salinas_Data

% 204 / 34 = 6, new feature space --> 6 dimensions, 34 times smaller
reduction_scale = 34;
fprintf("\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n" + ...
        "OVERVIEW AFTER DIM REDUCTION by %d times\n" + ...
        "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n", ...
        reduction_scale);
[Salinas_Image, ~] = feature_space_reduction(Salinas_Image, ...
    reduction_scale);

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
L_relevant = L(existed_L);  % Extract relevant labels

% PCA
components = 6;

tt = sprintf(...
    "PCA -\n" + ...
    "Combinations of the first %d components\n" + ...
    "after reducing the feature space to %d dimensions",...
    components, l);

explain = pca_plot(X, components, L_relevant, 7, tt);
fprintf("Variance explained by the first %d components \n",...
    components);
disp(explain(1:components));
fprintf("\nTotal variance")
disp(sum(explain(1:components)));


% Corr coef
t = sprintf("Correlation Coefficient Matrix with Absolute Values\n" + ...
    "after reducing the feature space to %d dimensions", ...
    l);
first = 6;
[corrcoefs3] = corr_coeff_plot(X, t);
rowSum = sum(corrcoefs3, 2);
[~, sortedIndices1] = sort(rowSum, "ascend");
fprintf("\n%d most variant pixels\n", first);
disp(sortedIndices2(1:first));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Even more feature space reduction
load Salinas_Data

fprintf("\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n" + ...
        "OVERVIEW AFTER KEEPING LOW CORR COEFF COLUMNS" + ...
        "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");

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
L_relevant = L(existed_L);  % Extract relevant labels

corrcoefs = corrcoef(X);
corrcoefs = abs(corrcoefs);
rowSum = sum(corrcoefs, 2);
[~, sortedIndices] = sort(rowSum, "ascend");

new_dimensions = 40;
columnIndices = sortedIndices(1:new_dimensions, :);
X = X(:, columnIndices);

% PCA
components = 6;
tt = sprintf(...
    "PCA -\n" + ...
    "Combinations of the first %d components\n" + ...
    "after keeping columns with low correlation coeffient",...
    components);
explain = pca_plot(X, components, L_relevant, 8, tt);
fprintf("Variance explained by the first %d components \n",...
    components);
disp(explain(1:components));
fprintf("\nTotal variance")
disp(sum(explain(1:components)));


% Corr coef
t = sprintf("Correlation Coefficient Matrix with Absolute Values\n" + ...
    "after keeping columns with low correlation coeffient");
first = 6;
[corrcoefs4] = corr_coeff_plot(X, t);
rowSum = sum(corrcoefs4, 2);
[~, sortedIndices4] = sort(rowSum, "ascend");
fprintf("\n%d most variant pixels\n", first);
disp(sortedIndices4(1:first));


%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Even more feature space reduction
load Salinas_Data

fprintf("\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n" + ...
        "OVERVIEW AFTER DROPPING LOW CORR COEFF COLUMNS\n" + ...
        "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");

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
L_relevant = L(existed_L);  % Extract relevant labels

% corrcoefs = corrcoef(X);
% corrcoefs = abs(corrcoefs);
% rowSum = sum(corrcoefs, 2);
% [~, sortedIndices] = sort(rowSum, "ascend");
% 
% 
% new_dimensions = 40;
% columnIndices = sortedIndices(1:new_dimensions, :);
% remaining = setdiff(1:size(X, 2), columnIndices);
% X = X(:, remaining);

corrcoefs = corrcoef(X);
corrcoefs = abs(corrcoefs);
rowSum = sum(corrcoefs, 2);
[~, sortedIndices] = sort(rowSum, "descend");

new_dimensions = 40;
columnIndices = sortedIndices(1:new_dimensions, :);
X = X(:, columnIndices);

% PCA
components = 6;
tt = sprintf(...
    "PCA -\n" + ...
    "Combinations of the first %d components\n" + ...
    "after dropping columns with low correlation coeffient",...
    components);
explain = pca_plot(X, components, L_relevant, 10, tt);
fprintf("Variance explained by the first %d components \n",...
    components);
disp(explain(1:components));
fprintf("\nTotal variance")
disp(sum(explain(1:components)));


% Corr coef
t = sprintf("Correlation Coefficient Matrix with Absolute Values\n" + ...
    "after dropping columns with low correlation coeffient");
first = 6;
[corrcoefs5] = corr_coeff_plot(X, t);
rowSum = sum(corrcoefs5, 2);
[~, sortedIndices5] = sort(rowSum, "ascend");
fprintf("\n%d most variant pixels\n", first);
disp(sortedIndices5(1:first));