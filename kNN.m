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
    [min_k_1, distances_1] = knn_coords(k, class_data_1, distances_1, min_k_1);
    [min_k_2, distances_2] = knn_coords(k, class_data_2, distances_2, min_k_2);

    % calculate new means and distance
    mean_1 = [0;0];
    mean_2 = [0;0];
    mean_dist_1 = knn_mean_dist(k, point, mean_1, min_k_1);
    mean_dist_2 = knn_mean_dist(k, point, mean_2, min_k_2);
    
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
        [min_k_3, distances_3] = knn_coords(k, class_data_3, distances_3, min_k_3);
        mean_3 = [0;0];
        mean_dist_3 = knn_mean_dist(k, point, mean_3, min_k_3);
        
        min_distances = [min(mean_dist_1), min(mean_dist_2), min(mean_dist_3)];
        if((min(min_distances) == min(mean_dist_1)) && (min(mean_dist_1) == min(mean_dist_2)))
            class = 0;
        elseif((min(min_distances) == min(mean_dist_1)) && (min(mean_dist_1) == min(mean_dist_3)))
            class = 0;
        elseif((min(min_distances) == min(mean_dist_2)) && (min(mean_dist_2) == min(mean_dist_3)))
            class = 0;
        elseif((min(mean_dist_1) == min(mean_dist_2)) && (min(mean_dist_2) == min(mean_dist_3)))
            class = 0;
        elseif min(min_distances) == min(mean_dist_1)
            class = 1;
        elseif min(min_distances) == min(mean_dist_2)
            class = 2;
        elseif min(min_distances) == min(mean_dist_3)
            class = 3;
        end
    
    else
        min_distances = [min(mean_dist_1), min(mean_dist_2)];
        if min(mean_dist_1) == min(distances_2)
            class = 0;
        elseif min(min_distances) == min(mean_dist_1)
            class = 1;
        elseif min(min_distances) == min(mean_dist_2)
            class = 2;
        end
    end

end