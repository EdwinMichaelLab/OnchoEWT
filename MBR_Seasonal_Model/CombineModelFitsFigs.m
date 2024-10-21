figure;

subplot(1,3,1);
FitMBRWeibull_BM;
title('a.');

PlotMBRFits;

subplot(1,3,2);
title('b.');
ylabel('');
set(gca,'xticklabel',{'May','','Jul','','Sep','','Nov','','Jan','','Mar'},'FontSize',10);

subplot(1,3,3);
title('c.');
ylabel('');
set(gca,'xticklabel',{'May','','Jul','','Sep','','Nov','','Jan','','Mar'},'FontSize',10);

subplot(1,3,1);
set(gca,'YLim',[0 1.1*max(max(MBR_0))],'FontSize',10);

fig = gcf;
fig.PaperUnits = 'centimeters';
fig.PaperPosition = [0 0 17.8 6];
print('MBR_Rain_ModelFits_Combined','-dtiff','-r500');