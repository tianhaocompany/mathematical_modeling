%-----------------------------------------------------------
%题名： 2012研究生数学建模竞赛C题—有杆抽油系统的数学建模与诊断
%题号:  问题二—泵功图计算之一级杆某油井的泵功图计算
%参考数据： 附件1  7#井
%作者:  102686020  陈源源，游检卫，王旭阳
%时间： 2012.09.21-2012.09.24 
%Email: jvyou@seu.edu.cn
%----------------------------------------------------------

%%
clear all;
clc;

%%
%-----加载外部数据（边界条件）-------
data1=load('1.txt');
u_1=data1(1,:);   %悬点处位移时间函数；
F_1=data1(2,:)*1e3;   %悬点处荷载时间函数；
% figure(1)
% plot(u_1,F_1,'r*-');grid on;
% xlabel('位移 (m)');ylabel('荷载 (n)');title('一级杆的悬点示功图');
% legend('悬点示功图');
rod_Num=1;

%%
%---------简单参数的初始化------------
data_length=length(u_1);  %K=K1=data_length

E=2.1*1e11;
density=8456;
a_velocity=sqrt(E/density);

radius=(22*(1e-3))/2;
A=pi*radius^2;

n_ba_u=20;
n_x=2;      n_t=data_length;

u=zeros(n_x,n_t);F=zeros(n_x,n_t);
u(1,:)=u_1;  F(1,:)=F_1;
L=792.5;     T=(1/7.6)*60;
delta_t=T/(n_t-1);
omega=2*pi/T;

%%
% %----[1]【a】基于Gibbs模型的阻尼系数c计算---
% S=3.2;
% N=7.6;
% V=S*N/30;
% % gama=exp(0.18-0.39094*V*30);
% gama=0.19746-0.06974*V+0.00075*V^2;
% c=(pi*a_velocity*gama)/(2*L);

% % %----[1]【b】基于摩擦功的阻尼系数c计算---
Mur_fluid=30*1e-3;  %液体动力粘度
L_crank=950*1e-3;   %驱柄杆长度
Dt=70*1e-3;         %油管内径
Dr=22*1e-3;         %抽油杆直径
m_Dia=Dt/Dr;        %直径系数
Hp=793;         %泵深
B1=(m_Dia^2-1)/(2*log(m_Dia))-1;
B2=m_Dia^4-1-(m_Dia^2-1)^2/log(m_Dia);
% % % 方法一
% c=(2*pi*Mur_fluid/(9.8*density*A))*(1/log(m_Dia)+(4*(B1+1)/B2)*...
%     (B1+(2*tan(omega*L_crank/a_velocity))/((omega*L_crank/a_velocity)/...
%     cos((omega*L_crank/a_velocity))+sin((omega*L_crank/a_velocity)))));
% % 方法二
c=(2*pi*Mur_fluid/(density*A))*(1/log(m_Dia)+(4*(B1+1)/B2)*...
    (B1+(2*tan(omega*Hp/a_velocity))/((omega*Hp/a_velocity)/...
    sin((omega*Hp/a_velocity))+cos((omega*Hp/a_velocity)))));
%%
alpha_n=zeros(1,n_ba_u);
belta_n=zeros(1,n_ba_u);
%----alpha_n,belta_n的计算----
for iN=1:n_ba_u+1
    alpha_n(1,iN)=(iN*omega/(a_velocity*sqrt(2)))*sqrt(1+sqrt(1+(c/(iN*omega))^2));
    belta_n(1,iN)=(iN*omega/(a_velocity*sqrt(2)))*sqrt(-1+sqrt(1+(c/(iN*omega))^2)); 
end

%%
%--------[2]系数的计算--------
%--------sigma_n,tao_n,v_n,delta_n的计算--------
sigma_n=zeros(1,n_ba_u+1);
tao_n=zeros(1,n_ba_u);
v_n=zeros(1,n_ba_u+1);
delta_n=zeros(1,n_ba_u);
for iN=1:n_ba_u+1  
    %%
    sigma_n_iNsum=0; v_n_iNsum=0;
    %-----sigma_n,v_n的计算----
    for jP=1:data_length
        sigma_n_iNsum=sigma_n_iNsum+F_1(jP)*cos(2*(iN-1)*pi*jP/data_length);
        v_n_iNsum=v_n_iNsum+u_1(jP)*cos(2*(iN-1)*pi*jP/data_length);
    end
%     sigma_n(1,1)=sigma_n(1,1)/data_length;
    sigma_n(1,iN)=(2/data_length.^2)*sigma_n_iNsum;
    v_n(1,iN)=(2/data_length)*v_n_iNsum;
    
    %%
    if iN<=n_ba_u
       tao_n_iNsum=0; delta_n_iNsum=0;
       %-----tao_n,delta_n的计算----   
       for jP=1:data_length
          tao_n_iNsum=tao_n_iNsum+F_1(jP)*sin(2*(iN)*pi*jP/data_length);
          delta_n_iNsum=delta_n_iNsum+u_1(jP)*sin(2*(iN)*pi*jP/data_length);
       end
       tao_n(1,iN)=(2/data_length)*tao_n_iNsum;
       delta_n(1,iN)=(2/data_length)*delta_n_iNsum;
    end        
