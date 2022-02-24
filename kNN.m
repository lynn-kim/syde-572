function [class] = kNN(k, point, class_data_1, class_data_2, class_data_3)

    class = 0
    length_var_1 = length(class_data_1);
    length_var_2 = length(class_data_2);
    
    distances_1 = zeros(length_var_1, 1);
    distances_2 = zeros(length_var_2, 1);
    
    % For class 1, find distance for each point
    for i=1 : length_var_1
        temp_dist = point - [class_data_1(i,1); class_data_1(i,2)];
        distances_1(i) = sqrt(temp_dist(1)^2 + temp_dist(2)^2);
    end
    
    % For class 2, find distance for each point
    for i=1 : length_var_2
        temp_dist = point - [class_data_2(i,1); class_data_2(i,2)];
        distances_2(i) = sqrt(temp_dist(1)^2 + temp_dist(2)^2);
    end
    
    % k x 2 matrix to store k min coords
    min_k_1 = zeros(k, 2);
    min_k_2 = zeros(k, 2);
    
    % find k nearest neighbour coords
    for i=1: k
        [minimum_1, index_1] = min(distances_1);
        min_k_1(i, 1) = class_data_1(index_1, 1);
        min_k_1(i, 2) = class_data_1(index_1, 2);
        distances_1(index_1) = inf;
    end

    for i=1: k
        [minimum_2, index_2] = min(distances_2);
        min_k_2(i, 1) = class_data_2(index_2, 1);
        min_k_2(i, 2) = class_data_2(index_2, 2);
        distances_2(index_2) = inf;
    end

    % calculate new means
    
    
    
    % Case 2
    % if class 3 exists
    if (exist('class_data_3', 'var'))
        length_var_3 = length(class_data_3);
        distances_3 = zeros(length_var_3, 1);
    
        for i=1 : length_var_3
            temp_dist = point - [class_data_3(i,1); class_data_3(i,2)];
            distances_3(i) = sqrt(temp_dist(1)^2 + temp_dist(2)^2);
        end
        
        min_k_3 = zeros(k, 2);

        for i=1: k
            [minimum_3, index_3] = min(distances_3);
            min_k_3(i, 1) = class_data_3(index_3, 1);
            min_k_3(i, 2) = class_data_3(index_3, 2);
            distances_3(index_3) = inf;
        end
        
        
    
    else
    end

end