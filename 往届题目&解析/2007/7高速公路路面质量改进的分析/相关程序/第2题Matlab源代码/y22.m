%第2题
%混合料类型Sup13
%S0与油石比和VV的回归分析：
%求包含常数项，线性项和交叉乘积项的二次响应曲面：
X1=[5.2 5.2 5.0 5.3 5.2 5.4 5.5 5.3 5.6 5.5 4.7 5.2 4.8 4.9 4.8]';
X2=[4.1 4.0 4.1 4.0 3.9 4.2 4.0 4.1 4 3.96 4.08 3.96 3.98 4.07 4.04]';
X=[X1 X2];
Y=[87.7 85.9 93.4 87.2 88.9 92.7 93.7 94.0 90.5 86.5 83.8 84.7 88.9 87.3 87.1]';
rstool(X,Y,'interaction')