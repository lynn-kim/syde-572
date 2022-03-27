function p = parzen_1D(N, h, d, x)
% Computes Parzen estimate for 1D case using Gaussian window estimation function
% Parameters
% N - number of samples
% h - scaling factor (std dev in this case)
% d - data set
% x - range over which density is plotted

% PDF
p = zeros(size(x));
for i=1:length(x)
    sum = 0;
    for j=1:length(d)
        % sum the contributions from each local PDF
        sum = sum + normpdf(x(i),d(j),h);
    end
    p(i) = 1/N * sum;
end
end

