function arc2(N)
% x1=linspace(0,360000,N);
% x=x1.^(1/2);
x=linspace(0,600,N);
y=30*exp(-x/400).*sin(1/100*(x+25*pi))+130;
%y1=Threepoint(y,x,1);
A(1,:)=x;
A(2,:)=y;
plot(x,y,'g');
hold on
A
for i=1:N-1
    B(i)=atand((y(i+1)-y(i))/(x(i+1)-x(i)));
end
x=180;
y=30*exp(-x/400).*sin(1/100*(x+25*pi))+130;
plot(x,y,'r*');
x
y
hold on
x=500;
y=30*exp(-x/400).*sin(1/100*(x+25*pi))+130;
plot(x,y,'r*');
x
y
B
x=91
y=30*exp(-x/400).*sin(1/100*(x+25*pi))+130
x=369
y=30*exp(-x/400).*sin(1/100*(x+25*pi))+130
%f=y+sqrt(x^2+y^2)*sind(8.52)-30*exp(-(y+sqrt(x^2+y^2)*cosd(8.52))/400).*sin(1/100*((y+sqrt(x^2+y^2)*cosd(8.52))+25*pi))+130+151.21
%ezplot('y+sqrt(x^2+y^2)*sind(8.52)-30*exp(-(y+sqrt(x^2+y^2)*cosd(8.52))/400).*sin(1/100*((y+sqrt(x^2+y^2)*cosd(8.52))+25*pi))-130+151.21', [-50,50,100,151.2132]);
