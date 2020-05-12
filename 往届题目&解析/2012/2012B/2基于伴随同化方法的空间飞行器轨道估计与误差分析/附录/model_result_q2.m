clc,clear,close all
% 2012-9-22
% 同化后的结果

obs=load('adjoint_model_q2_2\traj_fxq.dat');
model=load('adjoint_model_q2_2\xyz_forward.dat');
% obs=load('new_adj\traj_fxq.dat');
% model=load('new_adj\xyz_forward.dat');
[m,n]=size(obs);
t=linspace(50,170,m)';

figure(1)
subplot(3,1,1);
plot(t,obs(:,1),'c','linewidth',5)
hold on
plot(t,model(:,1),'k','linewidth',1.5);
ylabel('x(m)','fontsize',20)
set(gca,'xtick',[])
xlim([50,170])
subplot(3,1,2);
plot(t,obs(:,2),'c','linewidth',5)
hold on
plot(t,model(:,2),'k','linewidth',1.5);
ylabel('y(m)','fontsize',20)
set(gca,'xtick',[])
xlim([50,170])
subplot(3,1,3)
plot(t,obs(:,2),'c','linewidth',5)
hold on
plot(t,model(:,2),'k','linewidth',1.5);
legend('Observation','Model result',2)
ylabel('z(m)','fontsize',20)
xlabel('Time(s)','fontsize',20)
xlim([50,170])

data=load('adjoint_model_q2_2\uvw_forward.dat');
figure(2)
subplot(3,1,1);
plot(t(1:m-1),data(1:m-1,1),'b','linewidth',1.5)
ylabel('V_x(m/s)','fontsize',20)
set(gca,'xtick',[])
xlim([50,170])
subplot(3,1,2);
plot(t(1:m-1),data(1:m-1,2),'b','linewidth',1.5)
ylabel('V_y(m/s)','fontsize',20)
set(gca,'xtick',[])
xlim([50,170])
subplot(3,1,3)
plot(t(1:m-1),data(1:m-1,3),'b','linewidth',1.5)
ylabel('V_z(m/s)','fontsize',20)
xlabel('Time(s)','fontsize',20)
xlim([50,170])

% 计算残差
dx=model(1:m,1)-obs(:,1);
dy=model(1:m,2)-obs(:,2);
dz=model(1:m,3)-obs(:,3);
% clear data m model n obs t
% save xyz_adjoint