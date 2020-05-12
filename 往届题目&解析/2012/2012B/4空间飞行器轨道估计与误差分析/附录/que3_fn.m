% %第二问的求解
% global Gm
% Gm = 3.986005e14;
% % 
% % load satinfo.txt
% % load meadata_06_00.txt;
% % load meadata_09_00.txt;
% % 
% % dat_60 = meadata_06_00;
% % % dat_90 = meadata_09_00;
% % % 
% % % save data.mat
% % load data.mat
% % 
% % hmax = 5;
% % option_s = odeset('AbsTol',1e-13,'RelTol',1e-8,'MaxStep',hmax );%'OutputFcn','odephas3', %高
% % 
% % 继续利用第二题 结果计算
% % % load data3.mat
% % step  = 0.2; 
% % hmax1 = 5;
% % n_itv = 10;%差分的间隔
% % % 
% % t1 = 50 : step: 170;%需要插值，求解卫星位置的点
% % dat_org= data_pro(t1);
% % pos6 = dat_org(:,1:3);
% % pos9 = dat_org(:,4:6);
% % ab6 = dat_org(:,7:8);
% % ab9 = dat_org(:,9:10);
%  
% 
% % 6号星的系统误差修正***************
% nt2 = 1; 
% n_start = 1;
% ab_gus = [0.99 0.01 0.001 0.001] ;
% rv = rv_gus(n_start:nt2:n_pos,:);
% pos = pos6(n_start:nt2:n_pos,:);
% ab = ab6(n_start:nt2:n_pos,:);
% save ab_fun.mat rv  pos  ab ;
% tic
% [d_ab6 ssq6 cnt6] =  LMFsolve('ab_fun',ab_gus);
%  
%  
%  
%  %9号星的系统误差修正 
%  pos = pos9(n_start:nt2:n_pos,:);
% ab = ab9(n_start:nt2:n_pos,:);
% save ab_fun.mat rv  pos ab;
% [d_ab9 ssq9 cnt9] =  LMFsolve('ab_fun',ab_gus);
% toc
%  
% %修正6的误差
% dc6 = d_ab6(1);
% ds6 = d_ab6(2);
% da6 = d_ab6(3);
% db6 = d_ab6(4);
% 
% a6_f = ab6(:,2)*ds6 + ab6(:,1)*dc6 - da6;
% b6_f = ab6(:,2)*dc6 - ab6(:,1)*ds6 - db6;
% 
% %修正9的误差
% dc9 = d_ab9(1);
% ds9 = d_ab9(2);
% da9 = d_ab9(3);
% db9 = d_ab9(4);
% 
% a9_f = ab9(:,2)*ds9 + ab9(:,1)*dc9 - da9;
% b9_f = ab9(:,2)*dc9 - ab9(:,1)*ds9 - db9;
%  
% % save data3.mat
% % load data3.mat
%  %******************************************
%  %根据新的 alpha和 beta,重新求解 Rs_in
%  rf_in = Rs_cal( n_pos, pos6, pos9,  [a6_f b6_f], [a9_f b9_f] );
% 
% nf_itv = n_itv ;
% h2 =  nf_itv*step;
% 
% method = 1;
% re1 = vrm_cal( method, n_pos, h2, n_itv, t1, rf_in );
% 
% p1 = re1.para;
% r1 = re1.r;
% v1 = re1.v;
% a1 = re1.a;
% rva1 = [ r1  v1  a1 ]; 
% 
% method = 2;
% rs2 = vrm_cal( method, n_pos, h2, n_itv, t1, rf_in );
% 
% para2 = rs2.para;
% r2 = rs2.r;
% v2 = rs2.v;
% a2 = rs2.a;
% rva2 = [ r1  v1  a1 ]; 
% 
% 
% %% 下面进行积分计算，输出步长 为 10s;
%  
% h_ig = 0.2;
% t_ig = (50 :  h_ig : 170) - 50; 
% 
% n_ig = size(t_ig,2);

x0_gus = [r1(1,:) v1(1,:)];%这里的初值 是 50.3754448072 处的 初值

hmax_ig = 2;

options1  =  odeset('AbsTol',1e-16,'RelTol',1e-4,'MaxStep',hmax_ig);%'OutputFcn','odephas3',

if med_ch == 1
    mdotm = para1(1,n_ch);
    vr    = para1(2,n_ch);
else if med_ch == 2
        mdotm = para2(1,n_ch);
        vr    = para2(2,n_ch);
    end
end

[t_local_gus,rv_f] = ode45('myode',t_ig, x0_gus,options1, Gm, vr, mdotm);

rv_gus = rv_f;
plot(t_local_gus + t_ig(1) , rv_gus(:,4)/1000);
% legend('x' );
grid off;
XLabel('t/s');
YLabel('速度 - x /km')
title('0号飞行器 vx-t 示意图');
set(gcf,'color',[1,1,1]);
set(gca,'xtick',[0:20:120],'xticklabel',[50:20:170])


figure
plot(t_local_gus + t_ig(1) , rv_gus(:,5)/1000);
% legend( 'y' );
grid off;
XLabel('t/s');
YLabel('速度 - y /km')
title('0号飞行器 vy-t 示意图');
set(gcf,'color',[1,1,1]);
set(gca,'xtick',[0:20:120],'xticklabel',[50:20:170])

figure
plot(t_local_gus + t_ig(1) , rv_gus(:,6)/1000);
% legend( 'z');
grid off;
XLabel('t/s');
YLabel('速度 - z /km')
title('0号飞行器 vz-t 示意图');
set(gcf,'color',[1,1,1]);
set(gca,'xtick',[0:20:120],'xticklabel',[50:20:170])



 %计算残差 6- alpha, beta
 err6_f = err_cal( rv_f, n_pos, pos6, [a6_f b6_f]);
 err9_f = err_cal( rv_f, n_pos, pos9, [a9_f b9_f]);
[num1 num2] = size( err6_f);


cancha6 = sqrt( (sum(err6_f.^2,1)  )/num1); 
cancha9 = sqrt( (sum(err9_f.^2,1)  )/num1); 



