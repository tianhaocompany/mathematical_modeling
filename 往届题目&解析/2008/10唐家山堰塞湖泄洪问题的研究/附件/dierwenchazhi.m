clc
clear
% x2=xlsread('F:\2008\gmcm\2008A\12.xls','B1:B25');
% x1=xlsread('F:\2008\gmcm\2008A\12.xls','I1:I25');
% x4=xlsread('F:\2008\gmcm\2008A\12.xls','E1:E22');
% x3=xlsread('F:\2008\gmcm\2008A\12.xls','M1:M22');
x3=xlsread('F:\2008\gmcm\2008A\12.xls','R1:R24');
x4=xlsread('F:\2008\gmcm\2008A\12.xls','S1:S24');
%a1=size(x1);
a2=size(x3);
% t1=linspace(0,75,75/0.5);
% x21=interp1(x1,x2,t1,'*cubic');
t2=linspace(0,48,48/0.5);
x41=interp1(x4,x3,t2,'*cubic');