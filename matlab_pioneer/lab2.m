function [results, vels_rob] = lab2(vel,mode,port)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if mode~=0 && mode~=1
   display('Mode=0: Simulation');
   display('Mode=1: Robot');
end

if vel > 0.2
   display('Use a velocity no greater than 0.2 m/s'); 
   results=0;
   vels_rob=0;
   return;
end

close all
global flag;
global j;
global T;
global div;
global counter;
global ready;
div=10;
j=0;
ready=1;
T=round((1.5*0.150/vel*15/div)*100)/100
adjust=0;
piso5=imread('Piso005crop.png');
x=[2.5 3 6.7 7.5 7.5   7.5 9 12.5 16.5 19.6   21.2 21.2 21.2 21.2 19.5   15 11 6 3 2.5];
y=[26  22 21 17.7 13.5   9 7.5 7.5 7.5 7.5   9 12.7 16.5 19 20.7   21 21 21 22 24];
t=1:1:length(x);

[xref,yref,teta_ref,wref]=ref(x,y,t);
Total_time=T*(length(xref)-1)/60

xreal(1)=xref(1);
yreal(1)=yref(1);
teta_real(1)=teta_ref(1);

if mode==1
    sp=serial_port_start(port);
    pioneer_init(sp);
    figure;
    hold on;
    plot(xreal(1),yreal(1),'bo',xref(1),yref(1),'ro');
    odom=pioneer_read_odometry();
end
counter=length(x);

for i=1:length(xref)-1

    flag=0;
    i
    m=6000;
    if mode==1
        if i>floor(div/15*45) && i<floor(div/15*256)
            so=pioneer_read_sonars();
            so=so(1:8);
            [m,ind]=min(so);
        end
        if m<800 %&& ready==1
            sonars;
            %counter=0;
            %ready=0;
            so=so/1000;
            if so(1)<5
            plot(xreal(i)+so(1)*cos(teta_real(i)+90*pi/180),yreal(i)+so(1)*sin(teta_real(i)+90*pi/180),'ko');
            end
            if so(2)<5
            plot(xreal(i)+so(2)*cos(teta_real(i)+50*pi/180),yreal(i)+so(2)*sin(teta_real(i)+50*pi/180),'co');
            end
            if so(3)<5
            plot(xreal(i)+so(3)*cos(teta_real(i)+30*pi/180),yreal(i)+so(3)*sin(teta_real(i)+30*pi/180),'go');
            end
            if so(4)<5
            plot(xreal(i)+so(4)*cos(teta_real(i)+10*pi/180),yreal(i)+so(4)*sin(teta_real(i)+10*pi/180),'yo');
            end
            if so(5)<5
            plot(xreal(i)+so(5)*cos(teta_real(i)-10*pi/180),yreal(i)+so(5)*sin(teta_real(i)-10*pi/180),'yo');
            end
            if so(6)<5
            plot(xreal(i)+so(6)*cos(teta_real(i)-30*pi/180),yreal(i)+so(6)*sin(teta_real(i)-30*pi/180),'go');
            end
            if so(7)<5
            plot(xreal(i)+so(7)*cos(teta_real(i)-50*pi/180),yreal(i)+so(7)*sin(teta_real(i)-50*pi/180),'co');
            end
            if so(8)<5
            plot(xreal(i)+so(8)*cos(teta_real(i)-90*pi/180),yreal(i)+so(8)*sin(teta_real(i)-90*pi/180),'ko');
            end
            so=so*1000;
        end
        
    end
    plot(xreal(i),yreal(i),'bo',xref(i),yref(i),'ro');
    erro_rob(:,i)=erro(xref(i),yref(i),teta_ref(i),xreal(i),yreal(i),teta_real(i));

    v(:,i)=Controller(vel,wref(i),erro_rob(:,i));
    vels_rob(:,i)=[vel*cos(erro_rob(3,i));wref(i)]-v(:,i);
    vels_rob(1,i)=max(vels_rob(1,i),-vel*0.2);
    vels_rob(1,i)=min(vels_rob(1,i),vel+0.4*vel);
    robot;
    pose=[xreal(i) yreal(i) teta_real(i)]
    counter=counter+1;
    if counter>16
        ready=1;
    end
end

if mode==0
    sim_results;
end
if mode ==1
    pioneer_close(sp);
    serial_port_stop(sp);
    delete(timerfindall);
end
results=[xreal',yreal',teta_real'];