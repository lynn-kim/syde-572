function percent_error = experimental_error(confusion_matrix)
    total_points = 0;
    correct = 0;
    for i=1:length(confusion_matrix)
        for j=1:length(confusion_matrix(1))
            total_points = total_points + confusion_matrix(i,j);
            if i == j
                correct = correct + confusion_matrix(i,j);
            end
        end
    end

    percent_error = 100*(total_points - correct)/total_points ;
end