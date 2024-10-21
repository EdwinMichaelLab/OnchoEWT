clear all; clc;
%% load data
% rainfall data
addpath('../Data/');
rain = xlsread('RainfallJacob2018.xlsx');
rain(find(rain<0)) = 0;

% MBR in control sites
MBR = xlsread('2nd long term slash trial_MES_byMonth.xlsx','Sheet2');
MBR_cont = MBR(:,4:6);
MBR_max = mean(max(MBR_cont));
MBR_intv = MBR(:,1:3);

%% BM sampling
% set parameter ranges
% MBR_max, R_L, R_U, k1, k2, n, A
param_min = [MBR_max-0.25*MBR_max; 50; 200; 0.5; 2; 0.75; 0.05];
param_max = [MBR_max+0.25*MBR_max; 250; 350; 3; 10; 0.95; 0.4];

% sample parameters
n = 1000; 
P = param_min + (param_max-param_min).*lhsdesign(n,7,'criterion','correlation')';

% run MBR model for sampled params

% MBR for given rainfall values
x = round(rain(1:11,2))+1;
MBR_0 = zeros(length(x),n); % background MBR expected
for i = 1:n
    for t = 1:length(x) 
        MBR_0(t,i) = P(1,i)*(1-exp(-(x(t)/P(2,i)).^P(4,i))).*exp(-(x(t)/P(3,i)).^P(5,i)); % MBR function of rain
    end
end

% MBR given slash
MBR_1 = zeros(length(x),n); % MBR given slash
s = 1;
for i = 1:n
    for t = 1:length(x) % time since slash
        ts = t-s;
        if ts < 1
            MBR_1(t,i) = MBR_0(t,i);
        else
            MBR_1(t,i) = MBR_0(t,i)*P(6,i)*(1-exp(-P(7,i)*ts));
        end
    end
end


% calculate pass/fail likelihoods
MBR_pred = MBR_1;
mean_MBR = mean(MBR_intv,2);
stdev = std(MBR_intv,0,2);
CI = 1.96*stdev/sqrt(length(MBR_intv(1,:)));
bounds = [mean_MBR-CI, mean_MBR+CI];
lik = zeros(n,1);
for i = 1:n
    for j = 1:length(CI)
        
        id = find(MBR_pred(j,i) >= bounds(j,1) & MBR_pred(j,i) <= bounds(j,2));
        
        if ~isempty(id)
            lik(i) = lik(i) + 1;
        end
    end
end

% select parameter sets based on likelihoods
id = find(lik >= 5);

%% plot results
% MBR vs time
figure;

subplot(1,3,3)
plot(MBR_0(:,id),'Color',[0.7 0.7 0.7]);
hold on;
plot(MBR_1(:,id),'Color',[255 153 153]./255);
plot(median(MBR_0(:,id),2),'Color','k','LineWidth',2);
plot(median(MBR_1(:,id),2),'Color','r','LineWidth',2);

stdev_c = std(MBR_cont,0,2);
CI_c = 1.96*stdev_c/sqrt(length(MBR_cont(1,:)));
errorbar(mean(MBR_cont,2),CI_c,'ko','MarkerFaceColor','k','LineWidth',1.2);

stdev_i = std(MBR_intv,0,2);
CI_i = 1.96*stdev_i/sqrt(length(MBR_intv(1,:)));
errorbar(mean(MBR_intv,2),CI_i,'rx','MarkerSize',12,'LineWidth',1.2);

xlabel('Month');
ylabel('MBR');
set(gca,'YLim',[0 1.1*max(max(MBR_0))],'XLim',[1,11],'xtick',1:11,...
 'xticklabel',{'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar'});
title('Control vs Intervention Sites');

subplot(1,3,1)
plot(MBR_0(:,id),'Color',[0.7 0.7 0.7]);
hold on;
plot(median(MBR_0(:,id),2),'Color','k','LineWidth',2);
errorbar(mean(MBR_cont,2),CI_c,'ko','MarkerFaceColor','k','LineWidth',1.2);

xlabel('Month');
ylabel('MBR');
set(gca,'YLim',[0 1.1*max(max(MBR_0))],'XLim',[1,11],'xtick',1:11,...
 'xticklabel',{'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar'});
title('Control Sites');

subplot(1,3,2)

plot(MBR_1(:,id),'Color',[255 153 153]./255);
hold on;
plot(median(MBR_1(:,id),2),'Color','r','LineWidth',2);
errorbar(mean(MBR_intv,2),CI_i,'rx','MarkerSize',12,'LineWidth',1.2);

xlabel('Month');
ylabel('MBR');
set(gca,'YLim',[0 1.1*max(max(MBR_0))],'XLim',[1,11],'xtick',1:11,...
 'xticklabel',{'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar'});
title('Intervention Sites');
% 
% print('Control_vs_Intv_Fits','-dpng');




