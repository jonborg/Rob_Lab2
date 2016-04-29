piso5=imread('Piso005crop.png');
imshow(piso5);
hold on;

t=0:1:24;
x=[2 2 2 2.25 2.5   5.75 6.75 7 7 7    7 8 9 12 16   20.5 21 21.5 21.5 21.5   21.5 21 20.5 16.5 12.5]
y=[26 25 24 21.75 21.25    21.25 20.75 20.25 16.25 10.25    8.25 7 7 7 7   7 7.5 8 12 16   20.25 20.75 21.25 21.25 21.25]
px=pchip(t,57*x);
py=pchip(t,57*(28.5-y));
tempo=0:0.01:24;
plot(ppval(px,t),ppval(py,t));
% 
% figure
% px=spline(t,x);
% py=spline(t,y);
% tempo=0:0.01:24;
% plot(ppval(px,t),ppval(py,t));
