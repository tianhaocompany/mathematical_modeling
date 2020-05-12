%误差分析，投放方式和流速相同，高度不同
cd=2.1;%拖曳力系数
cL=1;%上举力系数

%综合表达式
m=0.5888;%质量

%水流速度，单位m/s
uu1=0.34;
uu2=0.40;
uu3=0.47;
uu4=0.55;

%投影面积
A11=80*40*10^(-6);%平放时与水速垂直的面
A21=80*80*10^(-6);%平放时与水速平行的面
cc1=2*m/(cd*1000*A11);

A12=80*40*10^(-6);%竖放时与水速垂直的面
A22=80*40*10^(-6);%竖放时与水速平行的面
cc2=2*m/(cd*1000*A12);

A13=80*80*10^(-6);%立放时与水速垂直的面
A23=80*40*10^(-6);%立放时与水速平行的面
cc3=2*m/(cd*1000*A13);

%重心高度
h1=0;%
h2=0.05;
h3=0.12;
H=0;

t=0:0.04:0.6;
vv=80*80*40*10^(-9);%块体的体积

sigma11=2.5;%uu1时x方向的修正值
sigma21=1;%uu1时y方向的修正值

sigma12=3.5;%uu2时x方向的修正值
sigma22=1;%uu2时y方向的修正值

sigma13=1.5;%uu3时x方向的修正值
sigma23=1;%uu3y方向的修正值

sigma14=2;%uu4时x方向的修正值
sigma24=1;%uu4y方向的修正值

%平放时的计算公式
%高度h=0
px1=sigma11*(uu1*t-cc1*log(1/cc1*t+1/uu1)+cc1*log(1/uu1));%uu1时x值
aa1=sqrt(2*1300*9.8*vv/(cL*1000*A21));
bb1=-1/m*sqrt(2*cL*1300*1000*9.8*A21*vv);
A1=(abs((sqrt(2*9.8*(h1-H))-aa1)/(sqrt(2*9.8*(h1-H))+aa1)));
py1=sigma21*(0.275-(aa1*t-2*aa1/bb1*log(A1*exp(bb1*t)+1)+2*aa1/bb1*log(A1+1)));%取负时

%高度h=0.05
px2=sigma12*(uu2*t-cc1*log(1/cc1*t+1/uu2)+cc1*log(1/uu2));%uu2时x值
aa1=sqrt(2*1300*9.8*vv/(cL*1000*A21));
bb1=-1/m*sqrt(2*cL*1300*1000*9.8*A21*vv);
A1=(abs((sqrt(2*9.8*(h2-H))-aa1)/(sqrt(2*9.8*(h2-H))+aa1)));
py2=sigma22*(0.275-(aa1*t-2*aa1/bb1*log(A1*exp(bb1*t)+1)+2*aa1/bb1*log(A1+1)));%取负时

%高度h=0.12
px3=sigma13*(uu3*t-cc1*log(1/cc1*t+1/uu3)+cc1*log(1/uu3));%uu3时x值
aa1=sqrt(2*1300*9.8*vv/(cL*1000*A21));
bb1=-1/m*sqrt(2*cL*1300*1000*9.8*A21*vv);
A1=(abs((sqrt(2*9.8*(h3-H))-aa1)/(sqrt(2*9.8*(h3-H))+aa1)));
py3=sigma23*(0.275-(aa1*t-2*aa1/bb1*log(A1*exp(bb1*t)+1)+2*aa1/bb1*log(A1+1)));%取负时



