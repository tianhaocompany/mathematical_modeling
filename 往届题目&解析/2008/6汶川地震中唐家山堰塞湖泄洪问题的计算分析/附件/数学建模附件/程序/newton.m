function [x1,n]=newton(x0,q)
x1=x0 - Q(x0,q)/dQ(x0);
n=1;
while(abs(x1-x0)>=1.0e-9)&&(n<=1000000)
    x0 = x1;
    x1 = x0 - Q(x0,q)/dQ(x0);
    n=n+1;
    
end
