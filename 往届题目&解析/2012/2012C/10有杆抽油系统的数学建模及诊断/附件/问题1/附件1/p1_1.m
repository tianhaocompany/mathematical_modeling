clc
clear all
close all
syms a b x
x1= 0.950; %曲柄长度
x2= 3.675; %连杆长度
x3= 2.495; %后臂长度
x4= 4.315; %前臂长度
perfai = 7.6*2*pi/60; %每秒多少度
Lxuandian=[2.518,2.512,2.504,2.495,2.484,2.472,2.459,2.444,2.427,2.41,2.391,2.372,2.351,2.329,2.305,2.281,2.256,2.229,2.201,2.172,2.142,2.111,2.079,2.046,2.011,1.975,1.938,1.9,1.86,1.82,1.778,1.735,1.69,1.645,1.598,1.55,1.501,1.451,1.399,1.347,1.294,1.239,1.184,1.129,1.072,1.015,0.958,0.901,0.844,0.786,0.729,0.673,0.618,0.563,0.51,0.459,0.409,0.361,0.315,0.272,0.231,0.193,0.158,0.127,0.098,0.074,0.052,0.034,0.02,0.01,0.003,0,0,0.004,0.012,0.023,0.037,0.054,0.074,0.097,0.123,0.152,0.183,0.216,0.251,0.289,0.328,0.369,0.412,0.456,0.501,0.548,0.596,0.645,0.694,0.745,0.797,0.849,0.901,0.954,1.008,1.062,1.116,1.17,1.225,1.279,1.334,1.388,1.442,1.496,1.55,1.603,1.655,1.707,1.758,1.808,1.858,1.906,1.953,1.999,2.043,2.086,2.127,2.167,2.205,2.241,2.275,2.307,2.337,2.365,2.391,2.414,2.435,2.454,2.471,2.485,2.497,2.507,2.515,2.52,2.524,2.525,2.524,2.522];
A=Lxuandian(1:72);Lxuandian(1:72)=[];Lxuandian=[Lxuandian,A];
%悬点功图位移
 Tchongcheng= 60/7.6; %一次冲程多少时间
 t=linspace(0,Tchongcheng,length(Lxuandian));
 fai= perfai.*t;
 LxuandianLilun1=x4.*x1/x3*(1-cos(fai));%简化方法

J=sqrt((x3+x1*sin(fai)).^2+(x1+x2-x1*cos(fai)).^2);
gama=abs(acos((x3^2+J.^2-x2^2)./J/2/x3));
peta=atan((x3+x1*sin(fai))./(x1+x2-x1*cos(fai)));
theta=pi-gama-peta;
fai0=atan(x3/(x1+x2));
K=sqrt((x1+x2)^2+x3^2);
thetamin=pi-acos((x3^2+K^2-(x1+x2)^2)/2/x3/K)-fai0;
%位移
L=x4*(theta-thetamin);
Lsimple=x4.*x1/x3*(1-cos(fai));%简化方法;%简化方法
%速度
v=x4/x3*x1*perfai*(K*sin(fai+fai0)+x3*sin(fai-theta))./J;
v=v./sin(theta+peta);
weiyi2=Lxuandian;
weiyi3=[weiyi2,weiyi2(144)];
weiyi3(1)=[];
t2=t;
t3=[t2,t2(144)];
t3(1)=[];
v2=(weiyi2-weiyi3)./(t2-t3);
v2(144)=0;
vsimple=x4.*x1/x3*perfai*sin(fai);%简化方法

%加速度
dtheta=v/x4;
a1=x4/x3*x1*perfai^2*(K*cos(fai+fai0)+x3*cos(fai-theta))./J;
a2=(-x4/x3*x1*perfai^2*2*x3*perfai*x1*dtheta.*cos(fai-theta))./J;
a3=(x4/x3*x1*perfai^2*(-dtheta.^2.*cos(theta+peta)))./J;
a=(a1+a2+a3)./sin(theta+peta);
asimple=x4.*x1/x3*perfai^2*cos(fai);%简化方法

p1 =0.03943; p2 =-0.4673;p3 =1.213 ;p4 =0.0718  ;%拟合速度，使加速度不产生震荡
 f= p1*x^3 + p2*x^2 + p3*x + p4;
v4=subs(f,t);
v5=[v4,v4(1)];
v5(1)=[];
aa=-(v4-v5)./0.0552;

