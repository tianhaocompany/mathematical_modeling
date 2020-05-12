%误差分析，投放方式和高度相同，流速不同
cd=1;
cL=1;

%综合表达式
m=0.5888;
uu1=0.34;
uu2=0.40;
uu3=0.47;
uu4=0.55;

A11=80*40*10^(-6);%平放时与水速垂直的面
A21=80*80*10^(-6);%平放时与水速平行的面
cc1=2*m/(cd*1000*A11);

A12=80*40*10^(-6);%竖放时与水速垂直的面
A22=80*40*10^(-6);%竖放时与水速平行的面
cc2=2*m/(cd*1000*A12);

A13=80*80*10^(-6);%立放时与水速垂直的面
A23=80*40*10^(-6);%立放时与水速平行的面
cc3=2*m/(cd*1000*A13);

% vv=15/23*(1/(nad^3));
h=0;
H=0;

t=0:0.04:0.6;
vv=80*80*40*10^(-9);

sigma11=3.2;%uu1时x方向的修正值
sigma21=1;%uu1时y方向的修正值

sigma12=2.7;%uu2时x方向的修正值
sigma22=1;%uu2时y方向的修正值

sigma13=3;%uu3时x方向的修正值
sigma23=1;%uu3y方向的修正值

sigma14=2.8;%uu4时x方向的修正值
sigma24=1;%uu4y方向的修正值

%平放时的计算公式
xxx1=sigma11*(uu1*t-cc1*log(1/cc1*t+1/uu1)+cc1*log(1/uu1));%uu1时x值
aa1=sqrt(2*1300*9.8*vv/(cL*1000*A21));
bb1=-1/m*sqrt(2*cL*1300*1000*9.8*A21*vv);
A1=(abs((sqrt(2*9.8*(h-H))-aa1)/(sqrt(2*9.8*(h-H))+aa1)));
yyy1=sigma21*(0.275-(aa1*t-2*aa1/bb1*log(A1*exp(bb1*t)+1)+2*aa1/bb1*log(A1+1)));%取负时
%yyy1=sigma2*(0.275-(aa*t-2*aa/bb*log(abs(A*exp(bb*t)-1))+2*aa/bb*log(abs(A-1))));%取正值时


xxx2=sigma12*(uu2*t-cc1*log(1/cc1*t+1/uu2)+cc1*log(1/uu2));%uu2时x值
aa1=sqrt(2*1300*9.8*vv/(cL*1000*A21));
bb1=-1/m*sqrt(2*cL*1300*1000*9.8*A21*vv);
A1=(abs((sqrt(2*9.8*(h-H))-aa1)/(sqrt(2*9.8*(h-H))+aa1)));
yyy2=sigma22*(0.275-(aa1*t-2*aa1/bb1*log(A1*exp(bb1*t)+1)+2*aa1/bb1*log(A1+1)));%取负时

xxx3=sigma13*(uu3*t-cc1*log(1/cc1*t+1/uu3)+cc1*log(1/uu3));%uu3时x值
aa1=sqrt(2*1300*9.8*vv/(cL*1000*A21));
bb1=-1/m*sqrt(2*cL*1300*1000*9.8*A21*vv);
A1=(abs((sqrt(2*9.8*(h-H))-aa1)/(sqrt(2*9.8*(h-H))+aa1)));
yyy3=sigma23*(0.275-(aa1*t-2*aa1/bb1*log(A1*exp(bb1*t)+1)+2*aa1/bb1*log(A1+1)));%取负时

xxx4=sigma14*(uu4*t-cc1*log(1/cc1*t+1/uu4)+cc1*log(1/uu4));%uu4时x值
aa1=sqrt(2*1300*9.8*vv/(cL*1000*A21));
bb1=-1/m*sqrt(2*cL*1300*1000*9.8*A21*vv);
A1=(abs((sqrt(2*9.8*(h-H))-aa1)/(sqrt(2*9.8*(h-H))+aa1)));
yyy4=sigma24*(0.275-(aa1*t-2*aa1/bb1*log(A1*exp(bb1*t)+1)+2*aa1/bb1*log(A1+1)));%取负时

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
% x34 = xlsread('34(3).xls');  % 从文件data.xls中读取数据
% m_data34=x34(:,:);%取得表中除去第0行第0列之外的所有数据
%  
% x40 = xlsread('40(3).xls');  % 从文件data.xls中读取数据
% m_data40=x40(:,:);%取得表中除去第0行第0列之外的所有数据
%  
% x47 = xlsread('47(3).xls');  % 从文件data.xls中读取数据
% m_data47=x47(:,:);%取得表中除去第0行第0列之外的所有数据
%  
% x55 = xlsread('55(3).xls');  % 从文件data.xls中读取数据
% m_data55=x55(:,:);%取得表中除去第0行第0列之外的所有数据

