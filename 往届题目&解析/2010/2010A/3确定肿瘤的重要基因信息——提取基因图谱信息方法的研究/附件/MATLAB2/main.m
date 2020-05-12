function main
%问题二的主函数，一键执行
%  Author : LIU Chao  
%  e-mail : liuchao-will@163.com
%  School of Computer Science and Technology,Southeast
%  University,China,Sept.2010  
clear all;%清空工作空间所有数据
[M,h]=data_pros;%取出数据和基因ID ,这里数据来源是project_data.xls
M_init=M;%原始数据
M=stdTrans(M);%标准化变换
[M_sorted,h_sorted]=relief_new(M,h);%对矩阵按FSC进行排序
a=zhucheng(M_sorted);%主成分分析
% 找到61列具有最大FSC的基因
data61 = M_sorted(:,(1:61));%取出这61列数据
data61h=h_sorted(1:61);%取出这61列数据的基因ID
[h_min,err_min]=RFE_Relief(data61,data61h);%找到决定分类的最小数量的基因组
h_min
err_min