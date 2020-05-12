clc,clear,close all
% 2012-9-22
% 采用拟合的方法确定ft_x,ft_y,ft_z

data=load('traj_fxq.dat');
x0=data(:,1);
y0=data(:,2);
z0=data(:,3);
clear data
r0=sqrt(x0.^2+y0.^2+z0.^2);

nt=601;
t0=linspace(50,170,nt)';
g=3.986005e14;
dt=0.2;
t1=[50:0.2:250];

px=polyfit(t0,x0,2);
x1=polyval(px,t1);
py=polyfit(t0,y0,2);
y1=polyval(py,t1);
pz=polyfit(t0,z0,2);
z1=polyval(pz,t1);

r1=sqrt(x1.^2+y1.^2+z1.^2);

fx=2*px(1)+g./(r1.^3).*x1;
fy=2*py(1)+g./(r1.^3).*y1;
fz=2*pz(1)+g./(r1.^3).*z1;
% figure(1)
% subplot(3,1,1)
% plot(t1,fx,'linewidth',1.5)
% xlim([50,170])
% ylabel('F_T_x(m/s^2)','fontsize',20)
% set(gca,'xtick',[])
% subplot(3,1,2)
% plot(t1,fy,'linewidth',1.5)
% xlim([50,170])
% ylabel('F_T_y(m/s^2)','fontsize',20)
% set(gca,'xtick',[])
% subplot(3,1,3)
% plot(t1,fz,'linewidth',1.5)
% xlim([50,170])
% ylabel('F_T_x(m/s^2)','fontsize',20)
% xlabel('Time(s)','fontsize',20)


% figure(2)
% subplot(3,1,1)
% plot(t0,x0,'c','linewidth',5);
% hold on
% plot(t1,x1,'k','linewidth',1.5);
% ylabel('X(m)','fontsize',20)
% set(gca,'xtick',[])
% xlim([50,170])
% subplot(3,1,2)
% plot(t0,y0,'c','linewidth',5);
% hold on
% plot(t1,y1,'k','linewidth',1.5);
% ylabel('Y(m)','fontsize',20)
% set(gca,'xtick',[])
% xlim([50,170])
% subplot(3,1,3)
% plot(t0,z0,'c','linewidth',5)
% hold on
% plot(t1,z1,'k','linewidth',1.5);
% legend('Observation','Fitting result',2)
% ylabel('Z(m)','fontsize',20)
% xlabel('Time(s)','fontsize',20)
% xlim([50,170])

fxq_x=x1(1:50:601)';
fxq_y=y1(1:50:601)';
fxq_z=z1(1:50:601)';
fxq_t=[50:10:170]';
fxq_u=2*px(1)*fxq_t+px(2);
fxq_v=2*py(1)*fxq_t+py(2);
fxq_w=2*pz(1)*fxq_t+pz(2);

u=2*px(1)*t0+px(2);
v=2*py(1)*t0+py(2);
w=2*pz(1)*t0+pz(2);
% figure(3)
% subplot(3,1,1)
% plot(t0,u,'b','linewidth',1.5);
% ylabel('V_x(m/s)','fontsize',20)
% set(gca,'xtick',[])
% xlim([50,170])
% subplot(3,1,2)
% plot(t0,v,'b','linewidth',1.5);
% ylabel('V_y(m/s)','fontsize',20)
% set(gca,'xtick',[])
% xlim([50,170])
% subplot(3,1,3)
% plot(t0,w,'b','linewidth',1.5)
% ylabel('V_z(m/s)','fontsize',20)
% xlabel('Time(s)','fontsize',20)
% xlim([50,170])

% 计算残差
dx=x1(1:nt)'-x0;
dy=y1(1:nt)'-y0;
dz=z1(1:nt)'-z0;
% figure
% plot(t0,dx,'r',t0,dy,'b',t0,dz,'g','linewidth',1.5)
% xlabel('Time(s)','fontsize',20)
% xlabel('Error(m)','fontsize',20)
% xlim([50,170])
% legend('X','Y','Z')
% clear dt fx fxq_t fxq_u fxq_v fxq_w fxq_x fxq_y fxq_z fy fz g nt px py pz r0 r1 t0 t1 u v w x0 x1 y0 y1 z0 z1
% save xyz_adjoint
[mean(abs(dx)) mean(abs(dy)) mean(abs(dz))];
[mean(abs(dx./abs(x0))) mean(abs(dy./abs(y0))) mean(abs(dz./abs(z0)))];