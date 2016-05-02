close all

x=[2 3 6 7 7 9 19 22 22 21.5 19 15 8 3 2];
y=[26 21.25 21.5 18 9 7 7 9 14 20 21.5 21.5 21.5 21 26];
t=1:1:length(x);
vel=0.100; %m/s
T=10;

sx=pchip(t,x);
sy=pchip(t,y);
tempo=1:0.01:length(x);

xref=ppval(sx,tempo);
yref=ppval(sy,tempo);
teta_ref(1)=-pi/2;

for i=2:length(xref)
    aux=cross([1 0 0],[xref(i)-xref(i-1) yref(i)-yref(i-1) 0]);
    teta_ref(i)=atan2(aux(3),dot([1 0 0],[xref(i)-xref(i-1) yref(i)-yref(i-1) 0]));
end

xreal(1)=xref(1);
yreal(1)=yref(1);
teta_real(1)=teta_ref(1);
K1=1/2;
K2=1/2;

for i=1:length(xreal)
%     delta_x=xref(i)-xreal(i);
%     delta_y=yref(i)-yreal(i);
%     delta_teta=teta_ref(i)-teta_real(i);
    l=norm([xref(i),yref(i)]-[xreal(i),yreal(i)]);
    delta_teta=teta_ref(i)-teta_real(i);

    vels_rob=[0 0 ; K1 K2]*[l delta_teta]'+[vel 0]';
    vels_world=[cos(teta_ref(i)) 0; sin(teta_ref(i)) 0; 0 1]*vels_rob;
    
    xreal(i+1)=xreal(i)+T*vels_world(1);
    yreal(i+1)=yreal(i)+T*vels_world(2);
    teta_real(i+1)=teta_real(i)+T*vels_world(3);
end
piso5=imread('Piso005crop.png');
imshow(piso5);
hold on;
plot(xref*57,57*(28.5-yref),'r');
figure
imshow(piso5);
hold on;
plot(xreal*57,57*(28.5-yreal),'b');