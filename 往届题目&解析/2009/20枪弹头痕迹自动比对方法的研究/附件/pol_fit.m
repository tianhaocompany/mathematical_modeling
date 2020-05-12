function [cc] = pol_fit(c1)
%趋势项去除,用于消除转动误差的影响
%输出转动趋势消除后的数据
[m,n]=size(c1);
t=(0:m-1)*2.75*10^(-3);
a=mean(c1,2);
cc=polyfit(t.',a,2) ;
% figure(1);
% subplot(211); plot(a);
y1=polyval(cc,t); 
% subplot(212); plot(y1);
yy=zeros(m,n);
for mm=1:n
yy(:,mm)=y1.';
end
cc=c1-yy;
