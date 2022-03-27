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

% plot distributions for data set b
figure(2);
hold on;
plot(x, uniform_dist_b);
plot(x, exp_dist_b);
scatter(b, y);
hold off;


%% Non-parametric Estimation
