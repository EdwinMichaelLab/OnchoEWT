clear all;clc;

addpath('../CommonFunctions/');
addpath('../IO/OUT');

Str = {'TBR';'ABR'};
load('../IO/IN/Break_IN.mat');

ATP_Th = zeros(length(Sites),2);
for ivill = 1:length(Sites)
    
    load(sprintf('Bpts_%s_ABR1.mat',char(Sites(ivill))));
    lArray(:,1) = log(lArray(:,1));
    
    ATP = bRate.*lArray*12;
    ATP_Th(ivill,:) = prctile(ATP,5);
   
end

csvwrite('ATP_Data.csv',ATP_Th);
