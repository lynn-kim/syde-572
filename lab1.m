% Note: to plot the equiprobabilty contour, we need eigenvalues
% Current implementation for the equiprobabilty contours is currently being
% hard coded. Depending on what he's looking for, we may have to switch to
% a dynamic version. For now, it'll just be hard coded

% gen Class A Data %
N_a = 200;
mean_a = [5 10];
covar_a = [8 0; 0 4];
class_a_data = gen_data(N_a, mean_a, covar_a);
eigenvalue_a = eig(covar_a);
[V_a, D_a] = eig(covar_a); 
% The columns of V are the eigenvectors 
% The diagonal of D contains the eigenvalues
% The columns of V are the eigenvectrs associated with each column in D
% (eigenvalue)

% gen Class B Data %
N_b = 200;
mean_b = [10 15];
covar_b = [8 0; 0 4];
class_b_data = gen_data(N_b, mean_b, covar_b);
eigenvalue_b = eig(covar_b);
[V_b, D_b] = eig(covar_b);

% gen Class C Data %
N_c = 100;
mean_c = [5 10];
covar_c = [8 4; 4 40];
class_c_data = gen_data(N_c, mean_c, covar_c);
eigenvalue_c = eig(covar_c);
[V_c, D_c] = eig(covar_c);

% gen Class D Data %
N_d = 200;
mean_d = [15 10];
covar_d = [8 0; 0 8];
class_d_data = gen_data(N_d, mean_d, covar_d);
eigenvalue_d = eig(covar_d);
[V_d, D_d] = eig(covar_d);

% gen Class E Data %
N_e = 150;
mean_e = [10 5];
covar_e = [10 -5; -5 20];
class_e_data = gen_data(N_e, mean_e, covar_e);
eigenvalue_e = eig(covar_e);
[V_e, D_e] = eig(covar_e);

