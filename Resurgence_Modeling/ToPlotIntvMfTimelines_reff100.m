clear all; clc;
load('../IO/IN/Inter_IN.mat','Sites');
close all
x = csvread('../Analysis/mfBpt_Data.csv');
color = colormap(lines);
titles = {'No EWT','EWT Before Peak Biting Season','EWT During Peak Biting Season','EWT Monthly'};

etastr='p8to1';
CTrstr1="p5_p6";
CTrstr2="p9_1";
mdastr="Annual";
epthstr="WHO";%"noWHO"
tWHO=[385,253];
tw=1;
VC=[0,1];
vi=1;
for iSites = 2%:length(Sites)
    
    % load no VC,     VC = 0
    VCStr = 'noVC';
    EP_Th = x(iSites,2);
    ThStr = num2str(EP_Th);
    IdStr = [ThStr,VCStr];
    i=4;
    if epthstr=="WHO"
        EP_Th=1;
    end
%     load(sprintf('../IO/OUT/Intv%s_%s_TBR.mat',char(Sites{iSites}),IdStr));,string(tWHO),string(VC)
    load(sprintf('../IO/OUT/resurgence/reff100/Intv%s_v%s_reff100_CTr_%s_%sMDAnewparam_ABRth_newtest_eta_%s_%s_resurgence_%sTWHO_VC_%s.mat',char(Sites{iSites}),...
          int2str(i),CTrstr2,mdastr,etastr,epthstr,string(tWHO(tw)),string(VC(vi))));
    


%     load(sprintf('../IO/OUT/Intv%s_v%s_reff200_CTr_p8_1_AnnualMDA_oldtest.mat',char(Sites{iSites}),int2str(i)),...
%         'MBRIntv','slash_t');


    subplot(5,1,1);
%     semilogy(median(mfPrevIntv,2),'Color',[0.7 0.7 0.7]);
        semilogy(mfPrevIntv1,'Color',[0.7 0.7 0.7]);

    hold on;
    line([0 600],[EP_Th EP_Th],'LineStyle','--','Color','r');
    
    t = prctile(tWHO,95);
    line([t t],[10^-2 10^2],'LineStyle','-','Color','r');
    set(gca,'XLim',[0 40*12],'YLim',[10^-2 10^2],'XTick',0:48:480,'XTickLabel',0:4:40);
    xlabel('years');
    ylabel('mf prevalence (%)');
%     title(titles{1})
            title(mdastr+"-VC-"+VC(vi))

    % load VC scenarios, VC = 1
    VCStr = 'VC';
    EP_Th = x(iSites,1);
    ThStr = num2str(EP_Th);
    IdStr = [ThStr,VCStr];
    
    if epthstr=="WHO"
        EP_Th=1;
    end
    
    j = 0;
    for i = 4%[1,2,3]%6 ...6 is for WHO threshold Us some other index to identify who threshold
        j = j+1;
%         load(sprintf('../IO/OUT/Intv%s_%s_v%s_TBR.mat',char(Sites{iSites}),...
%             IdStr,int2str(i)));
vi=2;
mdastr="Annual";
tw=1;
tWHO=[385,253];

load(sprintf('../IO/OUT/resurgence/reff100/Intv%s_v%s_reff100_CTr_%s_%sMDAnewparam_ABRth_newtest_eta_%s_%s_resurgence_%sTWHO_VC_%s.mat',char(Sites{iSites}),...
          int2str(i),CTrstr2,mdastr,etastr,epthstr,string(tWHO(tw)),string(VC(vi))));
    
        subplot(5,1,j+1);
%         semilogy(median(mfPrevIntv1,2),'Color',[0.7 0.7 0.7]);
        semilogy(mfPrevIntv2,'Color',[0.7 0.7 0.7]);

        hold on;
        line([0 600],[EP_Th EP_Th],'LineStyle','--','Color','r');
        
        t = prctile(tWHO1,95);
        line([t t],[10^-2 10^2],'LineStyle','-','Color','r');
        set(gca,'XLim',[0 40*12],'YLim',[10^-2 10^2],'XTick',0:48:480,'XTickLabel',0:4:40);
        xlabel('years');
        ylabel('mf prevalence (%)');
%         title(titles{j+1})
        title(mdastr+"-VC-"+VC(vi))

    end
    
end

% print('MfTimelines','-dpng','-r500');