% %重心在距水平面5cm处
% x34 = xlsread('34(2).xls');  % 从文件data.xls中读取数据
% m_data34=x34(:,:);%取得表中除去第0行第0列之外的所有数据
%  
% x40 = xlsread('40(2).xls');  % 从文件data.xls中读取数据
% m_data40=x40(:,:);%取得表中除去第0行第0列之外的所有数据
%  
% x47 = xlsread('47(2).xls');  % 从文件data.xls中读取数据
% m_data47=x47(:,:);%取得表中除去第0行第0列之外的所有数据
%  
% x55 = xlsread('55(2).xls');  % 从文件data.xls中读取数据
% m_data55=x55(:,:);%取得表中除去第0行第0列之外的所有数据

%重心在距水平处
x34 = xlsread('34(1).xls');  % 从文件data.xls中读取数据
m_data34=x34(:,:);%取得表中除去第0行第0列之外的所有数据
 
x40 = xlsread('40(1).xls');  % 从文件data.xls中读取数据
m_data40=x40(:,:);%取得表中除去第0行第0列之外的所有数据
 
x47 = xlsread('47(1).xls');  % 从文件data.xls中读取数据
m_data47=x47(:,:);%取得表中除去第0行第0列之外的所有数据
 
x55 = xlsread('55(1).xls');  % 从文件data.xls中读取数据
m_data55=x55(:,:);%取得表中除去第0行第0列之外的所有数据

% %平放,重心在水平面出
y1=m_data34(37,1:11);
x1=m_data34(38,1:11);
 
y2=m_data40(37,1:8);
x2=m_data40(38,1:8);
 
y3=m_data47(37,1:12);
x3=m_data47(38,1:12);
 
y4=m_data55(37,1:13);
x4=m_data55(38,1:13);

% %平放，重心在距5cm处
% y1=m_data34(37,1:9);
% x1=m_data34(38,1:9);
%  
% y2=m_data40(37,1:9);
% x2=m_data40(38,1:9);
%  
% y3=m_data47(37,1:9);
% x3=m_data47(38,1:9);
%  
% y4=m_data55(37,1:8);
% x4=m_data55(38,1:8);

%
%平放,重心在12cm
% y1=m_data34(37,1:9);
% x1=m_data34(38,1:9);
%  
% y2=m_data40(37,1:8);
% x2=m_data40(38,1:8);
%  
% y3=m_data47(37,1:9);
% x3=m_data47(38,1:9);
%  
% y4=m_data55(37,1:9);
% x4=m_data55(38,1:9);

% 竖放,重心在水平面处

% y1=m_data34(39,1:9);
% x1=m_data34(40,1:9);
%  
% y2=m_data40(39,1:6);
% x2=m_data40(40,1:6);
%  
% y3=m_data47(39,1:8);
% x3=m_data47(40,1:8);
%  
% y4=m_data55(39,1:9);
% x4=m_data55(40,1:9);

%竖放，重心在5cm处
% y1=m_data34(39,1:7);
% x1=m_data34(40,1:7);
%  
% y2=m_data40(39,1:7);
% x2=m_data40(40,1:7);
%  
% y3=m_data47(39,1:7);
% x3=m_data47(40,1:7);
%  
% y4=m_data55(39,1:7);
% x4=m_data55(40,1:7);

% %竖放，重心在12cm处
% y1=m_data34(39,1:6);
% x1=m_data34(40,1:6);
%  
% y2=m_data40(39,1:5);
% x2=m_data40(40,1:5);
%  
% y3=m_data47(39,1:6);
% x3=m_data47(40,1:6);
%  
% y4=m_data55(39,1:5);
% x4=m_data55(40,1:5);

