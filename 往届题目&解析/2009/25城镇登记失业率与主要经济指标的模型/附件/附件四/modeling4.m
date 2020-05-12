clc,clear;
shuju=xlsread('F:\第二天1\谢小平\第一问\新建文件夹\hao','sheet1');
shuju=shuju(:,2:14);
data=[shuju(:,1),shuju(:,2),shuju(:,5),shuju(:,6),shuju(:,10)];
t=10:-1:1;
data=data';
x=12:-1:11;
[p1,s1]=polyfit(t,data(1,:),3);
[p2,s2]=polyfit(t,data(2,:),3);
[p3,s3]=polyfit(t,data(3,:),3);
[p4,s4]=polyfit(t,data(4,:),3);
[p5,s5]=polyfit(t,data(5,:),3);
y1= 161.*x.^3-239.*x.^2+8217.*x+81941;
y2= 40.*x.^3+269.*x.^2+10398.*x+30188;
y3= 0.0015.*x.^2-0.0087.*x+0.0183;
y4= -0.0129.*x.^3+0.1781.*x.^2+0.1637.*x+98.3933;
y5=75.3.*x.^3-600.6.*x.^2+3631.5.*x+7514.9;
p=shuju(:,5)';
t=shuju(:,13)';
s=3:8;
res=1:6;
%for i=1:6
%net=newff(minmax(p),[s(i),1],{'tansig','purelin'},'traingdx');
%net.trainParam.epochs=6000;
%net.trainParam.goal=0.001;
%net=train(net,p,t);
%y=sim(net,p);
%error=y-t;
%res(i)=norm(error);
%end
net=newff(minmax(p),[8,1],{'tansig','purelin'},'traingdx');
net.trainParam.epochs=6000;
net.trainParam.goal=0.001;
net=train(net,p,t);
y=sim(net,p);
y1=sim(net,y3);
error=y-t;
res=norm(error);

x0=[shuju(:,1),shuju(:,2),shuju(:,5),shuju(:,6),shuju(:,10)];
y0=shuju(:,13);
a=x0\y0;
b=[1.1;1.0;1.0;1.1;1.1];
y=[b(1).*y1;b(2).*y2;b(3).*y3;b(4).*y4;b(5).*y5];
y0=[y1;y2;y3;y4;y5];
sy=abs(a'*y)
sy1=abs(a'*y0)


