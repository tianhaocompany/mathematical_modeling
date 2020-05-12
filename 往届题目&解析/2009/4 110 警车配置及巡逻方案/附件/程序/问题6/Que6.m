clear;

load 环路中间点初始点.mat;
load 增加6个点的道路信息和W距阵.mat;

bcnnum=length(BigRoadCircleNode);
csnnum=length(CenterSquareRoadNode);
scnnum=length(SmallCircleNode);
rcnnum=length(RightCircleNode);
othernum=length(Other);


%计算大环能覆盖到的结点
D=0;
D(bcnnum,313)=0;

for l=1:bcnnum
   [S,D0]=minRoute(BigRoadCircleNode(l,1),313,W2,1);
   D(l,:)=D0;
end

m=0;
for l=1:313
   D1(1,l)=min(D(:,l)); 
   if D1(1,l)<2500
       m=m+1;
       dahuanfugaijiedian(1,m)=l;
   end
end
dahuanfugaijiedianshu=m;

%计算中间方框能覆盖到的结点
D=0;
D(csnnum,313)=0;

for l=1:csnnum
   [S,D0]=minRoute(CenterSquareRoadNode(l,1),313,W2,1);
   D(l,:)=D0;
end

m=0;
for l=1:313
   D2(1,l)=min(D(:,l)); 
   if D2(1,l)<2500
       m=m+1;
       zhongjianfangkuangfugaijiedian(1,m)=l;
   end
end
zhongjianfangkuangfugaijiedianshu=m;

%计算小环能覆盖到的结点
D=0;
D(scnnum,313)=0;

for l=1:scnnum
   [S,D0]=minRoute(SmallCircleNode(l,1),313,W2,1);
   D(l,:)=D0;
end

m=0;
for l=1:313
   D3(1,l)=min(D(:,l)); 
   if D3(1,l)<2500
       m=m+1;
       xiaohuanfugaijiedian(1,m)=l;
   end
end
xiaohuanfugaijiedianshu=m;

%计算右侧小环能覆盖到的结点
D=0;
D(rcnnum,313)=0;

for l=1:rcnnum
   [S,D0]=minRoute(RightCircleNode(l,1),313,W2,1);
   D(l,:)=D0;
end

m=0;
for l=1:313
   D4(1,l)=min(D(:,l)); 
   if D4(1,l)<2500
       m=m+1;
       youcexiaohuanfugaijiedian(1,m)=l;
   end
end
youcexiaohuanfugaijiedianshu=m;

%计算其它2个中心点能覆盖到的结点
D=0;
D(othernum,313)=0;

for l=1:othernum
   [S,D0]=minRoute(Other(l,1),313,W2,1);
   D(l,:)=D0;
end

m=0;
for l=1:313
   D5(1,l)=min(D(:,l));
   if D5(1,l)<2500
       m=m+1;
       qitafugaijiedian(1,m)=l;
   end
end
qitafugaijiedianshu=m;

%计算所有环路及中心点能覆盖到的结点
D=0;
D=[D1;D2;D3;D4;D5];
m=0;
for l=1:313
   D0(1,l)=min(D(:,l)); 
   if D0(1,l)<2500
       m=m+1;
       quanbufugaijiedian(1,m)=l;
   end
end
quanbufugaijiedianshu=m;
