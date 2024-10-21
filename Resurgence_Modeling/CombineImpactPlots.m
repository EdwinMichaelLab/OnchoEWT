
ax1 = subplot(3,1,1);
ToPlotIntvMf_ATP_Timelines;
title({'a. Impact of Monthly S&C on Mf and ATP',''},'FontSize',10);
% pos = get(gca,'Position');
% set(gca, 'Position', [pos(1) pos(2)+0.06 pos(3) pos(4)-0.06]);

PlotYearsSaved;

% position: left, bottom, width, height
ax1.Position(1) = ax1.Position(1)+0.03;
ax1.Position(3) = ax1.Position(3)-0.1;
ax1.Position(4) = ax2.Position(4);

ax2.Position(2) = ax2.Position(2)+0.065;

ax3.Position(4) = ax2.Position(4);


fig = gcf;
fig.PaperUnits = 'centimeters';
fig.PaperPosition = [0 0 8.7 18];

print('S&CImpact_Combined','-dtiff','-r500');