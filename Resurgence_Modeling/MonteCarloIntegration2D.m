
%This function performs monte carlo integration in 1D

%to do this we generate a sample of uniform random numbers from the
%desiresd interval of integration. Then using central limit theorem, the
%value of the itnegral is the average value of the function over the entire
%interval
clear all
a=0;
b1=pi;

%the function to be integrated is cosine(x)
i=1
n=1000;
for b=a:0.1:b1
       X(:,1)=b*rand(n,1)+a;

    for b2=a:0.1:b1
        X(:,2)=b2*rand(n,1)+a;
        Y=MultiFn(X);
        intg(i)=(b2-a)*(b-a)*mean(Y);
        i=i+1;
    end
end
figure()
plot3(linspace(a,b1,length(intg)),linspace(a,b1,length(intg)),intg)

function Y=MultiFn(X)
    k=1;
    for i1=1:length(X)
        for j1=1:length(X)
            Y(k)=cos(X(i1,1)+X(j1,2));
            k=k+1;
        end
    end
end