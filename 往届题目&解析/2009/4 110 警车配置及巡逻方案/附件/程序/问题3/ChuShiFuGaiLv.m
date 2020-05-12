clear;
load 增加6个点的道路信息和W距阵.mat;

InP=[34
    26
    92
    255
    308
    298
    303
    194
    51
    104
    162
    259
116
39
253
24];

cnum=16;

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
    if D0(1,l)>2000
        m=m+1;
    end
end
jiedianfugailv=(313-m)/313;

m=0;
for l=1:464
    if D0(1,Road2(l,2))<2000||D0(1,Road2(l,3))<2000
        m=m+Road2(l,8);
    end
end
daolufugailv=m/253685;