function [window] = gaussian_window(variance)
%     variance = 400;
%     std_dev = sqrt(variance);
%     window = zeros(size(floor((3*std_dev)/h), 1), size(floor((3*std_dev)/h), 2));
% 
%     for i = 1:floor((3*std_dev)/h)
%         for j = 1:floor((3*std_dev)/h)
%             window(i, j) = (1/(2*pi*variance)) *exp((-0.5)*(((i-30)^2 + (j-30)^2)/variance));
%         end
%     end

    std_dev = sqrt(variance);
    window = zeros(size(30*std_dev, 1), size(30*std_dev, 2));

    for i = 1:30*std_dev
        for j = 1:30*std_dev
            window(i, j) = (1/(2*pi*variance)) *exp((-0.5)*(((i-(30*std_dev)/2)^2 + (j-(30*std_dev)/2)^2)/variance));
        end
    end


end