% %竖放时的计算公式
% xxx1=sigma11*(uu1*t-cc2*log(1/cc2*t+1/uu1)+cc2*log(1/uu1));%uu1时x值
% aa1=sqrt(2*1300*9.8*vv/(cL*1000*A22));
% bb1=-1/m*sqrt(2*cL*1300*1000*9.8*A22*vv);
% A1=(abs((sqrt(2*9.8*(h-H))-aa1)/(sqrt(2*9.8*(h-H))+aa1)));
% yyy1=sigma21*(0.275-(aa1*t-2*aa1/bb1*log(A1*exp(bb1*t)+1)+2*aa1/bb1*log(A1+1)));%取负时
% %yyy1=sigma2*(0.275-(aa*t-2*aa/bb*log(abs(A*exp(bb*t)-1))+2*aa/bb*log(abs(A
% %-1))));%取正值时
% 
% xxx2=sigma12*(uu2*t-cc2*log(1/cc2*t+1/uu2)+cc2*log(1/uu2));%uu2时x值
% aa1=sqrt(2*1300*9.8*vv/(cL*1000*A22));
% bb1=-1/m*sqrt(2*cL*1300*1000*9.8*A22*vv);
% A1=(abs((sqrt(2*9.8*(h-H))-aa1)/(sqrt(2*9.8*(h-H))+aa1)));
% yyy2=sigma22*(0.275-(aa1*t-2*aa1/bb1*log(A1*exp(bb1*t)+1)+2*aa1/bb1*log(A1+1)));%取负时
% 
% xxx3=sigma13*(uu3*t-cc2*log(1/cc2*t+1/uu3)+cc2*log(1/uu3));%uu3时x值
% aa1=sqrt(2*1300*9.8*vv/(cL*1000*A22));
% bb1=-1/m*sqrt(2*cL*1300*1000*9.8*A22*vv);
% A1=(abs((sqrt(2*9.8*(h-H))-aa1)/(sqrt(2*9.8*(h-H))+aa1)));
% yyy3=sigma23*(0.275-(aa1*t-2*aa1/bb1*log(A1*exp(bb1*t)+1)+2*aa1/bb1*log(A1+1)));%取负时
% 
% xxx4=sigma14*(uu4*t-cc2*log(1/cc2*t+1/uu4)+cc2*log(1/uu4));%uu4时x值
% aa1=sqrt(2*1300*9.8*vv/(cL*1000*A22));
% bb1=-1/m*sqrt(2*cL*1300*1000*9.8*A22*vv);
% A1=(abs((sqrt(2*9.8*(h-H))-aa1)/(sqrt(2*9.8*(h-H))+aa1)));
% yyy4=sigma24*(0.275-(aa1*t-2*aa1/bb1*log(A1*exp(bb1*t)+1)+2*aa1/bb1*log(A1+1)));%取负时
% 
% %竖放时的计算公式
% xxx1=sigma11*(uu1*t-cc2*log(1/cc2*t+1/uu1)+cc2*log(1/uu1));%uu1时x值
% aa1=sqrt(2*1300*9.8*vv/(cL*1000*A22));
% bb1=-1/m*sqrt(2*cL*1300*1000*9.8*A22*vv);
% A1=(abs((sqrt(2*9.8*(h-H))-aa1)/(sqrt(2*9.8*(h-H))+aa1)));
% yyy1=sigma21*(0.275-(aa1*t-2*aa1/bb1*log(A1*exp(bb1*t)+1)+2*aa1/bb1*log(A1+1)));%取负时
% %yyy1=sigma2*(0.275-(aa*t-2*aa/bb*log(abs(A*exp(bb*t)-1))+2*aa/bb*log(abs(A
% %-1))));%取正值时
% 
% xxx2=sigma12*(uu2*t-cc2*log(1/cc2*t+1/uu2)+cc2*log(1/uu2));%uu2时x值
% aa1=sqrt(2*1300*9.8*vv/(cL*1000*A22));
% bb1=-1/m*sqrt(2*cL*1300*1000*9.8*A22*vv);
% A1=(abs((sqrt(2*9.8*(h-H))-aa1)/(sqrt(2*9.8*(h-H))+aa1)));
% yyy2=sigma22*(0.275-(aa1*t-2*aa1/bb1*log(A1*exp(bb1*t)+1)+2*aa1/bb1*log(A1+1)));%取负时
% 
% xxx3=sigma13*(uu3*t-cc2*log(1/cc2*t+1/uu3)+cc2*log(1/uu3));%uu3时x值
% aa1=sqrt(2*1300*9.8*vv/(cL*1000*A22));
% bb1=-1/m*sqrt(2*cL*1300*1000*9.8*A22*vv);
% A1=(abs((sqrt(2*9.8*(h-H))-aa1)/(sqrt(2*9.8*(h-H))+aa1)));
% yyy3=sigma23*(0.275-(aa1*t-2*aa1/bb1*log(A1*exp(bb1*t)+1)+2*aa1/bb1*log(A1+1)));%取负时
% 
% xxx4=sigma14*(uu4*t-cc2*log(1/cc2*t+1/uu4)+cc2*log(1/uu4));%uu4时x值
% aa1=sqrt(2*1300*9.8*vv/(cL*1000*A22));
% bb1=-1/m*sqrt(2*cL*1300*1000*9.8*A22*vv);
% A1=(abs((sqrt(2*9.8*(h-H))-aa1)/(sqrt(2*9.8*(h-H))+aa1)));
% yyy4=sigma24*(0.275-(aa1*t-2*aa1/bb1*log(A1*exp(bb1*t)+1)+2*aa1/bb1*log(A1+1)));%取负时

