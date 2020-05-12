clc,clear;
shuju=xlsread('D:\My Documents\MATLAB\data','sheet2');
shuju(3:12,4)=diff(shuju(2:12,4));
shuju(14:20,4)=diff(shuju(13:20,4));
x=shuju(:,1:13);
y=shuju(:,14); %分别提出自变量x和因变量y的值
x=zscore(x); %数据标准化
r=cov(x);  %求标准化数据的协方差阵，即求相关系数矩阵
[vec,val,con]=pcacov(r);  %进行主成分分析的相关计算
num=2;  %选择主因子的个数
f1=repmat(sign(sum(vec)),size(vec,1),1);
vec=vec.*f1;     %特征向量正负号转换
f2=repmat(sqrt(val)',size(vec,1),1); 
a=vec.*f2;   %求初等载荷矩阵
am=a(:,1:num);  %提出num个主因子的载荷矩阵
[b,t]=rotatefactors(am,'method', 'varimax') %旋转变换,b为旋转后的载荷阵
bt=[b,a(:,num+1:end)];   %旋转后全部因子的载荷矩阵
contr=sum(bt.^2);       %计算因子贡献
rate=contr(1:num)/sum(contr); %计算因子贡献率
coef=inv(r)*b;         %计算得分函数的系数
weight=rate/sum(rate);  %计算得分的权重
%利用得分系数计算两个指标平均的大小，并进行排序
index=mean(x(:,1:13));
index=[weight(1).*index;weight(2).*index];
score=coef*index;
score=diag(score);
[score,order]=sort(score);
m=1:13;
plot(m,score(order).*10^15,'o');
hold on;
line=linspace(-0.01,-0.01,13);
plot(m,line,'r--');
xlabel('指标次序');
ylabel('指标得分');





