function q2_regressF_I3_5F
%使用回归模型分析四个指标之间的数量关系

%第一步：读取原始数据并标准化
indexdata=load('index3_5F_S.txt');
[n,col]=size(indexdata);

%p=21;%解释变量个数
%p=20;
%p=19;
%p=18;
%p=17;
%p=16;
%p=15;
%p=14;
%p=13;
%p=12;
%p=11;
%p=10;
%p=9;
%p=8;
%p=7;
%p=6;
p=5;

fR=p-1;
fRe=n-p;

y=indexdata(:,1);
m1=indexdata(:,2);
m2=indexdata(:,3);
m3=indexdata(:,4);
m4=indexdata(:,5);
m5=indexdata(:,6);

%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
P=[0.00017
0.00012
-0.00054
-0.00003
0.00077
];
%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

%yy=P(1)+P(2)*m1+P(3)*m2+P(4)*m3+P(5)*m4+P(6)*m5+P(7)*m1.^2+P(8)*m2.^2+...
%    P(9)*m3.^2+P(10)*m4.^2+P(11)*m5.^2+P(12)*m1.*m2+P(13)*m1.*m3+...
%    P(14)*m1.*m4+P(15)*m1.*m5+P(16)*m2.*m3+...
%    P(17)*m2.*m4+P(18)*m2.*m5+P(19)*m3.*m4+P(20)*m3.*m5+P(21)*m4.*m5;
yy=P(1)+P(2)*m1+P(3)*m1.*m2+P(4)*m1.*m3+P(5)*m2.*m3;

SSRe=sum((y-yy).^2);
SST=sum((y-mean(y)).^2);
SSR=SST-SSRe;
F=(SSR/fR)/(SSRe/fRe);
FF=[fR,fRe,F,SSRe,SST,SSR]

%第二步：回归的拟合不佳检验，将指标1分为6组，在计算误差平方和以及模型误差平方和


%第三步：模型的选择，即系数相关性检验，引入新变量偏回归平方和SS
XX=[ones(n,1),m1,m1.*m2,m1.*m3,m2.*m3];
XX=inv(XX'*XX);
cjj=diag(XX);
SSj=P.^2./cjj;
FFF=SSj/(SSRe/fRe)
[C,I]=min(FFF);
F1fRe=[1,fRe,C,I]
