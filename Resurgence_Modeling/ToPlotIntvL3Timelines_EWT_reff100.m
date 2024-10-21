clear all; clc;
load('../IO/IN/Inter_IN.mat','Sites');

x = csvread('../Analysis/mfBpt_Data.csv');
y = csvread('../Analysis/L3_Data.csv');
color = colormap(lines);
titles = {'EWT Before Peak Biting Month','EWT During Peak Biting Season','EWT Monthly','No EWT'};
CTrstr="p8_1";
etastr="p9to1";
mdastr="Annual";
for iSites = 1%:length(Sites)
    i=4;%no Vector Control
    % load no VC,     VC = 0
    VCStr = 'noVC';
    mf_Th = x(iSites,2);
    L3_Th = y(iSites,2);
    ThStr = num2str(mf_Th);
    IdStr = [ThStr,VCStr];
    load(sprintf('../IO/OUT/Intv%s_%s_TBR.mat',char(Sites{iSites}),IdStr));
    load(sprintf('../IO/OUT/reff100/Intv%s_v%s_reff100_CTr_%s_%sMDAnewparam_ABRth_newtest_eta_%s.mat',char(Sites{iSites}),...
            int2str(i),CTrstr(1),mdastr,etastr));
    subplot(5,1,1);
    semilogy(L3Intv,'Color',[0.7 0.7 0.7]);
    hold on;
    line([0 600],[L3_Th L3_Th],'LineStyle','--','Color','r','LineWidth',1.2);
    
    t = Time_toCross_below_Threshold(L3Intv,L3_Th);
    line([t t],[10^-7 10],'LineStyle','--','Color','r');
    set(gca,'XLim',[0 40*12],'YLim',[10^-7 10],'XTick',0:48:480,'XTickLabel',0:4:40);
    xlabel('years');
    ylabel('L3');
    title(titles{1})
    
    % load VC scenarios, VC = 1
    VCStr = 'VC';
    mf_Th = x(iSites,1);
    ThStr = num2str(mf_Th);
    IdStr = [ThStr,VCStr];
    j = 0;
    for i = [1,2,6,3]
        j = j+1;
        load(sprintf('../IO/OUT/Intv%s_%s_v%s_TBR.mat',char(Sites{iSites}),...
            IdStr,int2str(i)));
        
        subplot(5,1,j+1);
        semilogy(L3Intv,'Color',[0.7 0.7 0.7]);
        hold on;
        line([0 600],[L3_Th L3_Th],'LineStyle','--','Color','r','LineWidth',1.2);
        
        t = Time_toCross_below_Threshold(L3Intv,L3_Th);
        line([t t],[10^-7 10],'LineStyle','--','Color','r');
        set(gca,'XLim',[0 40*12],'YLim',[10^-7 10],'XTick',0:48:480,'XTickLabel',0:4:40);
        xlabel('years');
        ylabel('L3');
        title(titles{j+1})
    end
    
end

% print('RecrudMf','-dpng','-r500');