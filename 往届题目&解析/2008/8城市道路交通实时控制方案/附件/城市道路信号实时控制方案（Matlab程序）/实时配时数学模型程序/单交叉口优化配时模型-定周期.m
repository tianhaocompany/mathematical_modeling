 
function out=myfun_sigle(t)

T=sum(t); %T=70;             %设置周期长度
zhiliu(1:12)=5;   %设置各车道初始滞留车辆
na(1:12)=0.2;  %设置各车道平均到达率
p(1:12)=1;     %设置各车道通行时的平均离开率

na(3)=0.8;    %假设3，9方向来车多，5，11方向来车少
na(9)=0.8;
na(5)=0.1;
na(11)=0.1;

t1=t(1);t2=t(2);t3=t(3);t4=t(4); %t4=T-sum(t);
zhiliu=zhiliu+na*T;   %计算达到的车辆

te=[T t2 t1 T t4 t3 T t2 t1 T t4 t3]; zhiliu=zhiliu-te.*p; %减去离开的车
zhiliu=max(zhiliu,zeros(size(zhiliu)));   %将负数置0

out=sum(zhiliu);    %滞留车辆总数    %用x0=[10 10 10 40]; [x fval]=fmincon(@myfun_single,x0,[],[],[1 1 1 1],[70],[6 6 6 6],[52 52 52 52]) 的命令优化。其中[1 1 1 1]和[70]表示等式约束：t1+t2+t3+t4=70。
zhiliu