%main
clear;
clc;
%data = load('C:\Documents and Settings\SCUT\桌面\data.txt');
a=[
2008-5-25	723	1.269	8	18
2008-5-26	725.3	1.3	10	25
2008-5-27	727.245	1.4823	0	0
2008-5-28	729.19	1.586	1	2
2008-5-29	730.13	1.61	2	5
2008-5-30	732.5	1.7725	0	0
2008-5-31	733.42	1.83	0	0
2008-6-1	734.68	1.9032	0	0
2008-6-2	735.86	2.01	0	1
2008-6-3	736.86	2.0864	0	0
2008-6-4	737.78	2.116	0	0
2008-6-5	738.93	2.19	12	12
2008-6-6	739.96	2.237	10	20
2008-6-7	740.67	2.372	0	2
2008-6-8	742.11	2.42	0	0
2008-6-9	742.58	2.457	0	0
2008-6-10	742.961	2.468525	0	0
2008-6-11	743.94	2.543525	0	0
2008-6-12	744.894	2.618525	0	0

];
%forcast= rQ(data(:,1));%计算预测数据
data = a(:,2:5);
high= data(:,1);
Q = data(:,2);
minRain=data(:,3)*0.001;
maxRain=data(:,4)*0.001;
[m,n]=size(data);
S=3550*10^6;%平方米
midRain=(minRain+maxRain)/2;
%midRain=minRain;
%16 hang
realHigh=high-710;
forcastH=zeros(m,4);
forcastH(1,:)=high(1);
tempQ=zeros(m,4);%当天的蓄量=昨天的蓄量+降水4
deltaH=zeros(m,4);%当天的实际高度=反解方程组
tempQ(1,:)=Q(1);
sumof4=0;
alpha=0.9;
for i=2:m
    %tempQ(i)=Q(i)+midRain(i-1);
    if i<4
        sumof4=sum(midRain(1:i,1))/5;
    else
        sumof4=sum(midRain(i-3:i))/5;
    end
    if i<17
    tempQ(i,1)=tempQ(i-1,1)+alpha*sumof4*S/100000000*0.5;
    tempQ(i,2)=tempQ(i-1,2)+alpha*sumof4*S/100000000*0.8;
    tempQ(i,3)=tempQ(i-1,3)+alpha*sumof4*S/100000000*1;
    tempQ(i,4)=tempQ(i-1,4)+alpha*sumof4*S/100000000*1.5;
else
    tempQ(i,1)=tempQ(i-1,1)+0.075;
    tempQ(i,2)=tempQ(i-1,2)+0.075;
    tempQ(i,3)=tempQ(i-1,3)+0.075;
    tempQ(i,4)=tempQ(i-1,4)+0.075;
end
end

deltaH(1,:)=realHigh(1);
for i=2:m
    for j=1:4
    deltaH(i,j)=newton(Q(i),tempQ(i,j));
    forcastH(i,j)=710+deltaH(i,j);
end
end

hold on
subplot(2,2,1),plot(1:m,forcastH(:,1),'b-',1:m,high,'r*',0:m,752*ones(m+1,1),'k-.'),legend('forcast','source'),title('50%'),ylabel('H(t)')
subplot(2,2,2),plot(1:m,forcastH(:,2),'b-',1:m,high,'r*',0:m,752*ones(m+1,1),'k-.'),legend('forcast','source'),title('80%'),ylabel('H(t)')
subplot(2,2,3),plot(1:m,forcastH(:,3),'b-',1:m,high,'r*',0:m,752*ones(m+1,1),'k-.'),legend('forcast','source'),title('100%'),ylabel('H(t)')
subplot(2,2,4),plot(1:m,forcastH(:,4),'b-',1:m,high,'r*',0:m,752*ones(m+1,1),'k-.'),legend('forcast','source'),title('150%'),ylabel('H(t)')
%plot(0:m,752*ones(m+1,1),'k-.')
%normrnd(1,0.5,100,1)