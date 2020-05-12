function [uu,dd]=fgibbs(u,dl,c,jie,x,dr,n,hsl)

k=length(u);
omiga=n*pi/30;
uu=zeros(size(u));
dd=zeros(size(dl));
e=2.1e+11; %弹性模量
rou=8456; %抽油杆密度
rou0=864/1.025; %原油密度
rouw=1000; %水的密度
rouy=rou0*(1-hsl)+rouw*hsl;
f=pi*(dr/2).^2;  %截面积
a=sqrt(e/rou);
d=dl-sum(f.*x)*(rou-rouy)*9.8; %悬点动态载荷

% plot(-u,dl,'k');
% hold on

c=ones(jie,1)*c;
nz=20; %n截断数


o=zeros(1,nz);
p=zeros(1,nz);
o1=zeros(1,nz);
p1=zeros(1,nz);
for g=1:jie
    for i=1:nz
        sigma=2/k*sum(d.*cos(2*i*pi/k*(1:k)));
        tao  =2/k*sum(d.*sin(2*i*pi/k*(1:k)));
        v    =2/k*sum(u.*cos(2*i*pi/k*(1:k)));
        delta=2/k*sum(u.*sin(2*i*pi/k*(1:k)));
        alpha=i*omiga/(sqrt(2)*a)*sqrt(1+sqrt(1+(c(g)/(i*omiga))^2));
        beta =i*omiga/(sqrt(2)*a)*sqrt(-1+sqrt(1+(c(g)/(i*omiga))^2));
        ka   =(sigma*alpha+tao*beta)/(e*f(g)*(alpha^2+beta^2));
        miun =(sigma*beta-tao*alpha)/(e*f(g)*(alpha^2+beta^2));
        o(i) =(ka*cosh(beta*x(g))+delta*sinh(beta*x(g)))*sin(alpha*x(g))+(miun*sinh(beta*x(g))+v*cosh(beta*x(g)))*cos(alpha*x(g));
        p(i) =(ka*sinh(beta*x(g))+delta*cosh(beta*x(g)))*cos(alpha*x(g))-(miun*cosh(beta*x(g))+v*sinh(beta*x(g)))*sin(alpha*x(g));
        o1(i)=((delta*beta-v*alpha)*cosh(beta*x(g))+tao/(e*f(g))*sinh(beta*x(g)))*sin(alpha*x(g))+((v*beta+delta*alpha)*sinh(beta*x(g))+sigma/(e*f(g))*cosh(beta*x(g)))*cos(alpha*x(g));
        p1(i)=((delta*beta-v*alpha)*sinh(beta*x(g))+tao/(e*f(g))*cosh(beta*x(g)))*cos(alpha*x(g))-((v*beta+delta*alpha)*cosh(beta*x(g))+sigma/(e*f(g))*sinh(beta*x(g)))*sin(alpha*x(g));
    end
    sigma0=2/k*sum(d);
    v0=2/k*sum(u);
    for i=1:k
        u(i)=sigma0/(2*e*f(g))*x(g)+v0/2+sum(o.*cos(i*2*pi/k*(1:nz))+p.*sin(i*2*pi/k*(1:nz)));
        d(i)=sigma0/2+e*f(g)*sum(o1.*cos(i*2*pi/k*(1:nz))+p1.*sin(i*2*pi/k*(1:nz)));
        dd(i)=d(i)+f.*x*[zeros(g,1);ones(jie-g,1)]*(rou-rouy)*9.8;
    end
    uu=u;
%     plot(-uu,dd);
end
end
    


