function resul=hguanlian(x0,x1)
n0=length(x0);
n1=length(x1);
if n0~=n1
    disp('The size of x0 &x1 must be same');
end
x2=zeros(1,n0-1);
x3=zeros(1,n0-1);
kthe=zeros(1,n0-1);
for i=1:n0-1
    x2(i)=x0(i+1)-x0(i);
    x3(i)=x1(i+1)-x1(i);
end
m=n0-1;
for i=1:m
    if x2(i)~=0
        omega=x3(i)/x2(i);
        kthe(i)=omega*(omega*omega+1)/(omega^4+1);
    elseif x2(i)==0&x3(i)~=0
        kthe(i)=0;
    elseif x2(i)==0&x3(i)==0
        kthe(i)=0;
        m=m-1;
    end
end
if n0==1
    kthe1=1;
elseif n0>1
    kthe1=sum(kthe)/m;
end
resul=kthe1;