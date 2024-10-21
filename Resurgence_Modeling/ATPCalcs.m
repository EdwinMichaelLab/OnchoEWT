clear all; clc;
load('../IO/IN/Inter_IN.mat','Sites');

x = csvread('../Analysis/mfBpt_Data.csv');
y = csvread('../Analysis/L3_Data.csv');
color = colormap(lines);
titles = {'No S&C','S&C Before Known Peak','S&C During Peak Interval','Intermittent S&C','S&C Monthly'};

for iSites = 1%:length(Sites)
    
    % load no VC,     VC = 0
    VCStr = 'noVC';
    mf_Th = x(iSites,2);
    L3_Th = y(iSites,2);
    ThStr = num2str(mf_Th);
    IdStr = [ThStr,VCStr];
    load(sprintf('../IO/OUT/Intv%s_%s_TBR.mat',char(Sites{iSites}),IdStr));
    
    MTP = MBRIntv.*L3Intv;
    ATP = zeros((length(MTP(:,1))-1)/12,length(MTP(1,:)));
    for j = 1:(length(MTP(:,1))-1)/12
        ATP(j,:) = sum(MTP((j-1)*12+1:j*12,:),1);
    end
    
    subplot(5,1,1);
    plot(ATP,'Color',[0.7 0.7 0.7]);
    hold on;
%     line([0 25],[20 20],'Color','r');
    
    [m,n] = size(ATP);
    timeX = [];
    for i = 1:n
        id = find(ATP(1:m,i) < 20);
        if isempty(id)
            timeX = [timeX; length(ATP(:,1))];
        else
            timeX = [timeX; (id(1)-1)];
        end
    end
    t = prctile(timeX,95);
    line([t t],[0 4000],'Color','r');
    
    set(gca,'YLim',[0 4000],'XLim',[1 15]);
    xlabel('years');
    ylabel('ATP');
    title(titles{1})
    
    % load VC scenarios, VC = 1
    VCStr = 'VC';
    mf_Th = x(iSites,1);
    ThStr = num2str(mf_Th);
    IdStr = [ThStr,VCStr];
    k = 0;
    for i = [1,2,6,3]
        k = k+1;
        load(sprintf('../IO/OUT/Intv%s_%s_v%s_TBR.mat',char(Sites{iSites}),...
            IdStr,int2str(i)));
        
        MTP = MBRIntv.*L3Intv;
        ATP = zeros((length(MTP(:,1))-1)/12,length(MTP(1,:)));
        for j = 1:(length(MTP(:,1))-1)/12
            ATP(j,:) = sum(MTP((j-1)*12+1:j*12,:),1);
        end
        
        subplot(5,1,k+1);
        plot(ATP,'Color',[0.7 0.7 0.7]);
        hold on;
%         line([0 25],[20 20],'Color','r');
        
        [m,n] = size(ATP);
        timeX = [];
        for i = 1:n
            id = find(ATP(1:m,i) < 20);
            if isempty(id)
                timeX = [timeX; length(ATP(:,1))];
            else
                timeX = [timeX; (id(1)-1)];
            end
        end
        t = prctile(timeX,95);
        line([t t],[0 4000],'Color','r');
        
        set(gca,'YLim',[0 4000],'XLim',[1 15]);
        xlabel('years');
        ylabel('ATP');
        title(titles{k+1})
    end
    
end

print('ATPTimelines','-dpng','-r500');