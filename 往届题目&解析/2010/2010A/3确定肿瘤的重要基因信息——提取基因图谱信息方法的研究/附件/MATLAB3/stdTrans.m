function Y=stdTrans(X)
%对矩阵X进行标准化变换。
%这里X行代表样本，列代表基因
%  Author : LIU Chao  
%  e-mail : liuchao-will@163.com
%  School of Computer Science and Technology,Southeast
%  University,China,Sept.2010  
[r,c]=size(X);
average=mean(X);
stdd=std(X);
for j=1:1:c
    for i=1:1:r
        Y(i,j)=(double(X(i,j)-average(j)))/stdd(j);
    end
end


