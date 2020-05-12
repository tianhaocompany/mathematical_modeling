function correlation
% 关联分析计算方法，四个指标之间关联度分析
data=load('index_4_data.txt');
x0=data(:,1);
x1=data(:,2);
x2=data(:,3);
x3=data(:,4);

%剔除0元素,并且均值化处理
L=x0>0;
x0=x0(L);
x0=x0./mean(x0);
x1=x1(L);
x1=x1./mean(x1);
x2=x2(L);
x2=x2./mean(x2);
x3=x3(L);
x3=x3./mean(x3);

data=[x0,x1,x2,x3];
%第二步：求差序列
delta=[abs(x0-x1),abs(x0-x2),abs(x0-x3)];

%第三步：求两级最大差与最小差
deltamax=max(max(delta));
deltamin=min(min(delta));

%第四步：计算关联系数
yi=(deltamin+0.5*deltamax)./(delta+0.5*deltamax);

%第五步：计算关联度
l=length(yi);
r=sum(yi)./l