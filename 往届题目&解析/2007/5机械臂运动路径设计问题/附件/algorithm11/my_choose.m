function [sita,n]=my_choose(Loc,P,f)
%选择旋转角及旋转角度
jiaodu1=[-2:0.1:-1 1:0.1:2];
jiaodu2=[-1:0.1:-0.1 0.1:0.1:1];
eps=10;
if f>eps
    sita=jiaodu1(ceil(rand*size(jiaodu1,2)));
else
    sita=jiaodu2(ceil(rand*size(jiaodu2,2)));
end
A=[P'-Loc(:,1) Loc(:,2)-Loc(:,1) Loc(:,5)-Loc(:,1)];
f1=det(A);
number=[1/6 1/3 1/2 5/6 1
        1/8 3/8 5/8 3/4 1];
if f1~=0
    n=1;
else
    n=2;
end
rdn=rand;
for i=1:5
    if rdn<number(n,i);
        n=i;
        break
    end
end
