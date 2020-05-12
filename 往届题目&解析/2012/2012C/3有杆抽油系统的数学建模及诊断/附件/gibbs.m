clc;
clear;


% load fj1s;
% load fj1f;
% jie=1;
% k=length(fj1s);
% u=-fj1s';
% dl=fj1f'*1000;
% dr=[0.022]; %抽油杆杆径
% x=[792.5];  %抽油杆杆长
% omiga=7.6*pi/30; %曲柄角速度
% hsl=0.98;
% dt=0.07;  %油管内径

load fj2s;
load fj2f;
jie=3;
k=length(fj2s);
u=-fj2s';
dl=fj2f'*1000;
dr=[0.025 0.022 0.019];
x=[523.61 664.32 618.35];
omiga=4*pi/30;
hsl=0.912;
dt=0.044;  %油管内径

uu=zeros(size(u));
dd=zeros(size(dl));
e=2.1e+11; %弹性模量
rou=8456; %抽油杆密度
rou0=864/1.025; %原油密度
rouw=1000; %水的密度
rouy=rou0*(1-hsl)+rouw*hsl;
f=pi*(dr/2).^2;  %截面积
a=sqrt(e/rou);

d=dl -sum(f.*x)*(rou-rouy)*9.8; %悬点动态载荷
plot(-u,dl,'k');
hold on

miu=30e-3; %液体粘度
l=0.95; %曲柄长度
m=dt./dr;
b1=(m.^2-1)./(2*log(m))-1;
b2=m.^4-1-(m.^2-1).^2./log(m);
c=2*pi*miu./(rou*f).*(1./log(m)+4./b2.*(b1+1).*(b1+2/(omiga*l/a/sin(omiga*l/a)+cos(omiga*l/a))));
% c=[1 1 1]*0.1;
nz=20; %n截断数

sigma=zeros(1,nz);
tao=zeros(1,nz);
v=zeros(1,nz);
delta=zeros(1,nz);
o=zeros(1,nz);
p=zeros(1,nz);
o1=zeros(1,nz);
p1=zeros(1,nz);
for i=1:nz
    sigma(i)=2/k*sum(d.*cos(2*i*pi/k*(1:k)));
    tao(i)  =2/k*sum(d.*sin(2*i*pi/k*(1:k)));
    v(i)    =2/k*sum(u.*cos(2*i*pi/k*(1:k)));
    delta(i)=2/k*sum(u.*sin(2*i*pi/k*(1:k)));
end
    sigma0=2/k*sum(d);
    v0=2/k*sum(u);
for g=1:jie
    for i=1:nz
        alpha=i*omiga/(sqrt(2)*a)*sqrt(1+sqrt(1+(c(g)/(i*omiga))^2));
        beta =i*omiga/(sqrt(2)*a)*sqrt(-1+sqrt(1+(c(g)/(i*omiga))^2));
        ka   =(sigma(i)*alpha+tao(i)*beta)/(e*f(g)*(alpha^2+beta^2));
        miun =(sigma(i)*beta-tao(i)*alpha)/(e*f(g)*(alpha^2+beta^2));
        o(i) =(ka*cosh(beta*x(g))+delta(i)*sinh(beta*x(g)))*sin(alpha*x(g))+(miun*sinh(beta*x(g))+v(i)*cosh(beta*x(g)))*cos(alpha*x(g));
        p(i) =(ka*sinh(beta*x(g))+delta(i)*cosh(beta*x(g)))*cos(alpha*x(g))-(miun*cosh(beta*x(g))+v(i)*sinh(beta*x(g)))*sin(alpha*x(g));
        o1(i)=((delta(i)*beta-v(i)*alpha)*cosh(beta*x(g))+tao(i)/(e*f(g))*sinh(beta*x(g)))*sin(alpha*x(g))+((v(i)*beta+delta(i)*alpha)*sinh(beta*x(g))+sigma(i)/(e*f(g))*cosh(beta*x(g)))*cos(alpha*x(g));
        p1(i)=((delta(i)*beta-v(i)*alpha)*sinh(beta*x(g))+tao(i)/(e*f(g))*cosh(beta*x(g)))*cos(alpha*x(g))-((v(i)*beta+delta(i)*alpha)*cosh(beta*x(g))+sigma(i)/(e*f(g))*sinh(beta*x(g)))*sin(alpha*x(g));
    end
    if g==jie
        for i=1:k
        uu(i)=sigma0/(2*e*f(g))*x(g)+v0/2+sum(o.*cos(i*2*pi/k*(1:nz))+p.*sin(i*2*pi/k*(1:nz)));
        dd(i)=sigma0/2+e*f(g)*sum(o1.*cos(i*2*pi/k*(1:nz))+p1.*sin(i*2*pi/k*(1:nz)))+f.*x*[zeros(g,1);ones(jie-g,1)]*(rou-rouy)*9.8;
        end
        plot(-uu,dd,'k-');
        break;
    end
    v0=v0+sigma0*x(g)/(e*f(g));
    sigma=e*f(g)*o1;
    tao=e*f(g)*p1;
    v=o;
    delta=p;
    for i=1:k
        uu(i)=sigma0/(2*e*f(g))*x(g)+v0/2+sum(o.*cos(i*2*pi/k*(1:nz))+p.*sin(i*2*pi/k*(1:nz)));
        dd(i)=sigma0/2+e*f(g)*sum(o1.*cos(i*2*pi/k*(1:nz))+p1.*sin(i*2*pi/k*(1:nz)))+f.*x*[zeros(g,1);ones(jie-g,1)]*(rou-rouy)*9.8;
    end
    plot(-uu,dd);
end
grid on;
hold off;
    


