function output = map_classifier(mean_a, mean_b, covar_a, covar_b, N_a, N_b, X, Y)
    % Compute the priors using the number of samples avaiable for each
    % class
    P_a = (N_a) / (N_a + N_b);
    P_b = (N_b) / (N_a + N_b);

    % Initialize an output grid to store classification results
    output = zeros(size(X, 1), size(Y, 2));

    % Pre-compute the inverses of the covariance matrices to save
    % on recompution
    inv_a = inv(covar_a);
    inv_b = inv(covar_b);

    % Compute each of the coefficients of the MAP classifier decision boundary
    Q_0 = inv_a - inv_b;
    Q_1 = 2 * (mean_b * inv_b - mean_a * inv_a);
    Q_2 = mean_a * inv_a * mean_a' - mean_b * inv_b * mean_b';
    Q_3 = log(P_b / P_a);
    Q_4 = log( det(covar_a) / det(covar_b) );

    % Classify each point in the grid according to the MAP classifier
    % decision boundary
    for i = 1:size(X, 1)
        for j = 1:size(Y, 2)
            point = [X(i,j) Y(i,j)];
            output(i, j) = point * Q_0 * point' + Q_1 * point' + Q_2 + 2 * Q_3 + Q_4;
        end
    end

     % Simplify the output classified array into the 2 separate classes by
     % setting all values > 1 (belonging to class A) to 1,
     % and all other values (belonging to class B) to 0 
    output = output > 0;
