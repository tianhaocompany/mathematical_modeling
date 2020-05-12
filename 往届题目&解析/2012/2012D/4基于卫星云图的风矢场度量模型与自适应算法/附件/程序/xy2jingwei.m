% 灰度平面坐标到地理坐标新的转换
% 2012-09-22
function [jingdu,weidu]=xy2jingwei(i,j)

Rse=42164000; % 卫星到地心的距离
Q=140*10^(-6);% 步进角，微弧
P=140*10^(-6);% 采样角，微弧
a=6378136.5; % 地球长半轴
b=6356751.8; % 地球短半轴
i0=1145; % 星下标在S-VISSR帧平面上的行数
j0=1145; % 星下标在S-VISSR帧平面上的列数
lo=86.5; % 星下点所在经度，东经为正
la=0; % 星下点所在纬度，北纬为正
h=Rse;   % 卫星到星下点的距离

alfa=-(i0-i)*Q;
beita=-(j0-j)*P;


A=((tan(beita))^2+1)/a^2+((tan(alfa))^2)/b^2;

B=-2*h*(tan(beita))^2/a^2-2*h*(tan(alfa))^2/b^2;

C=h^2*(tan(beita))^2/a^2+h^2*(tan(alfa))^2/b^2-1;

y_zong=(-B+sqrt(B^2-4*A*C))/(2*A);


x_heng=-(y_zong-h)*tan(beita);

z_shu=(y_zong-h)*tan(alfa);

jingdu=atan(x_heng/y_zong)*180/pi+lo;
weidu=atan(z_shu/sqrt(x_heng^2+y_zong^2))*180/pi;























