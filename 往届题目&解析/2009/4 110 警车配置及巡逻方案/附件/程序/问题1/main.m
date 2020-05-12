%p1=[1,0];
%p2=[3,0];
%W2=addtwopoints(W,Road,p1,p2);
%[S,D]=minRoute(308,309,W2,1);
clear;
load 增加6个点的道路信息和W距阵.mat;
%聚类
%聚类中心数目
cnum=13;
%随机选取中心，C的第一行为各中心的点号，第二行为每一类中包含多少个点
C=floor(314*rand(1,cnum));

%juleilist第二行用于存放每个点属于第几类
juleilist=[1:313];
juleilist(2,1)=0;

for n=1:10000
    
%D用于存放每个中心距离图中所有点的距离
D=0;
D(cnum,313)=0;
for l=1:cnum
    [S,D0]=minRoute(C(1,l),313,W2,1);
    D(l,:)=D0;
end

%将每个点分到距离最近的中心那个类中
for l=1:313
    [x,juleilist(2,l)]=min(D(:,l));
end

%统计：C的第二行为每一类中包含多少个点，juleilist2的每一列为该类包含的点列表
C(2,1)=0;
juleilist2=0;
for m=1:cnum
    for l=1:313
        if(juleilist(2,l)==m)
            C(2,m)=C(2,m)+1; 
            juleilist2(C(2,m),m)=juleilist(1,l);
        end
    end    
end

%针对每一类，重新确定其中心,D用于存放该类中，每一个点距离其它307点的距离，
%D1用于存放该类中，每一个点距离类中其它点的距离
%D2用于存放该类中，每一个点距离类中其它点的距离的最大值
%C2用于存放新的中心点号

for m=1:cnum
    D=0;
    D(C(2,m),313)=0;
    D1=0;
    D1(C(2,m),C(2,m))=0;
    D2=0;
   for l=1:C(2,m)       
       [S,D0]=minRoute(juleilist2(l,m),313,W2,1);
       D(l,:)=D0;
   end
   for l=1:C(2,m)
       D1(:,l)=D(:,juleilist2(l,m));
   end
   for l=1:C(2,m)
       D2(l,1)=max(D1(l,:));
   end
   [x,y]=min(D2);
   C2(1,m)=juleilist2(y,m);   
end

if C2==C(1,:)
    break;
else
    C(1,:)=C2;
    C(2,:)=0;
end

end

D=0;
D(cnum,313)=0;
for l=1:cnum
    [S,D0]=minRoute(C2(1,l),313,W2,1);
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