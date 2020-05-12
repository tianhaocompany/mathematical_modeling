% 确定弹头的水平位置
clear,clc
close all

% result.mat 是在ZiTaiTiaoZheng.m中输出的数据文件
load result.mat % data, data_result, ANS

data = data_result;


x = data(1:564,1);
z = correctZround(data(:,3));
    
zz = zeros(756,564);
for I = 1:756
    zz(I,:) = z((I-1)*564+1:I*564);
end
    
Mean_Z = mean(zz,1);

% 显示平均后的曲线    
plot(x,Mean_Z,'k','LineWidth',2)
  
% 对平均值进行二项式拟合
P = polyfit(x',Mean_Z,2); %  Z = P(1)*x.^2 + P(2)*x + P(3)    
Z_new = P(1)*x.^2 + P(2)*x + P(3);
% 寻找对称轴的x坐标
ind = find(Z_new == max(Z_new));
% 显示拟合后的曲线和对称轴与拟合曲线的交点
hold on
plot(x(ind),max(Z_new),'ks','LineWidth',2)
plot(x,Z_new,'k:','LineWidth',2)
xlabel('X(mm)')
ylabel('Z(mm)');
    
% 对称轴的X坐标，即弹头的x轴方向定位标记 
Position = x(ind); 

