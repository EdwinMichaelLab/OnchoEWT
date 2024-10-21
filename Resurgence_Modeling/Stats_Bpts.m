clear all; clc;

addpath('../IO/OUT/');

load('../IO/IN/Baseline_IN.mat');
villageName = Sites;

% bpts/TBRs by focus/village

SSbpt = [];
SSTBR = [];
SSABR = [];
vill = [];

for ivill = 1:length(villageName) 
    load(sprintf('Bpts_%s_ABR1.mat',char(villageName(ivill))));
    SSbpt = [SSbpt;mfBpt];
    SSTBR = [SSTBR;bRate(:,1)];    
    vill = [vill;repmat(ivill,length(mfBpt(:,1)),1)];
end

% breakpoints at TBR
id2 = find(SSbpt(:,1)<10 & SSbpt(:,1)>0);
p1 = kruskalwallis(SSbpt(id2,1),vill(id2)); % site-specific TBR bpts ~ village

% breakpoints at ABR
id4 = find(SSbpt(:,2)<5 & SSbpt(:,2)>0);
p2 = kruskalwallis(SSbpt(id4,2),vill(id4)); % site-specific ABR bpts ~ village

% TBR values
p3 = kruskalwallis(SSTBR(id2),vill(id2)); % site-specific TBR ~ village

% ABR values
p4 = zeros(length(villageName),1);
p5 = zeros(length(villageName),1);
for ivill = 1:length(villageName)
      
    load(sprintf('Bpts_%s_ABR1.mat',char(villageName(ivill))));
    p4(ivill) = kruskalwallis([bRate(:,1),bRate(:,2)]); % site-specific TBR vs ABR
    p5(ivill) = kruskalwallis([mfBpt(:,1),mfBpt(:,2)]); % site-specific TBR vs ABR

end
