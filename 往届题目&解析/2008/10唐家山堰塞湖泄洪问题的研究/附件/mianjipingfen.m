clc
%clear
load s.mat
% load v.mat
 jj=v;
%load shen1.mat
kk=6.96E-05;
h=zeros(4,19);
h(:,1)=723;
q=1;
s(43:60)=s(42);
for j=1:4
    for i=2:19
        a=fix(h(j,i-1));         
        b=round(h(j,i-1)+0.5);
        ss=(s(b-708)+s(a-708))/2;         
        c=jj(j,i)/(kk*ss);
        h(j,i)=h(j,i-1)+c;
    end
end
%     c=(h(i+1)-h(i))/5;a
%     x=h(i):c:h(i+1);
%     for j=1:6
%         a=fix(x(j));
%         b=fix(x(j)+0.5);
%         ss(q,j)=(x(j)-a)*s(b-708)+(1-(x(j)-a))*s(a-708);
%     end
%     ss(q,7)=sum(ss(q,:))/6;
%     q=q+1;
