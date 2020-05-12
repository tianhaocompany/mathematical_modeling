% 将第3问的所有数据存在变量data里，并保存在que3data.mat中
%
% data是6维数据：第1维：枪的个数。在这里取为6
%                 第2维：从同一把枪射出的第几颗子弹，这里取为2
%                 第3维：一颗子弹的擦痕序号，这里取为4
%                 第4维：标定子弹擦痕位置的（x，y，z）的点数
%                 第5维：取为3，分别代表x、y、z轴
% 使用load命令加载的mat文件是擦痕的测量数据经Matlab的save命令保存的数
% 据文件。
% 
% 例如：T1_1203959_c1.mat 是第三问数据中编号为1203959的枪发射的第一颗
% 子弹(T1)的擦痕C1的数据（c1.dat）。该数据是先通过Matlab的Import功能将
% 其导入到Matlab的工作区内，然后使用save命令保存为T1_1203959_c1.mat文件


clear all
clc

gunNum = 6;
load T1_1203959_c1.mat
[row col] = size(T1_1203959);
data = zeros(gunNum,2,4,row,col);

% gun1
load T1_1203959_c1.mat
data(1,1,1,:,:) = T1_1203959;
load T1_1203959_c2.mat
data(1,1,2,:,:) = T1_1203959;
load T1_1203959_c3.mat
data(1,1,3,:,:) = T1_1203959;
load T1_1203959_c4.mat
data(1,1,4,:,:) = T1_1203959;

load T2_1203959_c1.mat
data(1,2,1,:,:) = T2_1203959;
load T2_1203959_c2.mat
data(1,2,2,:,:) = T2_1203959;
load T2_1203959_c3.mat
data(1,2,3,:,:) = T2_1203959;
load T2_1203959_c4.mat
data(1,2,4,:,:) = T2_1203959;

% gun2
load T1_1504519_c1.mat
data(2,1,1,:,:) = T1_1504519;
load T1_1504519_c2.mat
data(2,1,2,:,:) = T1_1504519;
load T1_1504519_c3.mat
data(2,1,3,:,:) = T1_1504519;
load T1_1504519_c4.mat
data(2,1,4,:,:) = T1_1504519;

load T2_1504519_c1.mat
data(2,2,1,:,:) = T2_1504519;
load T2_1504519_c2.mat
data(2,2,2,:,:) = T2_1504519;
load T2_1504519_c3.mat
data(2,2,3,:,:) = T2_1504519;
load T2_1504519_c4.mat
data(2,2,4,:,:) = T2_1504519;

% gun3
load t1_1811345_c1.mat
data(3,1,1,:,:) = t1_1811345;
load t1_1811345_c2.mat
data(3,1,2,:,:) = t1_1811345;
load t1_1811345_c3.mat
data(3,1,3,:,:) = t1_1811345;
load t1_1811345_c4.mat
data(3,1,4,:,:) = t1_1811345;

load t3_1811345_c1.mat
data(3,2,1,:,:) = t3_1811345;
load t3_1811345_c2.mat
data(3,2,2,:,:) = t3_1811345;
load t3_1811345_c3.mat
data(3,2,3,:,:) = t3_1811345;
load t3_1811345_c4.mat
data(3,2,4,:,:) = t3_1811345;

% gun4
load t1_1812492_c1.mat
data(4,1,1,:,:) = t1_1812492;
load t1_1812492_c2.mat
data(4,1,2,:,:) = t1_1812492;
load t1_1812492_c3.mat
data(4,1,3,:,:) = t1_1812492;
load t1_1812492_c4.mat
data(4,1,4,:,:) = t1_1812492;

load t2_1812492_c1.mat
data(4,2,1,:,:) = t2_1812492;
load t2_1812492_c2.mat
data(4,2,2,:,:) = t2_1812492;
load t2_1812492_c3.mat
data(4,2,3,:,:) = t2_1812492;
load t2_1812492_c4.mat
data(4,2,4,:,:) = t2_1812492;

%gun5
load T1_1923252_c1.mat
data(5,1,1,:,:) = T1_1923252;
load T1_1923252_c2.mat
data(5,1,2,:,:) = T1_1923252;
load T1_1923252_c3.mat
data(5,1,3,:,:) = T1_1923252;
load T1_1923252_c4.mat
data(5,1,4,:,:) = T1_1923252;

load T2_1923252_c1.mat
data(5,2,1,:,:) = T2_1923252;
load T2_1923252_c2.mat
data(5,2,2,:,:) = T2_1923252;
load T2_1923252_c3.mat
data(5,2,3,:,:) = T2_1923252;
load T2_1923252_c4.mat
data(5,2,4,:,:) = T2_1923252;


%gun6
load T1_1928033_c1.mat
data(6,1,1,:,:) = T1_1928033;
load T1_1928033_c2.mat
data(6,1,2,:,:) = T1_1928033;
load T1_1928033_c3.mat
data(6,1,3,:,:) = T1_1928033;
load T1_1928033_c4.mat
data(6,1,4,:,:) = T1_1928033;

load T2_1928033_c1.mat
data(6,2,1,:,:) = T2_1928033;
load T2_1928033_c2.mat
data(6,2,2,:,:) = T2_1928033;
load T2_1928033_c3.mat
data(6,2,3,:,:) = T2_1928033;
load T2_1928033_c4.mat
data(6,2,4,:,:) = T2_1928033;

save que3data.mat data

