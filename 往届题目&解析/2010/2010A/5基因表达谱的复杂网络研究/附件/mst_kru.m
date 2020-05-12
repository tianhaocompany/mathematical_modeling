%
function [T,d]=mst_kru(B,n)
B=B';
m=size(B,2);
[B,i]=sortrows(B',3);
B=B';
t=1:n;k=0;T=[];c=0;
for i=1:m
    if t(B(1,i))~=t(B(2,i))
        k=k+1;T(k,1:2)=B(1:2,i);c=c+B(3,i);
        d=c+B(3,i)-c;
        tmin=min(t(B(1,i)),t(B(2,i)));
        tmax=max(t(B(1,i)),t(B(2,i)));
        for j=1:n
            if  t(j)==tmax
                t(j)= tmin;
            end
        end
    end
    if k==n-1
        break;
    end
end