% %立方时的计算公式
% xxx1=sigma11*(uu1*t-cc3*log(1/cc3*t+1/uu1)+cc3*log(1/uu1));%uu1时x值
% aa1=sqrt(2*1300*9.8*vv/(cL*1000*A23));
% bb1=-1/m*sqrt(2*cL*1300*1000*9.8*A23*vv);
% A1=(abs((sqrt(2*9.8*(h-H))-aa1)/(sqrt(2*9.8*(h-H))+aa1)));
% yyy1=sigma21*(0.275-(aa1*t-2*aa1/bb1*log(A1*exp(bb1*t)+1)+2*aa1/bb1*log(A1+1)));%取负时
% %yyy1=sigma2*(0.275-(aa*t-2*aa/bb*log(abs(A*exp(bb*t)-1))+2*aa/bb*log(abs(A
% %-1))));%取正值时
% 
% xxx2=sigma12*(uu2*t-cc3*log(1/cc3*t+1/uu2)+cc3*log(1/uu2));%uu2时x值
% aa1=sqrt(2*1300*9.8*vv/(cL*1000*A23));
% bb1=-1/m*sqrt(2*cL*1300*1000*9.8*A23*vv);
% A1=(abs((sqrt(2*9.8*(h-H))-aa1)/(sqrt(2*9.8*(h-H))+aa1)));
% yyy2=sigma22*(0.275-(aa1*t-2*aa1/bb1*log(A1*exp(bb1*t)+1)+2*aa1/bb1*log(A1+1)));%取负时
% 
% xxx3=sigma13*(uu3*t-cc3*log(1/cc3*t+1/uu3)+cc3*log(1/uu3));%uu3时x值
% aa1=sqrt(2*1300*9.8*vv/(cL*1000*A23));
% bb1=-1/m*sqrt(2*cL*1300*1000*9.8*A23*vv);
% A1=(abs((sqrt(2*9.8*(h-H))-aa1)/(sqrt(2*9.8*(h-H))+aa1)));
% yyy3=sigma23*(0.275-(aa1*t-2*aa1/bb1*log(A1*exp(bb1*t)+1)+2*aa1/bb1*log(A1+1)));%取负时
% 
% xxx4=sigma14*(uu4*t-cc3*log(1/cc3*t+1/uu4)+cc3*log(1/uu4));%uu4时x值
% aa1=sqrt(2*1300*9.8*vv/(cL*1000*A23));
% bb1=-1/m*sqrt(2*cL*1300*1000*9.8*A23*vv);
% A1=(abs((sqrt(2*9.8*(h-H))-aa1)/(sqrt(2*9.8*(h-H))+aa1)));
% yyy4=sigma24*(0.275-(aa1*t-2*aa1/bb1*log(A1*exp(bb1*t)+1)+2*aa1/bb1*log(A1+1)));%取负时

