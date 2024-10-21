clc;
clear;
close all;
ll=2000;
A=ll*ll;
reff=200;
Cr=0.9;

str1="numTraps_vs_A_vs_Ad_Cr_p9_reff_200";
fp=fopen(str1+".dat",'w');


for ll=1000:100:3000
    for n=0:0.01:1
        A=ll*ll;

         Ac=A*Cr;
         NN=Ac/(pi*reff*reff);
         dd=(sqrt(A)-2*reff)./(sqrt(NN)-1);
    
    fd=(sqrt(A)-2*reff)/dd +1;
    NN=Cr*A/(pi*reff*reff);%pow(fd,2);
    NN1=power(fd,2);
    Ad=n*A;
    Neff=Cr*(A-Ad)/(pi*reff*reff);%NN*(A-Ad)/A;
    Neff1=NN1*(A-Ad)/A;
    fprintf(fp,'%f %f %f %f %f %f %f %f\n',dd,A,n,Ad,Neff,Neff1,NN,NN1);
    end
    fprintf(fp,'\n');
end

fclose(fp);

% clc;
% clear;
% close all;
% ll=2000;
% A=ll*ll;
% reff=200;
% 
% str1="numTraps_vs_Cr_vs_Ad_A_2kmsq_reff_200";
% fp=fopen(str1+".dat",'w');
% 
% for Cr=.1:0.1:1
%     for n=0:0.01:1
%          Ac=A*Cr;
%          NN=Ac/(pi*reff*reff);
%          dd=(sqrt(A)-2*reff)./(sqrt(NN)-1);
%     
%     fd=(sqrt(A)-2*reff)/dd +1;
%     NN=Cr*A/(pi*reff*reff);%pow(fd,2);
%     NN1=power(fd,2);
%     Ad=n*A;
%     Neff=Cr*(A-Ad)/(pi*reff*reff);%NN*(A-Ad)/A;
%     Neff1=NN1*(A-Ad)/A;
%     fprintf(fp,'%f %f %f %f %f %f %f %f\n',dd,Cr,n,Ad,Neff,Neff1,NN,NN1);
%     end
%     fprintf(fp,'\n');
% end
% 
% fclose(fp);

% load(str1+".dat")
% x=load(str1+".dat");
% x1=x(:,2);
% y1=x(:,3);
% z1=x(:,5);
% xx=linspace(min(x1),max(x1),1000);
% yy=linspace(min(y1),max(y1),1000);
% [XX,YY]=meshgrid(xx,yy);
% F = scatteredInterpolant(x1, y1, z1,'linear','none');
% Z=F(XX,YY);
% 
% v=ceil(min(x(:,5))):1:ceil(max(x(:,5)));
% [C,h]=contour(XX,YY,Z,v);
% clabel(C,h,v)
% xlim([0,1])
% xlabel('C_r')
% ylabel('A_{\Delta}/A')
% figure
% hist(x(:,5),100)