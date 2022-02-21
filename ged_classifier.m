function ged_classifier(mu_a, S_a, mu_b, S_b, mu_c, S_c)

    
    % for binary classifier:
    points = [];

    % generate 2d grid with 0.05 resolution
    for r = -4:0.05:20
        for c = 0:0.05:20
            x = [r; c];
            d_a = (x-mu_a)'* inv(S_a) * (x-mu_a);
            d_b = (x-mu_b)' * inv(S_b) * (x-mu_b);
            if (d_a == d_b)
                points = [points; x'];
            end
        end
    end

    figure
    plot(points(:,1), points(:,2))
    hold on
    %{ 
    ------------------------------------------

    % [eigenvectors, eigenvalues along diagonal]
    [V,D] = eig(S_a);
    
    % Λ
    lambda = V' * S * V;

    % weight matrix 
    W = lambda ^ (-1/2)* V';

    % new mean in transformed space:
    m_new = W*mu';


    % plot unit standard deviation:
    plot_ellipse(m_new(1), m_new(2,1), 0, 1, 1, "blue")
    hold on 

    % map points to transformed space
    for n = 1:length(dataset)
        transformed_data(n, :) = W*dataset(n, :)';
    end
    
    % plot transformed points
    scatter(transformed_data(:,1), transformed_data(:,2))
    hold on

    ------------------------------------------
    %}
    
end