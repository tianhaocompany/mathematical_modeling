clc,clear;
shuju=xlsread('F:\第二天1\谢小平\第一问\新建文件夹\第三问','sheet1');
data=[shuju(:,6),shuju(:,4),shuju(:,5),shuju(:,3),shuju(:,2)];
unemploy=shuju(:,7);
x=data\unemploy;
