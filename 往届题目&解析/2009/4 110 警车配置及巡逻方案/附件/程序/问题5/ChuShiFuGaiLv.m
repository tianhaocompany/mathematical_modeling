clear;
load 增加6个点的道路信息和W距阵.mat;

%InP=[138
%    303
 %   125
%    208
%    255
%    67
%    20
%    21
%    253
%    298];

InP=[28
    21
    148
    265
    260
    67
    104
    253
    249
    208];

cnum=10;

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