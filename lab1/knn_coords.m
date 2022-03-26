function [coords, distances] = knn_coords(k, data, distances, coords)
    for i=1: k
        [minimum, index] = min(distances);
        coords(i, 1) = data(index, 1);
        coords(i, 2) = data(index, 2);
        distances(index) = inf;
    end
end