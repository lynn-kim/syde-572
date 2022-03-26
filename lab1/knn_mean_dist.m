function [mean_distance] = knn_mean_dist(k, point, means, coords)

    for i=1: length(coords)
        means(1) = means(1) + coords(i, 1);
        means(2) = means(2) + coords(i, 2);
    end
    means(1) = means(1) / k;
    means(2) = means(2) / k;

    % calculate distance for means from point
    temp_mean_dist = point - means;
    mean_distance = sqrt(temp_mean_dist(1)^2 + temp_mean_dist(2)^2);
end