
% Section 3 - Model Estimation (2-D Case)

load('lab2_2.mat');

x_min = min([al(:,1); bl(:,1); cl(:,1)]);
y_min = min([al(:,2); bl(:,2); cl(:,2)]);
x_max = max([al(:,1); bl(:,1); cl(:,1)]);
y_max = max([al(:,2); bl(:,2); cl(:,2)]);

x = x_min-1:1:x_max+1;
y = y_min-1:1:y_max+1;

[X, Y] = meshgrid(x, y);

% PARAMETRIC ESTIMATION

% Learn the parametric models for each class of data
[mean_a_parametric, covar_a_parametric] = parametric_2d(al);

[mean_b_parametric, covar_b_parametric] = parametric_2d(bl);

[mean_c_parametric, covar_c_parametric] = parametric_2d(cl);

% Run ML Classification using the parametric models learned above
abc_parametric = zeros(size(X,1), size(Y,2));

ab = ml_classify(mean_a_parametric, mean_b_parametric, covar_a_parametric, covar_b_parametric, X, Y);

ac = ml_classify(mean_a_parametric, mean_c_parametric, covar_a_parametric, covar_c_parametric, X, Y);

bc = ml_classify(mean_b_parametric, mean_c_parametric, covar_b_parametric, covar_c_parametric, X, Y);

% Classify Points

for i = 1:size(X, 1)
    for j = 1:size(Y, 2)
        if (ab(i,j) > 0 && bc(i,j) <= 0)
            abc_parametric(i,j) = 1;
        elseif (ab(i,j) <= 0 && ac(i,j) <= 0)
            abc_parametric(i,j) = 2;
        elseif (ac(i,j) > 0 && bc(i,j) > 0)
            abc_parametric(i,j) = 3;
        end
    end
end

figure
% Plot ML contour for classes a,b,c
contour(X,Y,abc_parametric,'green');
hold on
scatter(al(:,1), al(:,2), color='red')
scatter(bl(:,1), bl(:,2), color='blue')
scatter(cl(:,1), cl(:,2), color='yellow')
legend('ML Decision Boundary', 'Class A Data', 'Class B Data', 'Class C Data');
xlabel('x');
ylabel('y');

% NON-PARAMETRIC ESTIMATION
h = 1;
x1 = x_min-1:h:x_max+1;
y1 = y_min-1:h:y_max+1;
[X1, Y1] = meshgrid(x1, y1);
abc_non_parametric = zeros(size(X1,1), size(Y1,2));

res = [h x_min y_min x_max y_max]; % From the parzen file

% Setting up for Parzen
%%% win = window
%%% The window function in lab 2 is a Gaussian Window function, with
%%% variance of 400
window = gaussian_window(400);

[p_al, x_al, y_al] = parzen(al, res, window);
[p_bl, x_bl, y_bl] = parzen(bl, res, window);
[p_cl, x_cl, y_cl] = parzen(cl, res, window);

for i = 1:size(X1, 1) -1
    for j = 1:size(Y1, 2)-1
        val1 = p_al(i,j);
        val2 = p_bl(i,j);
        val3 = p_cl(i,j);
        [max_val, class] = max([val1 val2 val3]);
        abc_non_parametric(i,j) = class;
    end
end

figure
% Plot ML contour for classes a,b,c
contour(X1,Y1,abc_non_parametric,'green');
hold on
scatter(al(:,1), al(:,2), color='red')
scatter(bl(:,1), bl(:,2), color='blue')
scatter(cl(:,1), cl(:,2), color='yellow')
legend('ML Decision Boundary', 'Class A Data', 'Class B Data', 'Class C Data');
xlabel('x');
ylabel('y');
