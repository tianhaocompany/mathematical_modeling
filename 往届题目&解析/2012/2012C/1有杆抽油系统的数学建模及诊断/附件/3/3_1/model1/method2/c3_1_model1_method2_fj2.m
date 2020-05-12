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

for i=1:NUM
    xp(i)=x(i);
    yp(i)=y(i);
end


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

%做等s取点
FS=200;%分成多少份，可以调
for i=1:FS   
    s(i)=2/FS*(i-1);
    for j=2:NUM
        if(s(i)<xpgz(j))
            f(i)=(s(i)-xpgz(j-1))/(xpgz(j)-xpgz(j-1))*(ypgz(j)-ypgz(j-1))+ypgz(j-1);
            break;
        end
    end
end

%求曲率
%cita_dlt=zeros(1,FS); 
for i=3:FS-2
    mm=(f(i)-f(i+2))*(s(i)-s(i-2))-(f(i)-f(i-2))*(s(i)-s(i+2));
    nn=1+(s(i)-s(i-2))*(s(i)-s(i+2));
    cita_dlt(i)=atan(mm/nn);  %结果为弧度
end

mm=(f(1)-f(3))*0.02-(f(1)-f(FS-1))*(-0.02);
nn=1+0.02*(-0.02);
cita_dlt(1)=atan(mm/nn);  %结果为弧度

mm=(f(2)-f(4))*0.02-(f(2)-f(FS))*(-0.02);
nn=1+0.02*(-0.02);
cita_dlt(2)=atan(mm/nn);  %结果为弧度

mm=(f(FS-1)-f(1))*0.02-(f(FS-1)-f(FS-3))*(-0.02);
nn=1+0.02*(-0.02);
cita_dlt(FS-1)=atan(mm/nn);  %结果为弧度
    
mm=(f(FS)-f(2))*0.02-(f(FS)-f(FS-2))*(-0.02);
nn=1+0.02*(-0.02);
cita_dlt(FS)=atan(mm/nn);  %结果为弧度

for i=2:FS-1
    mm=(s(i+1)-s(i))^2+(f(i+1)-f(i))^2;
    nn=(s(i)-s(i-1))^2+(f(i)-f(i-1))^2;
    l_dlt(i)=sqrt(mm)+sqrt(nn);
end

mm=0.01^2+(f(2)-f(1))^2;
nn=(-0.01)^2+(f(1)-f(FS))^2;
l_dlt(1)=sqrt(mm)+sqrt(nn);

mm=0.01^2+(f(1)-f(FS))^2;
nn=(-0.01)^2+(f(FS)-f(FS-1))^2;
l_dlt(FS)=sqrt(mm)+sqrt(nn);

for i=1:FS
    K(i)=cita_dlt(i)/l_dlt(i);
end

%求曲率变化率
for i=1:(FS-1)
    K_dlt(i)=abs(K(i+1)-K(i));
end

K_dlt(FS)=abs(K(FS)-K(1));

%采用3点法求曲率变化量的平均值
for i=2:(FS-1)
    K_dlt2(i)=(K_dlt(i-1)+K_dlt(i)+K_dlt(i+1))/3;
end

K_dlt2(1)=(K_dlt(FS)+K_dlt(1)+K_dlt(2))/3;
K_dlt2(FS)=(K_dlt(FS-1)+K_dlt(FS)+K_dlt(1))/3;


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
K_dlt2_max=0;
for i=1:FS
    if(f(i)>0.6)
        if(s(i)<0.5 && s(i)>0)
            if(K_dlt2(i)>K_dlt2_max)
                    x_mb=s(i);
                    y_mb=f(i);
                    K_dlt2_max=K_dlt2(i);
            end
        end
    end
end



%求C点
K_dlt2_max=0;
for i=1:FS

    if(f(i)>0.6)
        if(s(i)>(x_mb+0.1) && s(i)<1)
            if(K_dlt2(i)>K_dlt2_max)
                    x_mc=s(i);
                    y_mc=f(i);
                    K_dlt2_max=K_dlt2(i);
            end
        end
    end
end



%下冲程，游动阀开闭点
%求A点
K_dlt2_max=0;
for i=1:FS
    if(f(i)<0.4)
        if(s(i)<2 && s(i)>1.5)
            if(K_dlt2(i)>K_dlt2_max)
                    x_ma=s(i);
                    y_ma=f(i);
                    K_dlt2_max=K_dlt2(i);
            end
        end
    end
end



%求D点
K_dlt2_max=0;
for i=1:FS
    if(f(i)<0.4)
        if(s(i)<(x_ma-0.1) && s(i)>1)
            if(K_dlt2(i)>K_dlt2_max)
                    x_md=s(i);
                    y_md=f(i);
                    K_dlt2_max=K_dlt2(i);
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
plot(x_ma,y_ma,'ko',x_mb,y_mb,'ko',x_mc,y_mc,'ko',x_md,y_md,'ko');
hold on;
