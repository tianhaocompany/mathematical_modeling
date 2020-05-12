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

Road=0;
Road(cnum,1)=0;

for m=1:cnum
   for l=1:313
    if D(m,l)<2000
        Road(m,1)=Road(m,1)+1;
    end
    end 
end


m=0;
for l=1:cnum
    m=m+Road(l,1);
end
