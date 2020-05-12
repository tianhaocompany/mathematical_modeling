clc,clear,close all
% 2012-9-21
% 数值计算09\06号观测卫星的三维位置

format long e
% 初始位置和初始速度（0时刻）
dim=1000;
x=zeros(dim,1);
y=zeros(dim,1);
z=zeros(dim,1);
% % 9号卫星
% x0=2043922.166765;
% y0=8186504.631471;
% z0=4343461.714791;
% u0=-5379.544693;
% v0=-407.095342;
% w0=3516.052656;

% 6号卫星
x0=-1732113.220573;
y0=9092044.771852;
z0=1732113.220573;
u0=-4453.807606;
v0=-1566.513180;
w0=4453.807606;

t=linspace(0,dim,dim+1)';
dt=0.2;

t=t*dt;
g=3.986005e14;
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
% fid=fopen('traj09.dat','w')
% for i=250:850
%     fprintf(fid,'%15.5f',[x(i) y(i) z(i)]);
%     fprintf(fid,'\n');
% end
% fclose(fid)

fid=fopen('traj06.dat','w')
for i=250:850
    fprintf(fid,'%15.5f',[x(i) y(i) z(i)]);
    fprintf(fid,'\n');
end
fclose(fid)
