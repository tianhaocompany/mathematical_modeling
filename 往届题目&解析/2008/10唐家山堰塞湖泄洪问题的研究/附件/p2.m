clc;
for i=1:1:50
    w(i,1)=W*(l1(i,1)/l1(50,1))^(0.5);
    g(i,1)=G*(l1(i,1)/l1(50,1))^(0.5);
end
f=[];
for i=1:1:50
    f(i,1)=h(i,1)-(max(h)-g(i,1));
end

for i=51:1:90
    f(i,1)=h(i,1)-709;
end
for i=1:1:90
    v(i,1)=l1(i,1)/(S*(f(i,1)/max(g))*(f(i,1)/max(g)));
end
