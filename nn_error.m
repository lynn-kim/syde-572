function [ confusion_matrix ] = nn_error(classifier, x1, test_dataset_1, test_dataset_2, test_dataset_3)

    % need to figure out the mapping since the grid is bounded by [-5, 25]
    % for both the x and y axis
    % each x1 and x2 value will map to a certain i and j value. the x1 and
    % x2 value will be in the same domain and range of the test_dataset
    % values
    % - 5 maps to 1, 25 maps to 301. (0 should be 51) Determine an equation for the
    % coordinates to give you i and j , and round for necessary cases
    % Access that point with the i and j values returned from the
    % nn_point_to_map() function in the classifier, and see what class
    % value it is
    % if it matches the current class, set it to the corresponding
    % confusion matrix value
    
    % Initialize
    confusion_matrix = zeros(1,1);

    if (exist('test_dataset_3', 'var'))
        confusion_matrix = zeros(3,3);
        for a=1:length(test_dataset_1)
            point = [test_dataset_1(a, 1), test_dataset_1(a, 2)];
            [i, j] = nn_point_to_map(point, x1);
            i = int16(i);
            j = int16(j);

            % Class 1, Predicted Class 1 (Correct)
            if(classifier(i,j) == 1)
                confusion_matrix(1,1) = confusion_matrix(1,1) + 1;
            % Class 1, Predicted Class 2
            elseif(classifier(i, j) == 2)
                confusion_matrix(1,2) = confusion_matrix(1,2) + 1;
            % Class 1, Predicted Class 3
            elseif(classifier(i, j) == 3)
                confusion_matrix(1,3) = confusion_matrix(1,3) + 1;
            end
        end

        for a=1:length(test_dataset_2)
            point = [test_dataset_2(a, 1), test_dataset_2(a, 2)];
            [i, j] = nn_point_to_map(point, x1);
            i = int16(i);
            j = int16(j);

            % Class 2, Predicted Class 2 (Correct)
            if(classifier(i,j) == 2)
                confusion_matrix(2,2) = confusion_matrix(2,2) + 1;
            % Class 2, Predicted Class 1
            elseif(classifier(i,j) == 1)
                confusion_matrix(2,1) = confusion_matrix(2,1) + 1;
            % Class 2, Predicted Class 3
            elseif(classifier(i,j) == 3)
                confusion_matrix(2,3) = confusion_matrix(2,3) + 1;
            end
        end

        for a=1:length(test_dataset_3)
            point = [test_dataset_3(a, 1), test_dataset_3(a, 2)];
            [i, j] = nn_point_to_map(point, x1);
            i = int16(i);
            j = int16(j);

            % Class 3, Predicted Class 2 (Correct)
            if(classifier(i,j) == 3)
                confusion_matrix(3,3) = confusion_matrix(3,3) + 1;
            % Class 3, Predicted Class 1
            elseif(classifier(i,j) == 1)
                confusion_matrix(3,1) = confusion_matrix(3,1) + 1;
            % Class 3, Predicted Class 2
            elseif(classifier(i,j) == 2)
                confusion_matrix(3,2) = confusion_matrix(3,2) + 1;
            end
        end

    else
        confusion_matrix = zeros(2,2);
        for a=1:length(test_dataset_1)
            point = [test_dataset_1(a, 1), test_dataset_1(a, 2)];
            [i, j] = nn_point_to_map(point, x1);
            i = int16(i);
            j = int16(j);

            % Class 1, Predicted Class 1 (Correct)
            if(classifier(i,j) == 1)
                confusion_matrix(1,1) = confusion_matrix(1,1) + 1;
            % Class 1, Predicted Class 2
            else
                confusion_matrix(1,2) = confusion_matrix(1,2) + 1;
            end
        end

        for a=1:length(test_dataset_2)
            point = [test_dataset_2(a, 1), test_dataset_2(a, 2)];
            [i, j] = nn_point_to_map(point, x1);
            i = int16(i);
            j = int16(j);

            % Class 2, Predicted Class 2 (Correct)
            if(classifier(i,j) == 2)
                confusion_matrix(2,2) = confusion_matrix(2,2) + 1;
            % Class 2, Predicted Class 1
            else
                confusion_matrix(2,1) = confusion_matrix(2,1) + 1;
            end
        end

    end
end