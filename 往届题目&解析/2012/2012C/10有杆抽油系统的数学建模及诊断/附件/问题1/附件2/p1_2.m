clc
clear all
close all
syms a b
x1= 0.950; %曲柄长度
x2= 3.675; %连杆长度
x3= 2.495; %后臂长度
x4= 4.315; %前臂长度
perfai = 4*2*pi/60; %每秒多少度
 Lxuandian=[4.80,4.80,4.79,4.77,4.75,4.73,4.70,4.67,4.63,4.58,4.53,4.48,4.42,4.35,4.29,4.21,4.14,4.05,3.97,3.89,3.80,3.71,3.61,3.52,3.42,3.32,3.22,3.12,3.01,2.91,2.80,2.70,2.59,2.48,2.37,2.26,2.16,2.05,1.94,1.84,1.73,1.63,1.53,1.43,1.33,1.23,1.14,1.05,0.96,0.87,0.79,0.71,0.63,0.55,0.48,0.42,0.35,0.30,0.24,0.19,0.15,0.11,0.08,0.05,0.03,0.01,0.00,0,0.00,0.01,0.02,0.04,0.07,0.10,0.14,0.18,0.23,0.28,0.34,0.40,0.47,0.53,0.61,0.68,0.76,0.84,0.92,1.01,1.09,1.18,1.27,1.36,1.46,1.55,1.65,1.74,1.84,1.93,2.03,2.12,2.22,2.31,2.41,2.50,2.60,2.69,2.78,2.87,2.96,3.05,3.14,3.22,3.31,3.39,3.47,3.55,3.63,3.71,3.78,3.85,3.92,3.99,4.06,4.12,4.18,4.24,4.30,4.35,4.40,4.45,4.49,4.54,4.58,4.61,4.65,4.68,4.71,4.73,4.76,4.77,4.79,4.79,4.80,];
A=Lxuandian(1:72);Lxuandian(1:72)=[];Lxuandian=[Lxuandian,A];
%%%%%%%%%%%%%%悬点功图位移%%%%%%%%%%%%
 Tchongcheng= 60/4; %一次冲程多少时间
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
Lsimple=x4.*x1/x3*(1-cos(fai));%简化方法
%速度
v=x4/x3*x1*perfai*(K*sin(fai+fai0)+x3*sin(fai-theta))./J;
v=v./sin(theta+peta);
v2=x4.*x1/x3*perfai*sin(fai);%简化方法
%加速度
dtheta=v/x4;
a1=x4/x3*x1*perfai^2*(K*cos(fai+fai0)+x3*cos(fai-theta))./J;
a2=(-x4/x3*x1*perfai^2*2*x3*perfai*x1*dtheta.*cos(fai-theta))./J;
a3=(x4/x3*x1*perfai^2*(-dtheta.^2.*cos(theta+peta)))./J;
a=(a1+a2+a3)./sin(theta+peta);
aa=x4.*x1/x3*perfai^2*cos(fai);%简化方法

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
plot(t(i),L(i),'-ko')
hold on
plot(t(i),Lxuandian(i),'-kv')
plot(t(i),Lsimple(i),'-k*')
h=legend('原始数据','模型一','模型二',1);
set(h,'box','off');%去掉边框
axis([0 15 0 6])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(gca,'fontsize',9);           % 坐标轴上的数字字号为9 pt
set(h,'fontsize',7);     
h1 = xlabel('时间(s)'); h2 = ylabel('位移(m)');   % 坐标轴名称
set(h1,'fontsize',9);             %  X轴的字号为9 pt
set(h2,'fontsize',9);             %  Y轴的字号为9 pt
print('-djpeg','-r600','理论悬点距离')          % 以600 dpi的分辨率输出一个 JPG 图片
print('-dtiff','-r300','理论悬点距离')  % 以300 dpi的分辨率输出一个tiff 的 EPS 图片
 saveas(gcf,'理论悬点距离.fig')% 输出fig