% 立放,重心在水平面
% y1=m_data34(41,1:9);
% x1=m_data34(42,1:9);
%  
% y2=m_data40(41,1:10);
% x2=m_data40(42,1:10);
%  
% y3=m_data47(41,1:9);
% x3=m_data47(42,1:9);
%  
% y4=m_data55(41,1:10);
% x4=m_data55(42,1:10);

% %立放，重心在5cm处
% y1=m_data34(41,1:6);
% x1=m_data34(42,1:6);
%  
% y2=m_data40(41,1:6);
% x2=m_data40(42,1:6);
%  
% y3=m_data47(41,1:7);
% x3=m_data47(42,1:7);
%  
% y4=m_data55(41,1:6);
% x4=m_data55(42,1:6);

% %立放，重心在12cm
% y1=m_data34(41,1:5);
% x1=m_data34(42,1:5);
%  
% y2=m_data40(41,1:6);
% x2=m_data40(42,1:6);
%  
% y3=m_data47(41,1:5);
% x3=m_data47(42,1:5);
%  
% y4=m_data55(41,1:6);
% x4=m_data55(42,1:6);
% 


%修正读取值的偏移量
alpha1=2.765-x1(1);%横坐标的修正值
alpha2=2.765-x2(1);
alpha3=2.765-x3(1);
alpha4=2.765-x4(1);
delta_avg1=alpha1/atan(25/120);%每弧度的平均误差
delta_avg2=alpha2/atan(25/120);
delta_avg3=alpha3/atan(25/120);
delta_avg4=alpha4/atan(25/120);
for ii=1:20;
    if ii<(length(x1)+1);
        x1(ii)=x1(ii)+alpha1;
        alpha1=delta_avg1*atan((25-x1(ii))/120);
    end
    if ii<(length(x2)+1);
        x2(ii)=x2(ii)+alpha2;
        alpha2=delta_avg2*atan((25-x2(ii))/120);
    end
    if ii<(length(x3)+1);
        x3(ii)=x3(ii)+alpha3;
        alpha3=delta_avg3*atan((25-x3(ii))/120);
    end
    if ii<(length(x4)+1);
        x4(ii)=x4(ii)+alpha4;     
       alpha4=delta_avg4*atan((25-x4(ii))/120);
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
 
%第四组
i_x4=atan((25-x4)/120);
r_x4=asin(sin(i_x4)/1.33);
delta_x4=20*tan(r_x4);
x44=abs(x4-delta_x4);%修正后的横坐标
 
i_y4=atan((y4-20)/120);
r_y4=asin(sin(i_y4)/1.33);
delta_y4=20*tan(r_y4);
y44=y4+delta_y4;
% plot(t(1:11),y11(1:11),'b');
% hold on;
% plot(t(1:8),y22(1:8),'g');
% hold on;
% plot(t(1:12),y33(1:12),'k');
% hold on;
% plot(t(1:12),y33(1:12),'c');
% hold on;
% plot(t(1:12),y44(1:12),'m');

%参数方程求解，知道x，求y

    
%计算误差
sum1=0;
sum2=0;
sum3=0;
sum4=0;
for i=1:13
    if i<(length(x11)+1)
      sum1=sum1+(x11(i)-100*xxx1(i))^2+(y11(i)-100*yyy1(i))^2;
    end
    if i<(length(x22)+1)
       sum2=sum2+(x22(i)-100*xxx2(i))^2+(y22(i)-100*yyy2(i))^2;
    end
    if i<(length(x33)+1)
       sum3=sum3+(x33(i)-100*xxx3(i))^2+(y33(i)-100*yyy3(i))^2;
    end
    if i<(length(x44)+1)
       sum4=sum4+(x44(i)-100*xxx3(i))^2+(y44(i)-100*yyy4(i))^2;
    end
end
sum1=sqrt(sum1/length(x11));
sum2=sqrt(sum2/length(x22));
sum3=sqrt(sum3/length(x33));
sum4=sqrt(sum4/length(x44));

%用最小二乘法进行误差分析
p1=polyfit(x11,y11,2);
p2=polyfit(x22,y22,2);
p3=polyfit(x33,y33,2);
p4=polyfit(x44,y44,2);
% xi=linspace(0,5,100);
% z=polyval(p1,xi);
ff=myfun(3);
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
    if jj<=length(x44)
        z4(jj)=polyval(p4,x44(jj));
    end
    
