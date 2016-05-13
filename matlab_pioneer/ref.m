function [xref,yref,teta_ref,wref] = ref(x,y,t)
global T;
sx=pchip(t,x);
sy=pchip(t,y);
tempo=1:0.05:length(x);

xref=ppval(sx,tempo);
yref=ppval(sy,tempo);

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
    wref(i)=(teta_ref(i+1)-teta_ref(i))/T;
end
end

