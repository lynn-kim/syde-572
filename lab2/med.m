function [discriminant] = med(point, prototype_a, prototype_b)
    discriminant = sqrt((point-prototype_a) * (point-prototype_a)') - sqrt((point-prototype_b) * (point-prototype_b)');
end