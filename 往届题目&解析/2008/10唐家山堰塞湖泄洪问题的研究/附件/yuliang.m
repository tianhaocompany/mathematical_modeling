clc
clear
load R.mat
p=R;
pr=minmax(p)
goal=[ones(1,15);zeros(1,15)]
net=newff(pr,[3,2],{'logsig','logsig'});
net.trainParam.show=10;
net.trainParam.lr=0.05;
net.trainParam.goal=1e-10;
net.trainParam.epochs=50000;
net=train(net,p,goal);
y0=sim(net,p)
