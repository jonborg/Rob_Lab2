function [results] = lab2(vel,mode,port)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if mode~=0 && mode~=1
   display('Mode=0: Simulation');
   display('Mode=1: Robot');
end

close all
global flag;
global j;
global T;
global div;
global counter;
global ready;
div=15
j=0;
ready=1;
T=1.5;

piso5=imread('Piso005crop.png');
x=[2.5 3.5 6.7 7.5 7.5   7.5 9 12.5 16.5 20   21.7 22 22 21.7 19   15 11 6 3 2.5];
y=[26  22 21 17.7 13.5   9 7.3 7 7 7   9 12.5 16.5 20 21.3   21.5 21.5 21.5 22.5 26];
adjust=0.15;
%x=[2 3 6 7.5 7   9 20 22 22 20    8 3 2];
%y=[26 21 21.5 18 9   7 7 9 20 21.5    21.5 21 26];
 %x=[2 3 6 7.5 7   9 19 22 22 21.5   19 15 8 3 2];
 %y=[26 21.25 21.5 18 9   7 7 9 14 20   21.5 21.5 21.5 21 26];
t=1:1:length(x);

[xref,yref,teta_ref,wref]=ref(x,y,t);

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
counter=6;
for i=1:length(xref)-1
    flag=0;
    i
    erro_rob(:,i)=erro(xref(i),yref(i),teta_ref(i),xreal(i),yreal(i),teta_real(i));
    v(:,i)=Controller(vel,wref(i),erro_rob(:,i));
    vels_rob(:,i)=[vel*cos(erro_rob(3,i));wref(i)]-v(:,i);
    robot;
    counter=counter+1;
    if counter>5
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
results=[xref',yref',teta_ref'];