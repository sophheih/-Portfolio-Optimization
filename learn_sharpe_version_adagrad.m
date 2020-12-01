function [return_weight,N] = learn_sharpe_version_adagrad(weight,var_covar_matrix,rate,cumulative_return,n)




Re = (weight.')* cumulative_return;

a = (var_covar_matrix.'+var_covar_matrix)*weight;

num = Re*a;


%den1 = 2*((((var_covar_matrix.')*weight).')*weight).^(3/2);
den1 = 2*(weight'*var_covar_matrix*weight).^(3/2);
%den2 = ((((var_covar_matrix.')*weight).')*weight).^(1/2);
den2 = (weight'*var_covar_matrix*weight).^(1/2);
gradient_of_sharpe = cumulative_return/den2 - num/den1;

%disp(gradient_of_sharpe);
n = n + (gradient_of_sharpe/100).^2;
nn = sqrt(n)+10^(-4);
%disp(nn);
%disp(1./nn);
N = n;
new_weight = weight + rate*(1./nn).*gradient_of_sharpe;



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
