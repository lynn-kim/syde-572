% This file is not called directly from lab2.m, but it is to show the steps
% to create the non_parametric 2D model estimation. All functionality in
% lab2.m is repeated here

clear;
load('lab2_2.mat');

x_min = min([al(:,1); bl(:,1); cl(:,1)]);
y_min = min([al(:,2); bl(:,2); cl(:,2)]);
x_max = max([al(:,1); bl(:,1); cl(:,1)]);
y_max = max([al(:,2); bl(:,2); cl(:,2)]);

resolution = 1;
x1 = x_min-1:resolution:x_max+1;
y1 = y_min-1:resolution:y_max+1;
[X1, Y1] = meshgrid(x1, y1);
abc_non_parametric = zeros(size(X1,1), size(Y1,2));

res = [resolution x_min y_min x_max y_max]; % From the parzen file

% Setting up for Parzen
%%% win = window
%%% The window function in lab 2 is a Gaussian Window function, with
%%% variance of 400
window = gaussian_window(400, resolution);

[p_al, x_al, y_al] = parzen(al, res, window);
[p_bl, x_bl, y_bl] = parzen(bl, res, window);
[p_cl, x_cl, y_cl] = parzen(cl, res, window);

for i = 1:size(p_al, 1)
    for j = 1:size(p_al, 2)
        val1 = p_al(i,j);
        val2 = p_bl(i,j);
        val3 = p_cl(i,j);
        [max_val, class] = max([val1 val2 val3]);
        abc_non_parametric(i,j) = class;
    end
end


figure(2)
% Plot ML contour for classes a,b,c
contour(X1,Y1,abc_non_parametric,'green');
hold on
scatter(al(:,1), al(:,2), color='red')
scatter(bl(:,1), bl(:,2), color='blue')
scatter(cl(:,1), cl(:,2), color='yellow')
xlabel('x');
ylabel('y');
legend('ML Decision Boundary', 'Class A Data', 'Class B Data', 'Class C Data');
title("2D Non-Parametric Maximum Likelihood Boundary");

