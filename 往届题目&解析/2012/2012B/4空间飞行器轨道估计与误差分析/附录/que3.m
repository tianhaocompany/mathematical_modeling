%第二问的求解
global Gm
Gm = 3.986005e14;

load satinfo.txt
load meadata_06_00.txt;
load meadata_09_00.txt;

dat_60 = meadata_06_00;
dat_90 = meadata_09_00;

save data.mat
load data.mat

hmax = 5;
option_s = odeset('AbsTol',1e-13,'RelTol',1e-8,'MaxStep',hmax );%'OutputFcn','odephas3', %高


step  = 0.2; 
hmax1 = 5;
n_itv = 17;%差分的间隔

t1 = 50 : step: 170;%需要插值，求解卫星位置的点

%% **********  数据处理阶段，对 观测点的时刻进行统一，50:0.2:170， 求出卫星在这些插值点的位置
t0_s = [0 t1];% 求解卫星位置的 时间取值点
%卫星 状态矢量，包括位置 和速度
pv6 = state(6, t0_s, hmax, satinfo, 0,0);
pv9 = state(9, t0_s, hmax, satinfo, 0,0);

%卫星的位置 矢量
n_t = size(t0_s,2);%ode 保留的 t 样点
pos06 = pv6(2:n_t,1:3);% 位置,
pos09 = pv9(2:n_t,1:3);

% 6号卫星的观测值 
t0_6 = dat_60(:,1);% 观察样点
ab0_6 = dat_60(:,2:3);% 原始数据
ab1_6 = interp1(t0_6,ab0_6, t1,'spline','extrap');

%9号卫星的观测值 
t0_9 = dat_90(:,1);
ab0_9 = dat_90(:,2:3);% 原始数据
ab1_9 = interp1(t0_9,ab0_9, t1,'spline','extrap');

% *********************************************************************************************************************

n_pos = size(t1,2);

h3 =  n_itv*step;
% alpha 和beta 进行差分平滑后的 保留的样点
ab6 = ab1_6(1:n_itv:n_pos,:);
ab9 = ab1_9(1:n_itv:n_pos,:);

pos6 = pos06(1:n_itv:n_pos,:);
pos9 = pos09(1:n_itv:n_pos,:);

n_q3 = size(pos6,1);
% 6号星的系统误差修正***************
nx = 2*n_q3 + 8; %未知数的个数，便于生成初值

x_gus = ones(nx,1)*1e6;%[0.8 0.01 0.01 0.01] ;
x_gus(1:8) = [0.95 0.001 0.01 0.01 0.95  0.001 0.01 0.01];

save fun_new.mat  pos6  ab6 pos9  ab9 ;
 tic
[d_ab  ssq  cnt ] =  LMFsolve('fun_new',x_gus);
 
toc
save data3.mat
 %******************************************

% trv_prt = [ t1(1:50:n_pos)' rv_gus(1:50:n_pos,:)];
% options =  odeset('AbsTol',1e-16,'RelTol',1e-6,'MaxStep',hmax);%'OutputFcn','odephas3',
% [t_local,y] = ode45('myode',tspan, x0,options, Gm, 0,0 ));

 


 