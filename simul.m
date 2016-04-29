v=zeros(1,300);
w=zeros(1,300);
x=zeros(1,301);
y=zeros(1,301);
theta=zeros(1,301);
v(1:300)=0.35;
w(1:5)=0;
w(6:300)=0.1;

for i=1:300
    deltax=v(i)*cos(theta(i));
    deltay=v(i)*sin(theta(i));
    deltatheta=w(i);
    x(i+1)=x(i)+deltax;
    y(i+1)=y(i)+deltay;
    theta(i+1)=theta(i)+deltatheta;
end

plot(x,y);
theta