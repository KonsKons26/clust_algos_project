function [mu, Sigma, P, gamma] = probabi(X, m, thresh, seed)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROBABI Estimates parameters of a Gaussian Mixture Model using EM
% algorithm
%
%   [mu, Sigma, P, gamma] = probabi(X, m, thresh, seed)
%
%   This function implements the Expectation-Maximization (EM) algorithm
%       to estimate the parameters of a Gaussian Mixture Model (GMM) for
%       a given dataset.
%
%   INPUTS:
%       X       - A matrix of size (N x l) where N is the number of data
%                   points and l is the dimensionality of the feature
%                   space.
%       m       - Number of Gaussian components in the mixture model.
%       thresh  - Convergence threshold for stopping criteria. The
%                   algorithm stops when the change in mean parameters
%                   between iterations is below this value.
%       seed    - Random seed for reproducibility of initial parameter
%                   estimates.
%
%   OUTPUTS:
%       mu      - A matrix of size (m x l) containing the mean vectors for
%                   each Gaussian component.
%       Sigma   - A 3D matrix of size (l x l x m) containing the covariance 
%                 matrices for each Gaussian component.
%       P       - A row vector of length m containing the mixing
%                   coefficients (prior probabilities) for each Gaussian
%                   component.
%       gamma   - A matrix of size (N x m) containing the responsibilities
%                   of each data point for each Gaussian component.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rand("seed", seed);

[N, l] = size(X);

% Initialization
mu = rand(m, l);
Sigma = repmat(eye(l), [1, 1, m]);
P = ones(1, m) / m;
gamma = zeros(N, m);

t = 0;
e = inf;

while e > thresh
    % E-step: Compute responsibilities
    for i = 1:N
        for j = 1:m
            % Compute denominator (normalizing constant)
            denominator = 0;
            for q = 1:m
                denom_part = (det(Sigma(:, :, q))^(-0.5)) * ...
                    exp(-0.5 * (X(i, :) - mu(q, :)) * ...
                    inv(Sigma(:, :, q)) * ...
                    (X(i, :) - mu(q, :))');
                denominator = denominator + (denom_part * P(q));
            end
            % Compute numerator
            nominator = (det(Sigma(:, :, j))^(-0.5)) * ...
                exp(-0.5 * (X(i, :) - mu(j, :)) * inv(Sigma(:, :, j)) * ...
                (X(i, :) - mu(j, :))') * P(j);
            % Update gamma
            gamma(i, j) = nominator / denominator;
        end
    end

    % M-step: Update parameters
    t = t + 1;
    old_mu = mu;
    for j = 1:m
        gamma_sum = sum(gamma(:, j)); % Total responsibility for componentj
        % Update mean
        mu(j, :) = sum(gamma(:, j) .* X(i, :), 1) / gamma_sum;
        % Update covariance
        Sigma(:, :, j) = zeros(l);
        for i = 1:N
            diff = (X(i, :) - mu(j, :))';
            Sigma(:, :, j) = Sigma(:, :, j) + gamma(i, j) * (diff * diff');
        end
        Sigma(:, :, j) = Sigma(:, :, j) / gamma_sum;
        % Update mixing coefficient
        P(j) = gamma_sum / N;
    end

    % Convergence check
    e = sum(sum(abs(mu - old_mu)));
    fprintf("Iteration: %d\tconvergence value (e): %d\n", t, e);
end
end
