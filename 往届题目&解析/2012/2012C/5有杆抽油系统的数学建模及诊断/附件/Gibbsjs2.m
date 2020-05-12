clc;clear;
D=xlsread('DINPUT2.xls');u=xlsread('UINPUT2.xls');t=xlsread('TINPUT2.xls');
K=143;n=100;pi=3.1415926;a=4983.416;T=3;
omega=2*pi*4/60;E=2.1*(10^11);v=0.6347;
x=[523.61 664.32 618.35];L=1819.56;
d1=[0.025 0.022 0.019];Ar1=zeros(1,T);
for i=1:3
    Ar1(i)=pi*((d1(i))^2)/4;
end
%------------------------------------------------------------------
%傅里叶系数数值积分计算
sigma=zeros(n,1);tau=zeros(n,1);gamma=zeros(n,1);delta=zeros(n,1);
sigma0=(2/K)*sum(D(1:K));
gamma0=(2/K)*sum(u(1:K));
for i=1:n
    for p=1:K
        sigma(i)=sigma(i)+(2/K)*D(p)*cos(2*pi*i*p/K);
        tau(i)=tau(i)+(2/K)*D(p)*sin(2*pi*i*p/K);
        gamma(i)=gamma(i)+(2/K)*u(p)*cos(2*pi*i*p/K);
        delta(i)=delta(i)+(2/K)*u(p)*sin(2*pi*i*p/K);
    end
end
%-------------------------------------------------------------------
for q=1:T
%Gibbs方法求解阻尼系数
cd=2.29595-44.32202*v+459.29115*v^2-2790.90409*v^3+10451.0482*v^4-...
    24714.8911*v^5+36933.77379*v^6-33779.575*v^7+17244.66252*v^8-...
    3761.98482*v^9;
c=pi*a*cd/(2*L);
%计算特殊系数
alpha=zeros(n,1);beta=zeros(n,1);
for i=1:n
    alpha(i)=((i*omega)/(a*2^0.5))*(1+(1+(c/(i*omega))^2)^0.5)^0.5;
    beta(i)=((i*omega)/(a*2^0.5))*(-1+(1+(c/(i*omega))^2)^0.5)^0.5; 
end
%计算位移函数和载荷函数中的系数
kappa=zeros(n,1);mu=zeros(n,1);On=zeros(n,1);
Pn=zeros(n,1);dOn=zeros(n,1);dPn=zeros(n,1);
for i=1:n
    kappa(i)=(sigma(i)*alpha(i)+tau(i)*beta(i))/...
        (E*Ar1(q)*(alpha(i)^2+beta(i)^2));
    mu(i)=(sigma(i)*beta(i)-tau(i)*alpha(i))/...
        (E*Ar1(q)*(alpha(i)^2+beta(i)^2));
    On(i)=(kappa(i)*cosh(beta(i)*x(q))+delta(i)*...
        sinh(beta(i)*x(q)))*sin(alpha(i)*x(q))+...
        (mu(i)*sinh(beta(i)*x(q))+gamma(i)*...
        cosh(beta(i)*x(q)))*cos(alpha(i)*x(q));
    Pn(i)=(kappa(i)*sinh(beta(i)*x(q))+delta(i)*...
        cosh(beta(i)*x(q)))*cos(alpha(i)*x(q))-...
        (mu(i)*cosh(beta(i)*x(q))+gamma(i)*...
        sinh(beta(i)*x(q)))*sin(alpha(i)*x(q));
    dOn(i)=(tau(i)*sinh(beta(i)*x(q))/(E*Ar1(q))+...
        (delta(i)*beta(i)-gamma(i)*alpha(i))*cosh(beta(i)*x(q)))*...
        sin(alpha(i)*x(q))+(sigma(i)*cosh(beta(i)*x(q))/(E*Ar1(q))+...
        (gamma(i)*beta(i)+delta(i)*alpha(i))*sinh(beta(i)*x(q)))*...
        cos(alpha(i)*x(q));
    dPn(i)=(tau(i)*cosh(beta(i)*x(q))/(E*Ar1(q))+...
        (delta(i)*beta(i)-gamma(i)*alpha(i))*sinh(beta(i)*x(q)))*...
        cos(alpha(i)*x(q))+(sigma(i)*sinh(beta(i)*x(q))/(E*Ar1(q))+...
        (gamma(i)*beta(i)+delta(i)*alpha(i))*cosh(beta(i)*x(q)))*...
        sin(alpha(i)*x(q));
end
%计算位移函数和载荷函数
zjbl1=0;zjbl2=0;
u1=zeros(K,1);D1=zeros(K,1);
for p=1:K
    zjbl1=0;zjbl2=0;
    for i=1:n
        zjbl1=zjbl1+On(i)*cos(i*omega*t(p))+Pn(i)*sin(i*omega*t(p));
        zjbl2=zjbl2+dOn(i)*cos(i*omega*t(p))+dPn(i)*sin(i*omega*t(p));
    end
    u1(p)=(sigma0*x(q))/(2*E*Ar1(q))+gamma0/2+zjbl1;
    D1(p)=(sigma0/2+E*Ar1(q)*zjbl2)/1000;
end
%计算新的边界条件
gamma0=sigma0*x(q)/(E*Ar1(q))+gamma0;
for i=1:n
    sigma(i)=E*Ar1(q)*dOn(i);
    tau(i)=E*Ar1(q)*dPn(i);
    gamma(i)=On(i);
    delta(i)=Pn(i);
end
end













