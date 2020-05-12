%求大空心方体的X,Y
%type: 投放方式，1表示平放，2表示立放，3表示竖放
%v0:   水流的初始速度
%h0：  投放高度
%k
function calAllXY(type,v0,h0,N)
if(N==1) %大实心方体
    V=2.56*10^-4; %体积
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
elseif(N==2) %小实心方体
     V=3.2*10^-5; %体积
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
elseif(N==3) %大空心方体
    V=1.92*10^-4; %体积
    if(type==1)%平放
        Sx=0.0032; %x方向的受力面积
        Sy=0.0048; %y方向的受力面积
    elseif(type==2)%立放
        Sx=0.0048;
        Sy=0.0032;
    elseif(type==3)%竖放
        Sx=0.0032;
        Sy=0.0032;
    end;
elseif(N==4) %小空心方体
    V=2.4*10^-5; %体积
    if(type==1)%平放
        Sx=0.0008; %x方向的受力面积
        Sy=0.0012; %y方向的受力面积
    elseif(type==2)%立放
        Sx=0.0012;
        Sy=0.0008;
    elseif(type==3)%竖放
        Sx=0.0008;
        Sy=0.0008;
    end;
elseif(N==5) %大实心蜂巢
    V=1.6238*10^-4; %体积
    if(type==1)%平放
        Sx=0.0021651; %x方向的受力面积
        Sy=0.0064952; %y方向的受力面积
    elseif(type==2)%立放
        Sx=0.0064952;
        Sy=0.0021651;
    elseif(type==3)%竖放
        Sx=0.0021651;
        Sy=0.0021651;
    end;
 elseif(N==6) %小实心蜂巢
     V=1.9476*10^-5; %体积
    if(type==1)%平放
        Sx=0.0005196; %x方向的受力面积
        Sy=0.0016238; %y方向的受力面积
    elseif(type==2)%立放
        Sx=0.0016238;
        Sy=0.0005196;
    elseif(type==3)%竖放
        Sx=0.0005196;
        Sy=0.0005196;
    end;
 elseif(N==7) %大空心蜂巢
     V=1.13293*10^-4; %体积
    if(type==1)%平放
        Sx=0.0021651; %x方向的受力面积
        Sy=0.0044957; %y方向的受力面积
    elseif(type==2)%立放
        Sx=0.0044957;
        Sy=0.0021651;
    elseif(type==3)%竖放
        Sx=0.0021651;
        Sy=0.0021651;
    end;
elseif(N==8) %小空心蜂巢
     V=1.3586*10^-5; %体积
    if(type==1)%平放
        Sx=0.0005196; %x方向的受力面积
        Sy=0.000828; %y方向的受力面积
    elseif(type==2)%立放
        Sx=0.000828;
        Sy=0.0005196;
    elseif(type==3)%竖放
        Sx=0.0005196;
        Sy=0.0005196;
    end;
elseif(N==9) %大三角锥
    V=2.54558*10^-5; %体积
 %   if(type==1)%平放
 %       Sx=0.0032; %x方向的受力面积
 %       Sy=0.0048; %y方向的受力面积
 %   elseif(type==2)%立放
 %      Sx=0.0048;
 %       Sy=0.0032;
 %   elseif(type==3)%竖放
 %       Sx=0.0032;
 %       Sy=0.0032;
 %   end;
        Sx=0.001559;
        Sy=0.001559;
elseif(N==10) %小三角锥
    V=3.181981*10^-6; %体积
        Sx=0.0003097;
        Sy=0.0003097;
 %   if(type==1)%平放
 %       Sx=0.0032; %x方向的受力面积
 %       Sy=0.0048; %y方向的受力面积
 %   elseif(type==2)%立放
 %       Sx=0.0048;
 %       Sy=0.0032;
 %   elseif(type==3)%竖放
 %       Sx=0.0032;
 %      Sy=0.0032;
 %   end;
end;

m=V*2300;
mf=V*1000;
t=linspace(0,1.0,100);

k=950;
x=v0*t-(m+mf)/(k*Sx)*(log(k*Sx*v0*t+(m+mf)))+(m+mf)/(k*Sx)*log(m+mf);
A=(m-mf)/(k/v0*Sy);
B=sqrt((m*9.8-1000*V*9.8)/(k/v0*Sy));
V2=m*sqrt(2*9.8*h0)/(m+mf);
C4=(-V2-B)/(B-V2);
y=0.275+B*t-A*log(1-C4*exp(2*B*t/A))+A*log(1-C4);
plot(x,y,'y');
hold on;

