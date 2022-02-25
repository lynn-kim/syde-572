function confusion_matrix = map_error(ds_1, mean_1, covar_1, N_1, ds_2, mean_2, covar_2, N_2, ds_3, mean_3, covar_3, N_3)
    confusion_matrix = zeros(2,2);

    % 3 class case
    if (exist('ds_3', 'var'))
        confusion_matrix = zeros(3,3);
        
        for i=1:length(ds_1)
            x = [ds_1(i,1)  ds_1(i,2) ];
            classified_1_2 = classify_point_map(mean_1, mean_2, covar_1, covar_2, N_1, N_2, x);
            classified_1_3 = classify_point_map(mean_1, mean_3, covar_1, covar_3, N_1, N_3, x);
            classified_2_3 = classify_point_map(mean_2, mean_3, covar_2, covar_3, N_2, N_3, x);

            if (classified_1_2 <= 0 && classified_1_3 <= 0)
                % Classified as class 1
                confusion_matrix(1,1) = confusion_matrix(1,1) + 1;
            elseif (classified_1_2 > 0 && classified_2_3 <= 0)
                % Classified as class 2
                confusion_matrix(1,2) = confusion_matrix(1,2) + 1;  
            elseif (classified_1_3 > 0 && classified_2_3 > 0)
                % Classified as class 3
                confusion_matrix(1,3) = confusion_matrix(1,3) + 1;
            end
        end

        for i=1:length(ds_2)
            x = [ds_2(i,1)  ds_2(i,2) ];
            classified_1_2 = classify_point_map(mean_1, mean_2, covar_1, covar_2, N_1, N_2, x);
            classified_1_3 = classify_point_map(mean_1, mean_3, covar_1, covar_3, N_1, N_3, x);
            classified_2_3 = classify_point_map(mean_2, mean_3, covar_2, covar_3, N_2, N_3, x);

            if (classified_1_2 <= 0 && classified_1_3 <= 0)
                % Classified as class 1
                confusion_matrix(2,1) = confusion_matrix(2,1) + 1;
            elseif (classified_1_2 > 0 && classified_2_3 <= 0)
                % Classified as class 2
                confusion_matrix(2,2) = confusion_matrix(2,2) + 1;  
            elseif (classified_1_3 > 0 && classified_2_3 > 0)
                % Classified as class 3
                confusion_matrix(2,3) = confusion_matrix(2,3) + 1;
            end
        end

        for i=1:length(ds_3)
            x = [ds_3(i,1)  ds_3(i,2) ];
            classified_1_2 = classify_point_map(mean_1, mean_2, covar_1, covar_2, N_1, N_2, x);
            classified_1_3 = classify_point_map(mean_1, mean_3, covar_1, covar_3, N_1, N_3, x);
            classified_2_3 = classify_point_map(mean_2, mean_3, covar_2, covar_3, N_2, N_3, x);

            if (classified_1_2 <= 0 && classified_1_3 <= 0)
                % Classified as class 1
                confusion_matrix(3,1) = confusion_matrix(3,1) + 1;
            elseif (classified_1_2 > 0 && classified_2_3 <= 0)
                % Classified as class 2
                confusion_matrix(3,2) = confusion_matrix(3,2) + 1;  
            elseif (classified_1_3 > 0 && classified_2_3 > 0)
                % Classified as class 3
                confusion_matrix(3,3) = confusion_matrix(3,3) + 1;
            end
        end
        
    % 2 class case
    else
        for i=1:length(ds_1)
            x = [ds_1(i,1)  ds_1(i,2) ];
            classified = classify_point_map(mean_1, mean_2, covar_1, covar_2, N_1, N_2, x);

            if classified == 0
                confusion_matrix(1,1) = confusion_matrix(1,1) + 1;
            elseif classified == 1
                confusion_matrix(1,2) = confusion_matrix(1,2) + 1;
            end
        end

        for i=1:length(ds_2)
            x = [ds_2(i, 1) ds_2(i, 2) ];
            classified = classify_point_map(mean_1, mean_2, covar_1, covar_2, N_1, N_2, x);

            if classified == 1
                confusion_matrix(2,2) = confusion_matrix(2,2) + 1;

            elseif classified == 0
                confusion_matrix(2,1) = confusion_matrix(2,1) + 1;
            end
        end
    end
