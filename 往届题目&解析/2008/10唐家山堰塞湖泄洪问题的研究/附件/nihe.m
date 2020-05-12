clc
clear
load r.mat
rr=r;
y=rr(:,1);
x1=rr(:,2);
x2=rr(:,3);
x3=rr(:,4);
x=[ones(8,1),x1,x2,x3];
[b,bint,r,rint,stats]=regress(y,x);
b
sqrt(stats(1))
load rr.mat
for i=1:19
    v(1,i)=b(1)-b(2)*rr(1,i)*0.5+b(3)*rr(2,i)*0.5+b(4)*rr(3,i)*0.5;
    v(2,i)=b(1)-b(2)*rr(1,i)*0.8+b(3)*rr(2,i)*0.8+b(4)*rr(3,i)*0.8;
    v(3,i)=b(1)-b(2)*rr(1,i)+b(3)*rr(2,i)+b(4)*rr(3,i);
    v(4,i)=b(1)-b(2)*rr(1,i)*1.5+b(3)*rr(2,i)*1.5+b(4)*rr(3,i)*1.5;
end

