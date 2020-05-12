 
function out=myfun_siglechang1(t)
r=21;%r为单位时间内车辆的平均到达率；
m=1;
n=12;
y21=poissrnd(r,m,n)  % 得m*n阶矩阵



i=1:12;
s(i)=1.5;%饱和流量设为1.5

j=1:4;

na=y21/30;
A=reshape(na,4,3)
V=max(A');
z=sum(V);
T=(t(j)*z)/(V(j)/1.5)





%T(j)=sum(t); %T=70;             %设置周期长度
zhiliu(1:12)=5;   %设置各车道初始滞留车辆
na(1:12)=0.2;  %设置各车道平均到达率
p(1:12)=1;     %设置各车道通行时的平均离开率


t1=t(1);t2=t(2);t3=t(3);t4=t(4); %t4=T-sum(t);
zhiliu=zhiliu+na*T;   %计算达到的车辆

te=[T t2 t1 T t4 t3 T t2 t1 T t4 t3]; zhiliu=zhiliu-te.*p; %减去离开的车
zhiliu=max(zhiliu,zeros(size(zhiliu)));   %将负数置0

out=sum(zhiliu);    %滞留车辆总数    %用x0=[10 10 10 40]; [x fval]=fmincon(@myfun_single,x0,[],[],[1 1 1 1],[70],[6 6 6 6],[52 52 52 52]) 的命令优化。其中[1 1 1 1]和[70]表示等式约束：t1+t2+t3+t4=70。
