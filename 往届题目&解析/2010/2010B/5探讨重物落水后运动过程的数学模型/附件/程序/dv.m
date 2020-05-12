  %平放，重心高度为零，不同的流速
% t=0:0.04:0.4;
% cd=1;
% s=80*40*10^(-6);
% c=0.5*cd*s*1000;
% m=0.5888;
% u=0.40;%0.34;
% c1=-1/u;
% c2=-(-m/c*log(-c1))*2;
% sigma=1.6;%修正系数
% xx=sigma*(u*t-m/c*log(c/m*t-c1)-m/c*log(-c1)+c2);
%   figure;
  %求解第四问
cd=1;
cL=1;
m=0.5888;
uu=0.34;
A1=80*40*10^(-6);
A2=80*80*10^(-6);
cc=2*m/(cd*1000*A1);
% vv=15/23*(1/(nad^3));
h=0;
H=0;
t=0:0.04:0.4;
vv=80*80*40*10^(-9);

sigma_x=1;

xxx=sigma_x*(uu*t-cc*log(1/cc*t+1/uu)+cc*log(1/uu));
aa=sqrt(2*1300*9.8*vv/(cL*1000*A2));
bb=-1/m*sqrt(2*cL*1300*1000*9.8*A2*vv);
A=abs((sqrt(2*9.8*(h-H))-aa)/(sqrt(2*9.8*(h-H))+aa));
yyy=sigma*(0.275-(aa*t-2*aa/bb*log(A*exp(bb*t)+1)+2*aa/bb*log(A+1)));

sigma_y=0.3;
yyy1=sigma_y*(0.275-(aa*t-2*aa/bb*log(abs(A*exp(bb*t)-1))+2*aa/bb*log(abs(A-1))));
  %
u1=0.34;%0.34;
u2=0.40;%0.40
u3=0.47;%0.47;
u4=0.55;%0.55;
c11=-1/u1;
c12=-1/u2;
c13=-1/u3;
c14=-1/u4;
c21=-(-m/c*log(-c11))*2;%减号时的数据
c22=-(-m/c*log(-c12))*2;%减号时的数据
c23=-(-m/c*log(-c13))*2;%减号时的数据
c24=-(-m/c*log(-c14))*2;%减号时的数据

%c2=0;//加号时的数据
%xx=0.34*t-0.184*log(5.4348*t+2.9412)-0.1985+0.3970;
sigma1=1;%2;%修正系数
sigma2=1;%4.8;%3.7;%修正系数
sigma3=1;%2.7;%1.5;%修正系数
sigma4=1;%1.8;%1.2;%修正系数
xx1=sigma1*(u1*t-m/c*log(c/m*t-c11)-m/c*log(-c11)+c21);%减号时的表达式f（x，t）
xx2=sigma2*(u2*t-m/c*log(c/m*t-c12)-m/c*log(-c12)+c22);%减号时的表达式f（x，t）
xx3=sigma3*(u3*t-m/c*log(c/m*t-c13)-m/c*log(-c13)+c23);%减号时的表达式f（x，t）
xx4=sigma4*(u4*t-m/c*log(c/m*t-c14)-m/c*log(-c14)+c24);%减号时的表达式f（x，t）
plot(100*xx1,100*yyy,'k');
hold on;
plot(100*xx2,100*yyy,'b');
hold on;
plot(100*xx3,100*yyy,'g');
hold on; 
plot(100*xx3,100*yyy,'r');
hold on;
  %
  %plot(t(1:12),xx(1:12)*100,'r','LineWidth',2);
  
  
 x34 = xlsread('34(1).xls');  % 从文件data.xls中读取数据
 m_data34=x34(:,:);%取得表中除去第0行第0列之外的所有数据
 
x40 = xlsread('40(1).xls');  % 从文件data.xls中读取数据
m_data40=x40(:,:);%取得表中除去第0行第0列之外的所有数据
 
x47 = xlsread('47(1).xls');  % 从文件data.xls中读取数据
m_data47=x47(:,:);%取得表中除去第0行第0列之外的所有数据
 
