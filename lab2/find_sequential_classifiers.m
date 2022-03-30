% TO keep running without a limit on the j classifiers, set j=-1
function [classifiers] = find_sequential_classifiers(class_a_data, class_b_data, max_j)
    
    % Initialize two arrays to store the pairs of prototypes used for
    % classification
    a_prototypes = [];
    b_prototypes = [];
    naB = []; % How many times a point from a was classified as B
    nbA = []; % How many times a point from b was classified as A
    j = 0;

    % Copy the original data since we'll be removing elements from it
    original_data_a = class_a_data;
    original_data_b = class_b_data;

    % Continue to loop while there's still points that haven't been
    % perfectly classified
    while (true)
        a_size = size(class_a_data, 1)
        b_size = size(class_b_data, 1)
    
        % Choose a random point from class a and a random point from class b
        % by indexing the point at a random index
        a_prototype = class_a_data(randi(a_size), :)
        b_prototype = class_b_data(randi(b_size), :)
    

        % Determine the confusion matrices for all values in a and b using the
        % MED classifier for these prototypes
        [confusion_matrix, correct_a, correct_b] = med_error(a_prototype, b_prototype, class_a_data, class_b_data);

        % In the case our discriminant wasn't good, try with new prototypes
        if (confusion_matrix(1,2) ~= 0 && confusion_matrix(2,1) ~= 0)
            continue
        end

        % At this point, we have a good discriminant, store the prototypes
        disp("Found a good classifier");
        j = j + 1;
        a_prototypes(end+1, :) = a_prototype;
        b_prototypes(end+1, :) = b_prototype;
        naB(end+1, :) = confusion_matrix(1,2);
        nbA(end+1, :) = confusion_matrix(2,1);

        % If no class A points were classified as B, then remove all points
        % correctly classified as B from the dataset
        if confusion_matrix(1,2) == 0
            for i=1:length(class_b_data)-1
                for j=1:size(correct_b, 1)
                    if class_a_data(i, :) == correct_b(j, :)
                        % Delete the point
                        class_b_data(i, :) = [];
                    end
                end
            end
        end

        % If no class B points were classified as A, then remove all points
        % correctly classified as A from the dataset
        if confusion_matrix(2,1) == 0
            for i=1:b_size
                for j=1:size(correct_b, 1)
                    if class_b_data(i, :) == correct_b(j, :)
                        % Delete the point
                        class_b_data(i, :) = [];
                    end
                end
            end
        end
        
        % If we're not placing a limit on our classifiers, and have reached
        % our max classifiers number, break
        if (max_j ~= -1 && j == max_j)
            break;
        end

        % If we've correctly classified all our points, break
        if (size(class_a_data, 1) == 0 && size(class_b_data, 1) == 0)
            break;
        end
    end
end
