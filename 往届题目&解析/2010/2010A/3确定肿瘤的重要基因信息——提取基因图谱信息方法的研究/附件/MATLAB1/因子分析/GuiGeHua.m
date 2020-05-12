function [A]=GuiGeHua(x)
[m,n]=size(x);
for i=1:m   %求主因子分别承载各变量的方差
    a(i)=0;
    for j=1:n
        a(i)=a(i)+x(i,j)^2;
    end
end;

for i=1:m %对主因子矩阵正规化（规格化）处理
    for j=1:n
        A(i,j)=x(i,j)/sqrt(a(i));
    end
end;