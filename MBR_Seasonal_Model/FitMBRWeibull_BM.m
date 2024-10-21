%% load data
% rainfall data
clear all
addpath('../Data/');
rain = xlsread('RainfallJacob2018.xlsx');
rain(find(rain<0)) = 0;

% MBR in control sites
MBR = xlsread('2nd long term slash trial_MES_byMonth.xlsx','Sheet2');
MBR_cont = [MBR(:,4),MBR(:,5),MBR(:,6)];
MBR_max = mean(max(MBR_cont));

%% run BM fitting
% set parameter ranges
% MBR_max, R_L, R_U, k1, k2
param_min = [MBR_max-0.25*MBR_max; 50; 200; 0.5; 2];
param_max = [MBR_max+0.25*MBR_max; 250; 400; 3; 10];
% param_min = param_min-0.5*param_min;
% param_max = param_max+0.5*param_max;

% sample parameters
n = 200000; 
P = param_min + (param_max-param_min).*lhsdesign(n,5,'criterion','correlation')';

% run MBR model for sampled params

% MBR for rainfall values 0-500
x = 0:500;
MBR_pred0 = zeros(length(x),n);
for i = 1:n
    MBR_pred0(:,i) = P(1,i)*(1-exp(-(x/P(2,i)).^P(4,i))).*exp(-(x/P(3,i)).^P(5,i)); % MBR function
end

% calculate pass/fail likelihoods
% MBR for observed rainfall values
MBR_pred = MBR_pred0([round(rain(1:11,2))+1;round(rain(1:11,2))+1],:);
mean_MBR = mean(MBR_cont,2);
stdev = std(MBR_cont,0,2);
CI = 1.96*stdev/sqrt(length(MBR_cont(1,:)));
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
% figure;
% plot(MBR_pred(:,id),'Color',[0.7 0.7 0.7]);
% hold on;
% errorbar(mean_MBR,CI,'ro','MarkerFaceColor','r');
% xlabel('months');
% ylabel('MBR');
% set(gca,'XLim',[1,11],'xtick',1:11,...
%  'xticklabel',{'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar'},'FontSize',8);
% print('MBR_vs_time_DoubWeib_BM','-dpng');

% MBR vs rainfall
% figure;
plot(x,MBR_pred0(:,id),'Color',[0.7 0.7 0.7]);
hold on;
errorbar(rain(1:11,2),mean_MBR,CI,'ro','MarkerFaceColor','r');
xlabel('Rainfall (mm)','FontSize',10);
ylabel('MBR','FontSize',10);
set(gca,'XLim',[0 450],'YLim',[0 5000]);

% fig = gcf;
% fig.PaperUnits = 'centimeters';
% fig.PaperPosition = [0 0 8.7 8];

% print('MBR_vs_rain_DoubWeib_BM','-dtiff','-r500');

%% statistics
%ReRMSE calcs
% YmodelPredict = MBR_pred(:,id);
% Ytestdata = mean_MBR;
% [m1,n1] = size(YmodelPredict);
% ReRMSE_val = 0;
% for ij = 1:n1
%     ReRMSE_val = ReRMSE_val + ReRMSE(YmodelPredict(:,ij),Ytestdata);
% end
% ReRMSE_val = ReRMSE_val/n1;
% fprintf('%1.3f\n',ReRMSE_val);

% figure
% histogram(P(2,id));

