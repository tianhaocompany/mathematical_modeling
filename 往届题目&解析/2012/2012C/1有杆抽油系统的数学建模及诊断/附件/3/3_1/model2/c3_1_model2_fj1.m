clc
clear

%输入参数
FW=0.98;    %含水量
B0=1.025;  %原油体积系数
BW=1.3;   %水的体积系数
n_cs=7.6;  %冲次（次/分）
D=0.07;  %泵径（米）
S=3.2;   %悬点冲程（米）
rou_oil=864;  %原油密度（kg/m3)
rou_water=1000;   %水密度（kg/m3)
g=9.8;    %重力加速度
L=792.5;  %抽油杆总长度
DL=0.022;   %抽油杆直径
E=2.1*10^11;   %钢的弹性模量


%求理论示功图面积
fp=pi*(D/2)^2;   %活塞横截面积
rou_hunhe=rou_oil*(1-FW)+rou_water*FW;   %含水的油密度
WL=fp*L*rou_hunhe*g;  %抽油机上、下冲程中杆柱和管柱之间转移的载荷
fr=pi*(DL/2)^2;  %抽油杆横截面积
lamda=WL/E*(L/fr); %静载冲程损失
Sp=S-lamda;    %柱塞冲程长度   
Area_LL=0.5*WL*Sp;

%理论产量
yita_v=1/((1-FW)*B0+FW*BW);    %混合物的体积系数 (m3/m3)
Q_LL=1440*fp*Sp*n_cs*yita_v*rou_hunhe;

%读入示功数据
[s,f]=textread('result1.txt','%f %f');

%确定数据的个数
[r,c]=size(s);
NUM=r*c;

%用五点平均法求每一点的坐标平均值
for i=3:(NUM-2)
    sp(i)=(s(i-2)+s(i-1)+s(i)+s(i+1)+s(i+2))/5;
    fp(i)=(f(i-2)+f(i-1)+f(i)+f(i+1)+f(i+2))/5;
end
sp(1)=(s(NUM-1)+s(NUM)+s(1)+s(2)+s(3))/5;
sp(2)=(s(NUM)+s(1)+s(2)+s(3)+s(4))/5;
sp(NUM-1)=(s(NUM-3)+s(NUM-2)+s(NUM-1)+s(NUM)+s(1))/5;
sp(NUM)=(s(NUM-2)+s(NUM-1)+s(NUM)+s(1)+s(2))/5;
fp(1)=(f(NUM-1)+f(NUM)+f(1)+f(2)+f(3))/5;
fp(2)=(f(NUM)+f(1)+f(2)+f(3)+f(4))/5;
fp(NUM-1)=(f(NUM-3)+f(NUM-2)+f(NUM-1)+f(NUM)+f(1))/5;
fp(NUM)=(f(NUM-2)+f(NUM-1)+f(NUM)+f(1)+f(2))/5;

%沿柱塞冲程展开
for i=2:NUM
    if (sp(i)-sp(i-1))<0
        j=i;
        break;
    end
end

%上冲程
for i=1:j-1;
    s_s(i)=sp(i);
    f_s(i)=fp(i)*1000;
end

%下冲程
for i=j:NUM;
    s_x(NUM-i+1)=sp(i);
    f_x(NUM-i+1)=fp(i)*1000;
end

n_s=j-1;
n_x=NUM-j+1;
%保证下冲程与上冲程端点相同
for i=n_x:-1:1
    s_x(i+1)=s_x(i);
    f_x(i+1)=f_x(i);
end
s_x(1)=s_s(1);
f_x(1)=f_s(1);
s_x(n_x+2)=s_s(n_s);
f_x(n_x+2)=f_s(n_s);
n_x=n_x+2;


%求泵示功图的面积
s_b=s_s(1);
s_e=s_s(n_s);
n_ds=200;       %将图形化为200份来计算
ds=(s_e-s_b)/n_ds;    %ds为每份的长度
Area_bgt=0;
for i=1:n_ds
    s_ds=s_b+(i-0.5)*ds;
    
    %求上冲程位置
    for j=1:n_s
        if s_ds<s_s(j)
            k=j;
            break;
        end
    end
    fa_s=(s_ds-s_s(k-1))/(s_s(k)-s_s(k-1))*(f_s(k)-f_s(k-1))+f_s(k-1);
    
    %求下冲程位置
    for j=1:n_x
        if s_ds<s_x(j)
            k=j;
            break;
        end
    end
    fa_x=(s_ds-s_x(k-1))/(s_x(k)-s_x(k-1))*(f_x(k)-f_x(k-1))+f_x(k-1);
    
    Area_bgt=(fa_s-fa_x)*ds;
end

%实际产量
Q_SJ=Area_bgt/Area_LL*Q_LL;
