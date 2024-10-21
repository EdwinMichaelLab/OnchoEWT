data = xlsread('../../Data/2nd long term slash trial_MES_byMonth.xlsx','Sheet2');

cont = data(:,4:6);
intv = data(:,1:3);

for t = 1:length(data(:,1))
    [h(t),p(t)] = ttest2(cont(t,:),intv(t,:));
end

[h(t+1),p(t+1)] = ttest2(sum(cont,1),sum(intv,1));