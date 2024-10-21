clear all; clc;

addpath('../CommonFunctions/');
addpath('../BaselineFitting/');
addpath('../IO/OUT/');
addpath('./shadefunction/')
% Load user-editable variables from IO/setup_Vars.m
load('../IO/IN/Baseline_IN.mat');

SiteTitles = {'Palaure Pacunaci','Masaloa','Nyimanji','Olimbuni Aroga'};
alphabet = ('a':'z').';
chars = num2cell(alphabet(1:length(Sites)));
chars = chars.';
charlbl = strcat('(',chars,')'); % {'(a)','(b)','(c)','(d)'}

figure;
for iSite = 1:length(Sites)
    
    load(sprintf('ParamVectors%s.mat',Sites{iSite}));%ParamVectors%s_ABR1.mat-->Originally from morgan had ABR1.mat in the name of file
    
    subplot(2,2,iSite);
    tt=(1:length(mfPrevArray(:,1)))/12;
    %plot((1:length(mfPrevArray(:,1)))/12,100*mfPrevArray,'-','Color',[0.5 0.5 0.5])
    %shade(tt,100*mfPrevArray,tt,100*mfPrevArray,'FillType',[1,2;2,1],'FillColor','g','Color','g');%fill(x2, inBetween, 'g');
    mfmean=mean(mfPrevArray,2);
    sdev=std(mfPrevArray,[],2);
    data95=prctile(mfPrevArray,95,2);
    data05=prctile(mfPrevArray,5,2);
    mx1=max(mfPrevArray,[],2);
    mx2=min(mfPrevArray,[],2);
    shade(tt,100*data05,tt,data95*100,'FillType',[1,2;2,1],'FillColor','blue','Color','blue');%fill(x2, inBetween, 'g');

    text(0.025,0.95,charlbl{iSite},'Units','normalized','FontSize',12);
    hold('on');
    
    %% mf data construction
    MfData0 = eval(sprintf('%sMf',char(Sites{iSite})));
    MidAge = [5 14.5 24.5 34.5 44.5 54.5 64.5];
    OverallMfPrev = MfData0(:,3)/MfData0(:,2);
    TotalMfSamples = MfData0(:,2);
    
    colors = ['b','r'];
    for icurve = 1:2 % loop over two types of age curves
        
        % calculate theoretical age profile data
        MfData = getMfAgeProfile_fromOnchoCurves(TotalMfSamples,icurve,OverallMfPrev,ageMthMax/12,demog,MidAge);
        %         v=genvarname(sprintf('MfData%s',int2str(icurve)));
        %         eval([v '= MfData;']);
        aa = ConstructBinomialErrorBars(MfData);
        errorbar(aa(:,1),aa(:,2),aa(:,3),aa(:,4),'-o','Color',colors(icurve),'LineWidth',0.7,'MarkerFaceColor',colors(icurve),'MarkerSize',3);
    end
    
    if iSite > 2
        xlabel('Age (years)','FontSize',10);
    end
    if iSite == 1 || iSite == 3
        ylabel('Mf Prevalence (%)','FontSize',10);
    end
    set(gca,'YLim',[0 120],'XLim',[0 69],'XTick',[15:20:55],'FontSize',10);
    %title(sprintf('%s',SiteTitles{iSite}),'FontSize',10);
    
end

fig = gcf;
fig.PaperUnits = 'centimeters';
fig.PaperPosition = [0 0 8.7 8];
% print('BaselineFits.tif','-dtiff','-r500');