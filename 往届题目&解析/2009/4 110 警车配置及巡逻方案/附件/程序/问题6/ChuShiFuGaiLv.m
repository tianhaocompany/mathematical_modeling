clear;
load 增加6个点的道路信息和W距阵.mat;
load 环路中间点初始点.mat;

InP=[26
    111
    297
    298
    303
    139
    22
    129
    232
    123
    21
    253];

cnum=length(InP);

D=0;
D(cnum,313)=0;
for l=1:cnum
    [S,D0]=minRoute(InP(l,1),313,W2,1);
    D(l,:)=D0;
end
for l=1:313
    D0(1,l)=min(D(:,l));
end

m=0;
for l=1:313
    if D0(1,l)>2500
        m=m+1;
    end
end
jiedianfugailv=(313-m)/313;

m=0;
for l=1:464
    if D0(1,Road2(l,2))<2500||D0(1,Road2(l,3))<2500
        m=m+Road2(l,8);
    end
end
daolufugailv=m/253685;