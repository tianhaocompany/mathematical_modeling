clc
clear

%输入参数
FW=0.912;    %含水量
B0=1.025;  %原油体积系数
BW=1.3;   %水的体积系数
n_cs=4;  %冲次（次/分）
D=0.044;  %泵径（米）
rou_oil=864;  %原油密度（kg/m3)
rou_water=1000;   %水密度（kg/m3)

%读入示功数据
[x,y]=textread('result2.txt','%f %f');

%确定数据的个数
[r,c]=size(x);
NUM=r*c;

%用五点平均法求每一点的坐标平均值
for i=3:(NUM-2)
    xp(i)=(x(i-2)+x(i-1)+x(i)+x(i+1)+x(i+2))/5;
    yp(i)=(y(i-2)+y(i-1)+y(i)+y(i+1)+y(i+2))/5;
end
xp(1)=(x(NUM-1)+x(NUM)+x(1)+x(2)+x(3))/5;
xp(2)=(x(NUM)+x(1)+x(2)+x(3)+x(4))/5;
xp(NUM-1)=(x(NUM-3)+x(NUM-2)+x(NUM-1)+x(NUM)+x(1))/5;
xp(NUM)=(x(NUM-2)+x(NUM-1)+x(NUM)+x(1)+x(2))/5;
yp(1)=(y(NUM-1)+y(NUM)+y(1)+y(2)+y(3))/5;
yp(2)=(y(NUM)+y(1)+y(2)+y(3)+y(4))/5;
yp(NUM-1)=(y(NUM-3)+y(NUM-2)+y(NUM-1)+y(NUM)+y(1))/5;
yp(NUM)=(y(NUM-2)+y(NUM-1)+y(NUM)+y(1)+y(2))/5;

%求坐标的最大与最小值
xp_max=max(xp);
xp_min=min(xp);
yp_max=max(yp);
yp_min=min(yp);

%离散点归一化
for i=1:NUM
    xpg(i)=(xp(i)-xp_min)/(xp_max-xp_min);
    ypg(i)=(yp(i)-yp_min)/(yp_max-yp_min);
end

%沿柱塞冲程展开
for i=2:NUM
    if (xpg(i)-xpg(i-1))<0
        j=i;
        break;
    end
end

for i=1:j-1;
    xpgz(i)=xpg(i);
end

for i=j:NUM;
    xpgz(i)=2.0-xpg(i);
end

for i=1:NUM;
    ypgz(i)=ypg(i);
end

%求曲率
for i=2:(NUM-1)
    L0(i)=sqrt((ypgz(i)-ypgz(i-1))^2+(xpgz(i)-xpgz(i-1))^2);
    L1(i)=sqrt((ypgz(i+1)-ypgz(i))^2+(xpgz(i+1)-xpgz(i))^2);
    L2(i)=sqrt((ypgz(i-1)-ypgz(i+1))^2+(xpgz(i-1)-xpgz(i+1))^2);    
end

L0(1)=sqrt((ypgz(1)-ypgz(NUM))^2+(xpgz(1)-(2-xpgz(NUM)))^2);
L1(1)=sqrt((ypgz(2)-ypgz(1))^2+(xpgz(2)-xpgz(1))^2);
L2(1)=sqrt((ypgz(NUM)-ypgz(2))^2+((2-xpgz(NUM))-xpgz(2))^2);

L0(NUM)=sqrt((ypgz(NUM)-ypgz(NUM-1))^2+(xpgz(NUM)-xpgz(NUM-1))^2);
L1(NUM)=sqrt((ypgz(1)-ypgz(NUM))^2+(xpgz(1)-(2-xpgz(NUM)))^2);
L2(NUM)=sqrt((ypgz(NUM-1)-ypgz(1))^2+((2-xpgz(NUM-1))-xpgz(1))^2);

for i=1:NUM
    P(i)=(L0(i)+L1(i)+L2(i))/2;
    S_dlt(i)=sqrt(P(i)*(P(i)-L0(i))*(P(i)-L1(i))*(P(i)-L2(i)));
    K(i)=4*S_dlt(i)/(L0(i)*L1(i)*L2(i));
end

%求曲率变化率
for i=1:(NUM-1)
    dlt(i)=abs(K(i+1)-K(i));
