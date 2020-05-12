function d = dist(i,j,a,b,p)

%  a,b is 2 matrixs recording Pig's and Rat's feature, 3-by14
%  i,j is row line of each them
%  p is a 1-by-14 vector that indicates which feature dim is used. e.g. [1 1 1 1 0 0 .....]

num = sum(p(:));
a = a(i,:);
b = b(j,:);

a = a .* p;
b = b .* p;

dif = (a - b).^2;
dif = sum(dif(:));
d = dif.^0.5;
