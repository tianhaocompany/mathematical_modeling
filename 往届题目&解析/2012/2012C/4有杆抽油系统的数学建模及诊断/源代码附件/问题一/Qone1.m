%%
clc
clear all

x_original=load('1.txt');
%%
a=4315;
I=1700;
h=950+sqrt(3675^2-(I-2495)^2);
%I=5800;
T=60/7.6;
w=2*pi*7.6/60;
t=0:T/800:T;
y=w.*t;
b=2495;
r=950;
%h=950+3671.7;
L=3675;
% 位移
J=sqrt((I+r.*sin(y)).^2+(h-r.*cos(y)).^2);
x=atan((I+r.*sin(y))./(h-r.*cos(y)));
theta=pi-(acos((b.^2+J.^2-L.^2)./(2.*b.*J)))-x;
dtheta=theta-2.*pi./3;
s=(a.*theta)/1000-6.8;
t_ori=0:T/(length(x_original(1,:))-1):T;
plot(t,s,'red',t_ori,x_original(1,:),'g+-')
% axis([0 370 -1 5])
hold on;
xlabel(' 时间(s)');
ylabel(' 位移 (m) ');
legend('计算结果','附件1 数据结果');
grid on;

%%
%速度
K=sqrt(I.^2+h.^2);
y0=atan(h);
theta11=K.*sin(y+y0);
theta12=b.*sin(y-theta);
theta13=b.*J.*sin(theta+x);
theta1=w.*r.*(theta11+theta12)./theta13;
VA=a.*theta1;
%plot(360*y/(2*pi),VA/1000,'Black');
%axis([0 360 -3 2])
% xlabel('时间 (s)');
% ylabel('速度 (m/s)');
%text(2,0.5,'\leftarrow Velocity' )
%save sdata t s 
grid on


hold on;

%加速度

WA1=K.*cos(y+y0)+b.*cos(y-theta);
k=w^2.*950;
WA2=2.*b.*w.*950.*theta1.*cos(y+theta);
WA3=theta1.^2.*cos(theta+x);
WA4=b.*J.*sin(theta+x);
WA=a.*(k.*WA1-WA2-WA3)./WA4;
%plot(360*y/(2*pi),WA,'blue')
%xlable('时间 (s)')
%ylable('加速度 (m2/s)')

%text(4,0.5,'\leftarrow Acceleration' )
grid on;
hold off



