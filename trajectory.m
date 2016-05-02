%pchip
close all
piso5=imread('Piso005crop.png');
imshow(piso5);
hold on;
x=[2 2.25 2.5 3        6.25 6.90 7         7 7.25 7.5 7.75 9      20.5 21 21.3 21.50    21.5 21.3 20.75 20.25   3 2.5 2.25 2];
y=[24 22 21.5 21.25   21.25 20.75 20.25   8.25 7.75 7.5 7.25 7   7 7.20 7.4 8.25       20.25 20.75 21.1 21.25  21.25 21.5 22 24];
t=0:1:length(x)-1;
px=pchip(t,57*x);
py=pchip(t,57*(28.5-y));
tempo=0:0.01:24;
plot(ppval(px,tempo),ppval(py,tempo),'b');
plot(57*x,57*(28.5-y),'bo');

%spline
figure
imshow(piso5);
hold on;
x=[2 3 6 7 7 9 19 22 22 21.5 19 15 8 3 2];
y=[26 21.25 21.5 18 9 7 7 9 14 20 21.5 21.5 21.5 21 26];
t=0:1:length(x)-1;
px=spline(t,57*x);
py=spline(t,57*(28.5-y));
plot(ppval(px,tempo),ppval(py,tempo),'r');
plot(57*x,57*(28.5-y),'ro');

% 
% figure
% px=spline(t,x);
% py=spline(t,y);
% tempo=0:0.01:24;
% plot(ppval(px,t),ppval(py,t));

pos=[x;y];
for i=1:length(x)-1
    dist(i)=sqrt((x(i)-x(i+1))^2+(y(i)-y(i+1))^2);
    inttempo(i)=dist(i)/0.1;
end
sum(inttempo)