% xxx2=sigma12*(uu*t-cc2*log(1/cc2*t+1/uu)+cc2*log(1/uu));%竖放时x值
% aa2=sqrt(2*1300*9.8*vv/(cL*1000*A22));
% bb2=-1/m*sqrt(2*cL*1300*1000*9.8*A22*vv);
% A2=(abs((sqrt(2*9.8*(h-H))-aa2)/(sqrt(2*9.8*(h-H))+aa2)));
% yyy2=sigma2*(0.275-(aa2*t-2*aa2/bb2*log(A2*exp(bb2*t)+1)+2*aa2/bb2*log(A2+1)));%取负时
% 
% xxx3=sigma13*(uu*t-cc3*log(1/cc3*t+1/uu)+cc3*log(1/uu));%立放时x值
% aa3=sqrt(2*1300*9.8*vv/(cL*1000*A23));
% bb3=-1/m*sqrt(2*cL*1300*1000*9.8*A23*vv);
% A3=(abs((sqrt(2*9.8*(h-H))-aa3)/(sqrt(2*9.8*(h-H))+aa3)));
% yyy3=sigma2*(0.275-(aa3*t-2*aa3/bb3*log(A3*exp(bb3*t)+1)+2*aa3/bb3*log(A3+1)));%取负时


% cd=1;
% s=80*40*10^(-6);
% c=0.5*cd*s*1000;
% m=0.5888;%质量
% u=0.34;
% c1=-1/u;
% c2=-(-m/c*log(-c1))*2;
% %xx=0.34*t-0.184*log(5.4348*t+2.9412)-0.1985+0.3970;
% sigma=4.5;%4.5;%修正系数
% xx=sigma*(u*t-m/c*log(c/m*t-c1)-m/c*log(-c1)+c2);
%   figure;
%  plot(t,xx*100,'r');
  
%   %计算竖直方向上的运动
%   f=2.5088;%浮力
%   d1=9.8-f/m;
%   cL=1;
%   sy=80*80*10^(-6);%横截面
%   d2=0.5*cL*sy*1000;
%   d3=0;
%   y0=0;%初始纵坐标
%   d4=y0;
%   d5=y0;
%   a=sqrt(m*d1/d2);
%   b=-2*sqrt(d1*d2/m);
%   yy1=a*t-2*a/b*log(1+exp(b*t))+d5;%取负号时，我们的纵坐标表达式
%   yy2=a*t-2*a/b*log(1-exp(b*t))+d4;%取正号时，我们的纵坐标表达式
%   plot(t,100*(0.4-yy1),'r');%取负号时
%   hold on;
%plot(t,100*(y0-yy2),'k');%取正号时
  
%   %重心在12cm
px33 = xlsread('34(3).xls');  % 从文件data.xls中读取数据
m_data343=px33(:,:);%取得表中除去第0行第0列之外的所有数据

% %重心在距水平面5cm处
px22 = xlsread('34(2).xls');  % 从文件data.xls中读取数据
m_data342=px22(:,:);%取得表中除去第0行第0列之外的所有数据

%重心在距水平处
px11 = xlsread('34(1).xls');  % 从文件data.xls中读取数据
m_data341=px11(:,:);%取得表中除去第0行第0列之外的所有数据
 

% %平放,重心在水平面出
y1=m_data341(37,1:11);
x1=m_data341(38,1:11);

% %平放，重心在距5cm处
y2=m_data342(37,1:9);
x2=m_data342(38,1:9);

%平放,重心在12cm
y3=m_data343(37,1:9);
x3=m_data343(38,1:9);


%修正读取值的偏移量
alpha1=2.765-x1(1);%横坐标的修正值
alpha2=2.765-x2(1);
alpha3=2.765-x3(1);
delta_avg1=alpha1/atan(25/120);%每弧度的平均误差
delta_avg2=alpha2/atan(25/120);
delta_avg3=alpha3/atan(25/120);
for ii=1:20;
    if ii<(length(x1)+1);
        x1(ii)=x1(ii)+alpha1;
        alpha1=delta_avg1*atan((25-x1(ii))/120);
    end
    if ii<(length(x2)+1);
        x2(ii)=x2(ii)+alpha2;
        disp(length(x2));
        alpha2=delta_avg2*atan((25-x2(ii))/120);
    end
    if ii<(length(x3)+1);
        x3(ii)=x3(ii)+alpha3;
        alpha3=delta_avg3*atan((25-x3(ii))/120);
    end
end

%数据校正
i_x1=atan((25-x1)/120);
r_x1=asin(sin(i_x1)/1.33);
delta_x1=20*tan(r_x1);
x11=abs(x1-delta_x1);%修正后的横坐标
 
