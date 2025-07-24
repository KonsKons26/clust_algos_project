function [sorted_lifespans, sorted_indices] = plot_lifespans(Z, X, K, algo)
%PLOT_LIFESPANS Summary of this function goes here
%   Detailed explanation goes here
% Find the K highest lifespans

% Number of data points
n = size(X, 1);

% Initialize cluster lifespans
lifespans = zeros(n-1, 1);

% Compute Lifespan for Each Cluster
for i = 1:n-1
    merge_distance = Z(i, 3); % Distance at which the cluster is formed
    lifespans(i) = merge_distance; % Initially set lifespan to formation distance

    % Check if the cluster is merged into a larger cluster
    for j = (i+1):(n-1)
        if ismember(i + n, Z(j, 1:2)) % If this cluster is referenced in later merges
            lifespans(i) = Z(j, 3) - merge_distance; % Update lifespan
            break;
        end
    end
end

[sorted_lifespans, sorted_indices] = sort(lifespans, 'descend'); % Sort in descending order

% Select the top K lifespans
top_lifespans = sorted_lifespans(1:K);

% Plot the top K lifespans without showing cluster indices
figure;
bar(top_lifespans, 'FaceColor', [0.2 0.6 0.8]); % Highlight with color
xlabel('Ranked Cluster');
ylabel('Lifespan');
title(sprintf(['Top %d Cluster Lifespans\n'...
    'with %s'], K, algo));

% Customize X-ticks for readability
xticks(1:K); % Set x-ticks to range from 1 to K
xticklabels(arrayfun(@(x) sprintf('Rank %d', x), 1:K, 'UniformOutput', false)); % Label as rank

end

