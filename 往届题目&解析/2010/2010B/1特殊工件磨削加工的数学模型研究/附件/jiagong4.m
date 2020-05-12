clear;
R=300;    %中台转轴到控制丝杠——螺母副中心线的距离
n=40;
d2=n*1/300;
x2=0:d2:600;
y2=30*exp(-x2/400).*sin(1/100*(x2+25*pi))+130;
for i=1:length(x2)
    yr2(i)=round(y2(i)*300);
    k2(i)=-1/400*30*exp(-x2(i)/400)*sin(1/100*(x2(i)+25*pi))+1/100*30*exp(-x2(i)/400)*cos(1/100*(x2(i)+25*pi));
end
plot(x2,y2)
hold on;
plot(x2,yr2/300,'.r');
xg2=d2*300;      %加工时x方向上一个步长需要的脉冲数
xt2=xg2/80;      %在x方向工作频率为每秒80脉冲时一个步长所需时间
for i=1:(600/n*300)
    yg2(i)=yr2(i+1)-yr2(i);   %加工时y方向的步长
end
yf2=yg2/xt2;      %在x方向一个步长时间内y方向所需频率
j=0;
s=0;
s1=0;
for i=1:(600/n*300)
    if s==0
        if s1==0
        thetag2(i)=-round(tan(0.1)*R*300);   %每一步所需转角
        j=j+1;
        if j==round(round(120/(0.1*180)*pi)/2)
            s1=1;
            j=0;
            s=1;
        end
        end
        thetag2(i)=-round(tan(0.1)*R*300);   %每一步所需转角
        j=j+1;
        if j==round(120/(0.1*180)*pi)
            j=0;
            s=1;
        end
    end
    if s==1
        thetag2(i)=round(tan(0.1)*R*300);   %每一步所需转角
        j=j+1;
        if j==round(120/(0.1*180)*pi)
            j=0;
            s=0;
        end
    end
    
end
thetaf2=thetag2/xt2;                %在x方向一个步长时间内转角所需频率
maxh2=max(abs(yr2-y2*300))/300;