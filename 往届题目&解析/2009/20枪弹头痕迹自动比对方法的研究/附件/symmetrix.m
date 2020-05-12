function b=symmetrix(a)
%this function is used for symmetrize the matrix of a and return a value
%fit for pose estimation.
%这个功能函数是使a的矩阵对称并且找到合适的方位估计

[x,y]=size(a);
v=zeros(2*x,y);
flag=0;
for m=1:x
    for n=1:y
        v(m,n)=a(x-flag,n);
        v(m+x,n)=a(m,n);
    end
    flag=flag+1;
end
b=v;