clear;
R=300;    %中台转轴到控制丝杠——螺母副中心线的距离
n=40;
d1=n*1/300;
x1=0:d1:600;
y1=-7/(18000)*(600-x1).^2+0.45*(600-x1);
for i=1:length(x1)
    yr1(i)=round(y1(i)*300);
    k1(i)=14/18000*(600-x1(i))-0.45;
end
plot(x1,y1)
hold on;
plot(x1,yr1/300,'.r');
xg1=d1*300;      %加工时x方向上一个步长需要的脉冲数
xt1=xg1/80;      %在x方向工作频率为每秒80脉冲时一个步长所需时间
for i=1:(600/n*300)
    yg1(i)=yr1(i+1)-yr1(i);   %加工时y方向的步长
end
yf1=yg1/xt1;      %在x方向一个步长时间内y方向所需频率
theta1=atan(k1);
for i=1:(600/n*300)
    thetag1(i)=theta1(i+1)-theta1(i);   %每一步所需转角
end
thetag1=round(tan(thetag1)*R*300);         %转角对应的脉冲数
thetaf1=thetag1/xt1;                %在x方向一个步长时间内转角所需频率
maxh1=max(abs(yr1-y1*300))/300;
