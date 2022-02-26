function [ coord_i, coord_j ] = nn_point_to_map(coordinate, x1)
    % x1 above is either x1 or x2, essentially one of the meshgrid axes so
    % the mapping can be done when accounting for rounding of the actual
    % coordinate point in the test dataset. Makes use of a function for
    % linear interpolation
    
    rounded_x = interp1(x1, x1, coordinate(1, 1), 'nearest');
    rounded_y = interp1(x1, x1, coordinate(1, 2), 'nearest');

    coord_i = 10*rounded_x + 501;
    coord_j = 10*rounded_y + 501; % y = 10x + 51
end