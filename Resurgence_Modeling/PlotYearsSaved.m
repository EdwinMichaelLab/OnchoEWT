% clear all; clc;
load('../IO/IN/Inter_IN.mat','Sites');

x = csvread('../Analysis/mfBpt_Data.csv');
a = csvread('../Analysis/ATP_Data.csv');

z_ATP = [];
w_ATP = [];
z_mf = [];
w_mf = [];
for iSites = 1:length(Sites)
    
    y_ATP = [];
    y_mf = [];
    
    % load no VC,     VC = 0
    VCStr = 'noVC';
    EP_Th = x(iSites,2);
    ThStr = num2str(EP_Th);
    IdStr = [ThStr,VCStr];
    
    load(sprintf('../IO/OUT/Intv%s_%s_v4_TBR_AprStart.mat',char(Sites{iSites}),IdStr));
    
    MTP = MBRIntv.*L3Intv;
    ATP = zeros((length(MTP(:,1))-1)/12,length(MTP(1,:)));
    for j = 1:(length(MTP(:,1))-1)/12
        ATP(j,:) = sum(MTP((j-1)*12+1:j*12,:),1);
    end
    
    [m,n] = size(ATP);
    timeX = [];
    for k = 1:n
        id = find(ATP(1:m,k) < a(iSites,2));
        if isempty(id)
            timeX = [timeX; length(ATP(:,1))];
        else
            timeX = [timeX; (id(1)-1)];
        end
    end
    
    timeX(find(timeX==0)) = 1;
    y_ATP = [y_ATP,timeX];
    y_mf = [y_mf,MonthsMDA/12];
    
    % load VC scenarios, VC = 1
    VCStr = 'VC';
    EP_Th = x(iSites,1);
    
    
    ThStr = num2str(EP_Th);
    IdStr = [ThStr,VCStr];
    for i = [1,2,3]
        load(sprintf('../IO/OUT/Intv%s_%s_v%s_TBR_AprStart.mat',char(Sites{iSites}),...
            IdStr,int2str(i)));
        MTP = MBRIntv.*L3Intv;
        ATP = zeros((length(MTP(:,1))-1)/12,length(MTP(1,:)));
        for j = 1:(length(MTP(:,1))-1)/12
            ATP(j,:) = sum(MTP((j-1)*12+1:j*12,:),1);
        end
        
        [m,n] = size(ATP);
        timeX = [];
        for k = 1:n
            id = find(ATP(1:m,k) < a(iSites,1));
            if isempty(id)
                timeX = [timeX; length(ATP(:,1))];
            else
                timeX = [timeX; (id(1)-1)];
            end
        end
        
        timeX(find(timeX==0)) = 1;
        y_ATP = [y_ATP,timeX];
        y_mf = [y_mf,MonthsMDA/12];
    end
    
    z_ATP = [z_ATP;y_ATP(:,1)-y_ATP(:,2:4)];
    w_ATP = [w_ATP,y_ATP(:,1)-y_ATP(:,2:4)];
    z_mf = [z_mf;y_mf(:,1)-y_mf(:,2:4)];
    w_mf = [w_mf,y_mf(:,1)-y_mf(:,2:4)];
    
end

ax2 = subplot(3,1,2);
boxplot(z_ATP,'Colors','k');
set(gca,'XTickLabel',{'S&C at start of biting season','S&C throughout biting season','S&C every month of the year'},'FontSize',6);
% set(gca,'XTickLabel',{'S&C A','S&C B','S&C C'},'FontSize',6);
set(gca,'ylim',[-1 40]);
ylabel('Years Saved','FontSize',10);
hOut=findobj(gca,'tag','Outliers'); delete(hOut);
h1 = findobj(gca,'Tag','Box');
color = ['b','r','g'];
for j=1:length(h1)
    p = patch(get(h1(j),'XData'),get(h1(j),'YData'),color(j),'FaceAlpha',0.2,'EdgeColor',color(j)); 
end
title({'b. Years of Interventions Saved (ATP threshold)',''},'FontSize',10);
fix_xticklabels();

% pos = get(gca,'Position');
% set(gca, 'Position', [pos(1) pos(2)+0.06 pos(3) pos(4)-0.06]);

ax3 = subplot(3,1,3);
boxplot(z_mf,'Colors','k');
set(gca,'XTickLabel',{'S&C at start of biting season','S&C throughout biting season','S&C every month of the year'},'FontSize',6);
% set(gca,'XTickLabel',{'S&C A','S&C B','S&C C'},'FontSize',6);
set(gca,'ylim',[-1 40]);
ylabel('Years Saved','FontSize',10);
hOut=findobj(gca,'tag','Outliers'); delete(hOut);
h1 = findobj(gca,'Tag','Box');
color = ['b','r','g'];
for j=1:length(h1)
    p = patch(get(h1(j),'XData'),get(h1(j),'YData'),color(j),'FaceAlpha',0.2,'EdgeColor',color(j)); 
end
fix_xticklabels();
title({'c. Years of Interventions Saved (mf threshold)',''},'FontSize',10);

% fig = gcf;
% fig.PaperUnits = 'centimeters';
% fig.PaperPosition = [0 0 8.7 16];

% pos = get(gca,'Position');
% set(gca, 'Position', [pos(1) pos(2)+0.06 pos(3) pos(4)-0.06]);
% print('YearsSaved.tif','-dtiff','-r500');
