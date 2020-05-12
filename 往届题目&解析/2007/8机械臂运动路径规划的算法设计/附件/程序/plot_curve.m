t=-pi:.1:pi

y=128.738*cos(t);
x=131.393*sin(t)+183.75;
z=1/2*x;
plot3(x,y,z)
grid
hold on
clear x y z
t=-pi:2*pi/40:pi
y=128.738*cos(t);
x=131.393*sin(t)+183.75;
z=1/2*x;
plot3(x,y,z,'r+')
hold off
title('焊接曲线路径的离散化设计')