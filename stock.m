clear
x = {'spy','GOOG','FB'};
B = [];     %回報矩陣
std_ma = [];   %標準差矩陣
for i = 1:length(x)
    py.hist_stock.hist(x{i})
    filename = [x{i},'.csv'];
    A = readtable(filename);
    A.daily_return = (A.close - A.open)./A.open;
    average = mean(A.daily_return,1);
    excess_return = A.daily_return - average    
    B = [B excess_return];
    std_ma = [std_ma ;std(A.daily_return,1)];
    
end
format long;var_covar_matrix = B'*B/365;   %方差協方差矩陣
sdev_product_matrix =  std_ma *  std_ma'; %標準偏差乘積的矩陣
correlation_matrix = var_covar_matrix ./sdev_product_matrix %相關矩陣

