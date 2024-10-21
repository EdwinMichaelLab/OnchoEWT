clear all; clc;
load('../IO/IN/Inter_IN.mat','Sites');

x = csvread('../Analysis/mfBpt_Data.csv');

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
    
    load(sprintf('../IO/OUT/Intv%s_%s_v4_TBR_AprStart.mat',char(Sites{iSites}),IdStr),...
        'MonthsMDA','mfPrevIntv');
    
        y = [y,MonthsMDA];
%     [m,n] = size(mfPrevIntv);
%     timeX = [];
%     for k = 1:n
%         id = find(mfPrevIntv(1:12:m,k) < 1);
%         if isempty(id)
%             timeX = [timeX; length(mfPrevIntv(:,1))/12];
%         else
%             timeX = [timeX; (id(1)-1)];
%         end
%     end
%     
%     timeX(find(timeX==0)) = 1;
%     y = [y,timeX];
    
    % load VC scenarios, VC = 1
    VCStr = 'VC';
    EP_Th = x(iSites,1);
    
    
    ThStr = num2str(EP_Th);
    IdStr = [ThStr,VCStr];
    for i = [1,2,3]
        load(sprintf('../IO/OUT/Intv%s_%s_v%s_TBR_AprStart.mat',char(Sites{iSites}),...
            IdStr,int2str(i)),'MonthsMDA','mfPrevIntv');
        
                y = [y,MonthsMDA];  
%         [m,n] = size(mfPrevIntv);
%         timeX = [];
%         for k = 1:n
%             id = find(mfPrevIntv(1:12:m,k) < 1);
%             if isempty(id)
%                 timeX = [timeX; length(mfPrevIntv(:,1))/12];
%             else
%                 timeX = [timeX; (id(1)-1)];
%             end
%         end
%         
%         timeX(find(timeX==0)) = 1;
%         y = [y,timeX];
    end
    
    y = y/12;
    for z = 1:length(y(1,:))
        id = find(y(:,z)==0);
        y(id,z)=NaN;
    end
    n1(iSites,:) = prctile(y,2.5);
    n2(iSites,:) = nanmedian(y,1);
    n3(iSites,:) = prctile(y,97.5);
    n4(iSites,2:4) = nanmedian(y(:,1)-y(:,2:4));
    
    kruskalwallis(y)
   
end