end 

%%
%-----[3]Kai_n,Mur_n的计算----
Kai_n=zeros(1,n_ba_u);
Mur_n=zeros(1,n_ba_u);
for iN=1:n_ba_u
    Kai_n(1,iN)=(sigma_n(1,iN+1)*alpha_n(1,iN)+tao_n(1,iN)*belta_n(1,iN))/(E*A*(alpha_n(1,iN)^2+belta_n(1,iN)^2));
    Mur_n(1,iN)=(sigma_n(1,iN+1)*belta_n(1,iN)-tao_n(1,iN)*alpha_n(1,iN))/(E*A*(alpha_n(1,iN)^2+belta_n(1,iN)^2));    
end

%%
%---------[4]核心计算---------------
%%
%-----[4.1]----泵处--On,Pn,On_1,Pn_1的计算------
On=zeros(1,n_ba_u);
Pn=zeros(1,n_ba_u);
On_1=zeros(1,n_ba_u);
Pn_1=zeros(1,n_ba_u);
for iN=1:n_ba_u
    %%
    alpha_n_iN=alpha_n(1,iN);    belta_n_iN=belta_n(1,iN);
	sigma_n_iN=sigma_n(1,iN+1);  tao_n_iN=tao_n(1,iN);      v_n_iN=v_n(1,iN+1);     delta_n_iN=delta_n(1,iN);
	Kai_n_iN=Kai_n(1,iN);        Mur_n_iN=Mur_n(1,iN);
    %%
    On(1,iN)=(Kai_n_iN*cosh(belta_n_iN*L)+delta_n_iN*sinh(belta_n_iN*L))*sin(alpha_n_iN*L)...
                +(Mur_n_iN*sinh(belta_n_iN*L)+v_n_iN*cosh(belta_n_iN*L))*cos(alpha_n_iN*L);
    Pn(1,iN)=(Kai_n_iN*sinh(belta_n_iN*L)+delta_n_iN*cosh(belta_n_iN*L))*cos(alpha_n_iN*L)...
                -(Mur_n_iN*cosh(belta_n_iN*L)+v_n_iN*sinh(belta_n_iN*L))*sin(alpha_n_iN*L);  
    On_1(1,iN)=((delta_n_iN*belta_n_iN-v_n_iN*alpha_n_iN)*cosh(belta_n_iN*L)+tao_n_iN*sinh(belta_n_iN*L)/(E*A))*sin(alpha_n_iN*L)...
            +((v_n_iN*belta_n_iN+delta_n_iN*alpha_n_iN)*sinh(belta_n_iN*L)+sigma_n_iN*cosh(belta_n_iN*L)/(E*A))*cos(alpha_n_iN*L);
    Pn_1(1,iN)=((delta_n_iN*belta_n_iN-v_n_iN*alpha_n_iN)*sinh(belta_n_iN*L)+tao_n_iN*cosh(belta_n_iN*L)/(E*A))*cos(alpha_n_iN*L)...
            -((v_n_iN*belta_n_iN+delta_n_iN*alpha_n_iN)*cosh(belta_n_iN*L)+sigma_n_iN*sinh(belta_n_iN*L)/(E*A))*sin(alpha_n_iN*L);   
end

%%
%-----[4.2]----泵处--u(L,t),F(L,t)的计算------
for nt=1:n_t
    %%
    sum_u=0;    sum_F=0;
    for iN=1:n_ba_u
        sum_u=sum_u+On(1,iN)*cos(iN*omega*(nt-1)*delta_t)+Pn(1,iN)*sin(iN*omega*(nt-1)*delta_t);
        sum_F=sum_F+On_1(1,iN)*cos(iN*omega*(nt-1)*delta_t)+Pn_1(1,iN)*sin(iN*omega*(nt-1)*delta_t);
    end        
     %%
    sum_u_t(nt)=sum_u;
    sum_F_t(nt)=sum_F;
    EA=E*A;
    %--位移时间函数和荷载时间函数的计算----
    %位移时间函数的计算u(x,t)
    u(2,nt)=sigma_n(1,1)*L/(2*E*A)+v_n(1,1)/2+sum_u;
    %荷载时间函数的计算F(x,t)
    F(2,nt)=sigma_n(1,1)/2+E*A*sum_F;
end

%%
%---------示功图的显示------------
figure(2)
plot(u(1,:),F(1,:),'k-');
hold on;

plot(u(2,:),F(2,:),'r-.');
grid on;
xlabel('位移 (m)');ylabel('荷载 (n)');title('一级杆的悬点示功图');
legend('悬点示功图','泵功图');
% hold off
