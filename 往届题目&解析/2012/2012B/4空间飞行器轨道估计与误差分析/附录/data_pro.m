function data = data_pro(t1)%data = [pos6 pos9 ab1_6 ab1_9];
%% **********  数据处理阶段，对 观测点的时刻进行统一，50:0.2:170， 求出卫星在这些插值点的位置
load data.mat
t0_s = [0 t1];% 求解卫星位置的 时间取值点
%卫星 状态矢量，包括位置 和速度
pv6 = state(6, t0_s, hmax, satinfo, 0,0);
pv9 = state(9, t0_s, hmax, satinfo, 0,0);

%卫星的位置 矢量
n_t = size(t0_s,2);%ode 保留的 t 样点
pos6 = pv6(2:n_t,1:3);% 位置,
pos9 = pv9(2:n_t,1:3);

% 6号卫星的观测值 
t0_6 = dat_60(:,1);% 观察样点
ab0_6 = dat_60(:,2:3);% 原始数据
ab1_6 = interp1(t0_6,ab0_6, t1,'spline','extrap');

%9号卫星的观测值 
t0_9 = dat_90(:,1);
ab0_9 = dat_90(:,2:3);% 原始数据
ab1_9 = interp1(t0_9,ab0_9, t1,'spline','extrap');
data = [pos6 pos9 ab1_6 ab1_9];
end
