% A helper function for use in error analysis
% Computes the class for a given sample point x using the MAP classifier

function class = classify_point_map(mean_a, mean_b, covar_a, covar_b, N_a, N_b, x)
    P_a = (N_a) / (N_a + N_b);
    P_b = (N_b) / (N_a + N_b);

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

    class = x * Q_0 * x' + Q_1 * x' + Q_2 + 2 * Q_3 + Q_4;
    class = class > 0;

