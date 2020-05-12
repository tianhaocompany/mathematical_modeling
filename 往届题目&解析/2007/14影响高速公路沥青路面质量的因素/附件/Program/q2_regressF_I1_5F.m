function q2_regressF_I1_5F
%使用回归模型分析四个指标之间的数量关系

%第一步：读取原始数据并标准化
indexdata=load('index1_5F_S.txt');
[n,col]=size(indexdata);

p=21;%解释变量个数

fR=p-1;
fRe=n-p;

y=indexdata(:,1);
m1=indexdata(:,2);
m2=indexdata(:,3);
m3=indexdata(:,4);
m4=indexdata(:,5);
m5=indexdata(:,6);

P=[-0.01504
-0.00462
-0.31824
0.00798
-0.00158
0.04629
-0.00668
-0.03501
-0.00505
0.00001
0.02593
0.08164
0.00185
-0.00262
-0.00426
-0.05916
0.04572
0.40696
-0.00524
0.00219
-0.00406
];

yy=P(1)+P(2)*m1+P(3)*m2+P(4)*m3+P(5)*m4+P(6)*m5+P(7)*m1.^2+P(8)*m2.^2+...
    P(9)*m3.^2+P(10)*m4.^2+P(11)*m5.^2+P(12)*m1.*m2+P(13)*m1.*m3+...
    P(14)*m1.*m4+P(15)*m1.*m5+P(16)*m2.*m3+...
    P(17)*m2.*m4+P(18)*m2.*m5+P(19)*m3.*m4+P(20)*m3.*m5+P(21)*m4.*m5;

SSRe=sum((y-yy).^2);
SST=sum((y-mean(y)).^2);
SSR=SST-SSRe;
F=(SSR/fR)/(SSRe/fRe);
FF=[fR,fRe,F,SSRe,SST,SSR]

%第二步：回归的拟合不佳检验，将指标1分为6组，在计算误差平方和以及模型误差平方和


%第三步：模型的选择，即系数相关性检验，引入新变量偏回归平方和SS
XX=[ones(n,1),m1,m2,m3,m4,m5,m1.^2,m2.^2,m3.^2,m4.^2,m5.^2,...
    m1.*m2,m1.*m3,m1.*m4,m1.*m5,m2.*m3,m2.*m4,m2.*m5,m3.*m4,m3.*m5,m4.*m5];
XX=inv(XX'*XX);
cjj=diag(XX);
SSj=P.^2./cjj;
FFF=SSj/(SSRe/fRe);
[C,I]=min(FFF);
F1fRe=[1,fRe,C,I]
