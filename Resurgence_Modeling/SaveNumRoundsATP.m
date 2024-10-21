clear all; clc;
load('../IO/IN/Inter_IN.mat','Sites');

x = csvread('../Analysis/mfBpt_Data.csv');
a = csvread('../Analysis/ATP_Data.csv');

n1 = zeros(length(Sites),4);
n2 = zeros(length(Sites),4);
n3 = zeros(length(Sites),4);
n4 = zeros(length(Sites),4);

for iSites = 1:length(Sites)
    
    y = [];
    
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
    y = [y,timeX];
    
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
        y = [y,timeX];
    end
    
    n1(iSites,:) = prctile(y,5);
    n2(iSites,:) = median(y,1);
    n3(iSites,:) = prctile(y,95);
    n4(iSites,2:4) = nanmedian(y(:,1)-y(:,2:4));
    
    kruskalwallis(y)
    
end