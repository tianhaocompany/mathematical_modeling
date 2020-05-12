clc,clear,close all
% 2012-9-21
% 数值计算09号观测卫星的三维位置

format long e
% 初始位置和初始速度（0时刻）
dim=500000;
x=zeros(dim,1);
y=zeros(dim,1);
z=zeros(dim,1);
% 9号卫星
x0=2043922.166765;
y0=8186504.631471;
z0=4343461.714791;
u0=-5379.544693;
v0=-407.095342;
w0=3516.052656;

% % 6号卫星
% x0=-1732113.220573;
% y0=9092044.771852;
% z0=1732113.220573;
% u0=-4453.807606;
% v0=-1566.513180;
% w0=4453.807606;



% 时间步长
dt=0.1;
t=linspace(0,dim,dim+1);
g=3.986005e14;

% 采用三层格式，需要先计算1时刻的位置
x(1)=x0+u0*dt;
y(1)=y0+v0*dt;
z(1)=z0+w0*dt;
r=sqrt(x(1)^2+y(1)^2+z(1)^2);
x(2)=(2*x(1)-x0)-g/r^3*x(1)*dt^2;
y(2)=(2*y(1)-y0)-g/r^3*y(1)*dt^2;
z(2)=(2*z(1)-z0)-g/r^3*z(1)*dt^2;

for i=3:dim+1;
    r=sqrt(x(i-1)^2+y(i-1)^2+z(i-1)^2);
    x(i)=2*x(i-1)-x(i-2)-g/r^3*x(i-1)*dt^2;
    y(i)=2*y(i-1)-y(i-2)-g/r^3*y(i-1)*dt^2;
    z(i)=2*z(i-1)-z(i-2)-g/r^3*z(i-1)*dt^2;
end
figure(1)
plot3(x,y,z,'linewidth',1.5)
axis equal
xlabel('X_c(m)','fontsize',20)
ylabel('Y_c(m)','fontsize',20)
zlabel('Z_c(m)','fontsize',20)
figure(2)
subplot(3,1,1)
plot(t*dt,x,'linewidth',1.5)
ylabel('X_c(m)','fontsize',20)
set(gca,'xtick',[])
subplot(3,1,2)
plot(t*dt,y,'linewidth',1.5)
ylabel('Y_c(m)','fontsize',20)
set(gca,'xtick',[])
subplot(3,1,3)
plot(t*dt,z,'linewidth',1.5)
ylabel('Z_c(m)','fontsize',20)
xlabel('Time(s)','fontsize',20)

% nx=0;
% ny=0;
% nz=0;
% for i=2:dim
%     if x(i)>x(i-1)&x(i)>x(i+1)
%         nx=nx+1;
%         maxx(nx,1)=i;
%         maxx(nx,2)=x(i);
%     end
%     if y(i)>y(i-1)&y(i)>y(i+1)
%         ny=ny+1;
%         maxy(ny,1)=i;
%         maxy(ny,2)=y(i);
%     end    
%     if z(i)>z(i-1)&z(i)>z(i+1)
%         nz=nz+1;
%         maxz(nz,1)=i;
%         maxz(nz,2)=z(i);
%     end
% end
% 
% nx=0;
% ny=0;
% nz=0;
% for i=2:dim
%     if x(i)<x(i-1)&x(i)<x(i+1)
%         nx=nx+1;
%         maxx(nx,1)=i;
%         maxx(nx,2)=x(i);
%     end
%     if y(i)<y(i-1)&y(i)<y(i+1)
%         ny=ny+1;
%         maxy(ny,1)=i;
%         maxy(ny,2)=y(i);
%     end    
%     if z(i)<z(i-1)&z(i)<z(i+1)
%         nz=nz+1;
%         maxz(nz,1)=i;
%         maxz(nz,2)=z(i);
%     end
% end
