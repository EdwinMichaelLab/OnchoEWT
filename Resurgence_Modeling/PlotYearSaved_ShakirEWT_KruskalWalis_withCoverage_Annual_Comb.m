close all 
clear all; clc;
load('../IO/IN/Inter_IN.mat','Sites');

x = csvread('../Analysis/mfBpt_Data.csv');
a = csvread('../Analysis/ATP_Data.csv');

X=[];
G=[];
X1=[];
G1=[];
%for each site, we will perform the KruskalWalis test

for iSites = 2%:length(Sites)
    
    z_ATP = [];
    z2_ATP = [];
    z3_ATP = [];
    w_ATP = [];
    z_mf = [];
    z2_mf = [];
    z3_mf = [];

    w_mf = [];
    
    y_ATP = [];
    y_mf = [];
    
    % load no VC,     VC = 0
    VCStr = 'noVC';
    EP_Th = x(iSites,2);
    ThStr = num2str(EP_Th);
    IdStr = [ThStr,VCStr];
    i=4;
    load(sprintf('../IO/OUT/Intv%s_v%s_reff200_CTr_p8_1_AnnualMDAnewparam_ABRth.mat',char(Sites{iSites}),...
            int2str(i)));
    
        
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
    y_ATP = [y_ATP,timeX];
    
    y_mf = [y_mf,MonthsMDA/12];
    
    y_mf(isnan(y_mf)) = 1;
     y_mf(find(y_mf==0)) = 1;
    
    % load VC scenarios, VC = 1
    VCStr = 'VC';
    EP_Th = x(iSites,1);
    
    
    ThStr = num2str(EP_Th);
    IdStr = [ThStr,VCStr];
 %   for i = 3;%[1,2,3]
  %i = 1 annually month before peak observed biting (i.e. Apr slash, May peak biting)
            
  %i = 2 every other month during rainy (Apr, Jun, Aug, Oct)
   %i = 3 monthly
   %i=4 no vector control         
        i=1;%v == 1
       load(sprintf('../IO/OUT/Intv%s_v%s_reff200_CTr_p4_p6_AnnualMDAnewparam_ABRth.mat',char(Sites{iSites}),...
            int2str(i)));
       NN1=NN;
       CTr1=CTr;
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
        y_ATP = [y_ATP,timeX];
        y_mf = [y_mf,MonthsMDA/12];
        
         y_mf(isnan(y_mf)) = 1;
     y_mf(find(y_mf==0)) = 1;
     
     
     load(sprintf('../IO/OUT/Intv%s_v%s_reff200_CTr_p6_p8_AnnualMDAnewparam_ABRth.mat',char(Sites{iSites}),...
            int2str(i)));
       NN2=NN;
       CTr2=CTr;
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
        y_ATP = [y_ATP,timeX];
        y_mf = [y_mf,MonthsMDA/12];
        
         y_mf(isnan(y_mf)) = 1;
     y_mf(find(y_mf==0)) = 1;
     
     
      load(sprintf('../IO/OUT/Intv%s_v%s_reff200_CTr_p8_1_AnnualMDAnewparam_ABRth.mat',char(Sites{iSites}),...
            int2str(i)));
       NN3=NN;
       CTr3=CTr;
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
        y_ATP = [y_ATP,timeX];
        y_mf = [y_mf,MonthsMDA/12];
        
         y_mf(isnan(y_mf)) = 1;
     y_mf(find(y_mf==0)) = 1;
    end
    
    z_ATP = [z_ATP;y_ATP(:,1)-y_ATP(:,2)];
    z2_ATP = [z2_ATP,y_ATP(:,1)-y_ATP(:,3)];
    z3_ATP = [z3_ATP,y_ATP(:,1)-y_ATP(:,4)];
    
    z_mf = [z_mf;y_mf(:,1)-y_mf(:,2)];
    z2_mf = [z2_mf;y_mf(:,1)-y_mf(:,3)];
    z3_mf = [z3_mf;y_mf(:,1)-y_mf(:,4)];
    
    z_mf=z_mf(isfinite(z_mf));
    z2_mf=z2_mf(isfinite(z2_mf));
    z3_mf=z3_mf(isfinite(z3_mf));

    CI_ATP=[median(z_ATP(find(z_ATP>0))),prctile(z_ATP(find(z_ATP>0)),2.5),prctile(z_ATP(find(z_ATP>0)),97.5)]

    CI_mf=[median(z_mf(find(z_mf>0))),prctile(z_mf(find(z_mf>0)),2.5),prctile(z_mf(find(z_mf>0)),97.5)]
    CI_CTr=[median(CTr1(find(CTr1>0))),prctile(CTr1(find(CTr>0)),2.5),prctile(CTr1(find(CTr1>0)),97.5)]
        CI_NN=[median(NN1(find(NN1>0))),prctile(NN1(find(NN1>0)),2.5),prctile(NN1(find(NN1>0)),97.5)]


    CI2_ATP=[median(z2_ATP(find(z2_ATP>0))),prctile(z2_ATP(find(z2_ATP>0)),2.5),prctile(z2_ATP(find(z2_ATP>0)),97.5)]

    CI2_mf=[median(z2_mf(find(z2_mf>0))),prctile(z2_mf(find(z2_mf>0)),2.5),prctile(z2_mf(find(z2_mf>0)),97.5)]
    CI2_CTr=[median(CTr2(find(CTr2>0))),prctile(CTr2(find(CTr2>0)),2.5),prctile(CTr2(find(CTr2>0)),97.5)]
        CI2_NN=[median(NN2(find(NN2>0))),prctile(NN2(find(NN2>0)),2.5),prctile(NN2(find(NN2>0)),97.5)]
        

    CI3_ATP=[median(z3_ATP(find(z3_ATP>0))),prctile(z3_ATP(find(z3_ATP>0)),2.5),prctile(z3_ATP(find(z3_ATP>0)),97.5)]

    CI3_mf=[median(z3_mf(find(z3_mf>0))),prctile(z3_mf(find(z3_mf>0)),2.5),prctile(z3_mf(find(z3_mf>0)),97.5)]
    CI3_CTr=[median(CTr3(find(CTr3>0))),prctile(CTr3(find(CTr3>0)),2.5),prctile(CTr3(find(CTr3>0)),97.5)]
        CI3_NN=[median(NN3(find(NN3>0))),prctile(NN3(find(NN3>0)),2.5),prctile(NN3(find(NN3>0)),97.5)]
        

