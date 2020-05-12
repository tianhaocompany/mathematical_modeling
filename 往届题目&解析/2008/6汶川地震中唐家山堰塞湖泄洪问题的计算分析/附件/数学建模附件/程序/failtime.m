function y=failtime()
%计算失事历时总时间
%V 水库容量
%H 最终缺口高度
V=2.5*10^8;
H=60;
y=0.8*sqrt(V)/H;