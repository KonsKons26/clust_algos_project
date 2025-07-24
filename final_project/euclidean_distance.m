function d = euclidean_distance(x, y)
    % Compute the Euclidean distance between two vectors x and y
    
    % Ensure that x and y have the same size
    if length(x) ~= length(y)
        error('Vectors must have the same length.');
    end
    epsilon = 1e-6;
    % Calculate the Euclidean distance
    d = sqrt(sum((x - y).^2)) + epsilon;
end
