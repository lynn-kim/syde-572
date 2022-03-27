function [mean, covar] = parametric_2d(class_data)
    % Learn the Gaussian parametric model to represent a cluster of class
    % data
    mean_x = 0;
    mean_y = 0;

    % Compute the sample mean using the class data
    class_size = size(class_data, 1);
    for i = 1:class_size
        mean_x = mean_x + class_data(i, 1);
        mean_y = mean_y + class_data(i, 2);
    end
    mean_x = mean_x / class_size;
    mean_y = mean_y / class_size;
    mean = [mean_x mean_y];

    % Compute the sample covariance using the class data
    covar = [0 0; 0 0];

    for i = 1:class_size
        x = [class_data(i,1) class_data(i,2)];
        covar = covar + (x - mean)' * (x - mean);
    end
    covar = covar / class_size;
end
