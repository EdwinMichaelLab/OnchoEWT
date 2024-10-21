h = 6.25; %[2 6 12]; %half-life of slash
a = 0.1646 %log(2)./(h); % decay rate
e = 0.95; % efficacy of slash
MBR = 1000;
t = 1:24;

x = MBR.*e.*(1-exp(-a.*t'));
plot(t,x);

% smaller value of a indicates longer lasting effects of slash, slower
% return