%第二问的求解
global Gm
Gm = 3.986005e14;

% load satinfo.txt
% load meadata_06_00.txt;
% load meadata_09_00.txt;
% 
% dat_60 = meadata_06_00;
% dat_90 = meadata_09_00;
% 
% save data.mat
% load data.mat

hmax = 5;

option_s = odeset('AbsTol',1e-13,'RelTol',1e-8,'MaxStep',hmax );%'OutputFcn','odephas3', %高
  
step  = 0.2; 
hmax1 = 5;
med_ch = 1;%1：差分
n_ch = 2;

n_itv = 10;%差分的间隔

t1 = 50 : step: 170;%需要插值，求解卫星位置的点
 
dat_org= data_pro(t1);
pos6 = dat_org(:,1:3);
pos9 = dat_org(:,4:6);
ab6 = dat_org(:,7:8);
ab9 = dat_org(:,9:10);

 
n_pos = size(t1,2);
r_in = Rs_cal( n_pos, pos6, pos9,  ab6, ab9 );
 
%% 做出卫星 通过观测值 确定的位置的 曲线图
%分开画图
% figure(1);
% for i = 1 : 3;
%     subplot(2,3,i);
%     plot(t1', rs_in(:,i));
% end
% title('观测位置图');


%% 利用差分 来求解出 加速度 a, 由以上分析，知9星的 数据误差相对较小  % 以下全部是在 基础坐标系内进行计算
% vr(t)：燃料相对于火箭尾部喷口的喷射速度的逆矢量
% m0/mdot(t)：质量变化率  m0： 为积分初始时刻，飞行器的初始质量

% function para = vrm_cal( method, h, t1, rs_in  )  %  %利用  求解的数据，求得 vr 和 mdotm , 包含 分量求得结果 和 模值求解结果
%method =1：差分   2： 滤波 

h2 =  n_itv*step;
method = 1;%1：差分
res1 = vrm_cal( method, n_pos, h2, n_itv, t1, r_in );

para1 = res1.para;
r1 = res1.r;
v1 = res1.v;
a1 = res1.a;
rva1 = [ r1  v1  a1 ]; 
 
method = 2;%2： 滤波 
res2 = vrm_cal( method, n_pos , h2, n_itv, t1, r_in );
para2 = res2.para;
r2  = res2.r;
v2 = res2.v;
a2  = res2.a;
rva2 = [ r2  v2  a2]; 
 
%% 已经求出了, a的表达式，所以可以直接积分,估计轨道  利用初始 位置 和速度 作为 插值的初始解 
% 下面进行积分计算，输出步长 为 10s;
h_ig = 0.2;
t_ig = t1 - t1(1); 
n_ig = size(t_ig,2);
hmax_ig = 2;

x0_gus = [r1(1,:) v1(1,:)];%这里的初值 是 50.3754448072 处的 初值
options1  =  odeset('AbsTol',1e-13,'RelTol',1e-3,'MaxStep',hmax_ig);%'OutputFcn','odephas3',

if med_ch == 1
    mdotm = para1(1,n_ch);
    vr    = para1(2,n_ch);
else if med_ch == 2
        mdotm = para2(1,n_ch);
        vr    = para2(2,n_ch);
    end
end

[t_local_gus,rv_gus] = ode45('myode',t_ig, x0_gus,options1, Gm, vr, mdotm);

%第二问 作图
trv_prt = [ t1(1:50:n_pos)' rv_gus(1:50:n_pos,:)];

%做出估计轨道的位置和速度曲线图
% % 位置示意图
% plot(t_local_gus + t_ig(1) , rv_gus(:,1)/1000);
% % legend('x' );
% grid on;
% xlabel('t/s');
% ylabel('位置 - x /km')
% title('0号飞行器 x-t 示意图');
% 
% figure
% plot(t_local_gus + t_ig(1) , rv_gus(:,2)/1000);
% % legend( 'y' );
% grid on;
% xlabel('t/s');
% ylabel('位置 - y /km')
% title('0号飞行器 y-t 示意图');
% 
% figure
% plot(t_local_gus + t_ig(1) , rv_gus(:,3)/1000);
% % legend( 'z');
% grid on;
% xlabel('t/s');
% ylabel('位置 - z /km')
% title('0号飞行器 z-t 示意图');
% 
% plot(t_local_gus + t_ig(1) , rv_gus(:,1));
% legend('x','y', 'z');
% grid on;
% xlabel('t/s');
% ylabel('位置 /m')
% title('0号飞行器位置、速度示意图');
 
 %% 计算残差 6- alpha, beta
err6 = err_cal( rv_gus, n_pos, pos6, ab6);
err9 = err_cal( rv_gus, n_pos, pos9, ab9);

err = [err6, err9];
err_m = (sum( err.^2, 1)/n_ig).^(0.5);

% % 做出 6和9的残差图
% figure
% for i = 1: 1: 4
%     subplot(2,2,i);
%     plot(t_ig + t1(1), err(:,i));
%     xlabel('t/s');
%     ylabel('残差')
% end
%*****************************************8
% save data3.mat
 
%% 第三问 
% 
% 6号星的系统误差修正***************
nt2 = 20; 
n_start = 1;
ab_gus = [0.9 0.01 0.001 0.001] ;
rv = rv_gus(n_start:nt2:n_pos,:);
pos = pos6(n_start:nt2:n_pos,:);
ab = ab6(n_start:nt2:n_pos,:);
save ab_fun.mat rv  pos  ab ;
tic
[d_ab6 ssq6 cnt6] =  LMFsolve('ab_fun',ab_gus);
 
 
 
 %9号星的系统误差修正 
 pos = pos9(n_start:nt2:n_pos,:);
ab = ab9(n_start:nt2:n_pos,:);
save ab_fun.mat rv  pos ab;
[d_ab9 ssq9 cnt9] =  LMFsolve('ab_fun',ab_gus);
toc
 
%修正6的误差
dc6 = d_ab6(1);
ds6 = d_ab6(2);
da6 = d_ab6(3);
db6 = d_ab6(4);

a6_f = ab6(:,2)*ds6 + ab6(:,1)*dc6 - da6;
b6_f = ab6(:,2)*dc6 - ab6(:,1)*ds6 - db6;

%修正9的误差
dc9 = d_ab9(1);
ds9 = d_ab9(2);
da9 = d_ab9(3);
db9 = d_ab9(4);

a9_f = ab9(:,2)*ds9 + ab9(:,1)*dc9 - da9;
b9_f = ab9(:,2)*dc9 - ab9(:,1)*ds9 - db9;
 
% save data3.mat
% load data3.mat
 %******************************************
 %根据新的 alpha和 beta,重新求解 Rs_in
 rf_in = Rs_cal( n_pos, pos6, pos9,  [a6_f b6_f], [a9_f b9_f] );

nf_itv = 10 ;
h2 =  nf_itv*step;

method = 1;
res1 = vrm_cal( method, n_pos, h2, n_itv, t1, rf_in );

p1 = res1.para;
r1 = res1.r;
v1 = res1.v;
a1 = res1.a;
rva1 = [ r1  v1  a1 ]; 

method = 2;
r2 = vrm_cal( method, n_pos, h2, n_itv, t1, rf_in );

p2 = rs2.para;
r2 = rs2.r;
v2 = rs2.v;
a2 = rs2.a;
rva2 = [ r1  v1  a1 ]; 


%% 下面进行积分计算，输出步长 为 10s;
 
h_ig = 0.2;
t_ig = (50 :  h_ig : 170) - 50; 

n_ig = size(t_ig,2);

x0_gus = [r1(1,:) v1(1,:)]; 

hmax_ig = 2;

options1  =  odeset('AbsTol',1e-16,'RelTol',1e-4,'MaxStep',hmax_ig);%'OutputFcn','odephas3',

if med_ch == 1
    md1 = ps1(1,n_ch);
    vr1    = ps1(2,n_ch);
else if med_ch == 2
        md1 = ps2(1,n_ch);
        vr1    = ps2(2,n_ch);
    end
end

% [t_local_gus,rv_f] = ode45('myode',t_ig, x0_gus,options1, Gm, vr, mdotm);
% rv_gus = rv_f;
% plot(t_local_gus + t_ig(1) , rv_gus(:,4)/1000);
% % legend('x' );
% grid off;
% XLabel('t/s');
% YLabel('速度 - x /km')
% title('0号飞行器 vx-t 示意图');
% set(gcf,'color',[1,1,1]);
% set(gca,'xtick',[0:20:120],'xticklabel',[50:20:170])
% 
% 
% figure
% plot(t_local_gus + t_ig(1) , rv_gus(:,5)/1000);
% % legend( 'y' );
% grid off;
% XLabel('t/s');
% YLabel('速度 - y /km')
% title('0号飞行器 vy-t 示意图');
% set(gcf,'color',[1,1,1]);
% set(gca,'xtick',[0:20:120],'xticklabel',[50:20:170])
% 
% figure
% plot(t_local_gus + t_ig(1) , rv_gus(:,6)/1000);
% % legend( 'z');
% grid off;
% XLabel('t/s');
% YLabel('速度 - z /km')
% title('0号飞行器 vz-t 示意图');
% set(gcf,'color',[1,1,1]);
% set(gca,'xtick',[0:20:120],'xticklabel',[50:20:170])

 %计算残差 6- alpha, beta
 err6_f = err_cal( rv_f, n_pos, pos6, [a6_f b6_f]);
 err9_f = err_cal( rv_f, n_pos, pos9, [a9_f b9_f]);
[num1 num2] = size( err6_f);
%画出残差
figure;

plot(t_ig', [err6_f  err9_f]);


cancha6 = sqrt( (sum(err6_f.^2,1)  )/num1); 
cancha9 = sqrt( (sum(err9_f.^2,1)  )/num1); 

%  save data23-15-1.mat;
 
 


 