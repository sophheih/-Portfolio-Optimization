clear
x = {'GOOG','spy','FB','AAPL'};
% 回測真實數據(準確率)、測試速度、本益比、SGD-->優化法(ADAM、adagrad, momentum)、同類股票
k = 4;% k stock
B = zeros(365,k); % 365Days ktypes
std_ma = zeros(k,1);% ktypes
cumulative_return = zeros(k,1);%k types
for ii = 1:length(x)
    py.hist_stock.hist(x{ii})
    filename = [x{ii},'.csv'];
    A = readtable(filename);
    A.daily_return = (A.close - A.open)./A.open;
    average = mean(A.daily_return,1);
    excess_return = A.daily_return - average;
    cumulative_return(ii) = prod(A.daily_return+1)-1; 
    B(:,ii) = excess_return;
    std_ma(ii) = std(A.daily_return,1);
    
end

format long;
var_covar_matrix = B'*B/365;   
sdev_product_matrix =  std_ma *  std_ma';
correlation_matrix = var_covar_matrix ./sdev_product_matrix ;

Weight = ones(k,1)/k; rate = 0.000001;
varp = zeros(100,1,'double');
volp = zeros(100,1,'double');
returnp = zeros(100,1,'double');
ratiop = zeros(100,1,'double');
for ii = 1:1000000
    
    Weight = learn_sharpe_version(Weight,var_covar_matrix,rate,cumulative_return);
    if mod(ii,10000)==0
        fprintf("round %i :\n",ii);
        for jj = 1:k
            fprintf("%10s %16.8f\n",x{jj},Weight(jj)*100);
        end
        std_weight = Weight.*std_ma;
        var = (std_weight.')*correlation_matrix*std_weight;
        vol = sqrt(var);
        fprintf("volatility: %10.7f %% \n",vol*100);
        fprintf("return: %10.7f %% \n",Weight.'*cumulative_return*100);
        fprintf("sharperatio: %10.7f  \n",Weight.'*cumulative_return/vol);
        index = int16(ii/10000);
        varp(index,1) = var ;
        volp(index,1) = vol ;
        returnp(index,1) = Weight.'*cumulative_return*100;
        ratiop(index,1) = Weight.'*cumulative_return/vol;
    end
    
end
round = 1:100;
subplot(2,6,[1 2]),plot(round,volp,"--b","LineWidth",2);legend("volatility");
subplot(2,6,[7 8]),plot(round,varp,"--r","LineWidth",2);legend("variance");
subplot(2,6,[3 4]),plot(round,returnp,"--g","LineWidth",2);legend("return");
subplot(2,6,[9 10]),plot(round,ratiop,"--black","LineWidth",2);legend("sharpe ratio");
subplot(2,6,[5 6 11 12]),pie(Weight,x);
