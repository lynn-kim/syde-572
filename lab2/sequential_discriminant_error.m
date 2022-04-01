function [avg_err, min_err, max_err, std_dev_err] = sequential_discriminant_error(a, b, J, K)

    avg_err = zeros(1, J);
    min_err = zeros(1, J);
    max_err = zeros(1, J);
    std_dev_err = zeros(1, J);
    
    total = length(a) + length(b);
    misclassified_count = zeros(J, K); % 5 x 20
    
    for j=1:J
    
        for k=1:K
            [naB, nbA, a_prots, b_prots] = find_sequential_classifiers(a,b,j);
        
            % classify points in a and count misclassified points
            for i=1:length(a)
                is_classified = false;
                l = 1;
                class = 0;
                while ~is_classified && l <= height(a_prots)
                    % point
                    x = a(i,:);
                    discriminant = med(x, a_prots(l,:), b_prots(l,:));
                    % discriminant < 0: belongs to class a --> 1
                    % discriminant > 0: belongs to class b --> 2
                    if (nbA(l) == 0 && discriminant < 0)
                        is_classified = true;
                        class = 1;
                    elseif (naB(l) == 0 && discriminant > 0)
                        is_classified = true;
                        class = 2;
                    else
                        l = l + 1;
                    end
                end
    
                % misclassified
                if class == 2 || class == 0
                    misclassified_count(j,k) = misclassified_count(j,k)+1;
                end  
            end
    
            % classify points in b and count misclassified points
            for i=1:length(b)
                is_classified = false;
                l = 1;
                class = 0;
                while ~is_classified && l <= height(b_prots)
                    % point
                    x = b(i,:);
                    discriminant = med(x, a_prots(l,:), b_prots(l,:));
                    % discriminant < 0: belongs to class a --> 1
                    % discriminant > 0: belongs to class b --> 2
                    if (nbA(l) == 0 && discriminant < 0)
                        is_classified = true;
                        class = 1;
                    elseif (naB(l) == 0 && discriminant > 0)
                        is_classified = true;
                        class = 2;
                    else
                        l = l + 1;
                    end
                end
    
                % misclassified
                if class == 1 || class == 0
                    misclassified_count(j,k) = misclassified_count(j,k)+1;
                end  
            end
    
        end
    
        avg_err(j) = sum(misclassified_count(j,:))/K/total;
        min_err(j) = min(misclassified_count(j,:))/total;
        max_err(j) = max(misclassified_count(j,:))/total;
        std_dev_err(j) = std(misclassified_count(j,:));
    end
end
