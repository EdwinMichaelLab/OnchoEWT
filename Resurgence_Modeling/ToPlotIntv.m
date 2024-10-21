clear all; clc;
load('../IO/IN/Inter_IN.mat','Sites');

x = csvread('../Analysis/mfBpt_Data.csv');
y = csvread('../Analysis/bRate_Data.csv');
color = colormap(lines);

titles = {'No S&C','S&C Before Peak Biting Season','S&C During Peak Biting Season','S&C Monthly'};
for iSites = 1%1:length(Sites)
    
    % load no VC,     VC = 0
    VCStr = 'noVC';
    EP_Th = x(iSites,2);
    ThStr = num2str(EP_Th);
    IdStr = [ThStr,VCStr];
    
    load(sprintf('../IO/OUT/Intv%s_%s_v4_TBR_AprStart.mat',char(Sites{iSites}),IdStr),...
        'MBRIntv','slash_t');
    subplot(4,1,1);
    plot(median(MBRIntv(1+8:24+8,:),2),'b');
    z = gca;
    ymax = z.YLim(2);
%     set(gca,'XLim',[1 24],'YLim',[0 ymax],'xtick',1:2:24,'xticklabel',...
%          {'Jan','Mar','May','Jul','Sep','Nov',...
%                 'Jan','Mar','May','Jul','Sep','Nov'});
% %                 {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec',...
%                 'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
%                 {'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar','Apr',...
%                 'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar','Apr'});

    ylabel('MBR');
    title(titles{1})
    set(gca,'box','off')
    hold on;
    TBR = y(iSites,2)/12;
    line([1 24],[TBR TBR],'LineStyle','--','Color','k'); % median TBR Masaloa
    
    % load VC scenarios, VC = 1
    VCStr = 'VC';
    EP_Th = x(iSites,1);
    ThStr = num2str(EP_Th);
    IdStr = [ThStr,VCStr];
    j=0;
    for i = [1,2,3]
        j = j+1;
        load(sprintf('../IO/OUT/Intv%s_%s_v%s_TBR_shift6.mat',char(Sites{iSites}),...
            IdStr,int2str(i)),'MBRIntv','slash_t');
        subplot(4,1,j+1);
        plot(median(MBRIntv(1+8:24+8,:),2),'Color','b'); %color(j,:));
        tS = find(slash_t < 25+8);
        for m = 1:length(tS)
            x1 = [slash_t(m)-8 slash_t(m)-8];
            y1 = [0.8*ymax 0.6*ymax];
            %             annotation('arrow',x1,y1);
            line(x1,y1,'Color','r');
        end
%         set(gca,'XLim',[1 24],'YLim',[0 ymax],'xtick',1:2:24,'xticklabel',...
%                      {'Jan','Mar','May','Jul','Sep','Nov',...
%                 'Jan','Mar','May','Jul','Sep','Nov'});
% %                 {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec',...
%                 'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
%                 {'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar','Apr',...
%                 'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar','Apr'});
        ylabel('MBR');
        title(titles{j+1})
        set(gca,'box','off')
        line([1 24],[TBR TBR],'LineStyle','--','Color','k'); % median TBR Masaloa
    end
    xlabel('month');
    
end

fig = gcf;
fig.PaperUnits = 'centimeters';
fig.PaperPosition = [0 0 8.7 16];

% print('S&CSchedules','-dtiff','-r500');