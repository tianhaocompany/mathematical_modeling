%第2题
%混合料类型Sup13
%车辙与油石比和VFA的回归分析：
%求包含常数项，线性项和平方项的二次响应曲面：
X1=[5.2 5.2 5.0 5.3 5.2 5.4 5.5 5.3 5.6 5.5 4.7 5.2 4.8 4.9 4.8]';
X2=[72.0 72.6 71.7 71.5 73.8 72.4 74.0 72.3 73.91 73.44 71.28 73.97 71.7 72.38 71.19]';
X=[X1 X2];
Y=[1682.0 1134.0 2038.0 1736.0 4809.0 7583.0 3507.0 5624.0 4135 5115 1809 4650 6342 1312 1637]';
rstool(X,Y,'purequadratic')