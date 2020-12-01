function [return_weight] = learn_sharpe_version(weight,var_covar_matrix,rate,cumulative_return)

wstd = (weight.')* cumulative_return;

a = (var_covar_matrix.'+var_covar_matrix)*weight;

num = wstd*a;


den1 = 2*((((var_covar_matrix.')*weight).')*weight).^(3/2);
%disp(den1);
den2 = ((((var_covar_matrix.')*weight).')*weight).^(1/2);
%disp(den2);
gradient_of_sharpe = cumulative_return/den2 - num/den1;

new_weight = weight + rate*gradient_of_sharpe;



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
