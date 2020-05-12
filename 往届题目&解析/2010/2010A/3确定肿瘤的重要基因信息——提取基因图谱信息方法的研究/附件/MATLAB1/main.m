function main
%问题一的主函数，一键执行
%  Author : LIU Chao  
%  e-mail : liuchao-will@163.com
%  School of Computer Science and Technology,Southeast
%  University,China,Sept.2010  
clear all;%清空工作空间所有数据
[M,h]=data_pros;%取出数据和基因ID ,这里数据来源是project_data.xls
M=stdTrans(M);%标准化变换
% err1911=svm_process(Y)
% h_des=RFE_Relief1(M,h)

[M_sorted,h_sorted]=relief(M,h);%对矩阵按FSC进行排序
%实验证明用BFSC准则最好
a=zhucheng(M_sorted);%主成分分析
% 找到61列具有最大FSC的基因
data61 = M_sorted(:,(1:61));%取出这61列数据
% savefile = 'data62X61.mat';
% save(savefile, 'data61');
data61h=h_sorted(1:61);%取出这61列数据的基因ID
% err61=svm_process(data61)

% h_des=RFE_Relief1(data61,data61h);
%其实M_des和data61一样，h_des和data61h一样
% M_des==data61
% strcmp(h_des,data61h)

