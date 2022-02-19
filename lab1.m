% Note: to plot the equiprobabilty contour, we need eigenvalues

% gen Class A Data %
N_a = 200;
mean_a = [5 10];
covar_a = [8 0; 0 4];
class_a_data = gen_data(N_a, mean_a, covar_a);
eigenvalue_a = eig(covar_a);

% gen Class B Data %
N_b = 200;
mean_b = [10 15];
covar_b = [8 0; 0 4];
class_b_data = gen_data(N_b, mean_b, covar_b);
eigenvalue_b = eig(covar_b);

% gen Class C Data %
N_c = 100;
mean_c = [5 10];
covar_c = [8 4; 4 40];
class_c_data = gen_data(N_c, mean_c, covar_c);
eigenvalue_c = eig(covar_c);

% gen Class D Data %
N_d = 200;
mean_d = [15 10];
covar_d = [8 0; 0 8];
class_d_data = gen_data(N_d, mean_d, covar_d);
eigenvalue_d = eig(covar_d);

% gen Class E Data %
N_e = 150;
mean_e = [10 5];
covar_e = [10 -5; -5 20];
class_e_data = gen_data(N_e, mean_e, covar_e);
eigenvalue_e = eig(covar_e);

figure
scatter(class_a_data(:,1), class_a_data(:,2))
hold on
scatter(class_b_data(:,1), class_b_data(:,2))
xlabel('x');
ylabel('y');
title('Case 1')

figure
scatter(class_c_data(:,1), class_c_data(:,2))
hold on
scatter(class_d_data(:,1), class_d_data(:,2))
scatter(class_e_data(:,1), class_e_data(:,2))
xlabel('x');
ylabel('y');
title('Case 2')
