function output = ml_classify(mean_a, mean_b, covar_a, covar_b, X, Y)
    % Initialize an output grid to store classification results
    output = zeros(size(X, 1), size(Y, 2));

    % Pre-compute the inverses of the covariance matrices to save
    % on recompution
    inv_a = inv(covar_a);
    inv_b = inv(covar_b);

    % Compute each of the coefficients of the ML classifier decision boundary
    Q_0 = inv_a - inv_b;
    Q_1 = 2 * (mean_b * inv_b - mean_a * inv_a);
    Q_2 = mean_a * inv_a * mean_a' - mean_b * inv_b * mean_b';


    % Classify each point in the grid according to the MAP classifier
    % decision boundary
    for i = 1:size(X, 1)
        for j = 1:size(Y, 2)
            point = [X(i,j) Y(i,j)];
            output(i, j) = point * Q_0 * point' + Q_1 * point' + Q_2;
        end
    end

     % Simplify the output classified array into the 2 separate classes by
     % setting all values > 1 (belonging to class A) to 1,
     % and all other values (belonging to class B) to 0 
    output = output > 0;
