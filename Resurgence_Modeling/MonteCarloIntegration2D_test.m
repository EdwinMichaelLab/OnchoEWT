fun = @(X) cos(sum(X,2));
d=2;
intfun = @(N,limits) sum(fun(rand(N,d)*diff(limits) + limits(1)))/diff(limits)^d/N;
format long g
intfun(10000,[0,1])