clc
clear
%%%　读取数据　
t=xlsread('c.xls','sheet1','A1:A564');%读取样本数据
c1=xlsread('c1.xls','sheet1','A1:A564');%读取样本数据
c2=xlsread('c2.xls','sheet1','A1:A564');%读取样本数据
c3=xlsread('c3.xls','sheet1','A1:A564');%读取样本数据
c4=xlsread('c4.xls','sheet1','A1:A564');%读取样本数据
t=t';
c1=c1';
c2=c2';
c3=c3';
c4=c4';
y=t;
p=1:564;


error1=c1-y;
error2=c2-y;
error3=c3-y;
error4=c4-y;

res(1)=norm(error1);
res(2)=norm(error2);
res(3)=norm(error3);
res(4)=norm(error4);
res

figure (2);
subplot(2,2,1);
plot(p,y);
hold on;
plot(p,c1,'r','LineWidth',2);
legend('网络输出','C1棱截面')
xlabel('网络输出与C1棱截面对比照');
subplot(2,2,2);
plot(p,y);
hold on;
plot(p,c2,'r','LineWidth',2);
legend('网络输出','C2棱截面')
xlabel('网络输出与C2棱截面对比照');
subplot(2,2,3);
plot(p,y);
hold on;
plot(p,c3,'r','LineWidth',2);
legend('网络输出','C3棱截面')
xlabel('网络输出与C3棱截面对比照');
subplot(2,2,4);
plot(p,y);
hold on;
plot(p,c4,'r','LineWidth',2);
legend('网络输出','C4棱截面')
xlabel('网络输出与C4棱截面对比照');