X=[X;z_mf(find(z_mf>0));z2_mf(find(z2_mf>0));z3_mf(find(z3_mf>0))];

X1=[X1;z_ATP(find(z_ATP>0));z2_ATP(find(z2_ATP>0));z3_ATP(find(z3_ATP>0))];

        %X=[X,z_mf(find(z_mf)>0)];
%Y(iSites)=z_mf(find(z_mf)>0);
G=[G;repmat(string(char('Ctr_0.4_0.6')),length(z_mf(find(z_mf>0))),1);repmat(string(char('Ctr_0.6_0.8')),length(z2_mf(find(z2_mf>0))),1);repmat(string(char('Ctr_0.8_1')),length(z3_mf(find(z3_mf>0))),1)];

G1=[G1;repmat(string(char('Ctr_0.4_0.6')),length(z_ATP(find(z_ATP>0))),1);repmat(string(char('Ctr_0.6_0.8')),length(z2_ATP(find(z2_ATP>0))),1);repmat(string(char('Ctr_0.8_1')),length(z3_ATP(find(z3_ATP>0))),1)];

%G=[G,string(char(Sites{iSites}))];
%     z_ATP = [z_ATP;y_ATP(:,1)-y_ATP(:,2:4)];
%     w_ATP = [w_ATP,y_ATP(:,1)-y_ATP(:,2:4)];
%     z_mf = [z_mf;y_mf(:,1)-y_mf(:,2:4)];
%     w_mf = [w_mf,y_mf(:,1)-y_mf(:,2:4)];
    
%end
p1=kruskalwallis(X,G)

p2=kruskalwallis(X1,G1)

close all
subplot(2,2,1)
xx=[0,5,10]%['0.4-0.6','0.6-0.8','0.8-0.9'];
%yy=[median(z_mf(find(z_mf>0))),median(z2_mf(find(z2_mf>0))),median(z3_mf(find(z3_mf>0)))];
yy=[median(z_mf(find(z_mf>0))),median(z_ATP(find(z_ATP>0)));median(z2_mf(find(z2_mf>0))),median(z2_ATP(find(z2_ATP>0)));median(z3_mf(find(z3_mf>0))),median(z3_ATP(find(z3_ATP>0)))];

