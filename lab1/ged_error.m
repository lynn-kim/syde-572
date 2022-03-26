function confusion_matrix = ged_error(dataset_1, mu_1, s_1, dataset_2, mu_2, s_2, dataset_3, mu_3, s_3)
    confusion_matrix = zeros(2,2);
    if (exist('dataset_3', 'var'))
        confusion_matrix = zeros(3,3);

        for i=1:length(dataset_1)
            x = [dataset_1(i,1);dataset_1(i,2)];
            class = ged_classifier(x, mu_1', s_1, mu_2', s_2, mu_3', s_3);
            if class == 1
                confusion_matrix(1,1) = confusion_matrix(1,1) + 1;
            elseif class == 2
                % predicted 2, actual 1 
                confusion_matrix(1,2) = confusion_matrix(1,2) + 1; 
            elseif class == 3
                % predicted 3, actual 1
                confusion_matrix(1,3) = confusion_matrix(1,3) + 1;
            end
            
        end
    
        for i=1:length(dataset_2)
            x = [dataset_2(i,1);dataset_2(i,2) ];
            class = ged_classifier(x, mu_1', s_1, mu_2', s_2, mu_3', s_3);
            if class == 2
                confusion_matrix(2,2) = confusion_matrix(2,2) + 1;
            elseif class == 1
                confusion_matrix(2,1) = confusion_matrix(2,1) + 1; 
            elseif class == 3 
                confusion_matrix(2,3) = confusion_matrix(2,3) + 1;
            end
        end

        for i=1:length(dataset_3)
            x = [dataset_3(i,1);dataset_3(i,2) ];
            class = ged_classifier(x, mu_1', s_1, mu_2', s_2, mu_3', s_3);
            if class == 3
                confusion_matrix(3,3) = confusion_matrix(3,3) + 1;
            elseif class == 1
                % predicted class 1, actual class 3
                confusion_matrix(3,1) = confusion_matrix(3,1) + 1; 
            elseif class == 2
                confusion_matrix(3,2) = confusion_matrix(3,2) + 1;
            end
        end

    else
        for i=1:length(dataset_1)
            x = [dataset_1(i,1) ; dataset_1(i,2) ];
            class = ged_classifier(x, mu_1', s_1, mu_2', s_2);
            if class == 1
                confusion_matrix(1,1) = confusion_matrix(1,1) + 1;
            elseif class == 2
                % predicted 2, actual 1 
                confusion_matrix(1,2) = confusion_matrix(1,2) + 1; 
            end
            
        end
    
        for i=1:length(dataset_2)
            x = [dataset_2(i,1);dataset_2(i,2) ];
            class = ged_classifier(x, mu_1', s_1, mu_2', s_2);
            if class == 2
                confusion_matrix(2,2) = confusion_matrix(2,2) + 1;
            elseif class == 1
                % predicted class 1, actually class 2
                confusion_matrix(2,1) = confusion_matrix(2,1) + 1; 
            end
        end
        
    end 
end