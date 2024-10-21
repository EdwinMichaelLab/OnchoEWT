%In this coe we will plot the probability of capture assuming an array of
%traps placed on a 2D surface. This mimics the trap placement as expected
%in village settings in Uganda.
%We will cacluate the average instantaneous probabilty of capture by an
%array of n-EWT traps.
%The question we seek to answer is: what is the eaverage or expected capture
%probabilty accross and area A by an array of n-traps.


clear all
clc

lambda=linspace(1,61,5);
x=linspace(0,250,100);


randSq=@(N,d) rand(N,d).^2;
fun = @(X,lambda) 2/(exp(-sqrt(sum(X,2))/lambda)+exp(sqrt(sum(X,2))/lambda));%2/(exp(-lambda(i)*sqrt(x^2+y^2))+exp(lambda(i)*sqrt(x^2+y^2)));
d=2;
intfun = @(N,limits,lambda) sum(fun(randSq(N,d)*diff(limits) + limits(1),lambda))/(diff(limits)^d)/N;
format long g
%intfun(10000,[0,1],lambda)


i=1;
for l=1:100000
    px(i)=intfun(10000,[0,l],lambda(end))/l;
    i=i+1;
end
sum(px)
% for i=1:length(lambda)
%     l=250
%     px(i)=intfun(10000,[0,l],lambda(i))/l;
% end
figure
plot(px)