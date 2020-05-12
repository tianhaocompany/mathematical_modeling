clc,clear;
num=xlsread('F:\第二天1\谢小平\第一问\新建文件夹\hao','sheet1');
num=num(:,2:14);
x=[ones(10,1),num(:,1),num(:,2),num(:,5),num(:,6),num(:,10)];
y=num(:,13);
[b,bint,r,rint,stats]=regress(y,x);
b,bint,stats