k=1000;
x=v0*t-(m+mf)/(k*Sx)*(log(k*Sx*v0*t+(m+mf)))+(m+mf)/(k*Sx)*log(m+mf);
A=(m-mf)/(k/v0*Sy);
B=sqrt((m*9.8-1000*V*9.8)/(k/v0*Sy));
V2=m*sqrt(2*9.8*h0)/(m+mf);
C4=(-V2-B)/(B-V2);
y=0.275+B*t-A*log(1-C4*exp(2*B*t/A))+A*log(1-C4);
plot(x,y,'r');
hold on;

k=1050;
x=v0*t-(m+mf)/(k*Sx)*(log(k*Sx*v0*t+(m+mf)))+(m+mf)/(k*Sx)*log(m+mf);
A=(m-mf)/(k/v0*Sy);
B=sqrt((m*9.8-1000*V*9.8)/(k/v0*Sy));
V2=m*sqrt(2*9.8*h0)/(m+mf);
C4=(-V2-B)/(B-V2);
y=0.275+B*t-A*log(1-C4*exp(2*B*t/A))+A*log(1-C4);
plot(x,y,'g');
hold on;

k=1100;
x=v0*t-(m+mf)/(k*Sx)*(log(k*Sx*v0*t+(m+mf)))+(m+mf)/(k*Sx)*log(m+mf);
A=(m-mf)/(k/v0*Sy);
B=sqrt((m*9.8-1000*V*9.8)/(k/v0*Sy));
V2=m*sqrt(2*9.8*h0)/(m+mf);
C4=(-V2-B)/(B-V2);
y=0.275+B*t-A*log(1-C4*exp(2*B*t/A))+A*log(1-C4);
plot(x,y,'b');
hold on;

k=1150;
x=v0*t-(m+mf)/(k*Sx)*(log(k*Sx*v0*t+(m+mf)))+(m+mf)/(k*Sx)*log(m+mf);
A=(m-mf)/(k/v0*Sy);
B=sqrt((m*9.8-1000*V*9.8)/(k/v0*Sy));
V2=m*sqrt(2*9.8*h0)/(m+mf);
C4=(-V2-B)/(B-V2);
y=0.275+B*t-A*log(1-C4*exp(2*B*t/A))+A*log(1-C4);
plot(x,y,'c');
hold on;

k=1200;
x=v0*t-(m+mf)/(k*Sx)*(log(k*Sx*v0*t+(m+mf)))+(m+mf)/(k*Sx)*log(m+mf);
A=(m-mf)/(k/v0*Sy);
B=sqrt((m*9.8-1000*V*9.8)/(k/v0*Sy));
V2=m*sqrt(2*9.8*h0)/(m+mf);
C4=(-V2-B)/(B-V2);
y=0.275+B*t-A*log(1-C4*exp(2*B*t/A))+A*log(1-C4);
plot(x,y,'m');
hold on;

x1=[1.5	2.1	3	4.1	5.8	9	11.5	13	15	16	20	22	24.5	26.3	28.2	31.6	33.2	35.4]/100;
y1=[27.5	26.1	25.2	24.6	23.2	21	19.4	17.5	16	15	12.5	11	10	8	6.6	5	3.9	2.5]/100;
x1=x1-0.015;

if(N==1) %
    if(type==1)%平放
        viewTitle=sprintf('大实心方块模型数据和真实数据对比图--平放速度%d高度%d',v0*100,h0*100);
    elseif(type==2)%立放
        viewTitle=sprintf('大实心方块模型数据和真实数据对比图--立放速度%d高度%d',v0*100,h0*100);
    elseif(type==3)%竖放
        viewTitle=sprintf('大实心方块模型数据和真实数据对比图--竖放速度%d高度%d',v0*100,h0*100);
    end;
elseif(N==2)
    if(type==1)%平放
        viewTitle=sprintf('小实心方块模型数据和真实数据对比图--平放速度%d高度%d',v0*100,h0*100);
    elseif(type==2)%立放
        viewTitle=sprintf('小实心方块模型数据和真实数据对比图--立放速度%d高度%d',v0*100,h0*100);
    elseif(type==3)%竖放
        viewTitle=sprintf('小实心方块模型数据和真实数据对比图--竖放速度%d高度%d',v0*100,h0*100);
    end;
