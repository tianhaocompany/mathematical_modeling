clc
clear
load r.mat
load rr.mat
x=r(:,2:4);
x=x';
y=r(:,1);
y=y';
net=newff([0 26.5;0 20.5;0 20.5],[3,1],{'tansig','purelin'},'traingd');
net.trainParam.show=500;
net.trainParam.lr=0.05;
net.trainParam.epochs=5000;
net.trainParam.goal=0.9e-4;
net=train(net,x,y);
a=sim(net,x)
c=[0.5 0.8 1 1.5];
for i=1:4
    cc=rr*c(1,i);
    jj(i,:)=sim(net,cc);
end