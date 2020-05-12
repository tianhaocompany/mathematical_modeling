% main

load Data;

mi = min(a);
a = a - ones(size(a,1),1) * mi;
ma = max(a);
a = a ./ (ones(size(a,1),1) * ma);
a(:,1:2) =0;

mi = min(b);
b = b - ones(size(b,1),1) * mi;
ma = max(b);
b = b ./ (ones(size(b,1),1) * ma);

% p = genP();
t = zeros(1,14);
for i=1:14
    p(i,:) = t;
    p(i,i) = 1;
end

p(:,1) =1;
p(:,7) =1;
p(:,8) =1;
p(:,5) =1;
p(:,13) =1;
p(:,4) =1;
p(:,12) =1;
p(:,3) =1;
p(:,10) =1;
p(:,6) =1;
p(:,9) =1;
p(:,14) =1;
p(:,11) =1;
for i = 1:size(p,1)
    r(i) = com(a,b,p(i,:))
end