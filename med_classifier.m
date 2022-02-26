function discriminant = med_classifier(mu1, mu2, X, Y)
% Calculate discriminants for MED
if nargin < 4
    discriminant = zeros(length(X),1);
    for i=1:length(X)
        point = X(i,:);
        discriminant(i) = sqrt((point-mu1) * (point-mu1)') - sqrt((point-mu2) * (point-mu2)');
    end

else
    discriminant = zeros(size(X, 1), size(Y, 2));
    for i=1:size(X, 1)
        for j=1:size(Y, 2)
            point = [X(i,j),Y(i,j)];
            discriminant(i,j) = (point-mu1)*(point-mu1)' - (point-mu2)*(point-mu2)';
        end
    end

end
