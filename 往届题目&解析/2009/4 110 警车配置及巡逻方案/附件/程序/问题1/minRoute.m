function[S,D]=minRoute(i,m,W,opt)
%求最短路径的Dijkstra算法M函数
%格式[S,D]=minRoute(i,m,W,opt)
%i为最短路径的起始点，m为图顶点数，Ｗ为图的带权邻接矩阵，不构成的两顶点之间的权用inf表示。Ｓ的每一列从上到下记录了从始点到终点的最短路径所经顶点的序号
%opt=0(默认值)时，S按终点序号从小到大显示结果；opt=1时，S按最短路径值从小到大显示结果
%D是一行向量，对应记录了S各列所示路径的大小

if nargin<4,opt=0;end
dd=[];
tt=[];
ss=[];
ss(1,1)=i;
V=1:m;
V(i)=[];
dd=[0;i];
kk=2;
[mdd,ndd]=size(dd);
while~isempty(V);
    [tmpd,j]=min(W(i,V));
    tmpj=V(j);
    for k=2:ndd
        [tmp1,jj]=min(dd(1,k)+W(dd(2,k),V));
        tmp2=V(jj);
        tt(k-1,:)=[tmp1,tmp2,jj];
    end
    tmp=[tmpd,tmpj,j;tt];
    [tmp3,tmp4]=min(tmp(:,1));
    if tmp3==tmpd
        ss(1:2,kk)=[i;tmp(tmp4,2)];
    else,tmp5=find(ss(:,tmp4)~=0);tmp6=length(tmp5);
        if dd(2,tmp4)==ss(tmp6,tmp4)
            ss(1:tmp6+1,kk)=[ss(tmp5,tmp4);tmp(tmp4,2)];
        end;
    end
    dd=[dd,[tmp3;tmp(tmp4,2)]];
    V(tmp(tmp4,3))=[];
    [mdd,ndd]=size(dd);
    kk=kk+1;
end;

if opt==1
    [tmp,t]=sort(dd(2,:));
    S=ss(:,t);
    D=dd(1,t);
else,S=ss;D=dd(1,:);
end

