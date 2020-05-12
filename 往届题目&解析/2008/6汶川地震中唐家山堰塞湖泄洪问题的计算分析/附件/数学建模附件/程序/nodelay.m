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
forcastH=zeros(m,1);
forcastH(1,:)=high(1);
tempQ=zeros(m,1);%当天的蓄量=昨天的蓄量+降水
deltaH=zeros(m,1);%当天的实际高度=反解方程组
tempQ(1,1)=Q(1);
sumof4=0;
alpha=0.9;
for i=2:m
  % tempQ(i)=tempQ(i-1)+alpha*midRain(i-1)*S/100000000*1;
    if i<4
       sumof4=sum(midRain(1:i,1))/5;
   else
        sumof4=sum(midRain(i-3:i))/5;
    end
    tempQ(i)=tempQ(i-1)+alpha*sumof4*S/100000000*1;
    
end

deltaH(1)=realHigh(1);
for i=2:m
   
    deltaH(i)=newton(Q(i),tempQ(i));
    forcastH(i)=710+deltaH(i);
end
end

hold on
plot(1:16,forcastH(:,1),'b*-',1:16,high,'ro')
