clear all; clc;
load('../IO/IN/Inter_IN.mat','Sites');
close all
x = csvread('../Analysis/mfBpt_Data.csv');
color = colormap(lines);
titles = {'No S&C','S&C Before Known Peak','S&C During Peak Interval','Intermittent S&C','S&C Monthly'};

for iSites = 1%:length(Sites)
    
    % load no VC,     VC = 0
    VCStr = 'noVC';
    EP_Th = x(iSites,2);
    ThStr = num2str(EP_Th);
    IdStr = [ThStr,VCStr];
    load(sprintf('../IO/OUT/Intv%s_%s_TBR.mat',char(Sites{iSites}),IdStr));
    
    subplot(5,1,1);
    semilogy(median(mfPrevIntv,2),'Color',[0.7 0.7 0.7]);
    hold on;
    line([0 600],[EP_Th EP_Th],'LineStyle','--','Color','r');
    
    t = prctile(MonthsMDA,95);
    line([t t],[10^-2 10^2],'LineStyle','-','Color','r');
    set(gca,'XLim',[0 40*12],'YLim',[10^-2 10^2],'XTick',0:48:480,'XTickLabel',0:4:40);
    xlabel('years');
    ylabel('mf prevalence (%)');
    title(titles{1})
    
    % load VC scenarios, VC = 1
    VCStr = 'VC';
    EP_Th = x(iSites,1);
    ThStr = num2str(EP_Th);
    IdStr = [ThStr,VCStr];
    j = 0;
    for i = [1,2,6,3]
        j = j+1;
        load(sprintf('../IO/OUT/Intv%s_%s_v%s_TBR.mat',char(Sites{iSites}),...
            IdStr,int2str(i)));
        
        subplot(5,1,j+1);
        semilogy(median(mfPrevIntv,2),'Color',[0.7 0.7 0.7]);
        hold on;
        line([0 600],[EP_Th EP_Th],'LineStyle','--','Color','r');
        
        t = prctile(MonthsMDA,95);
        line([t t],[10^-2 10^2],'LineStyle','-','Color','r');
        set(gca,'XLim',[0 40*12],'YLim',[10^-2 10^2],'XTick',0:48:480,'XTickLabel',0:4:40);
        xlabel('years');
        ylabel('mf prevalence (%)');
        title(titles{j+1})
    end
    
end

% print('MfTimelines','-dpng','-r500');