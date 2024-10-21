  clear all;
load('../IO/IN/Inter_IN.mat','Sites');
figure;
etastr='p9to1';
CTrstr1="p5_p6";
CTrstr2="p9_1";
mdastr="biAnnual";
filename="Impactof_EWTnewparameters_ABRThIntervention_CTr_"+CTrstr1+"_"+CTrstr2+"_"+mdastr+"_Jan2024.png";
customPosition = [0 0 .6 .7];
set(gcf, 'units', 'normalized', 'outerposition', customPosition);
savePath = '../PlotShakirnew/AnnualMDA/'+filename; % Update this path
x = csvread('../Analysis/mfBpt_Data.csv');
y = csvread('../Analysis/bRate_Data.csv');


color = colormap(lines);

nIDs = 4;
alphabet = ('a':'z').';
chars = num2cell(alphabet(1:nIDs));
chars = chars.';
charlbl = strcat('(',chars,')'); % {'(a)','(b)','(c)','(d)'}

titles = {'No EWT','EWT Before Peak Biting Season','EWT During Peak Biting Season','EWT Monthly'};
for iSites = 2%1:length(Sites)
    
    % load no VC,     VC = 0
    VCStr = 'noVC';
    EP_Th = x(iSites,2);
    ThStr = num2str(EP_Th);
    IdStr = [ThStr,VCStr];
    i=4;
%     load(sprintf('../IO/OUT/Intv%s_v%s_reff200_CTr_p8_1_AnnualMDA_oldtest.mat',char(Sites{iSites}),int2str(i)),...
%         'MBRIntv','slash_t');
    load(sprintf('../IO/OUT/reff100/Intv%s_v%s_reff100_CTr_%s_%sMDAnewparam_ABRth_newtest_eta_%s.mat',char(Sites{iSites}),...
          int2str(i),CTrstr2,mdastr,etastr));
%     load(sprintf('../IO/OUT/Intv%s_v%s_reff200_CTr_p8_1_biAnnualMDAnewparam_ABRth.mat',char(Sites{iSites}),...
%           int2str(i)));
   
      MBR = MBRIntv;
        ABRIntv1 = zeros((length(MBR(:,1))-1)/12,length(MBR(1,:)));
        for j = 1:(length(MBR(:,1))-1)/12
            ABRIntv1(j,:) = sum(MBR((j-1)*12+1:j*12,:),1);
        end
    subplot(4,2,1);
    

   plot(prctile(MBRIntv(1:30,:)~=0,2.5,2),'--','Color','b')
   text(0.025,0.95,charlbl{1},'Units','normalized','FontSize',25)%puts sub figure labels i.e. a,b,c,d,e

    %hold on
    %plot(prctile(MBRIntv(1:30,:),97.5,2),'--','Color','b')
    hold on
    plot(median(MBRIntv(1:30,:),2),'b');
    
    hold off
    z = gca;
    ymax = z.YLim(2);

%      set(gca,'XLim',[1 24],'YLim',[0 ymax],'xtick',1:2:24,'FontSize',10);
    set(gca,'XLim',[1 24],'YLim',[0 ymax],'xtick',1:2:24,'xticklabel',...
        {'Apr','Jun','Aug','Oct','Dec','Feb',...
        'Apr','Jun','Aug','Oct','Dec','Feb'},'FontSize',18);
    % %                 {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec',...
    %                 'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
    %                 {'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar','Apr',...
    %                 'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar','Apr'});
    xtickangle(45);
    ylabel('MBR','FontSize',18);
    title(titles{1},'FontSize',10)
    set(gca,'box','off')
    hold on;
    TBR = y(iSites,2)/12;
    line([1 24],[TBR TBR],'LineStyle','--','Color','k'); % median TBR Masaloa
    set(gca,'XLim',[0.5 24]);
    z.LineWidth=2;            % set the axis linewidth for box/ticks

    % load VC scenarios, VC = 1
    VCStr = 'VC';
    EP_Th = x(iSites,1);
    ThStr = num2str(EP_Th);
    IdStr = [ThStr,VCStr];
    j=1;
    j1=0;
    for i = [1,2,3]
        j = j+2;
        j1=j1+1;
        load(sprintf('../IO/OUT/reff100/Intv%s_v%s_reff100_CTr_%s_%sMDAnewparam_ABRth_newtest_eta_%s.mat',char(Sites{iSites}),...
            int2str(i),CTrstr1,mdastr,etastr),'MBRIntv','slash_t');
