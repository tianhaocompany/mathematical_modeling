clc
clear
load w.mat
for i=1:11
    w1(i,1)=w(i,1)-w(i,3);
    w2(i,1)=w(i,2)-w(i,3);
end
for i=1:11
    w1(i,2)=w1(i,1)/w(i,3);
    w2(i,2)=w2(i,1)/w(i,3);
end
mean(w1(:,1))
var(w1(:,1))
mean(w1(:,2))
var(w1(:,2))
mean(w2(:,1))
var(w2(:,1))
mean(w2(:,2))
var(w2(:,2))