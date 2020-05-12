%-----------------------------------------------------------
%题名： 2012研究生数学建模竞赛C题—有杆抽油系统的数学建模与诊断
%题号:  问题三—泵功图的应用—进行气体的判断
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
interval_N=200;
delta_S=0:2/interval_N:2;
deltaS=2/interval_N;
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
%-------------[4]泵功图有效面积的计算--------------------
Area=sum(F_S(2,1:ceil(length(F_S(2,:))/2)))*deltaS-sum(F_S(2,ceil(length(F_S(2,:))/2):length(F_S(2,:))))*deltaS;



