data = xlsread('RainfallJacob2018.xlsx');

%% data
% figure;
month = 1:12; %data(:,1);
rainfall = data(:,2); %[data(:,2);data(:,2)];
% plot(month,rainfall,'bx');
% xlabel('month');
% ylabel('rainfall (mm)');

%% cftool
% cftool
% a = 220.5;
% b = 0.8938;
% c = 8.425;
% d = -15.29;
% 
% t = 1:36; % months
% R = a*(1+b*cos((-(2*pi*t)/c)+d));
% plot(t,R);
% hold on;
% plot(m,R0,'rx');

%% fitnlm
a = 1:12; % months
T = data(:,2); % rainfall
F=@(b,data) b(1)*(1+b(2)*cos(2*pi/b(3)*data+b(4))); % the fitting function
b0=[T(1),1,1,0]; % initial guess for the fit

opts = statset('maxIter',500,'TolFun',1e-6); % controlling the fit options
mdl=fitnlm(a,T,F,b0,'Options',opts); % doing the fit
coeff=mdl.Coefficients.Estimate; % the fit coefficients (b)
rsq = mdl.Rsquared.Ordinary;

figure;
plot(a,T,'ro','MarkerFaceColor','r'); hold on % lets see how we did...
plot(a,F(coeff,a),'-k'); 
xlabel('month');
ylabel('rainfall (mm)');
% text(8,500,sprintf('R^{2} = %.4f',rsq));
set(gca,'YLim',[0 600],'XLim',[1 12],'xtick',[1:12],...
    'xticklabel',{'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar','Apr'});
print('RainfallFunFit','-dpng','-r500');


% project for several years
% a1 = 1:36;
% b = coeff;
% for i = a1
%     m = mod(i,12);
%     if m == 0
%         m = 12;
%     end
%     R(i) = b(1)*(1+b(2)*cos(2*pi/b(3)*m+b(4)));
% end
% 
% figure;
% plot(a1,repmat(T,3,1),'--ro','MarkerFaceColor','r'); 
% hold on;
% plot(a1,R,'b-');
% xlabel('month');
% ylabel('rainfall (mm)');
% 
% % plot cos function
% figure;
% x = 1:12;
% y = cos(2*pi/b(3)*x+b(4));
% plot(x,y);

%% manual calculation of params
% figure;
% r0 = 250;
% r1 = -250;
% c = 2*pi/8;
% t = 0:11;
% r = r0+r1*cos(c*t);
% plot(m-1,r,'-');
% hold on;
% plot(t,T,'rx');
% xlabel('month');
% ylabel('rainfall (mm)');