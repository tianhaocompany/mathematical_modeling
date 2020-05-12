function [y]=calAssempleX(x) %������Ʒ���ƾ���
[n,p]=size(x);
y=zeros(n,n);
for i=1:n
    for j=1:n
        x1=0;
        x2=0;
        x3=0;
        for k=1:p
           x1=x1+x(i,k)*x(j,k); 
           x2=x2+x(i,k)^2;
           x3=x3+x(j,k)^2;
        end;
        y(i,j)=x1/sqrt(x2*x3);
    end;
end;
return;