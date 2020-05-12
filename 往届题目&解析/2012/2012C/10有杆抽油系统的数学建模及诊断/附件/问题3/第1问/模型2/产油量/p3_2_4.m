clc
clear all
close all
nw=0.912;%含水率
B0=1.025;%原油体积系数
Bw=1;%水体积系数
yv=1/((1-nw)*B0+nw*Bw);%混合物的体积系数
Spe=3.3734;%有效冲程
Ap=pi*(44^2)/4*10^(-6);%面积
N=4%冲次
nuomix=((1-nw)*0.864+nw*1)
Q=1440*yv*Spe*Ap*N*nuomix
