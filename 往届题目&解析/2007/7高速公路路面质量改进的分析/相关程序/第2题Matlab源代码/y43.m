%第2题
%混合料类型Sup13
%弯拉应变与油石比和最大理论密度的回归分析：
%求包含常数项，线性项和平方项的二次响应曲面：
X1=[5.2 5.2 5.0 5.3 5.2 5.4 5.5 5.3 5.6 5.5 4.7 5.2 4.8 4.9 4.8]';
X2=[2.588 2.576 2.496 2.530 2.568 2.533 2.553 2.612 2.651 2.568 2.598 2.56 2.514 2.484 2.476]';
X=[X1 X2];
Y=[3026.0 3223.0 2824.6 2963.5 3213.8 2990.1 3040.9 3180.8 3056.5 2963 2730 2881.7 2661.6 2737.4 2721.9]';
rstool(X,Y,'purequadratic')