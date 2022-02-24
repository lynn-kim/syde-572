function [ class ] = NN(point, class_data_1, class_data_2, class_data_3)
    class = 0
    length_var_1 = length(class_data_1);
    length_var_2 = length(class_data_2);
    
    distances_1 = zeros(length_var_1, 1);
    distances_2 = zeros(length_var_2, 1);
    
    % For class 1
    for i=1 : length_var_1
        temp_dist = point - [class_data_1(i,1); class_data_1(i,2)];
        distances_1(i) = sqrt(temp_dist(1)^2 + temp_dist(2)^2);
    end
    
    % For class 2
    for i=1 : length_var_2
        temp_dist = point - [class_data_2(i,1); class_data_2(i,2)];
        distances_2(i) = sqrt(temp_dist(1)^2 + temp_dist(2)^2);
    end
    
    % Case 2
    % if class 3 exists
    if (exist('class_data_3', 'var'))
        length_var_3 = length(class_data_3);
        distances_3 = zeros(length_var_3, 1);
    
        for i=1 : length_var_3
            temp_dist = point - [class_data_3(i,1); class_data_3(i,2)];
            distances_3(i) = sqrt(temp_dist(1)^2 + temp_dist(2)^2);
        end
    
        min_distances = [min(distances_1), min(distances_2), min(distances_3)];
        if((min(min_distances) == min(distances_1)) && (min(distances_1) == min(distances_2)))
            class = 0;
        elseif((min(min_distances) == min(distances_1)) && (min(distances_1) == min(distances_3)))
            class = 0;
    %     elseif((min(min_distances) == distances_2) && (distances_2 == distances_1))
    %         class = 0;
        elseif((min(min_distances) == min(distances_2)) && (min(distances_2) == min(distances_3)))
            class = 0;
    %     elseif((min(min_distances) == distances_3) && (distances_3 == distances_1))
    %         class = 0;
    %     elseif((min(min_distances) == distances_3) && (distances_3 == distances_2))
    %         class = 0;
        elseif((min(distances_1) == min(distances_2)) && (min(distances_2) == min(distances_3)))
            class = 0;
        elseif min(min_distances) == min(distances_1)
            class = 1;
        elseif min(min_distances) == min(distances_2)
            class = 2;
        elseif min(min_distances) == min(distances_3)
            class = 3;
        end
    
    else
        min_distances = [min(distances_1), min(distances_2)];
        if min(distances_1) == min(distances_2)
            class = 0;
        elseif min(min_distances) == min(distances_1)
            class = 1;
        elseif min(min_distances) == min(distances_2)
            class = 2;
        end
    end

end