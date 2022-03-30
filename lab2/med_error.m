% Return the confusion matrix and also store the correctly predicted a and
% b values for deletion 
function [confusion_matrix, correct_a, correct_b] = med_error(prototype_a, prototype_b, class_a_data, class_b_data)
    confusion_matrix = zeros(2,2);
    correct_a = [];
    correct_b = [];

    for i=1:length(class_a_data)

        point = class_a_data(i, :);
        discriminant = sqrt((point-prototype_a) * (point-prototype_a)') - sqrt((point-prototype_b) * (point-prototype_b)');

        if discriminant < 0
            confusion_matrix(1,1) = confusion_matrix(1,1)+1;
            correct_a(end +1, :) = point;

        else
            confusion_matrix(1,2) = confusion_matrix(1,2)+1;
        end
    end
    
    for i=1:length(class_b_data)

        point = class_b_data(i, :);
        discriminant = sqrt((point-prototype_a) * (point-prototype_a)') - sqrt((point-prototype_b) * (point-prototype_b)');

        if discriminant < 0
            confusion_matrix(2,1) = confusion_matrix(2,1)+1;

        else
            confusion_matrix(2,2) = confusion_matrix(2,2)+1;
            correct_b(end +1, :) = point;

        end
    end
end 