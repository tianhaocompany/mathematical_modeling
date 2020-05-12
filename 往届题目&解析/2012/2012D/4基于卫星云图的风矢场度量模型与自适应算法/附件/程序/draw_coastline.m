% 清空变量空间
clear all
clc
subplot(1,2,2)
% 载入海岸线矩阵
load coastline0.txt
for i=1:max(size(coastline0))
    [b_xyz(i,1),b_xyz(i,2)]=jingwei2xyz(coastline0(i,1),coastline0(i,2));
end

plot(b_xyz(:,1),b_xyz(:,2),'b.','MarkerSize',3);

view([90,90])
hold on