%P1=bar(xx,yy,BarWidth=0.2)
P1=bar(yy,BarWidth=0.5);

%set(P1,'FaceColor','red');
P1(1).LineWidth = 2;
P1(2).LineWidth = 2;

hold on
% errlow=[prctile(z_mf(find(z_mf>0)),25),prctile(z2_mf(find(z2_mf>0)),25),prctile(z3_mf(find(z3_mf>0)),25)];
% errhigh=[prctile(z_mf(find(z_mf>0)),75),prctile(z2_mf(find(z2_mf>0)),75),prctile(z3_mf(find(z3_mf>0)),75)];
errlow=[prctile(z_mf(find(z_mf>0)),25),prctile(z_ATP(find(z_ATP>0)),25);prctile(z2_mf(find(z2_mf>0)),25),prctile(z2_ATP(find(z2_ATP>0)),25);prctile(z3_mf(find(z3_mf>0)),25),prctile(z3_ATP(find(z3_ATP>0)),25)];
errhigh=[prctile(z_mf(find(z_mf>0)),75),prctile(z_ATP(find(z_ATP>0)),75);prctile(z2_mf(find(z2_mf>0)),75),prctile(z2_ATP(find(z2_ATP>0)),75);prctile(z3_mf(find(z3_mf>0)),75),prctile(z3_ATP(find(z3_ATP>0)),75)];

ngroups = size(yy, 1);
nbars = size(yy, 2);
% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
for i = 1:nbars
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    er=errorbar(x, yy(:,i), errlow(:,i),errhigh(:,i), '.');
er.Color = [0 0 0];                            
er.LineStyle = 'none'; 
er.CapSize=10;
er.LineWidth = 2;
hold on
end
hold off

% er = errorbar(xx,yy,errlow,errhigh);  
% er.Color = [0 0 0];                            
% er.LineStyle = 'none'; 
% er.CapSize=10;
% er.LineWidth = 2;
% 

