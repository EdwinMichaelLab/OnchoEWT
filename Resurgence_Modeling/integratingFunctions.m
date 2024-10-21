fun = @(x) cos(x);%@(x) exp(-x.^2).*log(x).^2;

ul=linspace(0,2*pi,100);
for i=1:length(ul)
    ux=ul(i);

    q(i) = integral(fun,0,ux);
end

figure()

 plot(ul,q)
 hold on
 plot(ul,cos(ul))