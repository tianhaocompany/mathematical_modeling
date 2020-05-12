%%%%%%%%%三级杆示功图和泵功图
clc;
clear all
close all
omiga=2*pi*4/60;  %曲柄角速度
N=20;
E=2.1*10^11; %弹性模量
a=4960;%应力传播速度
c=0.8;   %等效阻尼系数
nuo=8456;
g=9.81;

%%%%%%%杆的参数%%%%%%%%%
h=523.61;%一级杆长度
fr=pi*25^2*10^(-6)/4;  %一级杆截面面积
h2=664.32;%一级杆长度
fr2=pi*22^2*10^(-6)/4;  %二级杆截面面积
h3=618.35;%一级杆长度
fr3=pi*19^2*10^(-6)/4;  %三级杆截面面积
g=9.81;
M=nuo*(h*fr+h2*fr2+h3*fr3)*g;
%%%%%%%%位移和载荷%%%%%%%%%%%%%%%%%5555
weiyi=[0.24,0.19,0.15,0.11,0.08,0.05,0.03,0.01,0.00,0,0.00,0.01,0.02,0.04,0.07,0.10,0.14,0.18,0.23,0.28,0.34,0.40,0.47,0.53,0.61,0.68,0.76,0.84,0.92,1.01,1.09,1.18,1.27,1.36,1.46,1.55,1.65,1.74,1.84,1.93,2.03,2.12,2.22,2.31,2.41,2.50,2.60,2.69,2.78,2.87,2.96,3.05,3.14,3.22,3.31,3.39,3.47,3.55,3.63,3.71,3.78,3.85,3.92,3.99,4.06,4.12,4.18,4.24,4.30,4.35,4.40,4.45,4.49,4.54,4.58,4.61,4.65,4.68,4.71,4.73,4.76,4.77,4.79,4.79,4.80,4.80,4.80,4.79,4.77,4.75,4.73,4.70,4.67,4.63,4.58,4.53,4.48,4.42,4.35,4.29,4.21,4.14,4.05,3.97,3.89,3.80,3.71,3.61,3.52,3.42,3.32,3.22,3.12,3.01,2.91,2.80,2.70,2.59,2.48,2.37,2.26,2.16,2.05,1.94,1.84,1.73,1.63,1.53,1.43,1.33,1.23,1.14,1.05,0.96,0.87,0.79,0.71,0.63,0.55,0.48,0.42,0.35,0.30];
A=weiyi(1:10);weiyi(1:10)=[];weiyi=[weiyi,A];
zaihe=[48.50,48.14,47.96,47.35,46.85,46.99,46.67,46.81,47.46,48.61,50.01,52.84,52.98,53.2,53.56,53.42,52.77,55.46,57.08,59.02,60.67,61.46,62.28,63.07,64.4,67.2,69.78,71.94,74.2,75.21,76.68,76.64,74.42,71.87,70.04,68.67,67.49,67.42,67.45,68.89,70.97,72.58,73.05,73.23,72.87,72.08,70.90,69.96,68.10,67.31,67.63,68.24,68.42,69.17,70.50,71.26,71.47,71.01,70.29,69.53,68.85,68.17,67.99,67.63,67.88,68.6,69.21,69.75,69.78,70.04,70.07,69.64,69.03,68.28,67.77,67.31,67.27,67.38,67.74,68.13,68.6,68.71,68.67,68.17,67.85,67.31,66.81,65.73,65.15,64.72,63.61,63.25,62.82,62.57,62.46,62.68,62.50,61.71,60.92,59.45,58.19,56.97,55.10,53.59,51.55,49.83,47.46,44.73,42.25,39.63,38.98,40.6,43.44,45.48,47.24,48.78,49.68,49.75,49.07,47.31,44.73,43.22,42.43,42.29,42.50,43.47,45.55,46.13,47.74,48.25,48.07,47.53,46.49,45.27,44.58,43.76,43.65,44.05,44.87,46.06,46.67,48.14,48.53];
B=zaihe(1:10);zaihe(1:10)=[];zaihe=[zaihe,B];
zaihe=zaihe*10^3-M;
t=linspace(0,1/4*60,143);
k=143;

%%%%%%%%%%%%%一级杆%%%%%%%%%%%%%%%%%%%%%%%%5
for i=1:N
    sigma(i)=omiga/pi*trapz(t,zaihe.*cos((i-1)*omiga*t));
    tao(i)=omiga/pi*trapz(t,zaihe.*sin((i-1)*omiga*t));
    v(i)=omiga/pi*trapz(t,weiyi.*cos((i-1)*omiga*t));
    delta(i)=omiga/pi*trapz(t,weiyi.*sin((i-1)*omiga*t));