i_y1=atan((y1-20)/120);
r_y1=asin(sin(i_y1)/1.33);
delta_y1=20*tan(r_y1);
y11=y1+delta_y1;
 
%第二组数据校正
i_x2=atan((25-x2)/120);
r_x2=asin(sin(i_x2)/1.33);
delta_x2=20*tan(r_x2);
x22=abs(x2-delta_x2);%修正后的横坐标
 
i_y2=atan((y2-20)/120);
r_y2=asin(sin(i_y2)/1.33);
delta_y2=20*tan(r_y2);
y22=y2+delta_y2;
 
%第三组数据校正
i_x3=atan((25-x3)/120);
r_x3=asin(sin(i_x3)/1.33);
delta_x3=20*tan(r_x3);
x33=abs(x3-delta_x3);%修正后的横坐标
 
i_y3=atan((y3-20)/120);
r_y3=asin(sin(i_y3)/1.33);
delta_y3=20*tan(r_y3);
y33=y3+delta_y3;
    
% %计算误差
% sum1=0;
% sum2=0;
% sum3=0;
% for i=1:13
%     if i<(length(x11)+1)
%       sum1=sum1+(x11(i)-100*xxx1(i))^2+(y11(i)-100*yyy1(i))^2;
%     end
%     if i<(length(x22)+1)
%        sum2=sum2+(x22(i)-100*xxx2(i))^2+(y22(i)-100*yyy2(i))^2;
%     end
%     if i<(length(x33)+1)
%        sum3=sum3+(x33(i)-100*xxx3(i))^2+(y33(i)-100*yyy3(i))^2;
%     end
%     if i<(length(x44)+1)
%        sum4=sum4+(x44(i)-100*xxx3(i))^2+(y44(i)-100*yyy4(i))^2;
%     end
% end
% sum1=sqrt(sum1/length(x11));
% sum2=sqrt(sum2/length(x22));
% sum3=sqrt(sum3/length(x33));
% sum4=sqrt(sum4/length(x44));

%用最小二乘法进行误差分析
p1=polyfit(x11,y11,2);
p2=polyfit(x22(1:length(y22)),y22,2);
p3=polyfit(x33,y33,2);


for jj=1:13
    if jj<=length(x11)
       z1(jj)=polyval(p1,x11(jj));
    end
    if jj<=length(x22)
        z2(jj)=polyval(p2,x22(jj));
    end
    if jj<=length(x33)
        z3(jj)=polyval(p3,x33(jj));
    end
    
end
 
subplot(1,2,1);
plot(px1*100,py1*100,'r',x11(1:length(x11)),y11(1:length(y11)),'gd:',x11,z1(1:length(x11)),'b','LineWidth',1.5);
title('重心距水面高度为零时，y与x分布曲线图','Fontsize',10);
xlabel('水平偏移量x(单位cm)','Fontsize',10);
ylabel('竖直偏移量y(单位cm)','Fontsize',10);
legend('理论结果','实验数据','最小二乘法数据');
axis([0 10 0 30]);
% hold on;
% plot(x11,y11,'r*',x11,z(1:length(x11)),'b');
 
subplot(1,2,2);
plot(px2*100,py2*100,'r',x22(1:length(x22)),y22(1:length(y22)),'gd:',x22,z2(1:length(x22)),'b','LineWidth',1.5);
title('重心距水面高度为5cm时，y与x分布曲线图','Fontsize',10);
xlabel('水平偏移量x(单位cm)','Fontsize',10);
ylabel('竖直偏移量y(单位cm)','Fontsize',10);
legend('理论结果','实验数据','最小二乘法数据');
axis([0 6 0 30]);

figure;
plot(px3*100,py3*100,'r',x33(1:length(x33)),y33(1:length(x33)),'gd:',x33,z3(1:length(x33)),'b','LineWidth',1.5);
title('重心距水面高度为12cm时，y与x分布曲线图','Fontsize',10);
xlabel('水平偏移量x(单位cm)','Fontsize',10);
ylabel('竖直偏移量y(单位cm)','Fontsize',10);
legend('理论结果','实验数据','最小二乘法数据');
axis([0 6 0 30]);


wucha=[sum1 sum2 sum3 sum4];
