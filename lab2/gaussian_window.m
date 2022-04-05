function [window] = gaussian_window(variance, resolution)
    
    resolution = 1;
    modifier = 10;
    std_dev = sqrt(variance);
    window_size = 2*ceil(modifier*std_dev/resolution) + 1;
    window = zeros(size(window_size, 1) , size(window_size, 2));

    for i = 1:window_size
        for j = 1:window_size
            window(i, j) = (1/(2*pi*variance)) *exp((-0.5)*(((i*resolution - std_dev*modifier - resolution)^2 + (j*resolution - std_dev*modifier - resolution)^2)/variance));
        end
    end

end 