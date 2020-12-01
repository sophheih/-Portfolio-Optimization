function [return_weight,V,M] = learn_sharpe_version_adam(weight,var_covar_matrix,rate,cumulative_return,v,m,t)

beta1 = 0.9;
beta2 = 0.999;

Re = (weight.')* cumulative_return;

a = (var_covar_matrix.'+var_covar_matrix)*weight;

num = Re*a;


%den1 = 2*((((var_covar_matrix.')*weight).')*weight).^(3/2);
den1 = 2*(weight'*var_covar_matrix*weight).^(3/2);
%den2 = ((((var_covar_matrix.')*weight).')*weight).^(1/2);
den2 = (weight'*var_covar_matrix*weight).^(1/2);
gradient_of_sharpe = cumulative_return/den2 - num/den1;

%disp(gradient_of_sharpe);
m = beta1*m + (1-beta1)*gradient_of_sharpe;
v = beta2*v + (1-beta2)*(gradient_of_sharpe/100).^2;

m_hat = m/(1-beta1.^t);
v_hat = v/(1-beta2.^t);
nn = sqrt(v_hat)+10^(-4);

new_weight = weight + rate*(1./nn).*m_hat;
V = v;
M = m;

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
