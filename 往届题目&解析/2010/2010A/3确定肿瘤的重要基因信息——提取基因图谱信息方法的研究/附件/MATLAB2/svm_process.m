function totalError =svm_process(D)
%SVM训练分类器。注意D的行分为两类，列数代表数据的维数
%留一法
%  Author : LIU Chao
%  e-mail : liuchao-will@163.com
%  School of Computer Science and Technology,Southeast
%  University,China,Sept.2010
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[r,c]=size(D);
Y1 = ones(22,1);
Y2 = -ones(40,1);
Y = [Y1;Y2];
totalError=0;
% X1=D(1:15,:);
% X2=D(28:62,:);
% trnX = [X1;X2];
% Y1 = ones(15,1);
% Y2 = -ones(35,1);
% trnY = [Y1;Y2];
for i=1:1:r
    trnX=D;
    trnX(i,:)=[];
    trnY=Y;
    trnY(i,:)=[];
    C=20000;
    ker='rfb';%erfb与之运行结果一样

    [nsv alpha bias] = svc(trnX,trnY,ker,C);%训练
    % svcplot(trnX,trnY,ker,alpha,bias);

    % X3=D(16:22,:);
    % X4=D(23:27,:);
    % tstX = trnX;
    % Y3 = ones(7,1);
    % Y4 = -ones(5,1);
    % tstY = trnY;
    tstX=D(i,:);
    tstY =Y(i,:);
    predictedY = svcoutput(trnX,trnY,tstX,ker,alpha,bias);%测试
    % predictedY = knnclassify(tstX, trnX,trnY);
    % svcplot(tstX,predictedY,ker,alpha,bias);
    err = svcerror(trnX,trnY,tstX,tstY,ker,alpha,bias);
    totalError=totalError+err;
end





