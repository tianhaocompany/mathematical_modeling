function Q=overtop()
%返回初始的流量
Nr=760;%漫过高程
Nc=753;%坝顶高度
B=300;
lc= 803;
g=9.8;
c=1/3+1.32*(Nr-Nc)/B;
Q= c*lc*sqrt(2*g)*(Nr-Nc)^(3/2);