end

%  plot(xxx1*100,yyy1*100,'r',xxx2*100,yyy2*100,'b',xxx3*100,yyy3*100,'m',xxx4*100,yyy4*100,'g','LineWidth',1.5);
%   legend('u=0.34m/s','u=0.40m/s','u=0.47m/s','u=0.55m/s');
%  hold on;
%  plot(x11(1:length(x11)),y11(1:length(y11)),'rd','LineWidth',1.5);
%  hold on;
%  plot(x22(1:length(x22)),y22(1:length(y22)),'b*','LineWidth',1.5);
%  hold on;
%   plot(x33(1:length(x33)),y33(1:length(y33)),'mh','LineWidth',1.5);
%   hold on;
%   plot(x44(1:length(x44)),y44(1:length(y44)),'g+','LineWidth',1.5);
%  title('投放方式和重物重心位置相同，水流速度不同时的y与x分布曲线图）','Fontsize',10);
%  xlabel('水平偏移量x(单位cm)','Fontsize',10);
%  ylabel('竖直偏移量y(单位cm)','Fontsize',10);
% 
%  axis([0 10 0 30]);
  %plot(x11,z(1:length(x11)),'o',x11,z(1:length(x11)),xi,z,':');
 
subplot(2,2,1);
plot(xxx1*100,yyy1*100,'r',x11(1:length(x11)),y11(1:length(y11)),'gd:',x11,z1(1:length(x11)),'b','LineWidth',1.5);
title('平放y与x分布曲线图（h=0）','Fontsize',10);
xlabel('水平偏移量x(单位cm)','Fontsize',10);
ylabel('竖直偏移量y(单位cm)','Fontsize',10);
legend('理论结果','u=0.34m/s实验结果','最小二乘法数据');
axis([0 3 0 30]);
% hold on;
% plot(x11,y11,'r*',x11,z(1:length(x11)),'b');
 
subplot(2,2,2);
plot(xxx2*100,yyy2*100,'r',x22(1:length(x22)),y22(1:length(y22)),'gd:',x22,z2(1:length(x22)),'b','LineWidth',1.5);
title('平放y与x分布曲线图（h=0）','Fontsize',10);
xlabel('水平偏移量x(单位cm)','Fontsize',10);
ylabel('竖直偏移量y(单位cm)','Fontsize',10);
legend('理论结果','u=0.40m/s实验结果','最小二乘法数据');
axis([0 6 0 30]);

subplot(2,2,3)
plot(xxx3*100,yyy3*100,'r',x33(1:length(x33)),y33(1:length(x33)),'gd:',x33,z3(1:length(x33)),'b','LineWidth',1.5);
title('平放y与x分布曲线图（h=0）','Fontsize',10);
xlabel('水平偏移量x(单位cm)','Fontsize',10);
ylabel('竖直偏移量y(单位cm)','Fontsize',10);
legend('理论结果','u=0.47m/s实验结果','最小二乘法数据');
axis([0 6 0 30]);

subplot(2,2,4);
plot(xxx4*100,yyy4*100,'r',x44(1:length(x44)),y44(1:length(x44)),'gd:',x44,z4(1:length(x44)),'b','LineWidth',1.5);
title('平放y与x分布曲线图（h=0）','Fontsize',10);
xlabel('水平偏移量x(单位cm)','Fontsize',10);
ylabel('竖直偏移量y(单位cm)','Fontsize',10);
legend('理论结果','u=0.55m/s实验结果','最小二乘法数据');
axis([0 6 0 30]);

%plot(t,100*(0.4-yy1),'r',t(1:11),y11(1:11),'b',t(1:8),y22(1:8),'g',t(1:12),y33(1:12),'k',t(1:12),y44(1:12),'c','LineWidth',1.5);
title('竖直偏移量与时间的分布曲线图','Fontsize',10);
xlabel('时间t(单位s)','Fontsize',10);
ylabel('竖直偏移量y(单位m)','Fontsize',10);
legend('理论结果','u=0.34m/s','u=0.40m/s','u=0.47m/s','u=0.55m/s');

wucha=[sum1 sum2 sum3 sum4];