elseif(N==3)
    if(type==1)%平放
        viewTitle=sprintf('大空心方块模型数据和真实数据对比图--平放速度%d高度%d',v0*100,h0*100);
    elseif(type==2)%立放
        viewTitle=sprintf('大空心方块模型数据和真实数据对比图--立放速度%d高度%d',v0*100,h0*100);
    elseif(type==3)%竖放
        viewTitle=sprintf('大空心方块模型数据和真实数据对比图--竖放速度%d高度%d',v0*100,h0*100);
    end;
elseif(N==4)
     if(type==1)%平放
         viewTitle=sprintf('小空心方块模型数据和真实数据对比图--平放速度%d高度%d',v0*100,h0*100);
    elseif(type==2)%立放
        viewTitle=sprintf('小空心方块模型数据和真实数据对比图--立放速度%d高度%d',v0*100,h0*100);
    elseif(type==3)%竖放
        viewTitle=sprintf('小空心方块模型数据和真实数据对比图--竖放速度%d高度%d',v0*100,h0*100);
    end;
elseif(N==5)
    if(type==1)%平放
        viewTitle=sprintf('大实心蜂巢模型数据和真实数据对比图--平放速度%d高度%d',v0*100,h0*100);
    elseif(type==2)%立放
        viewTitle=sprintf('大实心蜂巢模型数据和真实数据对比图--立放速度%d高度%d',v0*100,h0*100);
    elseif(type==3)%竖放
        viewTitle=sprintf('大实心蜂巢模型数据和真实数据对比图--竖放速度%d高度%d',v0*100,h0*100);
    end;
elseif(N==6)
    if(type==1)%平放
        viewTitle=sprintf('小实心蜂巢模型数据和真实数据对比图--平放速度%d高度%d',v0*100,h0*100);
    elseif(type==2)%立放
        viewTitle=sprintf('小实心蜂巢模型数据和真实数据对比图--立放速度%d高度%d',v0*100,h0*100);
    elseif(type==3)%竖放
        viewTitle=sprintf('小实心蜂巢模型数据和真实数据对比图--竖放速度%d高度%d',v0*100,h0*100);
    end;
elseif(N==7)
    if(type==1)%平放
        viewTitle=sprintf('大空心蜂巢模型数据和真实数据对比图--平放速度%d高度%d',v0*100,h0*100);
    elseif(type==2)%立放
        viewTitle=sprintf('大空心蜂巢模型数据和真实数据对比图--立放速度%d高度%d',v0*100,h0*100);
    elseif(type==3)%竖放
        viewTitle=sprintf('大空心蜂巢模型数据和真实数据对比图--竖放速度%d高度%d',v0*100,h0*100);
    end;
elseif(N==8)
    if(type==1)%平放
        viewTitle=sprintf('小空心蜂巢模型数据和真实数据对比图--平放速度%d高度%d',v0*100,h0*100);
    elseif(type==2)%立放
        viewTitle=sprintf('小空心蜂巢模型数据和真实数据对比图--立放速度%d高度%d',v0*100,h0*100);
    elseif(type==3)%竖放
        viewTitle=sprintf('小空心蜂巢模型数据和真实数据对比图--竖放速度%d高度%d',v0*100,h0*100);
    end;
elseif(N==9)
    if(type==1)%平放
        viewTitle=sprintf('大三角锥模型数据和真实数据对比图--平放速度%d高度%d',v0*100,h0*100);
    elseif(type==2)%立放
        viewTitle=sprintf('大三角锥模型数据和真实数据对比图--立放速度%d高度%d',v0*100,h0*100);
    elseif(type==3)%竖放
        viewTitle=sprintf('大三角锥模型数据和真实数据对比图--竖放速度%d高度%d',v0*100,h0*100);
    end;
elseif(N==10)
    if(type==1)%平放
        viewTitle=sprintf('小三角锥模型数据和真实数据对比图--平放速度%d高度%d',v0*100,h0*100);
    elseif(type==2)%立放
        viewTitle=sprintf('小三角锥模型数据和真实数据对比图--立放速度%d高度%d',v0*100,h0*100);
    elseif(type==3)%竖放
        viewTitle=sprintf('小三角锥模型数据和真实数据对比图--竖放速度%d高度%d',v0*100,h0*100);
    end;
end;

%plot(x,y);
hold on;
plot(x1,y1,'r+');

xlabel('水平位移x');
ylabel('竖直位移y');
legend('Cd=1.9','Cd=2.0','Cd=2.1','Cd=2.2','Cd=2.3','Cd=2.4','实验数据');
format long g;
title(viewTitle);