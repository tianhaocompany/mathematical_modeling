clc;
clear all
close all
load xuangongtu 
omiga=2*pi*7.6/60;  %曲柄角速度
N=15;
E=2.1*10^11; %弹性模量
fr=pi*11^2*10^(-6);  %泵杆截面面积
pho=8456*fr;  %泵杆的线密度
a=4960;%sqrt(E/pho);     %应力传播速度
c=0.8;   %等效阻尼系数
h=792.5;
g=9.81;
M=pho*h*g;
new=-g/2/a^2*h^2;
new_diff=-E*fr*g*h/a^2;
t=linspace(0,1/7.6*60,144);
weiyi=[2.518,2.512,2.504,2.495,2.484,2.472,2.459,2.444,2.427,2.41,2.391,2.372,2.351,2.329,2.305,2.281,2.256,2.229,2.201,2.172,2.142,2.111,2.079,2.046,2.011,1.975,1.938,1.9,1.86,1.82,1.778,1.735,1.69,1.645,1.598,1.55,1.501,1.451,1.399,1.347,1.294,1.239,1.184,1.129,1.072,1.015,0.958,0.901,0.844,0.786,0.729,0.673,0.618,0.563,0.51,0.459,0.409,0.361,0.315,0.272,0.231,0.193,0.158,0.127,0.098,0.074,0.052,0.034,0.02,0.01,0.003,0,0,0.004,0.012,0.023,0.037,0.054,0.074,0.097,0.123,0.152,0.183,0.216,0.251,0.289,0.328,0.369,0.412,0.456,0.501,0.548,0.596,0.645,0.694,0.745,0.797,0.849,0.901,0.954,1.008,1.062,1.116,1.17,1.225,1.279,1.334,1.388,1.442,1.496,1.55,1.603,1.655,1.707,1.758,1.808,1.858,1.906,1.953,1.999,2.043,2.086,2.127,2.167,2.205,2.241,2.275,2.307,2.337,2.365,2.391,2.414,2.435,2.454,2.471,2.485,2.497,2.507,2.515,2.52,2.524,2.525,2.524,2.522];
A=weiyi(1:72);weiyi(1:72)=[];weiyi=[weiyi,A];
zaihe=[39.7,39.665,39.665,38.131,31.822,30.184,28.372,27.047,26.385,23.806,19.17,16.765,14.988,13.245,11.885,14.221,17.114,19.693,20.808,22.446,23.422,21.087,18.996,16.451,15.545,13.698,13.001,14.465,16.277,18.159,17.183,17.323,17.288,16.521,15.371,14.709,15.057,14.43,14.256,14.36,14.534,14.709,14.883,14.778,14.813,14.709,14.953,15.266,15.406,15.301,15.51,16.242,16.73,17.253,17.671,18.612,19.031,19.344,20.146,20.808,21.784,21.959,22.69,23.213,23.492,23.353,23.388,23.806,24.12,24.538,24.886,25.339,28.546,31.16,33.251,35.412,37.957,40.78,46.148,50.4,53.99,55.942,56.883,57.092,57.545,58.103,58.138,58.242,58.347,58.068,58.068,58.242,58.661,58.905,59.462,60.02,60.891,61.205,61.344,60.891,61.275,61.066,60.752,59.811,59.497,58.87,58.033,57.615,57.232,56.465,55.524,55.036,54.408,53.955,53.502,53.537,53.049,53.223,52.7,52.247,52.178,52.247,51.481,50.783,50.33,49.807,49.041,48.274,47.298,46.74,45.834,45.59,45.207,44.963,44.684,44.405,44.196,43.917,43.603,43.115,42.732,41.965,40.85,40.257];
B=zaihe(1:72);zaihe(1:72)=[];zaihe=[zaihe,B];
zaihe=zaihe*10^3-0;
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
end
%%%%%%%%求解边界条件的位移和载荷随时间的变化关系
for j=1:144
    qiuhe1=sigma(2:N).*cos((1:N-1).*omiga*t(j))+tao(2:N).*sin((1:N-1)*omiga*t(j));  %位移函数中的求和部分
    qiuhe2=v(2:N).*cos((1:N-1).*omiga*t(j))+delta(2:N).*sin((1:N-1)*omiga*t(j));  %载荷函数中的求和部分
    uzaihe(j)=v(1)/2+sum(qiuhe2);%位移的傅里叶展开式
    fzaihe(j)=sigma(1)/2+sum(qiuhe1);%载荷的傅里叶展开式
end
%%%%%%%%%%%%加因子项%%%%%%%%%%%%%%%%%%%5
for j=1:144
    qiuhe1=O(1:N-1).*cos((1:N-1).*omiga*t(j))+P(1:N-1).*sin((1:N-1)*omiga*t(j));  %位移函数中的求和部分
    qiuhe2=O_diff(1:N-1).*cos((1:N-1).*omiga*t(j))+P_diff(1:N-1).*sin((1:N-1)*omiga*t(j));  %载荷函数中的求和部分
    uyinzi(j)=sigma(1)/(2*E*fr)*h+v(1)/2+sum(qiuhe1)+new;
    Fyinzi(j)=E*fr*(sigma(1)/(2*E*fr)+sum(qiuhe2))+new_diff;%柱塞的载荷计算公式
end
%%%%%%%%%%%%%%%%% 泵功对比图%%%%%%%%%%%%%%%
fig2=figure;
xSize = 3;%3; 
ySize = 2.25%2.25;                            %  图片的长和高，3英寸 x 2.25英寸
xLeft = (6-xSize)/2;  yTop = (10-ySize)/2;  
set(fig2,'Units','inches');                                %  单位为英寸
set(fig2,'position',[xLeft yTop xSize ySize]);  % 图片在屏幕上显示的位置
set(fig2,'PaperUnits','inches');                       %  单位为英寸
set(fig2,'PaperPosition',[xLeft yTop xSize ySize]);  % 图片在“纸上”显示的位置
%%%%%%%%%%%%%%%画图%%%%%%%%%%%%%%%%%%%%%%%
cc=1:5:144;
plot(s(cc),f(cc)/10^3,'k-o')
hold on
plot(uyinzi(cc),Fyinzi(cc)/10^3,'b-v')
h=legend('未加因子','加因子',1);
set(h,'box','off');%去掉边框
axis([-0.2 3 -20 60])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(gca,'fontsize',9);           % 坐标轴上的数字字号为9 pt
h1 = xlabel('位移(m)'); h2 = ylabel('载荷(kN)');   % 坐标轴名称
set(h1,'fontsize',9);             %  X轴的字号为9 pt
set(h2,'fontsize',9);             %  Y轴的字号为9 pt
print('-djpeg','-r600','泵功对比图')          % 以600 dpi的分辨率输出一个JPG 图片
print('-dtiff','-r300',' 泵功对比图')  % 以300 dpi的分辨率输出一个tiff 的 图片
saveas(gcf,' 泵功对比图.fig')% 输出fig