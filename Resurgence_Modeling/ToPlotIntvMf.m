clear all; clc;
load('../IO/IN/Inter_IN.mat','Sites');

x = csvread('../Analysis/mfBpt_Data.csv');
color = colormap(lines);

for iSites = 1%:length(Sites)
    
    figure;
    % load no VC,     VC = 0
    VCStr = 'noVC';
    EP_Th = x(iSites,1);
    ThStr = num2str(EP_Th);
    IdStr = [ThStr,VCStr];
    
    load(sprintf('../IO/OUT/Intv%s_%s_TBR_stop.mat',char(Sites{iSites}),IdStr),...
        'mfPrevIntv');
    subplot(2,1,1);
    semilogy(mfPrevIntv,'Color',[0.6 0.6 0.6]);
    hold on;
    line([0 600],[EP_Th EP_Th],'LineStyle','--','Color','r'); % median TBR Masaloa
    set(gca,'XLim',[0 40*12],'YLim',[10^-2 10^2]);
    xlabel('months');
    ylabel('mf prevalence (%)');
    % load VC scenarios, VC = 1
    VCStr = 'VC';
    EP_Th = x(iSites,1);
    ThStr = num2str(EP_Th);
    IdStr = [ThStr,VCStr];
    j=0;
    for i = 6
        j = j+1;
        load(sprintf('../IO/OUT/Intv%s_%s_v%s_TBR_stop.mat',char(Sites{iSites}),...
            IdStr,int2str(i)));
        subplot(2,1,j+1);
        semilogy(mfPrevIntv,'Color',color(j,:));
        hold on;
        line([0 600],[EP_Th EP_Th],'LineStyle','--','Color','r'); % median TBR Masaloa
        set(gca,'XLim',[0 40*12],'YLim',[10^-2 10^2]);
        xlabel('months');
        ylabel('mf prevalence (%)');
    end
    
end

print('RecrudMf','-dpng','-r500');