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
hold on;
plot(x, uniform_dist_a);
plot(x, normal_dist_a);
scatter(a, y);
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
hold on;
plot(x, uniform_dist_b);
plot(x, exp_dist_b);
scatter(b, y);
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
hold on;
plot(x, non_param_a_1);
plot(x, normal_dist_a);
scatter(a, y);
hold off;

figure(4);
hold on;
plot(x, non_param_a_2);
plot(x, normal_dist_a);
scatter(a, y);
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
plot(x, non_param_b_1);
plot(x, exp_dist_b);
scatter(b, y);
hold off;

figure(6);
hold on;
plot(x, non_param_b_2);
plot(x, exp_dist_b);
scatter(b, y);
hold off;


