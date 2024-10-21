addpath("./integralN_mc/")

f=@(X) sin(X(:,1))+cos(X(:,2));

xl=0;
xu=1;
yl=0;
yu=inf;
Q=integralN_mc(f,[xl xu;yl yu]);
fprintf("%f\n",Q);