end
for i=1:N-1
    alpha(i)=i*omiga/(a*sqrt(2))*sqrt(1+sqrt(1+(c/(i*omiga))^2));
    beta(i)=i*omiga/(a*sqrt(2))*sqrt(-1+sqrt(1+(c/(i*omiga))^2));
    x(i)=(sigma(i+1)*alpha(i)+tao(i+1)*beta(i))/(E*fr*(alpha(i)^2+beta(i)^2));
    miu(i)=(sigma(i+1)*beta(i)-tao(i+1)*alpha(i))/(E*fr*(alpha(i)^2+beta(i)^2));
    O(i)=(x(i)*cosh(beta(i)*h)+delta(i+1)*sinh(beta(i)*h))*sin(alpha(i)*h)+(miu(i)*sinh(beta(i)*h)+v(i+1)*cosh(beta(i)*h))*cos(alpha(i)*h);
    P(i)=(x(i)*sinh(beta(i)*h)+delta(i+1)*cosh(beta(i)*h))*cos(alpha(i)*h)-(miu(i)*cosh(beta(i)*h)+v(i+1)*sinh(beta(i)*h))*sin(alpha(i)*h);
    O_diff(i)=alpha(i)*cos(alpha(i)*h)*(x(i)*cosh(beta(i)*h)+delta(i+1)*sinh(beta(i)*h))+(x(i)*beta(i)*sinh(beta(i)*h)+delta(i+1)*beta(i)*cosh(beta(i)*h))*sin(alpha(i)*h)...
        -(miu(i)*sinh(beta(i)*h)+v(i+1)*cosh(beta(i)*h))*alpha(i)*sin(alpha(i)*h)+(miu(i)*beta(i)*cosh(beta(i)*h)+v(i+1)*beta(i)*sinh(beta(i)*h))*cos(alpha(i)*h);
    P_diff(i)=-(x(i)*sinh(beta(i)*h)+delta(i+1)*cosh(beta(i)*h))*alpha(i)*sin(alpha(i)*h)+(x(i)*beta(i)*cosh(beta(i)*h)+delta(i+1)*beta(i)*sinh(beta(i)*h))*cos(alpha(i)*h)...
        -(miu(i)*cosh(beta(i)*h)+v(i+1)*sinh(beta(i)*h))*alpha(i)*cos(alpha(i)*h)-(miu(i)*beta(i)*sinh(beta(i)*h)+v(i+1)*beta(i)*cosh(beta(i)*h))*sin(alpha(i)*h);
%      O_diff(i)=(tao(i+1)/E/fr*sinh(beta(i)*h)+(delta(i+1)*beta(i)-v(i+1)*alpha(i))*cosh(beta(i)*h))*sin(alpha(i)*h)...
%     +(sigma(i+1)/E/fr*cosh(beta(i)*h)+(v(i+1)*beta(i)+delta(i+1)*alpha(i))*sinh(beta(i)*h))*cos(alpha(i)*h);
%     P_diff(i)=(tao(i+1)/E/fr*cosh(beta(i)*h)+(delta(i+1)*beta(i)-v(i+1)*alpha(i))*sinh(beta(i)*h))*cos(alpha(i)*h)...
%     -(sigma(i+1)/E/fr*sinh(beta(i)*h)+(v(i+1)*beta(i)+delta(i+1)*alpha(i))*cosh(beta(i)*h))*sin(alpha(i)*h);
end
%%%%%%%%求解边界条件的位移和载荷随时间的变化关系
for j=1:k
    qiuhe1=O(1:N-1).*cos((1:N-1).*omiga*t(j))+P(1:N-1).*sin((1:N-1)*omiga*t(j));  %位移函数中的求和部分
    qiuhe2=O_diff(1:N-1).*cos((1:N-1).*omiga*t(j))+P_diff(1:N-1).*sin((1:N-1)*omiga*t(j));  %载荷函数中的求和部分
    u(j)=sigma(1)/(2*E*fr)*h+v(1)/2+sum(qiuhe1);
    F(j)=E*fr*(sigma(1)/(2*E*fr)+sum(qiuhe2));%柱塞的载荷计算公式
end

%%%%%%%%%%%%%二级杆%%%%%%%%%%%%%%%%%%%%%%%%5
for i=1:N-1
    sigma2(i+1)=E*fr*O_diff(i);
    tao2(i+1)=E*fr*P_diff(i);
    v2(i+1)=O(i);
    delta2(i+1)=P(i);
end
    sigma2(1)=sigma(1);
    v2(1)=sigma(1)*h/E/fr+v(1);
    tao2(1)=0;
    delta2(1)=0;
    sigma=[];tao=[];v=[];delta=[];alpha=[];beta=[];x=[];miu=[];O=[];P=[];O_diff=[];P_diff=[];
    sigma=sigma2;
    tao=tao2;
    v=v2;
    delta=delta2;
    h=h2;
    fr=fr2;
