% MED Error Analysis

% Case 1

% Confusion Matrix
confusion_matrix_med_1 = zeros(2,2);

discriminants_class_a_data = med_classifier(mean_a, mean_b, class_a_data);
discriminants_class_b_data = med_classifier(mean_a, mean_b, class_b_data);

for i=1:length(discriminants_class_a_data)
    discriminant_diff = discriminants_class_a_data(i);
    if discriminant_diff < 0
        confusion_matrix_med_1(1,1) = confusion_matrix_med_1(1,1)+1;
    else
        confusion_matrix_med_1(1,2) = confusion_matrix_med_1(1,2)+1;
    end
end

for i=1:length(discriminants_class_b_data)
    discriminant_diff = discriminants_class_b_data(i);
    if discriminant_diff < 0
        confusion_matrix_med_1(2,1) = confusion_matrix_med_1(2,1)+1;
    else
        confusion_matrix_med_1(2,2) = confusion_matrix_med_1(2,2)+1;
    end
end

disp('Confusion Matrix for A and B:')
disp(confusion_matrix_med_1)

% Case 2

% Confusion Matrix
confusion_matrix_med_2 = zeros(3,3);

% Discriminant differences calculated with class c sample data
discriminants_cd_class_c_data = med_classifier(mean_c, mean_d, class_c_data);
discriminants_de_class_c_data = med_classifier(mean_d, mean_e, class_c_data);
discriminants_ec_class_c_data = med_classifier(mean_e, mean_c, class_c_data);

% Discriminant differences calculated with class d sample data
discriminants_cd_class_d_data = med_classifier(mean_c, mean_d, class_d_data);
discriminants_de_class_d_data = med_classifier(mean_d, mean_e, class_d_data);
discriminants_ec_class_d_data = med_classifier(mean_e, mean_c, class_d_data);

% Discriminant differences calculated with class e sample data
discriminants_cd_class_e_data = med_classifier(mean_c, mean_d, class_e_data);
discriminants_de_class_e_data = med_classifier(mean_d, mean_e, class_e_data);
discriminants_ec_class_e_data = med_classifier(mean_e, mean_c, class_e_data);

for i=1:length(class_c_data)
    class = classify_pattern(discriminants_cd_class_c_data(i), discriminants_de_class_c_data(i), discriminants_ec_class_c_data(i));
    if class == 1
        confusion_matrix_med_2(1,1) = confusion_matrix_med_2(1,1)+1;
    elseif class == 2
        confusion_matrix_med_2(1,2) = confusion_matrix_med_2(1,2)+1;
    elseif class == 3
        confusion_matrix_med_2(1,3) = confusion_matrix_med_2(1,3)+1;
    end
end

for i=1:length(class_d_data)
    class = classify_pattern(discriminants_cd_class_d_data(i), discriminants_de_class_d_data(i), discriminants_ec_class_d_data(i));
    if class == 1
        confusion_matrix_med_2(2,1) = confusion_matrix_med_2(2,1)+1;
    elseif class == 2
        confusion_matrix_med_2(2,2) = confusion_matrix_med_2(2,2)+1;
    elseif class == 3
        confusion_matrix_med_2(2,3) = confusion_matrix_med_2(2,3)+1;
    end
end

for i=1:length(class_e_data)
    class = classify_pattern(discriminants_cd_class_e_data(i), discriminants_de_class_e_data(i), discriminants_ec_class_e_data(i));
    if class == 1
        confusion_matrix_med_2(3,1) = confusion_matrix_med_2(3,1)+1;
    elseif class == 2
        confusion_matrix_med_2(3,2) = confusion_matrix_med_2(3,2)+1;
    elseif class == 3
        confusion_matrix_med_2(3,3) = confusion_matrix_med_2(3,3)+1;
    end
end

disp('Confusion Matrix for C, D, and E:')
disp(confusion_matrix_med_2)







    