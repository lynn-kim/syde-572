function class = ged_classifier(x, mu_a, S_a, mu_b, S_b, mu_c, S_c)
   d_a = (x-mu_a)' * inv(S_a) * (x-mu_a);
   d_b = (x-mu_b)' * inv(S_b) * (x-mu_b);
   
   % three class classifier
   if (exist('mu_c', 'var') && exist('S_c', 'var'))
       d_c = (x-mu_c)' * inv(S_c) * (x-mu_c);
       distances = [d_a, d_b, d_c];
       
       if d_a == d_b && d_b == d_c
           class = 0;
       elseif min(distances) == d_a
           class = 1;
       elseif min(distances) == d_b
           class = 2;
       elseif min(distances) == d_c
           class = 3;
       end

   % binary classifier
   else
       distances = [d_a, d_b];
       if d_a == d_b
           class = 0;
       elseif min(distances) == d_a
           class = 1;
       elseif min(distances) == d_b
           class = 2;
       end
   end
end