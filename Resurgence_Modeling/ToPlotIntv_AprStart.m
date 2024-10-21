clear all; clc;
load('../IO/IN/Inter_IN.mat','Sites');

x = csvread('../Analysis/mfBpt_Data.csv');
y = csvread('../Analysis/bRate_Data.csv');
color = colormap(lines);

titles = {'No S&C','S&C Before Peak Biting Season','S&C During Peak Biting Season','S&C Monthly'};
for iSites = 2%1:length(Sites)
    
    % load no VC,     VC = 0
    VCStr = 'noVC';
    EP_Th = x(iSites,2);
    ThStr = num2str(EP_Th);
    IdStr = [ThStr,VCStr];
    
    load(sprintf('../IO/OUT/Intv%s_%s_v4_TBR_AprStart.mat',char(Sites{iSites}),IdStr),...
        'MBRIntv','slash_t');
    subplot(4,1,1);
    plot(median(MBRIntv(1:24,:),2),'b');
    z = gca;
    ymax = z.YLim(2);
%      set(gca,'XLim',[1 24],'YLim',[0 ymax],'xtick',1:2:24,'FontSize',10);
    set(gca,'XLim',[1 24],'YLim',[0 ymax],'xtick',1:2:24,'xticklabel',...
        {'Apr','Jun','Aug','Oct','Dec','Feb',...
        'Apr','Jun','Aug','Oct','Dec','Feb'},'FontSize',10);
    % %                 {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec',...
    %                 'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
    %                 {'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar','Apr',...
    %                 'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar','Apr'});
    xtickangle(45);
    ylabel('MBR','FontSize',10);
    title(titles{1},'FontSize',10)
    set(gca,'box','off')
    hold on;
    TBR = y(iSites,2)/12;
    line([1 24],[TBR TBR],'LineStyle','--','Color','k'); % median TBR Masaloa
    set(gca,'XLim',[0.5 24]);
    
    % load VC scenarios, VC = 1
    VCStr = 'VC';
    EP_Th = x(iSites,1);
    ThStr = num2str(EP_Th);
    IdStr = [ThStr,VCStr];
    j=0;
    for i = [1,2,3]
        j = j+1;
        load(sprintf('../IO/OUT/Intv%s_%s_v%s_TBR_AprStart.mat',char(Sites{iSites}),...
            IdStr,int2str(i)),'MBRIntv','slash_t');
        subplot(4,1,j+1);
        plot(median(MBRIntv(1:24,:),2),'Color','b'); %color(j,:));
        tS = find(slash_t < 25);
        for m = 1:length(tS)
            x1 = [slash_t(m) slash_t(m)];
            y1 = [0.8*ymax 0.7*ymax];
            %             annotation('arrow',x1,y1);
            line(x1,y1,'Color','r','LineWidth',1.4);
        end
        set(gca,'XLim',[1 24],'YLim',[0 ymax],'xtick',1:2:24,'xticklabel',...
            {'Apr','Jun','Aug','Oct','Dec','Feb',...
            'Apr','Jun','Aug','Oct','Dec','Feb'},'FontSize',10);
        % %                 {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec',...
        %                 'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
        %                 {'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar','Apr',...
        %                 'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar','Apr'});
        xtickangle(45);
        ylabel('MBR','FontSize',10);
        title(titles{j+1},'FontSize',10)
        set(gca,'box','off')
        line([1 24],[TBR TBR],'LineStyle','--','Color','k'); % median TBR Masaloa
        set(gca,'XLim',[0.5 24]);
    end
    xlabel('Month','FontSize',10);
    
end

fig = gcf;
fig.PaperUnits = 'centimeters';
fig.PaperPosition = [0 0 8.7 16];

% print('S&CSchedules','-dtiff','-r500');