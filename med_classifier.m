function discriminant = med_classifier(X, Y, mu1, mu2)
% Calculate discriminants for MED
discriminant = zeros(size(X, 1), size(Y, 2));

for i=1:size(X, 1)
    for j=1:size(Y, 2)
        point = [X(i,j),Y(i,j)];
        discriminant(i,j) = (point-mu1)*(point-mu1)' - (point-mu2)*(point-mu2)';
    end
end

end

