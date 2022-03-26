function class_distro = gen_data(N, mu, covariance)
    R = chol(covariance);
    class_distro = repmat(mu, N, 1) + randn(N, 2) * R;
end