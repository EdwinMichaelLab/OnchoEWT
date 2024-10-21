addpath("./shadefunction")
close all
clear all;
figure


x = linspace(0,10*pi);
y1 = sin(x);
y2 = cos(x);
% figure(1)
% plot(x, y1)
% hold on
% plot(x, y2)
% patch([x fliplr(x)], [y1 fliplr(y2)], 'g')

shade(x,y1,x,y2,'FillType',[1 2;2 1]);