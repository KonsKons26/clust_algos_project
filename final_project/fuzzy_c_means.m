function [U, theta, J] = fuzzy_c_means(X, m, q, thresh, seed)
% FUNCTION

rand("seed", seed);

if q < 2
    error("<q> must be greater than 2.")
end

[N, l] = size(X);
theta = distant_init(X', m, seed);  % Initialize centroids
theta = theta';  % Transpose to make it 8 x 34
U = zeros(N, m);
e = 1;  % Initial error
iter = 0;  % Iteration counter

while e > thresh
    % Update membership matrix U
    for i = 1:N
        for j = 1:m
            denom = 0;
            for k = 1:m
                % Compute distances
                dist_ij = euclidean_distance(X(i, :), theta(j, :));
                dist_ik = euclidean_distance(X(i, :), theta(k, :));
                if dist_ij == 0 || dist_ik == 0
                    disp(['Zero distance detected: X(', num2str(i), ')']);
                end
                denom = denom + (dist_ij / dist_ik)^(1/(q-1));
            end
            U(i, j) = 1 / denom;
        end
    end

    iter = iter + 1;
    theta_old = theta;  % Save old centroids for convergence check

    % Update centroids (theta)
    for j = 1:m
        nominator = zeros(1, l);  % Initialize nominator as a 1 x 34 vector
        denominator = 0;  % Initialize denominator as scalar

        for i = 1:N
            u_ij_q = U(i, j)^q;
            nominator = nominator + u_ij_q * X(i, :);  % Weighted sum of data points
            denominator = denominator + u_ij_q;
        end

        % Check denominator for zero
        if denominator == 0
            disp(['Denominator is zero for cluster ', num2str(j), ' in iteration ', num2str(iter)]);
        end

        % Update centroid
        theta(j, :) = nominator / denominator;
    end

    % Compute error (convergence check)
    e = sum(sum(abs(theta - theta_old)));
end
% Compute cost J
J = 0;
for i = 1:N
    for j = 1:m
        dist_ij = euclidean_distance(X(i, :), theta(j, :));
        J = J + U(i, j) * dist_ij;
    end
end
end
