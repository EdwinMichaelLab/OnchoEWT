b = [220.45;0.8939;8.42;285.47];

for t = 1:24
    m = mod(t,12);
    if m == 0
        m = 12;
    end
    R(t) = b(1)*(1+b(2)*cos(2*pi/b(3)*m+b(4)));
    x(t) = cos(2*pi/b(3)*m+b(4));
end

plot(R);
figure;
plot(x);
hold on