end

dlt(NUM)=abs(K(NUM)-K(1));

%采用五点法求曲率变化量的平均值
for i=3:(NUM-2)
    dlt2(i)=(dlt(i-2)+dlt(i-1)+dlt(i)+dlt(i+1)+dlt(i+2))/5;
end

dlt2(1)=(dlt(NUM-1)+dlt(NUM)+dlt(1)+dlt(2)+dlt(3))/5;
dlt2(2)=(dlt(NUM)+dlt(1)+dlt(2)+dlt(3)+dlt(4))/5;    
dlt2(NUM-1)=(dlt(NUM-3)+dlt(NUM-2)+dlt(NUM-1)+dlt(NUM)+dlt(1))/5;    
dlt2(NUM)=(dlt(NUM-2)+dlt(NUM-1)+dlt(NUM)+dlt(1)+dlt(2))/5;


x_ma=0;
y_ma=0;
x_mb=0;
y_mb=0;
x_mc=0;
y_mc=0;
x_md=0;
y_md=0;
%上冲程，固定阀开闭点
%求B点
dlt2_max=0;
for i=1:NUM
    if(ypgz(i)>0.6)
        if(xpgz(i)<0.5 && xpgz(i)>0)
            if(dlt2(i)>dlt2_max)
                    x_mb=xpgz(i);
                    y_mb=ypgz(i);
                    dlt2_max=dlt2(i);
            end
        end
    end
end



%求C点
dlt2_max=0;
for i=1:NUM
    if(ypgz(i)>0.6)
        if(xpgz(i)>(x_mb+0.1) && xpgz(i)<1)
            if(dlt2(i)>dlt2_max)
                    x_mc=xpgz(i);
                    y_mc=ypgz(i);
                    dlt2_max=dlt2(i);
            end
        end
    end
end



%下冲程，游动阀开闭点
%求A点
dlt2_max=0;
for i=1:NUM
    if(ypgz(i)<0.4)
        if(xpgz(i)<2 && xpgz(i)>1.5)
            if(dlt2(i)>dlt2_max)
                    x_ma=xpgz(i);
                    y_ma=ypgz(i);
                    dlt2_max=dlt2(i);
            end
        end
    end
end



%求D点
dlt2_max=0;
for i=1:NUM
    if(ypgz(i)<0.4)
        if(xpgz(i)<(x_ma-0.1) && xpgz(i)>1)
            if(dlt2(i)>dlt2_max)
                    x_md=xpgz(i);
                    y_md=ypgz(i);
                    dlt2_max=dlt2(i);
            end
        end
    end
end


if(x_ma>1)
    x_ma=2-x_ma;
end
x_ma=x_ma*(xp_max-xp_min)+xp_min;
y_ma=y_ma*(yp_max-yp_min)+yp_min;

if(x_mb>1)
    x_mb=2-x_mb;
end
x_mb=x_mb*(xp_max-xp_min)+xp_min;
y_mb=y_mb*(yp_max-yp_min)+yp_min;

if(x_mc>1)
    x_mc=2-x_mc;
end
x_mc=x_mc*(xp_max-xp_min)+xp_min;
y_mc=y_mc*(yp_max-yp_min)+yp_min;

if(x_md>1)
    x_md=2-x_md;
end
x_md=x_md*(xp_max-xp_min)+xp_min;
y_md=y_md*(yp_max-yp_min)+yp_min;

%上冲程固定阀开闭之间的距离
SRg=abs(x_mb-x_mc);   

%下冲程游动阀关闭之间的距离
SRy=abs(x_ma-x_md); 

%求有效冲程
Spe=min(SRg,SRy);

%求油井一天的产液量
yita_v=1/((1-FW)*B0+FW*BW);
rou_hunhe=rou_oil*(1-FW)+rou_water*FW;   %含水的油密度
Qd=1440*yita_v*Spe*n_cs*pi*(D/2)^2*rou_hunhe;   %(千克/天)
 
plot(x,y,'k');
hold on;
xlabel('位移/m');
ylabel('载荷/N');
plot(x_ma,y_ma,'k*',x_mb,y_mb,'k*',x_mc,y_mc,'k*',x_md,y_md,'k*');
hold on;


