function y=forcastQ(x)
[m,n]=size(x);
for i=1:m
    y(i)=newton(25,x(i));
end