%         load(sprintf('../IO/OUT/Intv%s_v%s_reff200_CTr_p4_p6_biAnnualMDAnewparam_ABRth.mat',char(Sites{iSites}),...
%             int2str(i)),'MBRIntv','slash_t');
%         %'../IO/OUT/Intv%s_v%s_reff200_CTr_p8_1_biAnnualMDAnewparam_ABRth.mat'
        MBR = MBRIntv;
        ABRIntv = zeros((length(MBR(:,1))-1)/12,length(MBR(1,:)));
        for jj = 1:(length(MBR(:,1))-1)/12
            ABRIntv(jj,:) = sum(MBR((jj-1)*12+1:jj*12,:),1);
        end
        subplot(4,2,j);
    plot(prctile(MBRIntv(1:30,:)~=0,2.5,2),'--','Color','b')
    hold on
   %plot(prctile(MBRIntv(1:30,:),97.5,2),'--','Color','b')
    hold on
    plot(median(MBRIntv(1:30,:),2),'b');        tS = find(slash_t < 25);
        for m = 1:length(tS)
            x1 = [slash_t(m) slash_t(m)];
            y1 = [0.8*ymax 0.7*ymax];
            %             annotation('arrow',x1,y1);
            line(x1,y1,'Color','r','LineWidth',1.4);
        end
        z = gca;

        set(gca,'XLim',[1 48],'YLim',[0 ymax],'xtick',1:2:24,'xticklabel',...
            {'Apr','Jun','Aug','Oct','Dec','Feb',...
            'Apr','Jun','Aug','Oct','Dec','Feb'},'FontSize',18);
        % %                 {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec',...
        %                 'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
        %                 {'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar','Apr',...
        %                 'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar','Apr'});
        xtickangle(45);
        ylabel('MBR','FontSize',18);
        title(titles{j1+1},'FontSize',10)
        set(gca,'box','off')
        line([1 24],[TBR TBR],'LineStyle','--','Color','k'); % median TBR Masaloa
        set(gca,'XLim',[0.5 24]);
    z.LineWidth=2;            % set the axis linewidth for box/ticks

    end
    xlabel('Month','FontSize',18);


    %%%-----------------------------------------------------------------------
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      VCStr = 'noVC';
    EP_Th = x(iSites,2);
    ThStr = num2str(EP_Th);
    IdStr = [ThStr,VCStr];
    i=4;
%     load(sprintf('../IO/OUT/Intv%s_v%s_reff200_CTr_p8_1_AnnualMDA_oldtest.mat',char(Sites{iSites}),int2str(i)),...
%         'MBRIntv','slash_t');
    load(sprintf('../IO/OUT/reff100/Intv%s_v%s_reff100_CTr_%s_%sMDAnewparam_ABRth_newtest_eta_%s.mat',char(Sites{iSites}),...
          int2str(i),CTrstr1,mdastr,etastr));
%     load(sprintf('../IO/OUT/Intv%s_v%s_reff200_CTr_p8_1_biAnnualMDAnewparam_ABRth.mat',char(Sites{iSites}),...
%           int2str(i)));
   
      MBR = MBRIntv;
        ABRIntv1 = zeros((length(MBR(:,1))-1)/12,length(MBR(1,:)));
        for j = 1:(length(MBR(:,1))-1)/12
            ABRIntv1(j,:) = sum(MBR((j-1)*12+1:j*12,:),1);
        end
    subplot(4,2,2);
    

   plot(prctile(MBRIntv(1:30,:)~=0,2.5,2),'--','Color','b')
   text(0.025,0.95,charlbl{2},'Units','normalized','FontSize',25)%puts sub figure labels i.e. a,b,c,d,e

    %hold on
    %plot(prctile(MBRIntv(1:30,:),97.5,2),'--','Color','b')
    hold on
    plot(median(MBRIntv(1:30,:),2),'b');
    
    hold off
    z = gca;
    ymax = z.YLim(2);

