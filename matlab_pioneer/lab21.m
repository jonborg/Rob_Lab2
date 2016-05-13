function [vels_rob] = lab2(vel,mode,port)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if mode~=0 && mode~=1
   display('Mode=0: Simulation');
   display('Mode=1: Robot');
end

close all
global flag;
global j;
j=0;
piso5=imread('Piso005crop.png');
x=[2.5 3 6.5 7.5 7.25   7 9 12.5 16.5 20   22 22 22 21.5 19   15 11 6 3 2.5];
y=[26  22 21 18 13.5   9 7 7 7 7   9 12.5 16.5 20 21.5   21.5 21.5 21.5 22.5 26];
%x=[2 3 6 7.5 7   9 20 22 22 20    8 3 2];
%y=[26 21 21.5 18 9   7 7 9 20 21.5    21.5 21 26];
 %x=[2 3 6 7.5 7   9 19 22 22 21.5   19 15 8 3 2];
 %y=[26 21.25 21.5 18 9   7 7 9 14 20   21.5 21.5 21.5 21 26];
t=1:1:length(x);
%T=0.10;

sx=pchip(t,x);
sy=pchip(t,y);
tempo=1:0.05:length(x);

xref=ppval(sx,tempo);
yref=ppval(sy,tempo);
for i=1:length(xref)-1
   T(i)=3;%norm([xref(i+1),yref(i+1)]-[xref(i),yref(i)])/vel; 
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
    figure;
    imshow(piso5);
    hold on;
    plot(xreal(1),yreal(1));
    odom=pioneer_read_odometry();
end

for i=1:length(xref)-1
    flag=0;
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
    i
    damp=1;
    g=10;
    wn=sqrt(wref(i)^2+g*(vel)^2);
    K1=2*damp*wn;
    K2=g*abs(vel);
    K3=K1;
    K=[-K1 0 0; 0 -sign(vel)*K2 -K3];
    v(:,i)=K*erro_rob(:,i);
    
    vels_rob(:,i)=[vel*cos(erro_rob(3,i));wref(i)]-v(:,i);
    %vels_rob(1,i)=min(vels_rob(1,i),vel);
    
    if mode==0
       vels_world(:,i)=[cos(teta_real(i)) 0; sin(teta_real(i)) 0; 0 1]*vels_rob(:,i);
       xreal(i+1)=xreal(i)+T(i)*vels_world(1,i);
       yreal(i+1)=yreal(i)+T(i)*vels_world(2,i);
       teta_real(i+1)=teta_real(i)+T(i)*vels_world(3,i);
    end 
    if mode==1  
       t=timer('TimerFcn','odometria','StartDelay',T(i));
       pioneer_set_controls(sp,round(vels_rob(1,i)*1000),round(vels_rob(2,i)*180/pi));
       start(t);
       while flag==0
           pause(0.5); %VER UNTITLED3
           sonars=pioneer_read_sonars();
           [m,ind]=min(sonars);
           if m<300 
               stop(t);
               delete(t);
               pioneer_set_controls(sp,round(vels_rob(1,i)*1000),round(20*(ind-4.5)));
               pause(1);
               pioneer_set_controls(sp,round(vels_rob(1,i)*1000),round(vels_rob(2,i)*180/pi));
               t=timer('TimerFcn','odometria','StartDelay',T(i));
               start(t);
           end
           if flag==1
               odom=pioneer_read_odometry;
               while odom(3)>=4096
                   odom(3)=odom(3)-4096;
               end
               world=[0 1 xreal(1); -1 0 yreal(1); 0 0 1]*[odom(1)/1000 odom(2)/1000 1]';
               
               xreal(i+1)=world(1);
               yreal(i+1)=world(2);
               teta_real(i+1)=-pi/2+2*pi/4096*odom(3);
               plot(xreal(i+1),yreal(i+1));
               delete(t);
           end
       end
    end
end
if mode==0
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
    for i=1:20:length(xreal)
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
if mode ==1
    pioneer_close(sp);
    serial_port_stop(sp);
    delete(timerfindall);
end