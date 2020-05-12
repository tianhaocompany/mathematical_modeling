clc,clear,close all
% 2012-9-22
% 利用06和09号观测卫星对飞行器进行定位

tmin=50;
tmax=170;
nt=601;

% 生成p点观测数据
data1=load('traj06.dat');
data2=load('traj09.dat');
data3=load('meadata_06_00_new.dat');
data4=load('meadata_09_00_new.dat');
obs6=data1;
obs9=data2;
ab6=data3(:,2:3);
ab9=data4(:,2:3);
t=linspace(tmin,tmax,nt);
clear data1 data2 data3 data4
loc=zeros(nt,3);
for i=1:nt;
    [x6(i,1),y6(i,1),z6(i,1)]=coordinate_change(obs6(i,1),obs6(i,2),obs6(i,3),ab6(i,1),ab6(i,2));
    [x9(i,1),y9(i,1),z9(i,1)]=coordinate_change(obs9(i,1),obs9(i,2),obs9(i,3),ab9(i,1),ab9(i,2));
    [loc(i,1),loc(i,2),loc(i,3),dd(i)]=middle(obs6(i,1),obs6(i,2),obs6(i,3),obs9(i,1),obs9(i,2),obs9(i,3),x6(i,1),y6(i,1),z6(i,1),x9(i,1),y9(i,1),z9(i,1));
end
clear x6 x9 y6 y9 z6 z9
x=loc(:,1);
y=loc(:,2);
z=loc(:,3);


% 计算卫星的系统误差
% % 6号卫星的位置
% loc0=obs6;
% 9号卫星的位置
loc0=obs9;
x0=loc0(:,1);
y0=loc0(:,2);
z0=loc0(:,3);
clear obs6 obs9 loc0
r0=sqrt(x0.^2+y0.^2+z0.^2);
a1=x0./r0;
b1=y0./r0;
c1=z0./r0;
A=[a1 b1 c1];
clear r0 a1 b1 c1
r0=sqrt(x0.^2+y0.^2);
a2=-y0./r0;
b2=x0./r0;
c2=zeros(nt,1);
B=[a2 b2 c2];
clear r0 a2 b2 c2
r0=sqrt(x0.^2.*z0.^2+y0.^2.*z0.^2+(x0.^2+y0.^2).^2);
a3=-x0.*z0./r0;
b3=-y0.*z0./r0;
c3=(x0.^2+y0.^2)./r0;
C=[a3 b3 c3];
clear r0 a3 b3 c3

% 卫星到飞行器的矢量
v=[x-x0 y-y0 z-z0];
clear x x0 y y0 z z0

% % 有系统误差的alpha——a和beta——b
% a1=ab6(:,1);
% b1=ab6(:,2);
% 有系统误差的alpha——a和beta——b
a1=ab9(:,1);
b1=ab9(:,2);
clear ab6 ab9
% 计算无误差的a和b
for i=1:nt
    lx(i,1)=v(i,:)*A(i,:)';
    ly(i,1)=v(i,:)*B(i,:)';
    lz(i,1)=v(i,:)*C(i,:)';
end
a0=ly./lx;
b0=lz./lx;
clear lx ly lz
clear A B C

% 绘制系统误差造成的alpha和beta的偏移
% figure
% plot(t,a0,'k',t,b0,'c','linewidth',1.5);
% hold on
% plot(t,a1,'k --',t,b1,'c --','linewidth',1.5);
% legend('\alpha0','\beta0','\alpha1','\beta1',2)
% xlabel('Time(s)','fontsize',20);
% xlim([50 60])

% 计算偏移量dalpha、dbeta、sigma
A=[nt 0 sum(b1);0 nt sum(a1); sum(b1) sum(a1) sum(a1+b1)];
b=[sum(a0-a1);sum(b0-b1);sum((a0-a1).*b1-(b0-b1).*a1)];
v=A\b;
da=v(1);
db=v(2);
ds=v(3);
derror=[da db ds]