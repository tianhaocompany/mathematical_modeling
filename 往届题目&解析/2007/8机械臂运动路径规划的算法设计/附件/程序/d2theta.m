function [t1,t2,t3]=d2theta(p)

x=p(1);
y=p(2);
z=p(3);

t1=acot(x/y)*180/pi;
t2=90-180/pi*acos(sqrt(x^2+y^2+(z-140)^2)/510)-atan((z-140)/sqrt(x^2+y^2))*180/pi;
t3=2*180/pi*acos(sqrt(x^2+y^2+(z-140)^2)/510);


