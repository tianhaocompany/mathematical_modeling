%某区域内任意两点最短路径算法
%形成N*N的矩阵
function [D,path]=floyd(A)
n=size(A,1);
D=A;
path=zeros(n,n);
for i=1:n
    for j=1:n
        if D(i,j)~=inf 
            path(i,j)=j;
        end
    end
end
for k=1:n
    for i=1:n
        for j=1:n
            if D(i,k)+D(k,j)<D(i,j)
                D(i,j)=D(i,k)+D(k,j);
                path(i,j)=path(i,k);
            end
        end
    end
end

