lambda=[1/10,1/30,1/50];
x=linspace(-250,250,100);
Pc=zeros(100,3);
for i=1:3
    for k=1:100
        Pc(k,i)=2/(exp(-lambda(i)*abs(x(k)))+exp(lambda(i)*abs(x(k))));
    end
end


for i=1:3
    plot(x,Pc(:,i))
    hold on
end
 hold off