clear;
AB_speed=load('AB_speed.mat');
AB_speed=AB_speed.AB_speed;
BC_speed=load('BC_speed.mat');
BC_speed=BC_speed.BC_speed;
B_speed=load('B_speed.mat');
B_speed=B_speed.B_speed;
AB_dirt=load('AB_dirt.mat');
AB_dirt=AB_dirt.AB_dirt;
BC_dirt=load('BC_dirt.mat');
BC_dirt=BC_dirt.BC_dirt;
cloud_BB_id=load('cloud_BB_id.mat');
cloud_BB_id=cloud_BB_id.cloud_BB_id;
BC_move=load('BC_move.mat');
BC_move=BC_move.BC_move;
AB_move=load('AB_move.mat');
AB_move=AB_move.AB_move;
P_36=[0.1, 0.2,  0.5,  1,  1.5,  2,  3,   4,  5,   7, 10,  20, 30,  50,  70,...
    100, 150, 200, 250, 300, 350, 400, 450, 500, 550, 600, 650, 700, 750, ...
    800, 850, 900, 925, 950, 975, 1000]; %
temp=0;
% for i=1:18
%     temp(i)=P_36(37-i);
%     temp(37-i)=P_36(i);
% end
% P_36=temp;
% P_36=P_36';

ir1_2100=load('IR1_2100.mat');
BB=ir1_2100.bb;
temp=load('temp3.mat');
%BB=loab('BB.mat');
Temp3=temp.t;
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
% temp3文件起始点的经纬度
% x0=90; y0=180; %% 确认！！！180,90-  -180， -90
X_weidu=[90:-0.28125:0 0-0.28125:-0.28125:-90];%
Y_jindu=[-180:0.28125:0 0+0.28125:0.28125:180-0.28125];

%% computer zone 先把云的id转换成经纬坐标
I=size(cloud_BB_id,1);
for i=1:I
    [j1,w1]=xy2jingwei(cloud_BB_id(i,1),cloud_BB_id(i,2));
    [j2,w2]=xy2jingwei(cloud_BB_id(i,3),cloud_BB_id(i,4));
    Cloud_BB_jw(i,:)=[j1,w1,j2,w2];
end
%% 计算非为风矢的个数
% 非0风矢的定义
Nzero_wind=length(find(B_speed)>0); % 这里只是非0风块！！！
% 纬度26度，经度分别是52，53，54，57，58（度）处的风矢
% 纬度    经度   角度（北顺）  速度（米/秒） 压强（毫巴）
win_j=[52 53 54 57 58];
win_w=[26 26 26 26 26];
% 压强
for i=1:5
    j1=win_j(i);
    w1=win_w(i);
    %% 求压强
    [Jp,Ip]=jingwei2xy(j1,w1);% 把目标的经纬度转换成坐标号
    % huidou
    Jo=floor(Jp);
    Io=floor(Ip);
    a=Ip-Io;b=1-a;c=Jp-Jo;d=1-c;
    val1=BB(Jo,Io);val2=BB(Jo,Io+1);
    val3=BB(Jo+1,Io);val4=BB(Jo+1,Io+1);
    val=b*d*val1+a*d*val2+b*c*val3+a*c*val4;
    % 灰度值导成温度
    num=floor(val);
    K=K_temp(num)-(val-num)*(K_temp(num)-K_temp(num+1));% 由BB 数组中的灰度值导成温度

    [v s]=min(abs(X_weidu-w1));
    xx=s;
    [v s]=min(abs(Y_jindu-j1));
    yy=s;
    % 由温度求出所在层

    all_tem=Temp3(xx,yy,:);
    % 由所在层导出压强
    [v K_c1]=min(abs(all_tem-K));
    if  Temp3(xx,yy,K_c1)<K
        K_c2=K_c1+1;
        if  K_c2<=36
            k1=Temp3(xx,yy,K_c1);
            k2=Temp3(xx,yy,K_c2); % k1<k<k2
            win_par(i)=P_36(K_c1)+(P_36(K_c2)-P_36(K_c1))*(K-k1)/(k1-k2); % 插值
        else
            if K_c2>36
                win_par(i)=P_36(K_c1); %%
            end
        end
    else
        K_c2=K_c1-1;
        if K_c2>1
            k1=Temp3(xx,yy,K_c1);
            k2=Temp3(xx,yy,K_c2); % k2<k<k1
            win_par(i)=P_36(K_c1)+(P_36(K_c1)-P_36(K_c2))*(K-k1)/(k1-k2);% 插值
        else
            win_par(i)=P_36(K_c1);
        end
    end
    % win_par(i,j)=-1;
    %%
    % 角度 与 速度，由云块的值导出来 ！！
    % 步骤： 找到对应云块，得出相应的角度，速度
    k=1; % 所在云的个数
    same_id=[];
    [ii,jj]=jingwei2xy(j1,w1);% 把目标的经纬度转换成坐标号
    ii=round(ii);
    jj=round(jj);
    for j=1:I
        if ii>=cloud_BB_id(j,1) & jj>=cloud_BB_id(j,2)...
                & ii<=cloud_BB_id(j,3) & jj<=cloud_BB_id(j,4)
            same_id(k)=j;
            k=k+1;
        end
    end
    % 得出平均速度 角度
    if length(same_id)>=1
        win_speed(i)=mean(B_speed(same_id));
        win_speed_AB(i,1)=mean(AB_speed(same_id));
        win_speed_BC(i,1)=mean(BC_speed(same_id));
        win_dirt(i)=mean((AB_dirt(same_id)+BC_dirt(same_id))/2);
        win_dirt_AB(i,1)=mean(AB_dirt(same_id));
        win_dirt_BC(i,1)=mean(BC_dirt(same_id));
        % 角度！！
    else
        win_speed(i)=0;
        win_dirt(i)=0;
    end
