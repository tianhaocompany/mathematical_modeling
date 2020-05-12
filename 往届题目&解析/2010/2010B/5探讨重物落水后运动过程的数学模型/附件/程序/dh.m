  %(1)平放，流速为0.34,不同的高度
t=0:0.04:0.6;
cd=1;
s=80*40*10^(-6);
c=0.5*cd*s*1000;
m=0.5888;
u=0.34;%0.34;
c1=-1/u;
c2=-(-m/c*log(-c1))*2;
%xx=0.34*t-0.184*log(5.4348*t+2.9412)-0.1985+0.3970;
sigma=2;%修正系数
xx=sigma*(u*t-m/c*log(c/m*t-c1)-m/c*log(-c1)+c2);
%  figure;
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
y1=m_data34(39,1:9);
x1=m_data34(40,1:9);
 
y2=m_data40(39,1:6);
x2=m_data40(40,1:6);
 
y3=m_data47(39,1:8);
x3=m_data47(40,1:8);
 
y4=m_data55(39,1:9);
x4=m_data55(40,1:9);

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
 
%hold on;
 
plot(t(1:9),xx(1:9)*100,'r',t(1:9),x11(1:9),'b','LineWidth',2);
title('水平偏移量与时间的分布曲线图','Fontsize',10);
xlabel('时间t(单位s)','Fontsize',10);
ylabel('横向偏移量x(单位m)','Fontsize',10);
legend('理论值(u=0.34m/s)','实际值','Location','NorthWest');