%      set(gca,'XLim',[1 24],'YLim',[0 ymax],'xtick',1:2:24,'FontSize',10);
    set(gca,'XLim',[1 24],'YLim',[0 ymax],'xtick',1:2:24,'xticklabel',...
        {'Apr','Jun','Aug','Oct','Dec','Feb',...
        'Apr','Jun','Aug','Oct','Dec','Feb'},'FontSize',18);
    % %                 {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec',...
    %                 'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
    %                 {'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar','Apr',...
    %                 'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar','Apr'});
    xtickangle(45);
    ylabel('MBR','FontSize',18);
    title(titles{1},'FontSize',10)
    set(gca,'box','off')
    hold on;
    TBR = y(iSites,2)/12;
    line([1 24],[TBR TBR],'LineStyle','--','Color','k'); % median TBR Masaloa
    set(gca,'XLim',[0.5 24]);
    z.LineWidth=2;            % set the axis linewidth for box/ticks

    % load VC scenarios, VC = 1
    VCStr = 'VC';
    EP_Th = x(iSites,1);
    ThStr = num2str(EP_Th);
    IdStr = [ThStr,VCStr];
    j=2;
    j1=0;

    for i = [1,2,3]
        j = j+2;
        j1=j1+1;
        load(sprintf('../IO/OUT/reff100/Intv%s_v%s_reff100_CTr_p9_1_AnnualMDAnewparam_ABRth_newtest_eta_%s.mat',char(Sites{iSites}),...
            int2str(i),etastr),'MBRIntv','slash_t');
%         load(sprintf('../IO/OUT/Intv%s_v%s_reff200_CTr_p4_p6_biAnnualMDAnewparam_ABRth.mat',char(Sites{iSites}),...
%             int2str(i)),'MBRIntv','slash_t');
%         %'../IO/OUT/Intv%s_v%s_reff200_CTr_p8_1_biAnnualMDAnewparam_ABRth.mat'
        MBR = MBRIntv;
        ABRIntv = zeros((length(MBR(:,1))-1)/12,length(MBR(1,:)));
        for jj = 1:(length(MBR(:,1))-1)/12
            ABRIntv(jj,:) = sum(MBR((jj-1)*12+1:jj*12,:),1);
        end
        subplot(4,2,j);
    plot(prctile(MBRIntv(1:30,:)~=0,2.5,2),'--','Color','b')
    hold on
   %plot(prctile(MBRIntv(1:30,:),97.5,2),'--','Color','b')
    hold on
    plot(median(MBRIntv(1:30,:),2),'b');        tS = find(slash_t < 25);
        for m = 1:length(tS)
            x1 = [slash_t(m) slash_t(m)];
            y1 = [0.8*ymax 0.7*ymax];
            %             annotation('arrow',x1,y1);
            line(x1,y1,'Color','r','LineWidth',1.4);
        end
        z = gca;

        set(gca,'XLim',[1 48],'YLim',[0 ymax],'xtick',1:2:24,'xticklabel',...
            {'Apr','Jun','Aug','Oct','Dec','Feb',...
            'Apr','Jun','Aug','Oct','Dec','Feb'},'FontSize',18);
        % %                 {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec',...
        %                 'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
        %                 {'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar','Apr',...
        %                 'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar','Apr'});
        xtickangle(45);
        ylabel('MBR','FontSize',18);
        title(titles{j1+1},'FontSize',10)
        set(gca,'box','off')
        line([1 24],[TBR TBR],'LineStyle','--','Color','k'); % median TBR Masaloa
        set(gca,'XLim',[0.5 24]);
    z.LineWidth=2;            % set the axis linewidth for box/ticks

    end
    xlabel('Month','FontSize',18);
    
end

fig = gcf;
fig.PaperUnits = 'centimeters';
fig.PaperPosition = [0 0 8.7 16];


fig.PaperPositionMode = 'auto'; % Set the paper position mode to auto
print(fig, savePath, '-dpng', '-r0');
% Close the figure if not needed anymore
% close(fig);



% print('S&CSchedules','-dtiff','-r500');