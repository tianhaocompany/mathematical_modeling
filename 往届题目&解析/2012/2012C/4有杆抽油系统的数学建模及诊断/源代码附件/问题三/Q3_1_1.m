%-----------------------------------------------------------
%题名： 2012研究生数学建模竞赛C题—有杆抽油系统的数学建模与诊断
%题号:  问题三—油井参量估计之一有效冲程法
%参考数据： 问题二计算得到的泵功图数据
%作者:  102686020  陈源源，游检卫，王旭阳
%时间： 2012.09.21-2012.09.24 
%Email: jvyou@seu.edu.cn
%----------------------------------------------------------

%%
clear all;
clc;

%%
%-----加载泵功图数据-------
load('U_F_1.mat');
u_1=u(2,:);       %悬点处位移时间函数；
F_1=F(2,:);   %悬点处荷载时间函数；

%%
%-------[1]泵功图归一化处理-------
Rati_s=max(u_1-min(u_1));
Rs=(u_1-min(u_1))/Rati_s;
Rati_f=max(F_1-min(F_1));
Rf=(F_1-min(F_1))/Rati_f;
figure(1)
subplot(1,2,1)
plot(Rf,'r-');grid on;
xlabel('采样点');ylabel('归一化荷载比 Rf');title('原始泵功图的荷载归一化');
subplot(1,2,2)
plot(Rs,'r-');grid on;
xlabel('采样点');ylabel('归一化位移比 Rs');title('原始泵功图的位移归一化');

%%
%-------[2]归一化泵功图的区间转移-------
F_S_Ori(1,1:5)=Rs(140:144);
F_S_Ori(1,6:70)=Rs(1:65);
F_S_Ori(2,1:5)=Rf(140:144);
F_S_Ori(2,6:70)=Rf(1:65);
for iN=71:144
    F_S_Ori(1,iN)=2-Rs(iN-(144-140+1));
    F_S_Ori(2,iN)=Rf(iN-(144-140+1));  
end
figure(2)
% plot(Rs,Rf,'r+-',F_S_Ori(1,:),F_S_Ori(2,:),'g*-');
plot(F_S_Ori(1,:),F_S_Ori(2,:),'r+-');
grid on;
xlabel('扩展区间 S');ylabel('归一化荷载比 F');title('区间转移后的单值曲线 F(S)');
legend('归一化泵功图的区间扩展结果');

%%
%-------[3]等间隔位移取样-------
interval_N=100;
delta_S=0:2/interval_N:2;
F_S=zeros(interval_N);
iM=1;
for iM=1:length(delta_S)
for iN=1:length(F_S_Ori)-1
    if delta_S(iM)>=F_S_Ori(1,iN) && delta_S(iM)<=F_S_Ori(1,iN+1)
        F_S(1,iM)=delta_S(iM);
        F_S(2,iM)=F_S_Ori(2,iN)+((delta_S(iM)-F_S_Ori(1,iN))/(F_S_Ori(1,iN+1)-F_S_Ori(1,iN)))*(F_S_Ori(2,iN+1)-F_S_Ori(2,iN));
        break;
    end 
end
end
figure(3)
% plot(Rs,Rf,'r+-',F_S(1,:),F_S(2,:),'g*-');
plot(F_S(1,:),F_S(2,:),'r+-');
grid on;
xlabel('扩展区间 S');ylabel('归一化荷载比 F');title('均匀采样后的单值曲线 F(S)');
legend('单值曲线 F(S)的均匀采样');

%%
%--------[4]基于五点差值的曲率计算模型-----------
% for iN=3:length(Rf)-2
%     delta_Theta(iN-2)=atan((((Rf(iN)-Rf(iN+2))*(Rs(iN)-Rs(iN-2)))-...
%         ((Rf(iN)-Rf(iN-2))*(Rs(iN)-Rs(iN+2))))/((Rs(iN)-Rs(iN-2))*(Rs(iN)-Rs(iN+2))));  
%     delta_l(iN-2)=sqrt((Rf(iN-2)-Rf(iN-1))^2+(Rs(iN-2)-Rs(iN-1))^2)+...
%         sqrt((Rf(iN-1)-Rf(iN))^2+(Rs(iN-1)-Rs(iN))^2)+...
%         sqrt((Rf(iN)-Rf(iN+1))^2+(Rs(iN)-Rs(iN+1))^2)+...
%         sqrt((Rf(iN+1)-Rf(iN+2))^2+(Rs(iN+1)-Rs(iN+2))^2);
%     K_iN(iN-2)=delta_Theta(iN-2)/delta_l(iN-2);
%     Gra_iN(iN-2)=(Rf(iN+1)-Rf(iN))/(Rs(iN+1)-Rs(iN));
% end
for iN=3:length(F_S(2,:))-2
    delta_Theta(iN-2)=atan((((F_S(2,iN)-F_S(2,iN+2))*(F_S(1,iN)-F_S(1,iN-2)))-...
        ((F_S(2,iN)-F_S(2,iN-2))*(F_S(1,iN)-F_S(1,iN+2))))/...
        (1+(F_S(1,iN)-F_S(1,iN-2))*(F_S(1,iN)-F_S(1,iN+2))));  
    delta_l(iN-2)=sqrt((F_S(2,iN-2)-F_S(2,iN-1))^2+(F_S(1,iN-2)-F_S(1,iN-1))^2)+...
        sqrt((F_S(2,iN-1)-F_S(2,iN))^2+(F_S(1,iN-1)-F_S(1,iN))^2)+...
        sqrt((F_S(2,iN)-F_S(2,iN+1))^2+(F_S(1,iN)-F_S(1,iN+1))^2)+...
        sqrt((F_S(2,iN+1)-F_S(2,iN+2))^2+(F_S(1,iN+1)-F_S(1,iN+2))^2);
    K_iN(iN-2)=delta_Theta(iN-2)/delta_l(iN-2);
    Gra_iN(iN-2)=(F_S(2,iN+1)-F_S(2,iN))/(F_S(1,iN+1)-F_S(1,iN));
end
for iN=1:length(Gra_iN)-1
   Gra_Gra(iN)=(Gra_iN(iN+1)-Gra_iN(iN));
end
for iN=1:length(K_iN)-1
    delta_K(iN)=abs(K_iN(iN+1)-K_iN(iN));
end
for iN=3:length(delta_K)
    if iN<=length(delta_K)-2
       delta_K_m(iN-2)=(delta_K(iN-2)+delta_K(iN-1)+delta_K(iN)+delta_K(iN+1)+delta_K(iN+2))/5;
    end
end
figure(4)
t_1=(1:length(delta_K))*2/interval_N;
subplot(3,1,1);plot(t_1,delta_K/max(abs(delta_K)));
grid on;
xlabel('扩展区间 S');ylabel('曲率变化量 \delta K');legend(['压缩比: ',num2str(Rati_s)]);
t_2=(1:length(delta_K_m))*2/interval_N;
subplot(3,1,2);plot(t_2,delta_K_m/max(abs(delta_K_m)));
grid on;
xlabel('扩展区间 S');ylabel('平均曲率变化量 \delta K');legend(['压缩比: ',num2str(Rati_s)]);
subplot(3,1,3);
plot(F_S(1,:),F_S(2,:),'r-');
grid on;
xlabel('扩展区间 S');ylabel('归一化荷载比 F');title('均匀采样后的单值曲线 F(S)');

