%% Model Estimation 1D Case
load('lab2_1.mat');

mu_a = 5;
std_dev_a = 1;
lambda_b = 1;

%% Uniform
% Data set a
a_lower_bound = min(a);
a_upper_bound = max(a);
x = 0:0.01:max(a(1,:))+2;

% uniform distribution
uniform_dist_a = unifpdf(x, a_lower_bound, a_upper_bound);

% true distribution
normal_dist_a = normpdf(x, mu_a, std_dev_a);

% data points
y = zeros(size(a));

% plot distributions for data set a
figure(1);
title("1D Parametric Estimation Uniform - Dataset A")
hold on;
plot(x, uniform_dist_a);
plot(x, normal_dist_a);
scatter(a, y);
legend("Estimation", "Dataset A")
xlabel("x")
ylabel("P(x)")
saveas(gcf, "figures/1D_uniform_A.png")
hold off;

% Data set b
b_lower_bound = min(b);
b_upper_bound = max(b);
x = 0:0.01:max(b(1,:))+2;

% uniform distribution
uniform_dist_b = unifpdf(x, b_lower_bound, b_upper_bound);

% true distribution
exp_dist_b = exppdf(x, 1/lambda_b);

% data points
y = zeros(size(b));

% plot distributions for data set b
figure(2);
title("1D Parametric Estimation Uniform - Dataset B")
hold on;
plot(x, uniform_dist_b);
plot(x, exp_dist_b);
scatter(b, y);
legend("Estimation", "Dataset B")
xlabel("x")
ylabel("P(x)")
saveas(gcf, "figures/1D_uniform_B.png")
hold off;

%% Non-parametric Estimation
% Data set a
N = length(a);
x = 0:0.01:max(a(1,:))+2;

% non-parametric density using Parzen method
non_param_a_1 = parzen_1D(N, 0.1, a, x);
non_param_a_2 = parzen_1D(N, 0.4, a, x);

% data points
y = zeros(size(a));

% plot density functions for each standard deviation (0.1 and 0.4)
figure(3);
title("1D Non-Parametric Estimation - Dataset A STD 0.1")
hold on;
plot(x, non_param_a_1);
plot(x, normal_dist_a);
scatter(a, y);
legend("Estimation", "Dataset A")
xlabel("x")
ylabel("P(x)")
saveas(gcf, "figures/1D_non_parametric_0_1_A.png")
hold off;

figure(4);
title("1D Non-Parametric Estimation - Dataset A STD 0.4")
hold on;
plot(x, non_param_a_2);
plot(x, normal_dist_a);
scatter(a, y);
legend("Estimation", "Dataset A")
xlabel("x")
ylabel("P(x)")
saveas(gcf, "figures/1D_non_parametric_0_4_A.png")
hold off;


% Data set b
N = length(b);
x = 0:0.01:max(b(1,:))+2;

% non-parametric density using Parzen method
non_param_b_1 = parzen_1D(N, 0.1, b, x);
non_param_b_2 = parzen_1D(N, 0.4, b, x);

% data points
y = zeros(size(b));

% plot density functions for each standard deviation (0.1 and 0.4)
figure(5);
hold on;
title("1D Non-Parametric Estimation - Dataset B STD 0.1")
plot(x, non_param_b_1);
plot(x, exp_dist_b);
scatter(b, y);
legend("Estimation", "Dataset B")
xlabel("x")
ylabel("P(x)")
saveas(gcf, "figures/1D_non_parametric_0_1_B.png")
hold off;

figure(6);
hold on;
title("1D Non-Parametric Estimation - Dataset B STD 0.4")
plot(x, non_param_b_2);
plot(x, exp_dist_b);
scatter(b, y);
legend("Estimation", "Dataset B")
xlabel("x")
ylabel("P(x)")
saveas(gcf, "figures/1D_non_parametric_0_4_B.png")
hold off;

%% Gaussian & Exponential
% Dataset a

mu_a_hat = mean(a);
var_a_hat = var(a);

x = 0:0.01:max(a(1,:))+2;

% data points
y = zeros(size(a));

% gaussian distribution 
gaussian_dist_a = normpdf(x, mu_a_hat, sqrt(var_a_hat));

% exponential distribution
exponential_dist_a = exppdf(x, mu_a_hat);


% plot gaussian
figure(7);
title("1D Parametric Estimation Gaussian - Dataset A")
hold on;
plot(x, gaussian_dist_a);
plot(x, normal_dist_a);
scatter(a, y);
legend("Estimation", "Dataset A")
xlabel("x")
ylabel("P(x)")
saveas(gcf, "figures/1D_gaussian_A.png")
hold off;

% plot exponential
figure(8);
title("1D Parametric Estimation Exponential - Dataset A")
hold on;
plot(x, exponential_dist_a);
plot(x, normal_dist_a);
scatter(a, y);
legend("Estimation", "Dataset A")
xlabel("x")
ylabel("P(x)")
saveas(gcf, "figures/1D_exponential_A.png")
hold off;


% Dataset b

mu_b_hat = mean(b);
var_b_hat = var(b);

x = 0:0.01:max(b(1,:))+2;

% data points
y = zeros(size(b));


% gaussian distribution
gaussian_dist_b = normpdf(x, mu_b_hat, sqrt(var_b_hat));

% exponential distribution
exponential_dist_b = exppdf(x, mu_b_hat);


% plot gaussian
figure(9);
title("1D Parametric Estimation Gaussian - Dataset B")
hold on;
plot(x, gaussian_dist_b);
plot(x, exp_dist_b);
scatter(b, y);
legend("Estimation", "Dataset B")
xlabel("x")
ylabel("P(x)")
saveas(gcf, "figures/1D_gaussian_B.png")
hold off;


% plot exponential
figure(10);
hold on;
title("1D Parametric Estimation Exponential - Dataset B")
plot(x, exponential_dist_b);
plot(x, exp_dist_b);
legend("Estimation", "Dataset B")
scatter(b, y);
xlabel("x")
ylabel("P(x)")
saveas(gcf, "figures/1D_exponential_B.png")
hold off;


