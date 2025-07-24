function plotPCAClusters(X, cl_label, t, K)
% plotPCAClusters - Visualize clustering results using PCA
% 
% Inputs:
%   X        - Input data matrix (rows are samples, columns are features)
%   cl_label - Cluster labels for each sample
%   title    - Title for the plot
%   K        - (Optional) Number of clusters
%
% This function applies PCA on the input data, reduces it to 2 dimensions,
% and creates a scatter plot with points colored by their cluster labels.

if nargin < 4
    K = numel(unique(cl_label)); % Infer number of clusters if not provided
end

% Apply PCA
[~, score, ~] = pca(X);

% Use the first two principal components for plotting
pca_data = score(:, 1:2);

% Create PCA scatter plot
figure;
gscatter(pca_data(:, 1), pca_data(:, 2), cl_label, lines(K), 'o');
title(t);
xlabel('Principal Component 1');
ylabel('Principal Component 2');
legend(arrayfun(@(x) sprintf('Cluster %d', x),...
    1:K,...
    'UniformOutput', false),...
    'Location', 'bestoutside');
end
