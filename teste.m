close all

x=[2 2.5 6 7.5 7   7 9 12.5 16.5 20   22 22 22 21.5 19   15 11 8 4 2];
y=[26 22.5 21.5 18 13.5   9 7 7 7 7   9 12.5 16.5 20 21.5   21.5 21.5 21.5 22 26];
t=1:1:length(x);
vel=0.35; %m/s
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

xsim(1)=xref(1);
ysim(1)=yref(1);
teta_sim(1)=teta_ref(1);
K1=0.1;
K2=20;



for i=1:length(xref)-1
    l=norm([xref(i),yref(i)]-[xsim(i),ysim(i)]);  
    while teta_sim(i) > 2*pi
        teta_sim(i)=teta_sim(i)-2*pi;
    end
    while teta_sim(i) < -2*pi
        teta_sim(i)=teta_sim(i)+2*pi;
    end
    delta_teta(i)=teta_ref(i)-teta_sim(i);
    
    vels_rob=[0 0 ; K1 K2]*[l delta_teta(i)]'+[vel 0]';
    %state_space
    vels_world=[cos(teta_sim(i)) 0; sin(teta_sim(i)) 0; 0 1]*vels_rob;
    
    xsim(i+1)=xsim(i)+T(i)*vels_world(1);
    ysim(i+1)=ysim(i)+T(i)*vels_world(2);
    if i~=length(xref)
        teta_sim(i+1)=teta_sim(i)+T(i)*vels_world(3);
    else
        teta_sim(i+1)=teta_sim(i);
    end
end
piso5=imread('Piso005crop.png');
imshow(piso5);
hold on;
plot(xref*57,57*(28.5-yref),'r');
labels = cellstr( num2str([1:length(x)]') )
plot(57*x,57*(28.5-y),'ro');
text(57*x,57*(28.5-y),labels);
figure
imshow(piso5);
hold on;
plot(xsim*57,57*(28.5-ysim),'b');
figure
plot(teta_sim,'b');
hold on;
plot(teta_ref,'r');