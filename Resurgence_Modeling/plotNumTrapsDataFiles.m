clc;
clear;
close all;

sl=[1,2,5,8];

nIDs = 4;
alphabet = ('a':'z').';
chars = num2cell(alphabet(1:nIDs));
chars = chars.';
charlbl = strcat('(',chars,')'); % {'(a)','(b)','(c)','(d)'}
text(0.025,0.95,charlbl{1},'Units','normalized','FontSize',25)
for i=1:2

str1="numTraps_vs_Cr_vs_Ad_A_"+string(sl(i))+"kmsq_reff_200";

load(str1+".dat")
x=load(str1+".dat");
x1=x(:,2);
y1=x(:,3);
z1=x(:,5);
xx=linspace(min(x1),max(x1),1000);
yy=linspace(min(y1),max(y1),1000);
[XX,YY]=meshgrid(xx,yy);
F = scatteredInterpolant(x1, y1, z1,'linear','none');
Z=F(XX,YY);
if i==1
v=ceil(min(x(:,5))):1:ceil(max(x(:,5)));
else
    v=ceil(min(x(:,5))):5:ceil(max(x(:,5)));

end

nexttile
hAx=gca;                    % create an axes

[C,h]=contour(XX,YY,Z,v);
clabel(C,h,v)
hAx.LineWidth=2;            % set the axis linewidth for box/ticks

text(0.025,0.95,charlbl{i},'Units','normalized','FontSize',12)

xlim([0,1])
xlabel('C_r','FontSize',18)
ylabel('A_{\Delta}/A','FontSize',18)
set(gca,'fontsize',18)
end

for i=3:4

str1="numTraps_vs_A_vs_Ad_Cr_p"+string(sl(i))+"_reff_200";

load(str1+".dat")
x=load(str1+".dat");
x1=x(:,2);
y1=x(:,3);
z1=x(:,5);
xx=linspace(min(x1),max(x1),1000);
yy=linspace(min(y1),max(y1),1000);
[XX,YY]=meshgrid(xx,yy);
F = scatteredInterpolant(x1, y1, z1,'linear','none');
Z=F(XX,YY);
v=ceil(min(x(:,5))):2:ceil(max(x(:,5)));


nexttile
hAx=gca;                    % create an axes

[C,h]=contour(XX,YY,Z,v);
clabel(C,h,v)
hAx.LineWidth=2;            % set the axis linewidth for box/ticks

text(0.025,0.95,charlbl{i},'Units','normalized','FontSize',12)

%xlim([0,1])
xlabel('A','FontSize',18)
ylabel('A_{\Delta}/A','FontSize',18)
set(gca,'fontsize',18)
end
