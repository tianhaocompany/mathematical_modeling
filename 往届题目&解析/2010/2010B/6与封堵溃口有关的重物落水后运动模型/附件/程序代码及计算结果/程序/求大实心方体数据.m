%求大实心方体的X,Y
%type: 投放方式，1表示平放，2表示立放，3表示竖放
%v0:   水流的初始速度
%h0：  投放高度
%k
function calBigXY(type,v0,h0,k)
if(type==1)%平放
    Sx=0.0032; %x方向的受力面积
    Sy=0.0064; %y方向的受力面积
elseif(type==2)%立放
    Sx=0.0064;
    Sy=0.0032;
elseif(type==3)%竖放
    Sx=0.0032;
    Sy=0.0032;
end;
V=2.56*10^-4; %体积
m=V*2300;
mf=V*1000;
t=linspace(0,1.0,100);
x=v0*t-(m+mf)/(k*Sx)*(log(k*Sx*v0*t+(m+mf)))+(m+mf)/(k*Sx)*log(m+mf);
A=(m-mf)/(k/v0*Sy);
B=sqrt((m*9.8-1000*V*9.8)/(k/v0*Sy));
V2=m*sqrt(2*9.8*h0)/(m+mf);
C4=(-V2-B)/(B-V2);
y=0.275+B*t-A*log(1-C4*exp(2*B*t/A))+A*log(1-C4);

x1=[2.7	2.9	3.1	3.5	3.9	4.4	5.6	7	8.5	9.5	11]/100;
y1=[26.1	25	23.5	21.5	19.4	17.5	14	11.5	8.5	5	2.8]/100;
x1=x1-0.025;

plot(x,y);
hold on;
plot(x1,y1,'r+');
xlabel('水平位移x');
ylabel('竖直位移y');
title('大实心方块模型数据和真实数据对比图--平放速度34高度12');