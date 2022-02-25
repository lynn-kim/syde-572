function label = classify_pattern(cd, de, ec)
% Helper function to classify pattern using MED and assign to appropriate class label
if cd <= 0 && ec >= 0
    % belongs to class C
    label = 1;
elseif cd >= 0 && de <= 0
    % belongs to class D
    label = 2;
elseif de >= 0 && ec <= 0
    % belongs to class E
    label = 3;
end