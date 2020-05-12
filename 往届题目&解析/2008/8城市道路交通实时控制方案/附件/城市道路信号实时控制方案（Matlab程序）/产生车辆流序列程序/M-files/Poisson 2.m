
r=18; %r为单位时间内车辆的平均到达率；
m=1;
n=15;
y13=poissrnd(r,m,n)  % 得m*n阶矩阵
plot(y13)



