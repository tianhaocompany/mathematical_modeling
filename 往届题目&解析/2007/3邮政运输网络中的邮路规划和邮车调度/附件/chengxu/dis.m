function DD=dis(p)
global D
DD=1;
m=max(size(p));
n=max(max(size(D)));
if sum(D(p(1:m-1)+n*(p(2:m)-1)))>180-2.5*(m-2)%150-(n-2)*5/60*30
    DD=0;
end