%%%%%%图1%%%%%%%%%%%理论悬点距离%%%%%%%%%%%
fig1=figure;
xSize = 3;%3; 
ySize = 2.25;%2.25;                            %  图片的长和高，3英寸 x 2.25英寸
xLeft = (6-xSize)/2;  yTop = (10-ySize)/2;  
set(fig1,'Units','inches');                                %  单位为英寸
set(fig1,'position',[xLeft yTop xSize ySize]);  % 图片在屏幕上显示的位置
set(fig1,'PaperUnits','inches');                       %  单位为英寸
set(fig1,'PaperPosition',[xLeft yTop xSize ySize]);  % 图片在“纸上”显示的位置
%%%%%%%%%%%%%%%画图%%%%%%%%%%%%%%%%%%%%%%%
i=1:7:length(L);
plot(t(i),Lxuandian(i),'-ko')
hold on
plot(t(i),L(i),'-kv')
plot(t(i),Lsimple(i),'-k*')
h=legend('实测数据','模型一','模型二',1);
set(h,'box','off');%去掉边框
axis([0 8 0 5.5])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(gca,'fontsize',9);           % 坐标轴上的数字字号为9 pt
set(h,'fontsize',8);     
h1 = xlabel('时间(s)'); h2 = ylabel('位移(m)');   % 坐标轴名称
set(h1,'fontsize',9);             %  X轴的字号为9 pt
set(h2,'fontsize',9);             %  Y轴的字号为9 pt
print('-djpeg','-r600','理论悬点距离')          % 以600 dpi的分辨率输出一个 JPG 图片
print('-dtiff','-r300','理论悬点距离')  % 以300 dpi的分辨率输出一个tiff 的 EPS 图片
 saveas(gcf,'理论悬点距离.fig')% 输出fig

 
 
%%%%%%图2%%%%%%%%%%%理论速度%%%%%%%%%%%
fig2=figure;
xSize = 3;%3; 
ySize = 2.25%2.25;                            %  图片的长和高，3英寸 x 2.25英寸
xLeft = (6-xSize)/2;  yTop = (10-ySize)/2;  
set(fig2,'Units','inches');                                %  单位为英寸
set(fig2,'position',[xLeft yTop xSize ySize]);  % 图片在屏幕上显示的位置
set(fig2,'PaperUnits','inches');                       %  单位为英寸
set(fig2,'PaperPosition',[xLeft yTop xSize ySize]);  % 图片在“纸上”显示的位置
%%%%%%%%%%%%%%%画图%%%%%%%%%%%%%%%%%%%%%%%
i=1:7:length(L);
plot(t(i),v2(i),'-ko')
hold on
plot(t(i),v(i),'-kv')
plot(t(i),vsimple(i),'-k*')
axis([0 8 -2 2.5])
h=legend('实测数据','模型一','模型二',1);
set(h,'box','off');%去掉边框
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(gca,'fontsize',9);           % 坐标轴上的数字字号为9 pt
set(h,'fontsize',8);     
h1 = xlabel('时间(s)'); h2 = ylabel('速度(m/s)');   % 坐标轴名称
set(h1,'fontsize',9);             %  X轴的字号为9 pt
set(h2,'fontsize',9);             %  Y轴的字号为9 pt
print('-djpeg','-r600','理论速度')          % 以600 dpi的分辨率输出一个 JPG 图片
print('-dtiff','-r300','理论速度')  % 以300 dpi的分辨率输出一个tiff 的 EPS 图片
saveas(gcf,'理论速度.fig')% 输出fig

%%%%%%图3%%%%%%%%%%%理论加速度%%%%%%%%%%%
fig3=figure;
xSize = 3;%3; 
ySize = 2.25;%2.25;                            %  图片的长和高，3英寸 x 2.25英寸
xLeft = (6-xSize)/2;  yTop = (10-ySize)/2;  
set(fig3,'Units','inches');                                %  单位为英寸
set(fig3,'position',[xLeft yTop xSize ySize]);  % 图片在屏幕上显示的位置
set(fig3,'PaperUnits','inches');                       %  单位为英寸
set(fig3,'PaperPosition',[xLeft yTop xSize ySize]);  % 图片在“纸上”显示的位置
%%%%%%%%%%%%%%%画图%%%%%%%%%%%%%%%%%%%%%%%
i=1:7:length(L);
plot(t(i),aa(i),'-ko')
hold on
plot(t(i),a(i),'-kV')
plot(t(i),asimple(i),'-k*')
axis([0 8 -1.5 2.4])
h=legend('实测数据','模型一','模型二',2);
set(h,'box','off');%去掉边框
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(gca,'fontsize',9);           % 坐标轴上的数字字号为9 pt
set(h,'fontsize',8);      
h1 = xlabel('时间(s)'); h2 = ylabel('加速度(m/s^2)');   % 坐标轴名称
set(h1,'fontsize',9);             %  X轴的字号为9 pt
set(h2,'fontsize',9);             %  Y轴的字号为9 pt
print('-djpeg','-r600','理论加速度')          % 以600 dpi的分辨率输出一个JPG 图片
print('-dtiff','-r300','理论加速度')  % 以300 dpi的分辨率输出一个名为tiff 的 EPS 图片
saveas(gcf,'理论加速度.fig')% 输出fig
