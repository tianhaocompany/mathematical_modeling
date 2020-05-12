clear;
load 增加6个点的道路信息和W距阵.mat;
load 选择的线路中心点初始点.mat;

Line1Num=length(Line1);
Line2Num=length(Line2);
Line3Num=length(Line3);
Line4Num=length(Line4);
Line5Num=length(Line5);
Line6Num=length(Line6);
Line7Num=length(Line7);
OtherNum=length(Other);


%计算Line1能覆盖到的结点
D=0;
D(Line1Num,313)=0;

for l=1:Line1Num
   [S,D0]=minRoute(Line1(l,1),313,W2,1);
   D(l,:)=D0;
end

m=0;
for l=1:313
   D1(1,l)=min(D(:,l)); 
   if D1(1,l)<2000
       m=m+1;
       Line1fugaijiedian(1,m)=l;
   end
end
Line1fugaijiedianshu=m;


%计算Line2能覆盖到的结点
D=0;
D(Line2Num,313)=0;

for l=1:Line2Num
   [S,D0]=minRoute(Line2(l,1),313,W2,1);
   D(l,:)=D0;
end

m=0;
for l=1:313
   D2(1,l)=min(D(:,l)); 
   if D2(1,l)<2000
       m=m+1;
       Line2fugaijiedian(1,m)=l;
   end
end
Line2fugaijiedianshu=m;

%计算Line3能覆盖到的结点
D=0;
D(Line3Num,313)=0;

for l=1:Line3Num
   [S,D0]=minRoute(Line3(l,1),313,W2,1);
   D(l,:)=D0;
end

m=0;
for l=1:313
   D3(1,l)=min(D(:,l)); 
   if D3(1,l)<2000
       m=m+1;
       Line3fugaijiedian(1,m)=l;
   end
end
Line3fugaijiedianshu=m;

%计算Line4能覆盖到的结点
D=0;
D(Line4Num,313)=0;

for l=1:Line4Num
   [S,D0]=minRoute(Line4(l,1),313,W2,1);
   D(l,:)=D0;
end

m=0;
for l=1:313
   D4(1,l)=min(D(:,l)); 
   if D4(1,l)<2000
       m=m+1;
       Line4fugaijiedian(1,m)=l;
   end
end
Line4fugaijiedianshu=m;

%计算Line5能覆盖到的结点
D=0;
D(Line5Num,313)=0;

for l=1:Line5Num
   [S,D0]=minRoute(Line5(l,1),313,W2,1);
   D(l,:)=D0;
end

m=0;
for l=1:313
   D5(1,l)=min(D(:,l)); 
   if D5(1,l)<2000
       m=m+1;
       Line5fugaijiedian(1,m)=l;
   end
end
Line5fugaijiedianshu=m;

%计算Line6能覆盖到的结点
D=0;
D(Line6Num,313)=0;

for l=1:Line6Num
   [S,D0]=minRoute(Line6(l,1),313,W2,1);
   D(l,:)=D0;
end

m=0;
for l=1:313
   D6(1,l)=min(D(:,l)); 
   if D6(1,l)<2000
       m=m+1;
       Line6fugaijiedian(1,m)=l;
   end
end
Line6fugaijiedianshu=m;

%计算Line7能覆盖到的结点
D=0;
D(Line7Num,313)=0;

for l=1:Line7Num
   [S,D0]=minRoute(Line7(l,1),313,W2,1);
   D(l,:)=D0;
end

m=0;
for l=1:313
   D7(1,l)=min(D(:,l)); 
   if D7(1,l)<2000
       m=m+1;
       Line7fugaijiedian(1,m)=l;
   end
end
Line7fugaijiedianshu=m;

%计算Other能覆盖到的结点
D=0;
D(OtherNum,313)=0;

for l=1:OtherNum
   [S,D0]=minRoute(Other(l,1),313,W2,1);
   D(l,:)=D0;
end

m=0;
for l=1:313
   D8(1,l)=min(D(:,l)); 
   if D8(1,l)<2000
       m=m+1;
       Otherfugaijiedian(1,m)=l;
   end
end
Otherfugaijiedianshu=m;

%计算所有线路及中心点能覆盖到的结点
D=0;
D=[D1;D2;D3;D4;D5;D6;D7;D8];
m=0;
for l=1:313
   D0(1,l)=min(D(:,l)); 
   if D0(1,l)<2000
       m=m+1;
       quanbufugaijiedian(1,m)=l;
   end
end
quanbufugaijiedianshu=m;