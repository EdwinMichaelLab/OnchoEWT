clear all;clc;

addpath('../CommonFunctions/');
addpath('../IO/OUT');

Str = {'TBR';'ABR'};
load('../IO/IN/Break_IN.mat');

mfEP_ss = zeros(length(Sites),2);
bRate_ss = zeros(length(Sites),2);
L3EP_ss = zeros(length(Sites),2);
for ivill = 1:length(Sites)
    
    load(sprintf('Bpts_%s_ABR1.mat',char(Sites(ivill))));
    lArray(:,1) = log(lArray(:,1));
    
    for i = 1:length(Str)
        mfEP_ss(ivill,i) = writing_Three_EliminProb_thresholdValues(Str{i},0.95,mfBpt);
        L3EP_ss(ivill,i) = writing_Three_EliminProb_thresholdValues(Str{i},0.95,lArray);
        if strcmp(Str(i),'TBR')
            bRate_ss(ivill,(i-1)+1:i) = prctile(bRate(:,1),5); % TBR
        else
            bRate_ss(ivill,(i-1)+1:i) = prctile(bRate(:,2),5); % ABR
        end
        
    end
    
end

% csvwrite('mfBpt_Data.csv',mfEP_ss);
csvwrite('bRate_Data.csv',bRate_ss);
% csvwrite('L3_Data.csv',L3EP_ss);
