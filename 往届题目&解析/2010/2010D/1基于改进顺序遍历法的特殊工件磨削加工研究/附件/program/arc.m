function A=arc(N)
x1=linspace(0,600^(25/18),N);
x=x1.^(18/25);
%x=linspace(0,600,N);
y=-7/18000*(600-x).^2+0.45*(600-x);
%y=30*(exp(-x/400)).*sin((1/100)*(x+25*pi))+130;
A(1,:)=x;
A(2,:)=y;
y1=-7/9000*x+7/15-0.45;
% y1Ϊ����
zz1=-atan(y1);
zz2=zz1/pi*180;
A(3,:)=zz2;