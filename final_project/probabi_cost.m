function cost = probabi_cost(X, mu, Sigma, P, gamma)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROBABI_COST Computes the cost function for a Gaussian Mixture Model
%
%   cost = probabi_cost(X, mu, Sigma, P, gamma)
%
%   INPUTS:
%       X       - A matrix of size (N x l), where N is the number of data
%                 points and l is the dimensionality of the feature space.
%       mu      - A matrix of size (m x l) containing the mean vectors for
%                 each Gaussian component.
%       Sigma   - A 3D matrix of size (l x l x m) containing the covariance 
%                 matrices for each Gaussian component.
%       P       - A row vector of length m containing the mixing
%                 coefficients (prior probabilities) for each Gaussian
%                 component.
%       gamma   - A matrix of size (N x m) containing the responsibilities
%                 of each data point for each Gaussian component.
%
%   OUTPUT:
%       cost    - The value of the cost function.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[N, l] = size(X);
m = size(mu, 1);

cost = 0;

for i = 1:N
    for j = 1:m
        diff = X(i, :) - mu(j, :);
        gauss_prob = (1 / ((2 * pi)^(l / 2) *...
            sqrt(det(Sigma(:, :, j))))) *...
            exp(-0.5 * diff * inv(Sigma(:, :, j)) * diff');

        if gauss_prob > 0 && P(j) > 0
            cost = cost + gamma(i, j) * log(gauss_prob * P(j));
        end
    end
end

end
