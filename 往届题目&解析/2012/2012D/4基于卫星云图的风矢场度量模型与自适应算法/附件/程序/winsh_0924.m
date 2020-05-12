clc;
% clear;
tic
% 2012 D题（2）
%% 原始数据区
global K_temp
ir1_2030=load('IR1_2030.mat');
ir1_2100=load('IR1_2100.mat');
ir1_2130=load('IR1_2130.mat');
%temp=load('temp3.mat');
%Temp3=temp.t;

AA=ir1_2030.aa;
BB=ir1_2100.bb;
CC=ir1_2130.cc; % 三个时刻的灰度矩阵
k_temp=load('k_temp.txt');
k_temp=k_temp(1:128,:); % 128*8
% K_temp=reshape(k_temp,1,1024); ***
[II JJ]=size(k_temp);
kk=1;
for i=1:II
    for j=1:JJ
        K_temp(kk)=k_temp(i,j);
        kk=kk+1;
    end
end
%% 基础数据区
% Rse=42164000; % 卫星到地心的距离
% a=6378136.5; % 地球长半轴
% b=6356751.8; % 地球短半轴
% P=140;% 步进角，微弧
% Q=140;% 采样角，微弧
% I0=1145; % 星下标在S-VISSR帧平面上的行数
% J0=1145; % 星下标在S-VISSR帧平面上的列数
% Long0=86.5; % 星下点所在经度，东经为正
% La0=0; % 星下点所在纬度，北纬为正
%% 云块的确定
% 要判断这一区域是不是存在于地表
%T=583; % 温度阈值，273.16k,在K_temp文件中灰度值应大于 582
%f=0.85; % 假设云块大到超过搜索范围的f，则认为是地面 !!!!
M=64; % 搜索范围 64*64
N=32; % 云块大小 16*16
step=32;
% x1=64; % 有效搜索区间
% y1=61;
% x2=2225;
% y2=2229;
% step=N/2;% 每次平移大小,步长
%cloud_sample=ones(N,N);% 云标准矩阵
% 对于数据AA
cloud_AA_id=zeros(1000,4);% 存放云的左上角，右下角坐标
g=1; % 云标号
[x1 y1]=jingwei2xy(46,40);% 计算范围确定
[x2 y2]=jingwei2xy(126,-40);
x1=floor(x1);
y1=floor(y1);
x2=floor(x2)-N+1;
y2=floor(y2)-N+1;
g=1;


% 对于数据BB
cloud_BB_id=zeros(1000,4);% 存放云的左上角，右下角坐标
g=1; % 云标号
for i=x1:step:x2
    for j=y1:step:y2
            cloud_BB_id(g,:)=[i,j,i+N-1,j+N-1]; % 要换成实际的S_vissr 坐标
            g=g+1;
        % 块划分
    end
end

%% 窗口匹配
B_size=size(cloud_BB_id,1);%%
AB_move=zeros(B_size,2);
BC_move=zeros(B_size,2);
for i=1:B_size
    x1=cloud_BB_id(i,1);
    y1=cloud_BB_id(i,2);
    x2=cloud_BB_id(i,3);
    y2=cloud_BB_id(i,4);% 示踪云区间
    % 目标区域
    aa=(M-N)/2+1;% 示踪云相对顶点
    bb=aa;
    xx1=x1-(M-N)/2;
    yy1=y1-(M-N)/2;
    xx2=x2+(M-N)/2;
    yy2=y2+(M-N)/2;
    b_sample=BB(x1:x2,y1:y2);
    t_sum=sum(sum(b_sample));% 示踪云灰度和
    t_ave=t_sum/(N*N);
    % t_ave=mean(b_sample);
    % t_var=var(b_sample(:));%;方差
    % 与均值的偏差之各
    % t_subs=0;
    t_vary=0;
    for u=1:N
        for v=1:N
            % t_subs=t_subs+(b_sample(u,v)-t_ave);
            t_vary=t_vary+(b_sample(u,v)-t_ave)^2;
        end
    end
    %%%%%%% 与 AA进行匹配 %%%%%%%
    % 计算相关系数
    for ii=xx1:(xx2-N+1)
        for jj=yy1:(yy2-N+1)
            a_sample=AA(ii:ii+N-1,jj:jj+N-1);
            %k_ave=mean(a_sample);
            k_sum=sum(sum(a_sample));% 匹配区灰度和
            k_ave=k_sum/(N*N);
            % k_var=var(a_sample(:));%;方差
            % 与均值的偏差之各
            k_subs=0;
            k_vary=0;
            for u=1:N
                for v=1:N
                    k_subs=k_subs+(b_sample(u,v)-t_ave)*(a_sample(u,v)-k_ave);
                    k_vary=k_vary+(a_sample(u,v)-k_ave)^2;
                end
            end
            R(ii-xx1+1,jj-yy1+1)=k_subs/sqrt(k_vary*t_vary); %相关系数
        end
    end
    [maxr,I]=max(R);
    [max_R,kk]=max(maxr);
    jj=I(kk);
    AB_move(i,:)=[aa-jj,bb-kk];%% B - A 的差
    %%%%%% 与 CC 进行匹配  %%%%%
    % 计算相关系数
    for ii=xx1:(xx2-N+1)
        for jj=yy1:(yy2-N+1)
            a_sample=CC(ii:ii+N-1,jj:jj+N-1);
            %k_ave=mean(a_sample);
            k_sum=sum(sum(a_sample));% 匹配区灰度和
            k_ave=k_sum/(N*N);
            % k_var=var(a_sample(:));%;方差
            % 与均值的偏差之各
            k_subs=0;
            k_vary=0;
            for u=1:N
                for v=1:N
                    k_subs=k_subs+(b_sample(u,v)-t_ave)*(a_sample(u,v)-k_ave);
                    k_vary=k_vary+(a_sample(u,v)-k_ave)^2;
                end
            end
            R(ii-xx1+1,jj-yy1+1)=k_subs/sqrt(k_vary*t_vary); %相关系数
        end
    end
    [maxr,I]=max(R);
    [max_R,kk]=max(maxr);
    jj=I(kk);
    BC_move(i,:)=[jj-aa,kk-bb]; % C-B 的差
end
%% 风矢计算
% 风速 风向
[AB_speed,AB_dirt,speed_id]=cloud_speed_AB(cloud_BB_id,AB_move);
[BC_speed,BC_dirt,speed_id]=cloud_speed_BC(cloud_BB_id,BC_move,speed_id);
B_speed=(AB_speed+BC_speed)/2;
% 压强
P_36=[0.1, 0.2,  0.5,  1,  1.5,  2,  3,   4,  5,   7, 10,  20, 30,  50,  70,...
    100, 150, 200, 250, 300, 350, 400, 450, 500, 550, 600, 650, 700, 750, ...
    800, 850, 900, 925, 950, 975, 1000];
% 641*1280*36
% 计算步骤，由灰度——温度，由经纬度与温度——确定所在层，由层得出压强
% par=tem2par_0923(BB);
disp('非0风矢的个数');
speed_id=speed_id>0;
sum_wind=sum(sum(speed_id))
%
save AB_speed AB_speed
save BC_speed BC_speed
save B_speed B_speed
save AB_dirt AB_dirt
save BC_dirt BC_dirt
save cloud_BB_id cloud_BB_id
save BC_move BC_move
save AB_move AB_move
save speed_id speed_id
% save par par
%
toc
