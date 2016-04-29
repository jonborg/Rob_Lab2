t=0:1:24;
x=[1 1 1 1.25 1.5   7 8 9 9 9    9 10 11 14 18   22 22.5 23 23 23   23 22.5 22 18 14]
y=[26 25 24 23.5 23    23 22.5 22 18 14    11 10 9 9 9   9 10 11 14 18   22 22.5 23 23 23]
px=pchip(t,x);
py=pchip(t,y);
tempo=0:0.01:24;
plot(ppval(px,t),ppval(py,t));

figure
px=spline(t,x);
py=spline(t,y);
tempo=0:0.01:24;
plot(ppval(px,t),ppval(py,t));