% How each value for the ellipse is calcualted:
% function plot_ellipse(x,y,theta,a,b,color)
% x: the x point of the mean
% y: the y point of the mean
% theta: the angle between the major axis and the horizontal axis. 
%         Look at D_x to find the larger , and note the column that its in
%         then look at V_x and locate the same column value
%         take the arctan of V_x(2,2) / V_x(2,1) (because arctan(y/x) gives 
%         you the angle between the two points, and set that as theta
% a: the major axis length, which is the square root of the larger eigenvalue
% b: the minor axis length, which is the square root of the smaller eigenvalue
% color: i just chose black


% 2D grid:

x1 = [-5:0.1:25];
x2 = [-5:0.1:25];
[X,Y] = meshgrid(x1, x2);

% Compute MED decision boundaries

% MED Case 1
AB_MED = med_classifier(X, Y, mean_a, mean_b);
MED1 = zeros(size(X, 1), size(Y, 2));

% Classify points
for i=1:size(X,1)
    for j=1:size(Y,2)
        if AB_MED(i,j) >= 0 
            MED1(i,j) = 1;
        elseif AB_MED(i,j) <=0 
            MED1(i,j) = 2; 
        end
    end
end

% MED Case 2
CD_MED = med_classifier(X, Y, mean_c, mean_d);
EC_MED = med_classifier(X, Y, mean_e, mean_c);
DE_MED = med_classifier(X, Y, mean_d, mean_e);

% Classify points
MED2 = zeros(size(X, 1), size(Y, 2));
for i=1:size(X, 1)
    for j=1:size(Y, 2)
        if CD_MED(i,j) >= 0 && DE_MED(i,j) <= 0
            MED2(i,j) = 2;
        elseif CD_MED(i,j) <= 0 && EC_MED(i,j) >= 0
            MED2(i,j) = 1;
        elseif DE_MED(i,j) >= 0 && EC_MED(i,j) <= 0
            MED2(i,j) = 3;
        end
    end
end

AB_GED = zeros(size(X,1), size(Y,1));
CDE_GED = zeros(size(X,1), size(Y,1));

for i=1:length(x1)
    for j=1:length(x2)
        x = [x1(i); x2(j)];
        AB_GED(i,j) = ged_classifier(x, mean_a', covar_a, mean_b', covar_b);
        CDE_GED(i,j) = ged_classifier(x, mean_c', covar_c, mean_d', covar_d,mean_e', covar_e);
    end
end


% Run MAP Classification
AB_MAP = map_classifier(mean_a, mean_b, covar_a, covar_b, N_a, N_b, X, Y);
CDE_MAP = zeros(size(X,1), size(Y,1));
CD_classified = map_classifier(mean_c, mean_d, covar_c, covar_d, N_c, N_d, X, Y);
CE_classified = map_classifier(mean_c, mean_e, covar_c, covar_e, N_c, N_e, X, Y);
DE_classified = map_classifier(mean_d, mean_e, covar_d, covar_e, N_d, N_e, X, Y);

for i = 1:size(X, 1)
    for j = 1:size(Y, 2)
        if (CD_classified(i,j) > 0 && DE_classified(i,j) <= 0)
            CDE_MAP(i,j) = 1;
        elseif (CD_classified(i,j) <= 0 && CE_classified(i,j) <= 0)
            CDE_MAP(i,j) = 2;
        elseif (CE_classified(i,j) > 0 && DE_classified(i,j) > 0)
            CDE_MAP(i,j) = 3;
        end
    end
end



figure
% Plot MED contour for class A/B
contour(X,Y,MED1,'red');
hold on

% Plot GED contour for class A/B
contour(Y,X,AB_GED,'blue','LineWidth',2);
hold on

% Plot MAP contour for class A/B
contour(X,Y,AB_MAP,'green');
hold on

scatter(class_a_data(:,1), class_a_data(:,2))
hold on
scatter(class_b_data(:,1), class_b_data(:,2))
plot_ellipse(mean_a(1), mean_a(2), 0, sqrt(covar_a(1,1)), sqrt(covar_a(2,2)), 'black')
plot_ellipse(mean_b(1), mean_b(2), 0, sqrt(covar_b(1,1)), sqrt(covar_b(2,2)), 'black')
xlabel('x');
ylabel('y');
title('Classification for Class A/B');
legend('MED Decision Boundary', 'MICD Decision Boundary','MAP Decision Boundary', 'Class A','Class B');



figure
% Plot MED contour for class C/D/E
contour(X,Y,MED2, "red");
hold on

% Plot GED contour for class C/D/E
contour(Y,X, CDE_GED, "blue");
hold on

% Plot MAP contour for class C/D/E
contour(X, Y, CDE_MAP, "green");
hold on

scatter(class_c_data(:,1), class_c_data(:,2))
hold on
scatter(class_d_data(:,1), class_d_data(:,2))
scatter(class_e_data(:,1), class_e_data(:,2))
plot_ellipse(mean_c(1), mean_c(2), atan(V_c(2,2) / V_c(1,2)), sqrt(covar_c(2,2)), sqrt(covar_c(1,1)), 'black')
plot_ellipse(mean_d(1), mean_d(2), 0, sqrt(covar_d(1,1)), sqrt(covar_d(2,2)), 'black')
plot_ellipse(mean_e(1), mean_e(2), atan(V_e(2,2) / V_e(1,2)), sqrt(covar_e(2,2)), sqrt(covar_e(1,1)), 'black')
xlabel('x');
ylabel('y');
title('Classification for Class C/D/E');
legend('MED Decision Boundary', 'MICD Decision Boundary','MAP Decision Boundary', 'Class C','Class D', 'Class E');



[XNN,YNN] = meshgrid(x1, x2);
AB_NN = zeros(size(XNN,1), size(YNN,1));
CDE_NN = zeros(size(XNN,1), size(YNN,1));

for i=1:length(x1)
    for j=1:length(x2)
        point = [x1(i); x2(j)];
        AB_NN(i,j) = NN(point, class_a_data, class_b_data);
        CDE_NN(i,j) = NN(point, class_c_data, class_d_data, class_e_data);
    end
end

figure
imagesc(x1,x2,AB_NN')
hold on
contour(XNN, YNN, AB_NN');
hold on
scatter(class_a_data(:,1), class_a_data(:,2), 'filled')
hold on
scatter(class_b_data(:,1), class_b_data(:,2), 'filled')
plot_ellipse(mean_a(1), mean_a(2), 0, sqrt(covar_a(1,1)), sqrt(covar_a(2,2)), 'black')
plot_ellipse(mean_b(1), mean_b(2), 0, sqrt(covar_b(1,1)), sqrt(covar_b(2,2)), 'black')
xlabel('x');
ylabel('y');
title('NN Classification Case 1');
legend('Decision Boundaries', 'Class A','Class B');
set(gca, 'YDir', 'normal')

figure
imagesc(x1,x2,CDE_NN')
hold on
contour(XNN, YNN, CDE_NN');
hold on
scatter(class_c_data(:,1), class_c_data(:,2), 'filled')
hold on
scatter(class_d_data(:,1), class_d_data(:,2), 'filled')
scatter(class_e_data(:,1), class_e_data(:,2), 'filled')

plot_ellipse(mean_c(1), mean_c(2), atan(V_c(2,2) / V_c(1,2)), sqrt(covar_c(2,2)), sqrt(covar_c(1,1)), 'black')
plot_ellipse(mean_d(1), mean_d(2), 0, sqrt(covar_d(1,1)), sqrt(covar_d(2,2)), 'black')
plot_ellipse(mean_e(1), mean_e(2), atan(V_e(2,2) / V_e(1,2)), sqrt(covar_e(2,2)), sqrt(covar_e(1,1)), 'black')
xlabel('x');
ylabel('y');
title('NN Classification Case 2');
legend('Decision Boundaries', 'Class C','Class D', 'Class E');
set(gca, 'YDir', 'normal')

[XKNN,YKNN] = meshgrid(x1, x2);
AB_KNN = zeros(size(XKNN,1), size(YKNN,1));
CDE_KNN = zeros(size(XKNN,1), size(YKNN,1));

k = 5;
for i=1:length(x1)
    for j=1:length(x2)
        point = [x1(i); x2(j)];
        AB_KNN(i,j) = kNN(k, point, class_a_data, class_b_data);
        CDE_KNN(i,j) = kNN(k, point, class_c_data, class_d_data, class_e_data);
    end
end

figure
imagesc(x1,x2,AB_KNN')
hold on
contour(XKNN, YKNN, AB_KNN');
hold on
scatter(class_a_data(:,1), class_a_data(:,2), 'filled')
hold on
scatter(class_b_data(:,1), class_b_data(:,2), 'filled')
plot_ellipse(mean_a(1), mean_a(2), 0, sqrt(covar_a(1,1)), sqrt(covar_a(2,2)), 'black')
plot_ellipse(mean_b(1), mean_b(2), 0, sqrt(covar_b(1,1)), sqrt(covar_b(2,2)), 'black')
xlabel('x');
ylabel('y');
title('kNN Classification Case 1');
legend('Decision Boundaries', 'Class A','Class B');
set(gca, 'YDir', 'normal')

figure
imagesc(x1,x2,CDE_KNN')
hold on
contour(XKNN, YKNN, CDE_KNN');
hold on
scatter(class_c_data(:,1), class_c_data(:,2), 'filled')
hold on
scatter(class_d_data(:,1), class_d_data(:,2), 'filled')
scatter(class_e_data(:,1), class_e_data(:,2), 'filled')
plot_ellipse(mean_c(1), mean_c(2), atan(V_c(2,2) / V_c(1,2)), sqrt(covar_c(2,2)), sqrt(covar_c(1,1)), 'black')
plot_ellipse(mean_d(1), mean_d(2), 0, sqrt(covar_d(1,1)), sqrt(covar_d(2,2)), 'black')
plot_ellipse(mean_e(1), mean_e(2), atan(V_e(2,2) / V_e(1,2)), sqrt(covar_e(2,2)), sqrt(covar_e(1,1)), 'black')
xlabel('x');
ylabel('y');
title('kNN Classification Case 2');
legend('Decision Boundaries', 'Class C','Class D', 'Class E');
set(gca, 'YDir', 'normal')