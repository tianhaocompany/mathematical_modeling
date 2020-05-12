function totalError=svm_linear
%  Author : LIU Chao
%  e-mail : liuchao-will@163.com
%  School of Computer Science and Technology,Southeast
%  University,China,Sept.2010
% load GG%存在变量ans里
% load data61%存在变量s里
load M05
D=M5;
% D(:,5)=[];
[r,c]=size(D);
Y1 = ones(22,1);
Y2 = -ones(40,1);
Y = [Y1;Y2];
totalError=0;
% D=stdTrans(D);
for i=1:1:r
    trnX=D;
    trnX(i,:)=[];
    trnY=Y;
    trnY(i,:)=[];
    C=20000;
    ker='rbf';%线形分类器
%         clear p1 p2;
    [nsv alpha bias] = svc4(D,trnX,trnY,ker,C);%svc,svc1,svc2. 实验证实，svc和svc1结果相同

    tstX=D(i,:);
    tstY =Y(i,:);
    predictedY = svcoutput(trnX,trnY,tstX,ker,alpha,bias);%显示
    % svcplot(tstX,predictedY,ker,alpha,bias);
    err = svcerror(trnX,trnY,tstX,tstY,ker,alpha,bias)%显示
    % err = sum(predictedY ~= tstY);
    totalError=totalError+err
end