%     M=nuo*h*fr*g;
    for i=1:N-1
    alpha(i)=i*omiga/(a*sqrt(2))*sqrt(1+sqrt(1+(c/(i*omiga))^2));
    beta(i)=i*omiga/(a*sqrt(2))*sqrt(-1+sqrt(1+(c/(i*omiga))^2));
    x(i)=(sigma(i+1)*alpha(i)+tao(i+1)*beta(i))/(E*fr*(alpha(i)^2+beta(i)^2));
    miu(i)=(sigma(i+1)*beta(i)-tao(i+1)*alpha(i))/(E*fr*(alpha(i)^2+beta(i)^2));
    O(i)=(x(i)*cosh(beta(i)*h)+delta(i+1)*sinh(beta(i)*h))*sin(alpha(i)*h)+(miu(i)*sinh(beta(i)*h)+v(i+1)*cosh(beta(i)*h))*cos(alpha(i)*h);
    P(i)=(x(i)*sinh(beta(i)*h)+delta(i+1)*cosh(beta(i)*h))*cos(alpha(i)*h)-(miu(i)*cosh(beta(i)*h)+v(i+1)*sinh(beta(i)*h))*sin(alpha(i)*h);
    O_diff(i)=alpha(i)*cos(alpha(i)*h)*(x(i)*cosh(beta(i)*h)+delta(i+1)*sinh(beta(i)*h))+(x(i)*beta(i)*sinh(beta(i)*h)+delta(i+1)*beta(i)*cosh(beta(i)*h))*sin(alpha(i)*h)...
        -(miu(i)*sinh(beta(i)*h)+v(i+1)*cosh(beta(i)*h))*alpha(i)*sin(alpha(i)*h)+(miu(i)*beta(i)*cosh(beta(i)*h)+v(i+1)*beta(i)*sinh(beta(i)*h))*cos(alpha(i)*h);
    P_diff(i)=-(x(i)*sinh(beta(i)*h)+delta(i+1)*cosh(beta(i)*h))*alpha(i)*sin(alpha(i)*h)+(x(i)*beta(i)*cosh(beta(i)*h)+delta(i+1)*beta(i)*sinh(beta(i)*h))*cos(alpha(i)*h)...
        -(miu(i)*cosh(beta(i)*h)+v(i+1)*sinh(beta(i)*h))*alpha(i)*cos(alpha(i)*h)-(miu(i)*beta(i)*sinh(beta(i)*h)+v(i+1)*beta(i)*cosh(beta(i)*h))*sin(alpha(i)*h);
end
%%%%%%%%二级杆柱塞的载荷计算公式%%%%%%%%%%%%%%%%%%%%%
for j=1:k
    qiuhe1=O(1:N-1).*cos((1:N-1).*omiga*t(j))+P(1:N-1).*sin((1:N-1)*omiga*t(j));  %位移函数中的求和部分
    qiuhe2=O_diff(1:N-1).*cos((1:N-1).*omiga*t(j))+P_diff(1:N-1).*sin((1:N-1)*omiga*t(j));  %载荷函数中的求和部分
    u2(j)=sigma(1)/(2*E*fr2)*h+v(1)/2+sum(qiuhe1);
    F2(j)=E*fr*(sigma(1)/(2*E*fr2)+sum(qiuhe2));%柱塞的载荷计算公式
end




%%%%%%%%%%%%%三级杆%%%%%%%%%%%%%%%%%%%%%%%%5
for i=1:N-1
    sigma3(i+1)=E*fr2*O_diff(i);
    tao3(i+1)=E*fr2*P_diff(i);
    v3(i+1)=O(i);
    delta3(i+1)=P(i);
end
    sigma3(1)=sigma(1);
    v3(1)=sigma(1)*h/E/fr2+v(1);
    tao3(1)=0;
    delta3(1)=0;
    sigma=[];tao=[];v=[];delta=[];alpha=[];beta=[];x=[];miu=[];O=[];P=[];O_diff=[];P_diff=[];
    sigma=sigma3;
    tao=tao3;
    v=v3;
    delta=delta3;
    h=h3;
    fr=fr3;
