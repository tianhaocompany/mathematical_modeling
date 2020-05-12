%求小实心方体的X,Y
%type: 投放方式，1表示平放，2表示立放，3表示竖放
%v0:   水流的初始速度
%h0：  投放高度
%k
function calSmallXY(type,v0,h0,k)
if(type==1)%平放
    Sx=0.0008; %x方向的受力面积
    Sy=0.0016; %y方向的受力面积
elseif(type==2)%立放
    Sx=0.0016;
    Sy=0.0008;
elseif(type==3)%竖放
    Sx=0.0008;
    Sy=0.0008;
end;
V=3.2*10^-5; %体积
m=V*2300;
mf=V*1000;
t=linspace(0,1.0,100);
x=v0*t-(m+mf)/(k*Sx)*(log(k*Sx*v0*t+(m+mf)))+(m+mf)/(k*Sx)*log(m+mf);
A=(m-mf)/(k/v0*Sy);
B=sqrt((m*9.8-1000*V*9.8)/(k/v0*Sy));
V2=m*sqrt(2*9.8*h0)/(m+mf);
C4=(-V2-B)/(B-V2);
y=0.275+B*t-A*log(1-C4*exp(2*B*t/A))+A*log(1-C4);

x1=[2.5	2.7	3.2	4.5	5.5	7	8.6	9	11.5	12.5	14.5	16]/100;
y1=[26	25.5	22.5	21.5	18.5	16.5	13.8	12	9	6	4	2]/100;
x1=x1-0.02;

plot(x,y);
hold on;
plot(x1,y1,'r+');
xlabel('水平位移x');
ylabel('竖直位移y');
title('大实心方块模型数据和真实数据对比图--平放速度34高度12');
