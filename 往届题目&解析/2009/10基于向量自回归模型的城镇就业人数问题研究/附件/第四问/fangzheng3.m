function  [yuce,jiuye]=fangzheng3()%按月预测就业综合数据
clc;clear;
shu_1=load('D:\ti4.3.txt');%数据共有24期
shu_2=load('D:\ti4.3.data.txt');%数据共有17期，缺少就业总人数的，通过历史数据补齐
r_x=load('D:\r_x4.3.txt');%模型的系数，
[m1,n1]=size(shu_1);[m2,n2]=size(shu_2);
jiuye=zeros(m2,1);%待预测的总就业人数
%%%%%%%%%%%%%%%%%%%%%填表，只有一个指标需要预测
qian=log(shu_1(end,:));
xishu=r_x(:,1);
for i=1:m2
    jiuye(i)=exp(qian*xishu);
    qian=log([jiuye(i),shu_2(i,:)]);
end
jiuye;
%%%%%%%%%%%%%%%%%%根据建立好的模型向后预测13期
yizhi=log([jiuye(end),shu_2(end,:)]);
date=30;
yuce=zeros(date,n1);
for i=1:date %向后预测13期
    for j=1:n1
        yuce(i,j)=exp(yizhi*r_x(:,j));
    end
    yizhi=log(yuce(i,:));
end
format long;
jiuye;
yuce;
jiuye_zongshu=[shu_1(:,1)',jiuye',yuce(:,1)'];
length(jiuye_zongshu) %55个变量
plot(jiuye_zongshu,'-');
%%%%%%%%%%%%%%以下为人造曲线
%%%%%%前48个数据按原规律变化
for i=1:48
    bodong=0;
    while bodong<0.97||bodong>1.03
    bodong=rand+0.5;
    end
    maker1(i)=jiuye_zongshu(i)*bodong;
end
%%%%%%48-53个数据与43-48同态，53以后数据与43以后同态
%maker1,jiuye_zongshu
for i=1:5
    bodong=0;
    while bodong<0.99||bodong>1.01
    bodong=rand+0.5;
    end
    maker1(48+i)=jiuye_zongshu(48-i)*bodong;
end
%%%%
for i=1:15
    bodong=0;
    while bodong<0.99999||bodong>1.00001
    bodong=rand+0.5;
    end
    maker1(53+i)=jiuye_zongshu(43+i)*bodong;
end
hold on
plot(maker1,'-');


    