x55 = xlsread('55(1).xls');  % 从文件data.xls中读取数据
m_data55=x55(:,:);%取得表中除去第0行第0列之外的所有数据

%平放
y1=m_data34(37,1:11);
x1=m_data34(38,1:11);
 
y2=m_data40(37,1:8);
x2=m_data40(38,1:8);
 
y3=m_data47(37,1:12);
x3=m_data47(38,1:12);
 
y4=m_data55(37,1:13);
x4=m_data55(38,1:13);

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
x11=x1-delta_x1;%修正后的横坐标
 
i_y1=atan((y1-20)/120);
r_y1=asin(sin(i_y1)/1.33);
delta_y1=20*tan(r_y1);
y11=y1+delta_y1;
 
%第二组数据校正
i_x2=atan((25-x2)/120);
r_x2=asin(sin(i_x2)/1.33);
delta_x2=20*tan(r_x2);
x22=(x2-delta_x2);%修正后的横坐标
 
i_y2=atan((y2-20)/120);
r_y2=asin(sin(i_y2)/1.33);
delta_y2=20*tan(r_y2);
y22=y2+delta_y2;
 
%第三组数据校正
i_x3=atan((25-x3)/120);
r_x3=asin(sin(i_x3)/1.33);
delta_x3=20*tan(r_x3);
x33=(x3-delta_x3);%修正后的横坐标
 
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

sum_delta=0;
for i=1:9
    sum_delta=sum_delta+(xx(i)*100-x44(i))^2;
end
plot(x11,y11,'k*');
hold on;
plot(x22,y22,'bd');
hold on;
plot(x33,y33,'go');
hold on;
plot(x44,y44,'rh');
hold on;
% plot(t(1:9),xx(1:9)*100,'r',t(1:9),x11(1:9),'b','LineWidth',2);
% title('竖放时水平偏移量与时间的分布曲线图','Fontsize',10);
% xlabel('时间t(单位s)','Fontsize',10);
% ylabel('横向偏移量x(单位cm)','Fontsize',10);
% legend('理论值(u=0.40m/s)','实际值','Location','NorthWest');
% axis([0 0.3 0 5]);

%figure;
% subplot(2,2,1)
% plot(t(1:9),xx1(1:9)*100,'r',t(1:9),x11(1:9),'b','LineWidth',2);
% title('竖放时x与t的分布曲线图','Fontsize',10);
% xlabel('时间t(单位s)','Fontsize',10);
% ylabel('横向偏移量x(单位cm)','Fontsize',10);
% legend('理论值(u=0.34m/s)','实际值','Location','NorthWest');
% axis([0 0.35 0 5]);
% 
% subplot(2,2,2)
% plot(t(1:6),xx2(1:6)*100,'r',t(1:6),x22(1:6)-1.6,'b','LineWidth',2);
% title('立放时x与t的分布曲线图','Fontsize',10);
% xlabel('时间t(单位s)','Fontsize',10);
% ylabel('横向偏移量x(单位cm)','Fontsize',10);
% legend('理论值(u=0.40m/s)','实际值','Location','NorthWest');
% axis([0 0.3 0 5]);
% 
% subplot(2,2,3)
% plot(t(1:8),xx3(1:8)*100,'r',t(1:8),x33(1:8)-0.8,'b','LineWidth',2);
% title('竖放时x与t的分布曲线图','Fontsize',10);
% xlabel('时间t(单位s)','Fontsize',10);
% ylabel('横向偏移量x(单位cm)','Fontsize',10);
% legend('理论值(u=0.47m/s)','实际值','Location','NorthWest');
% axis([0 0.35 0 7]);
% 
% subplot(2,2,4)
% plot(t(1:9),xx4(1:9)*100,'r',t(1:9),x44(1:9),'b','LineWidth',2);
% title('竖放时x与t的分布曲线图','Fontsize',10);
% xlabel('时间t(单位s)','Fontsize',10);
% ylabel('横向偏移量x(单位cm)','Fontsize',10);
% legend('理论值(u=0.55m/s)','实际值','Location','NorthWest');
% axis([0 0.4 0 8]);

