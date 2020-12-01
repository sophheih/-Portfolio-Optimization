function [return_weight,V] = learn_sharpe_version_momentum(weight,var_covar_matrix,rate,cumulative_return,v)

beta = 0.99;


Re = (weight.')* cumulative_return;

a = (var_covar_matrix.'+var_covar_matrix)*weight;

num = Re*a;


%den1 = 2*((((var_covar_matrix.')*weight).')*weight).^(3/2);
den1 = 2*(weight'*var_covar_matrix*weight).^(3/2);
%den2 = ((((var_covar_matrix.')*weight).')*weight).^(1/2);
den2 = (weight'*var_covar_matrix*weight).^(1/2);
gradient_of_sharpe = cumulative_return/den2 - num/den1;

%disp(gradient_of_sharpe);
v = beta*v + gradient_of_sharpe;
new_weight = weight + rate*v;
V = v;


% bounded weight:
Lower_bound = new_weight<0;
Upper_bound = new_weight>1;
new_weight(Lower_bound) = 0;
new_weight(Upper_bound) = 1;

% total  =  1:
s = sum(new_weight);
new_weight = new_weight/s;

return_weight = new_weight;


end
