% from nscosinor fits in R
data = [131,178,266,263,424,334,259,0,0,24,122,501];
out = [1  213.3726546   17.58811 336.3574
2  140.8576131   17.91813 284.1882
3  156.7036108   73.10406 295.5932
4  249.6492613  123.14563 361.6807
5  301.4888766  183.92816 426.9220
6  351.0909768  261.30948 495.4988
7  360.6242472  203.05669 467.1044
8  238.7224165   85.65108 335.6017
9   77.5569640  -78.55215 166.5825
10  -0.7517445 -150.36941 115.8439
11  52.7450363  -88.79477 146.0304
12 189.8713339   54.89617 312.6493];

minR = out(:,3);
minR(minR<0) = 0;
maxR = out(:,4);
meanR = out(:,2);
meanR(meanR<0) = 0;
month = [5:12,1:4];

m = 12;
n = 50;
r = zeros(m,n);
for t = 1:m
    
    x = mod(t,12);
    if x == 0
        x = 12;
    end
    
    r(t,:) = minR(x)+rand(1,n)*(maxR(x) - minR(x));
    
end

plot(r,'Color',[0.8 0.8 0.8]);
hold on
plot(r(:,1),'r','LineWidth',1.3);
plot(minR,'--k','LineWidth',1.3);
plot(meanR,'k','LineWidth',1.3);
plot(maxR,'--k','LineWidth',1.3);
plot(data,'ko','MarkerFaceColor','k');
set(gca,'XLim',[1 12],'xtick',1:12,'xticklabel',...
    {'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan','Feb','Mar','Apr'});
xlabel('Month (2017-2018)');
ylabel('Rainfall (mm)');
print('cosinor_samples','-dtiff','-r400');