%     weiyi=u2;
%     zaihe=F2-M;
    for i=1:N-1
    alpha(i)=i*omiga/(a*sqrt(2))*sqrt(1+sqrt(1+(c/(i*omiga))^2));
    beta(i)=i*omiga/(a*sqrt(2))*sqrt(-1+sqrt(1+(c/(i*omiga))^2));
    x(i)=(sigma(i+1)*alpha(i)+tao(i+1)*beta(i))/(E*fr*(alpha(i)^2+beta(i)^2));
    miu(i)=(sigma(i+1)*beta(i)-tao(i+1)*alpha(i))/(E*fr*(alpha(i)^2+beta(i)^2));
    O(i)=(x(i)*cosh(beta(i)*h)+delta(i+1)*sinh(beta(i)*h))*sin(alpha(i)*h)+(miu(i)*sinh(beta(i)*h)+v(i+1)*cosh(beta(i)*h))*cos(alpha(i)*h);
    P(i)=(x(i)*sinh(beta(i)*h)+delta(i+1)*cosh(beta(i)*h))*cos(alpha(i)*h)-(miu(i)*cosh(beta(i)*h)+v(i+1)*sinh(beta(i)*h))*sin(alpha(i)*h);
    O_diff(i)=alpha(i)*cos(alpha(i)*h)*(x(i)*cosh(beta(i)*h)+delta(i+1)*sinh(beta(i)*h))+(x(i)*beta(i)*sinh(beta(i)*h)+delta(i+1)*beta(i)*cosh(beta(i)*h))*sin(alpha(i)*h)...
        -(miu(i)*sinh(beta(i)*h)+v(i+1)*cosh(beta(i)*h))*alpha(i)*sin(alpha(i)*h)+(miu(i)*beta(i)*cosh(beta(i)*h)+v(i+1)*beta(i)*sinh(beta(i)*h))*cos(alpha(i)*h);
    P_diff(i)=-(x(i)*sinh(beta(i)*h)+delta(i+1)*cosh(beta(i)*h))*alpha(i)*sin(alpha(i)*h)+(x(i)*beta(i)*cosh(beta(i)*h)+delta(i+1)*beta(i)*sinh(beta(i)*h))*cos(alpha(i)*h)...
        -(miu(i)*cosh(beta(i)*h)+v(i+1)*sinh(beta(i)*h))*alpha(i)*cos(alpha(i)*h)-(miu(i)*beta(i)*sinh(beta(i)*h)+v(i+1)*beta(i)*cosh(beta(i)*h))*sin(alpha(i)*h);
end
%%%%%%%%三级杆柱塞的载荷计算公式%%%%%%%%%%%%%%%%%%%%%
for j=1:k
    qiuhe1=O(1:N-1).*cos((1:N-1).*omiga*t(j))+P(1:N-1).*sin((1:N-1)*omiga*t(j));  %位移函数中的求和部分
    qiuhe2=O_diff(1:N-1).*cos((1:N-1).*omiga*t(j))+P_diff(1:N-1).*sin((1:N-1)*omiga*t(j));  %载荷函数中的求和部分
    u3(j)=sigma(1)/(2*E*fr3)*h+v(1)/2+sum(qiuhe1);
    F3(j)=E*fr*(sigma(1)/(2*E*fr3)+sum(qiuhe2));%柱塞的载荷计算公式
end


%%%%%%%%%%%三级杆示功图和泵功图%%%%%%%%%%%%%%%
fig1=figure;
xSize = 5;%3; 
ySize = 2.25%2.25;                            %  图片的长和高，3英寸 x 2.25英寸
xLeft = (6-xSize)/2;  yTop = (10-ySize)/2;  
set(fig1,'Units','inches');                                %  单位为英寸
set(fig1,'position',[xLeft yTop xSize ySize]);  % 图片在屏幕上显示的位置
set(fig1,'PaperUnits','inches');                       %  单位为英寸
set(fig1,'PaperPosition',[xLeft yTop xSize ySize]);  % 图片在“纸上”显示的位置
%%%%%%%%%%%%%%%画图%%%%%%%%%%%%%%%%%%%%%%%
i=1:1:length(zaihe);
huatu=(zaihe+M)/1000;
plot(weiyi(i),huatu(i),'kx')
 hold on
 plot(u3(i),F3(i)/10^3,'k.')
 h3 = xlabel('位移(m)'); h4 = ylabel('载荷(kN)'); 
 h=legend('示功图','泵功图',-1);
 set(gca,'xtick',-10:2:16)
 set(gca,'ytick',-15:15:75)
 set(gca,'fontsize',9);      
 axis([-0.5 5.5 -20 80])
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(gca,'fontsize',9);           % 坐标轴上的数字字号为9 pt
set(h3,'fontsize',9);             %  X轴的字号为9 pt
set(h4,'fontsize',9);             %  Y轴的字号为9 pt
print('-djpeg','-r600','三级杆示功图和泵功图')          % 以600 dpi的分辨率输出一个JPG 图片
print('-dtiff','-r300','三级杆示功图和泵功图')  % 以300 dpi的分辨率输出一个tiff 的 图片
saveas(gcf,'三级杆示功图和泵功图.fig')% 输出fig
u3;
F3=F3/1000;
result=[u3;F3];
xlswrite('三级杆位移和载荷.xls',result)
save weiyizaihe u3 F3