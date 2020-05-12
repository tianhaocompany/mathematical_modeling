
global Gm
Gm = 3.986005e14;
  
load data.mat

hmax = 5;

option_s = odeset('AbsTol',1e-18,'RelTol',1e-8,'MaxStep',hmax );%'OutputFcn','odephas3', %高
%options  =  odeset('AbsTol',1e-10,'RelTol',1e-3,'MaxStep',hmax );%'OutputFcn','odephas3',%低

%插值 求解 规律 t 时刻的 观测值 alpha 和 beta ， 通过内推  求解 51:169s的 alpha和beta, %通过外推 求解 50 和 170 s处的位置和速度。
step1 = 0.2; 
hmax1 = 5;
n_itv = 15;%差分的间隔

t1 =50 : step1 :170;%需要插值的点

rs_in = Rs_cal( step1, hmax1);
n_pos = size(rs_in,1);

%% 做出卫星 通过观测值 确定的位置的 曲线图
%分开画图
% figure(1);
% for i = 1 : 3;
%     subplot(2,3,i);
%     plot(t1', rs_in(:,i));
% end
% title('观测位置图');


%% 利用差分 来求解出 加速度 a, 由以上分析，知9星的 数据误差相对较小  % 以下全部是在 基础坐标系内进行计算
%未知量包括
% vr(t)：燃料相对于火箭尾部喷口的喷射速度的逆矢量
% mdot(t)：质量变化率
% m0： 飞行器的初始质量
 
%% 废掉思路----插值 求解 规律 t 时刻的 观测值 alpha 和 beta ， 通过内推  求解 51:169s的 alpha和beta, 通过外推 求解 50 和 170 s处的位置和速度。 
% 利用差分 来求解出 加速度 a, 由以上分析，知9星的 数据误差相对较小  % 以下全部是在 基础坐标系内进行计算
%未知量包括
% vr(t)：燃料相对于火箭尾部喷口的喷射速度的逆矢量
% mdot(t)：质量变化率
% m0： 飞行器的初始质量

% 已知量 是0.2s步长下， 飞行器的位置矢量
h =  n_itv*step;%差分 
n_dif = 1 : h : n_pos;
num = size(n_dif,1);

rs0_dif = rs_in(n_dif,:);

dr = rs0_dif(3: num,:) -  rs0_dif(1: num-2,:); %0.2s的位移

  
v = dr/h/2;%  一共有 n_pos-1 个速度点


v_dif = v(1:num-2,:);
vm_dif = sum(v_dif.^2,2).^(0.5);%速度模值
%差分加速度
a_dif  = (rs_in(3: num,:) - 2* rs_in(2: num-1,:) +  rs_in(1: num-2,:)) / h/h ;% 加速度的大小，共有 nv-1个 样点

ax_dif = a_dif(:,1);
ay_dif = a_dif(:,2);
az_dif = a_dif(:,3);

%表示每个加速度对应的 速度矢量 v 和 位置矢量 r, 用每段的平均值来表示
v_x = v_dif(:,1);
v_y = v_dif(:,2);
v_z = v_dif(:,3);
 
r_dif = rs_in(1:num-2,:);
  
r_x = r_dif(:,1);
r_y = r_dif(:,2);
r_z = r_dif(:,3);

pva_dif = [r_dif v_dif a_dif];


%% 新思路-直接 对 求出的 惯性系下的坐标，进行滤波处理
% t_cal = t_pl - t_pl(1);
t_pl = (t1 - t1(1))';

r0_x = rs_in(:,1);
r0_y = rs_in(:,2);
r0_z = rs_in(:,3);
 
% % 3 次拟合  
% [ply_rx,S_rx]  = polyfit(t_pl, r0_x, 3);
% [ply_ry,S_ry]  = polyfit(t_pl, r0_y, 3);
% [ply_rz,S_rz]  = polyfit(t_pl, r0_z, 3);
% 
% % 拟合后的 方程 - 位置矢量
% rx = ply_rx(1).*t_pl.^3 + ply_rx(2).*t_pl.^2 + ply_rx(3).*t_pl + ply_rx(4);
% ry = ply_ry(1).*t_pl.^3 + ply_ry(2).*t_pl.^2 + ply_ry(3).*t_pl + ply_ry(4);
% rz = ply_rz(1).*t_pl.^3 + ply_rz(2).*t_pl.^2 + ply_rz(3).*t_pl + ply_rz(4);
% 
% 
% vx = 3.*ply_rx(1).*t_pl.^2 + 2.*ply_rx(2).*t_pl  + ply_rx(3) ;
% vy = 3.*ply_ry(1).*t_pl.^2 + 2.*ply_ry(2).*t_pl  + ply_ry(3) ;
% vz = 3.*ply_rz(1).*t_pl.^2 + 2.*ply_rz(2).*t_pl  + ply_rz(3) ;
% 
% ax = 6.*ply_rx(1).*t_pl + 2.*ply_rx(2) ;
% ay = 6.*ply_ry(1).*t_pl + 2.*ply_ry(2)  ;
% az = 6.*ply_rz(1).*t_pl + 2.*ply_rz(2) ;
% 
% r = [rx ry rz];
% v = [vx vy vz];
% a = [ax ay az];

 
%% 做出 拟合的 位置-速度-加速度 图
% figure;
% for i = 1 : 9;
% subplot(3,3,i);%三次拟合
% plot(t_pl, pva_pl( :,i),'r','LineWidth',3);
% 
% hold on;
% plot(t_pl(1:n_pos-2), pva_dif( :,i));%差分
% 
% end
% title('拟合轨道图');

% % *************利用模值 计算 vr 和mdotm×××××××××××××××
t_cal = t_pl ;
am  = sum(a.^2,2).^(0.5);
rm  = sum(r.^2,2).^(0.5); % 位置 模值
vm  = sum(v.^2,2).^(0.5); % 速度 模值


%飞行器所受的外力之和
Fe_x = -Gm./(rm.^3).*rx;% x轴方向
Fe_y = -Gm./(rm.^3).*ry;% y轴方向  
Fe_z = -Gm./(rm.^3).*rz;% z轴方向  

%Fr,火箭产生的加速度
% 化简成 方程组
% A * x + B * y = b; 其中 A= accl+Gm/r^3*r_vec, B = v_unit( 飞行器 的 速度 方向)， x = m0/mdot, y = vr; 
A_m = ((ax - Fe_x).^2+( ay - Fe_y).^2+ (az - Fe_z).^2).^(0.5);

%vr,燃料相对于火箭尾部喷口的喷射速度的矢量，方向 与飞行器方向相反，故速度变化率取 负值

b_pl = t_cal.*A_m;
 
A_pl = [A_m -1*ones(num,1)];
A_pl_new = A_pl'*A_pl;
b_pl_new = A_pl'*b_pl; 
para_pl = A_pl_new\b_pl_new;
% % *************利用模值 计算 vr 和mdotm×××××××××××××××


% ****** 利用 各分量 建立方程 计算 vr 和mdotm×××××××××××××××
 
A_vr = -[vx./vm; vy./vm; vz./vm];% vr(t)的
A_m = [ax - Fe_x; ay - Fe_y; az - Fe_z;];

b_x = -t_pl.* (ax - Fe_x) ;
b_y = -t_pl.* (ay - Fe_y);
b_z = -t_pl.* (az - Fe_z);
 
b_dif = [b_x;  b_y; b_z];


A_dif = [ A_m -A_vr];
A_dif_new = A_dif'*A_dif;
b_dif_new = A_dif'*b_dif;

para2 = A_dif_new\b_dif_new;
% ****** 利用 各分量 建立方程 计算 vr 和mdotm×××××××××××××××

r_error  = r  -  rs_in ;

figure;
for i = 1 : 3;
subplot(1,3,i);
plot(t_pl , abs(r_error(:,i)));
end
title('拟合残差图');


 
%% 已经求出了, a的表达式，所以可以直接积分,估计轨道
%初始 位置 和速度 都可以 都用 上面求的, 利用插值的初始解 就可以了。
% 分别为 r_dif 和 v_dif
% 下面进行积分计算，输出步长 为 10s;
 
%  t_gus = t1;

n_gus = size(t_gus,2);

x0_gus = [r(1,:) v(1,:)];%这里的初值 是 50.3754448072 处的 初值

tspan_gus = t1;

hmax_gus = 2;

options1  =  odeset('AbsTol',1e-16,'RelTol',1e-0,'MaxStep',hmax_gus);%'OutputFcn','odephas3',

mdotm = para_pl(1);
vr    = para_pl(2);

[t_local_gus,pv_gus] = ode45('myode',tspan_gus, x0_gus,options1, Gm, vr, mdotm);
 


% %做出估计轨道的位置和速度曲线图
% %分开画图
% figure;
% for i = 1 : 6;
% subplot(2,3,i);
% plot(t_local_gus(1:n_gus)+ t_gus(1) , pv_gus(1:n_gus,i));
% end
% title('估计轨道图');
% % save gcf 

p_error = pv_gus  - [rs_in   v ];

figure;
for i = 1 : 3;
subplot(2,3,i);
plot(t_local_gus , abs(p_error(:,i)));
end
title('估计残差图');




% %同一个图中
% figure;
% plot(t_local_gus(2:n_gus-1), pv_gus(2:n_gus-1,:));
%做出轨道的位置和速度曲线图


% 飞行器每隔 10s 的取样点
% 积分起点 为， 50.3754448072
t_out = t_local_gus(2:5*10: (169-51)*5);
pv_out = pv_gus(2:5*10: (169-51)*5,:);% 每隔 10s 的取样点

n_out = size(t_out,1);
% 卫星每隔 10s 的位置， 为了求解 转换矩阵
ts_out = [0; t_out-t_gus(1)];%为了输出， 必须加上 零点
hmax = 5;%卫星位置计算最大步长

pv_s6 = state(6,ts_out, hmax, satinfo, 0,0);
pv_s9 = state(9,ts_out, hmax, satinfo, 0,0);

pv_out_s6 = pv_s6(2 : n_out+1,:); % 排除掉 第一个初值分量
pv_out_s9 = pv_s9(2 : n_out+1,:); % 排除掉 第一个初值分量

%飞行器每隔 10s 的 观测值，通过插值求出
ab6_real = interp1(t0_6,ab0_6, t_out,'spline');



% 卫星的位置矢量
ab6_out = zeros(n_out,2);

for j = 1:1:n_out
rs6_out  = pv_out_s6(j,1:3);
rs9_out  = pv_out_s9(j,1:3);

R6_out = Rcal(rs6_out);
R9_out = Rcal(rs9_out);

% 转化后的 观测坐标系 下的 x,y,z
yz_6 = R6_out(2:3,:)*(pv_out(j,1:3) - rs6_out)';
x_6 = R6_out(1,:)*(pv_out(j,1:3) - rs9_out)';

a6_out = yz_6(1)./x_6;
b6_out = yz_6(2)./x_6;

ab6_out(j,:) = [a6_out b6_out ];
end

ab6_error = ab6_out - ab6_real;
 


 