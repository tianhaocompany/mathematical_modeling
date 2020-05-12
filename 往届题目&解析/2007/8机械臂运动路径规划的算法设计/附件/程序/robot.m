function [ex,ey,ez]=robot(th1,th2,th3,th4,th5,th6)

th=[th1,th2,th3,th4,th5,th6]./180*pi;%弧度转化为角度

%各连杆的长度
lab=140;
lbc=255;
lcd=255;
lde=65;

%坐标变换阵T1~T6
T1=[cos(th(1)) -sin(th(1)) 0 0;
    sin(th(1)) cos(th(1)) 0 0;
    0 0 1 lab;
    0 0 0 1];
T2=[cos(th(2)-pi/2) -sin(th(2)-pi/2) 0 0;
    0 0 1 0;
    -sin(th(2)-pi/2) -cos(th(2)-pi/2) 1 0;
    0 0 0 1];
T3=[cos(th(3)-pi/2) -sin(th(3)-pi/2) 0 lbc;
    sin(th(3)-pi/2) cos(th(3)-pi/2) 0 0;
    0 0 1 0;
    0 0 0 1];
T4=[cos(th(4)) sin(th(4)) 0 0;
    0 0 1 lcd
    -sin(th(4)) -cos(th(4)) 0 0;
    0 0 0 1];
T5=[cos(th(5)+pi/2) -sin(th(5)+pi/2) 0 0;
    0 0 -1 0;    
    sin(th(5)+pi/2) cos(th(5)+pi/2) 0 0;
    0 0 0 1];
T6=[1 0 0 lde;
    0 1 0 0;
    0 0 1 0;
    0 0 0 1];

%Tc=T1*T2*T3;
%cx=Tc(1,4);
%cy=Tc(2,4);
%cz=Tc(3,4);

%Td=Tc*T4;
%dx=Td(1,4);

%dy=Td(2,4);
%dz=Td(3,4);

Te=T1*T2*T3*T4*T5*T6;

ex=Te(1,4);
ey=Te(2,4);
ez=Te(3,4);
 
%hold on   
%line([0,0],[0,0],[0,140])   
%line([0,cx],[0,cy],[140,cz])   
%line([cx,dx],[cy,dy],[cz,dz])  
%line([dx,ex],[dy,ey],[dz,ez])  
%axis([-500 500 -500 500 0 800])
%grid on
%hold off
