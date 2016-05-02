x=[2 3 6 7 7 9 19 22 22 21.5 19 15 8 3 2];
y=[26 21.25 21.5 18 9 7 7 9 14 20 21.5 21.5 21.5 21 26];
t=1:1:length(x);

sx=pchip(t,x);
sy=pchip(t,y);
tempo=1:0.01:length(x);

xref=ppval(sx,tempo);
yref=ppval(sy,tempo);
teta_ref(1)=-pi/2;

for i=2:length(xref)
    teta_ref(i)=atan2(norm(cross([xref(i) yref(i) 0],[1 0 0])),dot([xref(i) yref(i) 0],[1 0 0]));
end

xreal(1)=xref(1);
yreal(1)=yref(1);
teta_real(1)=teta_ref(1);
K=1;

for i=1:length(xreal)
    delta_x=xref(i)-xreal(i);
    delta_y=yref(i)-yreal(i);
    delta_teta=teta_ref(i)-teta_real(i);
    
    vels_rob=K*[delta_x delta_y delta_teta]';
    vels_world=[cos(teta_ref(i)) 1 0; sin(teta_ref(i)) 1 0; 0 1 1]*vels_rob;
    xreal(i+1)=xreal(i)+T*vels_world(1);
    yreal(i+1)=yreal(i)+T*vels_world(2);
    teta_real(i+1)=teta_real(i)+T*vels_world(3);
end