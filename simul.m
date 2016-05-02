T=0.2;%intervalo de amostragem
v=zeros(1,round(300/T));
w=zeros(1,round(300/T));
x=zeros(1,round(300/T)+1);
y=zeros(1,round(300/T)+1);
theta=zeros(1,round(300/T)+1);
v(1:round(300/T))=0.35;
w(1:5)=0;
w(6:round(150/T))=0.1;
w(round(150/T)+1:round(300/T))=-0.05;

for i=1:round(300/T)
    deltax=v(i)*cos(theta(i))*T;
    deltay=v(i)*sin(theta(i))*T;
    deltatheta=w(i)*T;
    x(i+1)=x(i)+deltax;
    y(i+1)=y(i)+deltay;
    theta(i+1)=theta(i)+deltatheta;
    if(theta(i+1)>pi)
        theta(i+1)=theta(i+1)-2*pi;
    end
    if(theta(i+1)<-pi)
        theta(i+1)=theta(i+1)+2*pi;
    end
end

figure;
plot(x,y);
figure;
plot(theta);