end
a=[win_w' win_j' win_dirt' win_speed' win_par'];
bb=[win_w' win_j' win_dirt' win_speed' win_par' win_dirt_AB win_dirt_BC win_speed_AB win_speed_BC];

%% 把结果写到 winsh.txt文件里
fid=fopen('winsh.txt','wt');
m=5; n=5;
for i=1:m
    for j=1:n
        if j==n
            fprintf(fid,'%.2f \n',a(i,j));
        else
            fprintf(fid,'%.2f \t',a(i,j));
        end
    end
end
%% 绘图用 数据 输出 D2
B_dirt=(AB_dirt+BC_dirt)/2;
I=size(cloud_BB_id,1);
for i=1:I
    B_ij(i,1)=(cloud_BB_id(i,1)+cloud_BB_id(i,3))/2;
    B_ij(i,2)=(cloud_BB_id(i,2)+cloud_BB_id(i,4))/2;
    %% 求压强
    [j1,w1]=xy2jingwei(B_ij(i,1),B_ij(i,2));% 把目标的坐标号转换成经纬度
    % huidou
    Jp=B_ij(i,1);
    Ip=B_ij(i,2);
    Jo=floor(Jp);
    Io=floor(Ip);
    a=Ip-Io;b=1-a;c=Jp-Jo;d=1-c;
    val1=BB(Jo,Io);val2=BB(Jo,Io+1);
    val3=BB(Jo+1,Io);val4=BB(Jo+1,Io+1);
    val=b*d*val1+a*d*val2+b*c*val3+a*c*val4;
    % 灰度值导成温度
    num=floor(val);
    if num>0
        K=K_temp(num)-(val-num)*(K_temp(num)-K_temp(num+1));% 由BB 数组中的灰度值导成温度
        if K<273+20
            [v s]=min(abs(X_weidu-w1));
            xx=s;
            [v s]=min(abs(Y_jindu-j1));
            yy=s;
            % 由温度求出所在层
            all_tem=Temp3(xx,yy,:);
            % 由所在层导出压强
            [v K_c1]=min(abs(all_tem-K));
            if  Temp3(xx,yy,K_c1)<K
                K_c2=K_c1+1;
                if  K_c2<36
                    k1=Temp3(xx,yy,K_c1);
                    k2=Temp3(xx,yy,K_c2); % k1<k<k2
                    B_par(i)=P_36(K_c2)+(P_36(K_c2)-P_36(K_c1))*(K-k2)/(k2-k1); % 插值
                    % win_par(i)=P_36(K_c1)+(P_36(K_c2)-P_36(K_c1))*(K-k1)/(k1-k2);
                         if B_par(i)<0
                       B_par(i)=0;
                        end
                           if B_par(i)>1000
                       B_par(i)=1000;
                        end
                else
                    if K_c1==36
                        B_par(i)=P_36(K_c1); %%
                    end
                    if  K_c1==1
                        B_par(i)=P_36(K_c1);
                    end
                end
            else
                K_c2=K_c1-1;
                if K_c2>=1 
                    k1=Temp3(xx,yy,K_c1);
                    k2=Temp3(xx,yy,K_c2); % k2<k<k1
                    B_par(i)=P_36(K_c2)+(P_36(K_c1)-P_36(K_c2))*(K-k2)/((k1-k2));% 插值
                    % win_par(i)=P_36(K_c1)+(P_36(K_c1)-P_36(K_c2))*(K-k1)/(k1-k2);% 插值
                        if B_par(i)<0
                       B_par(i)=0;
                        end
                           if B_par(i)>1000
                       B_par(i)=1000;
                        end
                else
                    B_par(i)=P_36(K_c1);
                end
            end
        else
            B_par(i)=0;
        end
    else
        B_par(i)=0;
    end
end
B_date=[B_ij B_speed B_dirt B_par'];
%%
k=1;
I=size(B_date,1);
for i=1:I
    if B_date(i,3)>0
        DD(k,:)=B_date(i,:);
        k=k+1;
    end
end
B_date=DD;
%% 绘制 几个坐标旁边的等压面
win_j=[52 53 54 57 58];
win_w=[26 26 26 26 26];
% 步骤： 找到对应云块，得出相应的角度，速度
k=1; % 所在云的个数
same_id=[];
[ii,jj]=jingwei2xy(j1,w1);% 把目标的经纬度转换成坐标号
ii=round(ii);
jj=round(jj);

for j=1:I
    if ii>=cloud_BB_id(j,1) & jj>=cloud_BB_id(j,2)...
            & ii<=cloud_BB_id(j,3) & jj<=cloud_BB_id(j,4)
        same_id(k)=j;
        k=k+1;
    end
end


save B_date B_date
fclose(fid);


