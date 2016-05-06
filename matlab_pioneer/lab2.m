function [] = lab2(vel,mode,port)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if mode~=0 && mode~=1
   display('Mode=0: Simulation');
   display('Mode=1: Robot');
end

close all

% x=[2 2.5 6 7.5 7   7 9 12.5 16.5 20   22 22 22 21.5 19   15 11 8 4 2];
% y=[26 22.5 21.5 18 13.5   9 7 7 7 7   9 12.5 16.5 20 21.5   21.5 21.5 21.5 22 26];
x=[2 3 6 7.5 7   9 20 22 22 20    8 3 2];
y=[26 21 21.5 18 9   7 7 9 20 21.5    21.5 21 26];
% x=[2 3 6 7.5 7 9 19 22 22 21.5 19 15 8 3 2];
% y=[26 21.25 21.5 18 9 7 7 9 14 20 21.5 21.5 21.5 21 26];
t=1:1:length(x);
%T=0.10;

sx=pchip(t,x);
sy=pchip(t,y);
tempo=1:0.001:length(x);

xref=ppval(sx,tempo);
yref=ppval(sy,tempo);
for i=1:length(xref)-1
   T(i)=norm([xref(i+1),yref(i+1)]-[xref(i),yref(i)])/vel; 
end

teta_ref(1)=-pi/2;

for i=2:length(xref)
    aux=cross([1 0 0],[xref(i)-xref(i-1) yref(i)-yref(i-1) 0]);
    teta_ref(i)=atan2(aux(3),dot([1 0 0],[xref(i)-xref(i-1) yref(i)-yref(i-1) 0]));
    if teta_ref(i)-teta_ref(i-1)>pi
        teta_ref(i)=teta_ref(i)-2*pi;
    end
    if teta_ref(i)-teta_ref(i-1)<-pi
        teta_ref(i)=teta_ref(i)+2*pi;
    end
end

for i=1:length(teta_ref)-1
    wref(i)=(teta_ref(i+1)-teta_ref(i))/T(i);
end

xreal(1)=xref(1);
yreal(1)=yref(1);
teta_real(1)=teta_ref(1);

if mode==1
    sp=serial_port_start(port);
    pioneer_init(sp);
end


for i=1:length(xref)-1
    delta_x(i)=xref(i)-xreal(i);
    delta_y(i)=yref(i)-yreal(i);
        while teta_real(i) > 2*pi
        teta_real(i)=teta_real(i)-2*pi;
    end
    while teta_real(i) < -2*pi
        teta_real(i)=teta_real(i)+2*pi;
    end
    delta_teta(i)=teta_ref(i)-teta_real(i);
    erro_rob(:,i)=[cos(teta_real(i)) sin(teta_real(i)) 0; -sin(teta_real(i)) cos(teta_real(i)) 0; 0 0 1]*[delta_x(i) delta_y(i) delta_teta(i)]';
    
    damp=0.6;
    g=100;
    wn=sqrt(wref(i)^2+g*(vel)^2);
    K1=2*damp*wn;
    K2=g*abs(vel);
    K3=K1;
    K=[-K1 0 0; 0 -sign(vel)*K2 -K3];
    v(:,i)=K*erro_rob(:,i);
    
    vels_rob(:,i)=[vel*cos(erro_rob(3,i));wref(i)]-v(:,i);
    
    if mode==0
        vels_world(:,i)=[cos(teta_real(i)) 0; sin(teta_real(i)) 0; 0 1]*vels_rob(:,i);
        xreal(i+1)=xreal(i)+T(i)*vels_world(1,i);
        yreal(i+1)=yreal(i)+T(i)*vels_world(2,i);
        teta_real(i+1)=teta_real(i)+T(i)*vels_world(3,i);
    end
    
    if mode==1
        odo=0;
        pioneer_set_controls(sp,vels_rob(1)*10^3, vels_rob(2));
        t=timer('TimerFcn','odo==1;StartDelay',T(i));
        start(t);
        while odo==0
            odo
        end
        xreal=odometry(1);
        yreal=odometry(2);
        teta_real=odometry(3);
        delete(t);
    end
end
if mode==0
    piso5=imread('Piso005crop.png');
    imshow(piso5);
    hold on;
    plot(xref*57,57*(28.5-yref),'r');
    labels = cellstr(num2str([1:length(x)]') );
    plot(57*x,57*(28.5-y),'ro');
    text(57*x,57*(28.5-y),labels);
   
    figure
    imshow(piso5);
    hold on;
    plot(xreal*57,57*(28.5-yreal),'b');
    labels = cellstr( num2str([1:length(x)]') );
    j=1;
    for i=1:1000:length(xreal)
        xe(j)=xreal(i);
        ye(j)=yreal(i);
        j=j+1;
    end
    plot(57*xe,57*(28.5-ye),'bo');
    text(57*xe,57*(28.5-ye),labels);
    plot(57*x,57*(28.5-y),'ro');
    text(57*x,57*(28.5-y),labels);
    figure
    
    plot(teta_real,'b');
    hold on;
    plot(teta_ref,'r');
end
if mode==1
    pioneer_set_controls(sp, 0, 0);
    serial_port_stop(sp);
end 