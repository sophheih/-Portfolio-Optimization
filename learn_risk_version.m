function [return_weight] = learn_risk_version(weight,var_covar_matrix,rate)

% gradient
gradeint = (var_covar_matrix.'+var_covar_matrix)*weight;

% update new wieght
new_weight = weight - rate*gradeint;

% bounded weight
Lower_bound = new_weight < 0;
Upper_bound = new_weight > 1;
new_weight(Lower_bound) = 0;
new_weight(Upper_bound) = 1;

% total  =  1:
s = sum(new_weight);
new_weight = new_weight/s;

% return
return_weight = new_weight;

end