% hold on
% xx=[2,7,12]%['0.4-0.6','0.6-0.8','0.8-0.9'];
% 
% yy=[median(z_ATP(find(z_ATP>0))),median(z2_ATP(find(z2_ATP>0))),median(z3_ATP(find(z3_ATP>0)))];
% P2=bar(xx,yy,BarWidth=0.2)
% P2.LineWidth = 2;
% 
% set(P2,'FaceColor','yellow');
% hold on
% errlow=[prctile(z_ATP(find(z_ATP>0)),25),prctile(z2_ATP(find(z2_ATP>0)),25),prctile(z3_ATP(find(z3_ATP>0)),25)];
% errhigh=[prctile(z_ATP(find(z_ATP>0)),75),prctile(z2_ATP(find(z2_ATP>0)),75),prctile(z3_ATP(find(z3_ATP>0)),75)];
% er = errorbar(xx,yy',errlow,errhigh);  
% er.Color = [0 0 0];                            
% er.LineStyle = 'none';  
% er.LineWidth = 2;
% er.CapSize=10
% 
ylim([0 40])
xlabel('Coverage range')
ylabel('Years saved to reach MF/ATP threshold')

set(gcf,'Position',[0,0,1000,400])
set(gca, 'XTickLabel',{'Ctr:0.4-0.6','Ctr:0.6-0.8','Ctr:0.8-1'},'Fontsize',18,'LineWidth',3)




hold off
%--Bar graphs in different subplots
% subplot(2,2,1)
% xx=[0,5,10]%['0.4-0.6','0.6-0.8','0.8-0.9'];
% yy=[median(z_ATP(find(z_ATP>0))),median(z2_ATP(find(z2_ATP>0))),median(z3_ATP(find(z3_ATP>0)))];
% p1=bar(xx,yy,BarWidth=0.2)
% p1.LineWidth = 2;
% 
% set(p1,'FaceColor','yellow');
% hold on
% errlow=[prctile(z_ATP(find(z_ATP>0)),25),prctile(z2_ATP(find(z2_ATP>0)),25),prctile(z3_ATP(find(z3_ATP>0)),25)];
% errhigh=[prctile(z_ATP(find(z_ATP>0)),75),prctile(z2_ATP(find(z2_ATP>0)),75),prctile(z3_ATP(find(z3_ATP>0)),75)];
% er = errorbar(xx,yy',errlow,errhigh);  
% er.Color = [0 0 0];                            
% er.LineStyle = 'none';  
% er.LineWidth = 2;
% er.CapSize=10
% 
% ylim([0 40])
% xlabel('Coverage range')
% ylabel('Years saved to reach ATP threshold')
% 
% set(gcf,'Position',[0,0,1000,400])
% set(gca, 'XTickLabel',{'Ctr:0.4-0.6','Ctr:0.6-0.8','Ctr:0.8-1'},'Fontsize',18,'LineWidth',3)
% hold off
% 
% subplot(2,2,3)
% 
% xx=[0,5,10]%['0.4-0.6','0.6-0.8','0.8-0.9'];
% yy=[median(z_mf(find(z_mf>0))),median(z2_mf(find(z2_mf>0))),median(z3_mf(find(z3_mf>0)))];
% p2=bar(xx,yy,BarWidth=0.2)
% set(p2,'FaceColor','yellow');
% p2.LineWidth = 2;
% 
% hold on
% errlow=[prctile(z_mf(find(z_mf>0)),25),prctile(z2_mf(find(z2_mf>0)),25),prctile(z3_mf(find(z3_mf>0)),25)];
% errhigh=[prctile(z_mf(find(z_mf>0)),75),prctile(z2_mf(find(z2_mf>0)),75),prctile(z3_mf(find(z3_mf>0)),75)];
% er = errorbar(xx,yy',errlow,errhigh);  
% er.Color = [0 0 0];                            
% er.LineStyle = 'none'; 
% er.CapSize=10;
% er.LineWidth = 2;
% xlabel('Coverage range')
% ylabel('Years saved to reach MF threshold')
% set(gcf,'Position',[0,0,1000,400])
% set(gca, 'XTickLabel',{'Ctr:0.4-0.6','Ctr:0.6-0.8','Ctr:0.8-1'},'Fontsize',18,'LineWidth',3)
% hold off

% ax2 = subplot(3,1,2);
% boxplot(z_ATP,'Colors','k');
% set(gca,'XTickLabel',{'EWT Before Peak Biting Month','EWT During Peak Biting Season','EWT Monthly'},'FontSize',6);
% % set(gca,'XTickLabel',{'S&C A','S&C B','S&C C'},'FontSize',6);
% set(gca,'ylim',[-1 40]);
% ylabel('Years Saved','FontSize',10);
% hOut=findobj(gca,'tag','Outliers'); delete(hOut);
% h1 = findobj(gca,'Tag','Box');
% color = ['b','r','g'];
% for j=1:length(h1)
%     p = patch(get(h1(j),'XData'),get(h1(j),'YData'),color(j),'FaceAlpha',0.2,'EdgeColor',color(j)); 
% end
% title({'b. Years of Interventions Saved (ATP threshold)',''},'FontSize',10);
% fix_xticklabels();
% 
% % pos = get(gca,'Position');
% % set(gca, 'Position', [pos(1) pos(2)+0.06 pos(3) pos(4)-0.06]);
% 
% ax3 = subplot(3,1,3);
% boxplot(z_mf,'Colors','k');
% set(gca,'XTickLabel',{'EWT Before Peak Biting Month','EWT During Peak Biting Season','EWT Monthly'},'FontSize',6);
% % set(gca,'XTickLabel',{'S&C A','S&C B','S&C C'},'FontSize',6);
% set(gca,'ylim',[-1 40]);
% ylabel('Years Saved','FontSize',10);
% hOut=findobj(gca,'tag','Outliers'); delete(hOut);
% h1 = findobj(gca,'Tag','Box');
% color = ['b','r','g'];
% for j=1:length(h1)
%     p = patch(get(h1(j),'XData'),get(h1(j),'YData'),color(j),'FaceAlpha',0.2,'EdgeColor',color(j)); 
% end
% fix_xticklabels();
% title({'c. Years of Interventions Saved (mf threshold)',''},'FontSize',10);
% 
% % fig = gcf;
% % fig.PaperUnits = 'centimeters';
% % fig.PaperPosition = [0 0 8.7 16];
% 
% % pos = get(gca,'Position');
% % set(gca, 'Position', [pos(1) pos(2)+0.06 pos(3) pos(4)-0.06]);
% % print('YearsSaved.tif','-dtiff','-r500');
