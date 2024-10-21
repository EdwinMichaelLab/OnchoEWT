

%This function performs monte carlo integration in 1D

%to do this we generate a sample of uniform random numbers from the
%desiresd interval of integration. Then using central limit theorem, the
%value of the itnegral is the average value of the function over the entire
%interval
clear all
a=0;
b1=pi*4;

%the function to be integrated is cosine(x)
i=1
n=1000000;
for b=a:0.01:b1
    x=b*rand(n,1)+a;
    intg(i)=(b-a)*sum(cos(x))/n;
    i=i+1;
end
figure()
plot(linspace(a,b1,length(intg)),intg)
hold on
plot(linspace(a,b1,length(intg)),cos(linspace(a,b1,length(intg))))
ylim([-1 1])