clear all; clc;
close all
load('../IO/IN/Inter_IN.mat','Sites');

x = csvread('../Analysis/mfBpt_Data.csv');
a = csvread('../Analysis/ATP_Data.csv');

color = colormap(lines);
titles = {'EWT Before Peak Biting Month','EWT During Peak Biting Season','EWT Monthly','No EWT'};

for iSites = 4%:length(Sites)
    
%     figure;
%     % load no VC, VC = 0
%     VCStr = 'noVC';
%     EP_Th = x(iSites,2);
%     ThStr = num2str(EP_Th);
%     IdStr = [ThStr,VCStr];
%     load(sprintf('../IO/OUT/Intv%s_%s_v4_TBR_AprStart.mat',char(Sites{iSites}),IdStr));
%     
%     MTP = MBRIntv.*L3Intv;
%     ATP = zeros((length(MTP(:,1))-1)/12,length(MTP(1,:)));
%     for j = 1:(length(MTP(:,1))-1)/12
%         ATP(j,:) = sum(MTP((j-1)*12+1:j*12,:),1);
%     end
%     
%     subplot(4,1,1);
%     yyaxis right
%     plot(prctile(ATP,97.5,2),'--','Color','r'); %[0.9804    0.3608    0.3608]);
%     hold on
%     plot(prctile(ATP,2.5,2),'--','Color','r'); %[0.9804    0.3608    0.3608]);
%     plot(median(ATP,2),'Color','r');
%     hold off
%     y1 = gca;
%     ymax = y1.YLim(2);
%     
%     [m,n] = size(ATP);
%     timeX = [];
%     for i = 1:n
%         id = find(ATP(1:m,i) < a(iSites,2));
%         if isempty(id)
%             timeX = [timeX; length(ATP(:,1))];
%         else
%             timeX = [timeX; (id(1)-1)];
%         end
%     end
%     t = prctile(timeX,50);
%     line([t t],[0 ymax*1.1],'LineStyle','-','Color','r');
%     set(gca,'YLim',[0 ymax]);
%     ylabel('ATP','FontSize',10);
%     
%     yyaxis left
%     semilogy(prctile(mfPrevIntv(1:12:end,:),97.5,2),'--','Color','b'); %[0.3333    0.3333    0.9804]);
%     hold on
%     semilogy(prctile(mfPrevIntv(1:12:end,:),2.5,2),'--','Color','b'); %[0.3333    0.3333    0.9804]);
%     semilogy(median(mfPrevIntv(1:12:end,:),2),'Color','b');
%     %     line([0 600],[EP_Th EP_Th],'LineStyle','--','Color','r');
%     
%     MonthsMDA(MonthsMDA==0)=NaN;
%     t1 = nanmedian(MonthsMDA)/12;
%     line([t1 t1],[10^-3 10^2],'LineStyle','-','Color','b');
%     set(gca,'XLim',[1 t1+2],'YLim',[10^-3 10^2],'YTick',[10^-2,10^0,10^2]);
%     xlabel('Years','FontSize',10);
%     ylabel('AMf prevalence (%)','FontSize',10);
%     title(titles{1},'FontSize',10)
    
    % load VC scenarios, VC = 1
    VCStr = 'VC';
    EP_Th = x(iSites,1);
    ThStr = num2str(EP_Th);
    IdStr = [ThStr,VCStr];
    k = 0;
    for i =1%[1,2,3]
        k = k+1;
       % IntvMasaloa_v4_reff200_CTr_p8_1_AnnualMDAnewparam_ABRth.mat
        load(sprintf('../IO/OUT/Intv%s_v%s_reff200_CTr_p8_1_AnnualMDAnewparam_ABRth.mat',char(Sites{iSites}),...
            int2str(i)));
        
        MTP = MBRIntv.*L3Intv;
        ATP = zeros((length(MTP(:,1))-1)/12,length(MTP(1,:)));
        for j = 1:(length(MTP(:,1))-1)/12
            ATP(j,:) = sum(MTP((j-1)*12+1:j*12,:),1);
        end
        
%         subplot(4,1,k+1);
        yyaxis right
        plot(prctile(ATP,97.5,2),'--','Color','r'); %[0.9804    0.3608    0.3608]);
        hold on
        plot(prctile(ATP,2.5,2),'--','Color','r'); %[0.9804    0.3608    0.3608]);
        plot(median(ATP,2),'Color','r','LineWidth',1);
        hold off
        y = gca;
        ymax = y.YLim(2);
        
        [m,n] = size(ATP);
        timeX = [];
        for j = 1:n
            id = find(ATP(1:m,j) < a(iSites,1));
            if isempty(id)
                timeX = [timeX; length(ATP(:,1))];
            else
                timeX = [timeX; (id(1)-1)];
            end
        end
        t1 = prctile(timeX,50);
        CI_ATP=[median(timeX(find(timeX>0))),prctile(timeX(find(timeX>0)),2.5),prctile(timeX(find(timeX>0)),97.5)]

        line([t1 t1],[0 ymax*1.1],'LineStyle','-','Color','r','LineWidth',1);
        set(gca,'YLim',[0 ymax]);
        ylabel('ATP','FontSize',10);
        
        yyaxis left
        semilogy(prctile(mfPrevIntv(1:12:end,:),97.5,2),'--','Color','b'); %[0.6196    0.6196    1.0000]);
        hold on
        semilogy(prctile(mfPrevIntv(1:12:end,:),2.5,2),'--','Color','b'); %[0.6196    0.6196    1.0000]);
        semilogy(median(mfPrevIntv(1:12:end,:),2),'Color','b','LineWidth',1);
        hold off
        %         line([0 600],[EP_Th EP_Th],'LineStyle','--','Color','r');

        MonthsMDA(MonthsMDA==0)=NaN;
        t = nanmedian(MonthsMDA)/12;
        CI_mf=[median(MonthsMDA(find(MonthsMDA>0))),prctile(MonthsMDA(find(MonthsMDA>0)),2.5),prctile(MonthsMDA(find(MonthsMDA>0)),97.5)]/12

        line([t t],[10^-3 10^2],'LineStyle','-','Color','b','LineWidth',1);
%         set(gca,'XLim',[1 t1+2],'YLim',[10^-3 10^2],'YTick',[10^-2,10^0,10^2]);
        set(gca,'XLim',[0.5 t+2],'XTick',[1:2:36],'YLim',[10^-2 10^2],'YTick',[10^-2,10^0,10^2]);
        xlabel('Years','FontSize',10);
        ylabel('Mf prevalence (%)','FontSize',10);
        title(titles{i},'FontSize',10)
    end
    
end

% fig = gcf;
% fig.PaperUnits = 'centimeters';
% % fig.PaperPosition = [0 0 8.7 16];
% fig.PaperPosition = [0 0 8.7 7];
% print('Mf_ATP_Timelines','-dtiff','-r500');