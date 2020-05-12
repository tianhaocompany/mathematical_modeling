function err =svm_process(D)
%SVM训练分类器。注意D的行分为两类，列数代表数据的维数
%  Author : LIU Chao  
%  e-mail : liuchao-will@163.com
%  School of Computer Science and Technology,Southeast
%  University,China,Sept.2010  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% D(:,3:end)=[];
X1=D(1:15,:);
X2=D(33:62,:);
trnX = [X1;X2];
Y1 = ones(15,1);
Y2 = -ones(30,1);
trnY = [Y1;Y2];
C=20;
ker='rfb';%erfb与之运行结果一样
[nsv alpha bias] = svc(trnX,trnY,ker,C);%训练
% svcplot(trnX,trnY,ker,alpha,bias);

X3=D(16:22,:);
X4=D(23:32,:);
tstX = [X3;X4];
Y3 = ones(7,1);
Y4 = -ones(10,1);
tstY = [Y3;Y4];
predictedY = svcoutput(trnX,trnY,tstX,ker,alpha,bias);%测试
% predictedY = knnclassify(tstX, trnX,trnY);
% svcplot(tstX,predictedY,ker,alpha,bias);
err = svcerror(trnX,trnY,tstX,tstY,ker,alpha,bias);




