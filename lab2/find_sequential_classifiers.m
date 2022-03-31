% TO keep running without a limit on the j classifiers, set j=-1
function [naB, nbA, a_prototypes, b_prototypes] = find_sequential_classifiers(class_a_data, class_b_data, max_j)
    
    % Initialize two arrays to store the pairs of prototypes used for
    % classification
    a_prototypes = [];
    b_prototypes = [];
    naB = []; % How many times a point from a was classified as B
    nbA = []; % How many times a point from b was classified as A
    j = 1;


    % Continue to loop while there's still points that haven't been
    % perfectly classified
    while (true)
        a_size = size(class_a_data, 1);
        b_size = size(class_b_data, 1);
    
        % Choose a random point from class a and a random point from class b
        % by indexing the point at a random index
        a_prototype = class_a_data(randi(a_size), :);
        b_prototype = class_b_data(randi(b_size), :);
    

        % Determine the confusion matrices for all values in a and b using the
        % MED classifier for these prototypes
        [confusion_matrix, correct_a, correct_b] = med_error(a_prototype, b_prototype, class_a_data, class_b_data);

        
        % In the case our discriminant wasn't good, try with new prototypes
        if (confusion_matrix(1,2) ~= 0 && confusion_matrix(2,1) ~= 0)
            continue
        end

        
        % At this point, we have a good discriminant, store the prototypes
        naB(end+1) = confusion_matrix(1,2);
        nbA(end+1) = confusion_matrix(2,1);
        a_prototypes(end+1,:) = a_prototype;
        b_prototypes(end+1,:) = b_prototype;

        j = j + 1;

        % If no class A points were classified as B, then remove all points
        % correctly classified as B from the dataset
        if naB(end) == 0
            for k = 1:height(correct_b)
                i = 1;
                while (i <= height(class_b_data))
                    if class_b_data(i,:) == correct_b(k,:)
                        class_b_data(i,:) = [];
                    else
                        i = i + 1 ;
                    end
                end
            end
        end


        % If no class B points were classified as A, then remove all points
        % correctly classified as A from the dataset
        if nbA(end) == 0
            for k = 1:height(correct_a)
                i = 1;
                while (i <= height(class_a_data))
                    if class_a_data(i,:) == correct_a(k,:)
                        class_a_data(i,:) = [];
                    else
                        i = i + 1 ;
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
        if (isempty(class_a_data) || isempty(class_b_data))
            break;
        end
    end
end
