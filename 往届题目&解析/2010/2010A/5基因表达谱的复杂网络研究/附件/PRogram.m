
clc,clear all
BB=load('project data2.txt');
[nnn,mmm]=size(BB);
B=sum(BB);
A = zeros(nnn,mmm);
for i=1:mmm
    A(:,i)=nnn*BB(:,i)/B(i);
end
for i=1:1:nnn
    xmean=sum(A(i,1:22))/22;
    ymean=sum(A(i,23:62))/40;
    xvar=var(A(i,1:22));
    yvar=var(A(i,23:62));
    H(i,1)=xmean;
    H(i,2)=ymean;
    H(i,3)=xvar;
    H(i,4)=yvar;
    H(i,5)=0.5*abs(xmean-ymean)/(xvar^0.5+yvar^0.5)+0.5*log((xvar+yvar)/2/xvar^0.5/yvar^0.5);%分类信息指数
    H(i,6)=i;
end

%-----------23到32，选取分类信息指数大于0.2的基因存入DD.txt中，其中DD(:,1)为树中的编号，DD(:,2)为相应的基因编号
pork=1;
for j=1:nnn
    if H(j,5)>0.2
        D(pork,:)=A(j,:);
        DD(pork,:)=[pork,j];%DD(:,1)树中的基因编号，DD(:,2)相应基因编号
        pork=pork+1;
    end
end
save('DD.txt','DD','-ascii');


%--------------------筛选后的相关系数矩阵 R
RNN=abs(corrcoef(D(:,1:22)'));  %正常样本，筛选后的相关系数矩阵，314*314的方阵
RDD=abs(corrcoef(D(:,23:62)'));  %肿瘤样本，筛选后的相关系数矩阵，314*314的方阵
%----------------------------------------
RN = 1 - RNN;%正常样本，筛选后的距离矩阵
RD = 1 - RDD;%肿瘤样本，筛选后的距离矩阵

%------------------最小生成树43到63
W=triu(RN);
[i,j,v]=find(W);
WEI=[i j v];
demensionMat = length(RN);
[TRNN,d]=mst_kru(WEI,demensionMat);

W=triu(RD);
[i,j,v]=find(W);
WEI=[i j v];
demensionMat = length(RD);
[TRDD,d]=mst_kru(WEI,demensionMat);

fp1 =fopen('MST_RN.txt','wt');
fp2 =fopen('MST_RD.txt','wt');
for i=1:1:length(TRNN)
    fprintf(fp1,'%d %d\n',TRNN(i,1),TRNN(i,2));%正常样本的最小生成树
    fprintf(fp2,'%d %d\n',TRDD(i,1),TRDD(i,2));%肿瘤样本的最小生成树
end
fclose(fp1);
fclose(fp2);
%------------------------------
TRN=zeros(length(TRNN));
TRD=zeros(length(TRDD));
for i = 1 : length(TRNN)
    TRN(TRNN(i,1),TRNN(i,2))=1;TRN(TRNN(i,2),TRNN(i,1))=1;%正常样本的最小生成树的邻接矩阵
    TRD(TRDD(i,1),TRDD(i,2))=1;TRD(TRDD(i,2),TRDD(i,1))=1;%肿瘤样本的最小生成树的邻接矩阵
end

%---------------------------寻找阈值方法1-----------------------------------
%------------------------------normal的阈值-------------------------------
indexN = [2 38 39 58 66 68 83 90 114 122 130 155 163 180 198 205 207 213 219 220 222 237 248 256 257 269 270 279 288 290 294 296 297 306];%查阅文献得到的34个致病基因节点在树中的编号

POKE=[];
nap=0;
for i=2:length(indexN)
    for j=1:i-1
        if TRN(indexN(i),indexN(j))==1|TRN(indexN(j),indexN(i))==1
            nap=nap+1;
            POKE(nap,1)=RNN(indexN(i),indexN(j));
        end
    end
end
thresholdNI=min(POKE) %方法一找到的正常样本的阈值

fp = fopen('NetNorI.txt','wt');
linkId = 0;
for i = 1 : length(RNN)-1
    for j = i+1 : length(RNN)
        if RNN(i,j) > thresholdNI
            linkId = linkId+1;
            linksN(linkId,1) = i;
            linksN(linkId,2) = j;
            fprintf(fp,'%d %d\n',i,j);
        end
    end
end
fclose(fp);

POKE=[];
nap=0;
for i=2:length(indexN)
    for j=1:i-1
        if TRD(indexN(i),indexN(j))==1|TRD(indexN(j),indexN(i))==1
            nap=nap+1;
            POKE(nap,1)=RDD(indexN(i),indexN(j));
        end
    end
end
thresholdDI=min(POKE)%方法一找到的肿瘤样本的阈值

fp = fopen('NetDisI.txt','wt');
linkId = 0;
for i = 1 : length(RDD)-1
    for j = i+1 : length(RDD)
        if RDD(i,j) > thresholdDI
            linkId = linkId+1;
            linksD(linkId,1) = i;
            linksD(linkId,2) = j;
            fprintf(fp,'%d %d\n',i,j);
        end
    end
end
fclose(fp);
%--------------------------------------------------------------------------


%---------------------------寻找阈值方法2-----------------------------------
%--------------------------取前50个点到MST上--------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
[HHH,IX] = sort(H(:,5),'descend');
setNum = 50;
NodeId = zeros(setNum,2);
NodeId(:,2) = IX(1:setNum);

for i=1:setNum
    for j=1:length(DD(:,2))
        if IX(i)==DD(j,2)
            NodeId(i,1)=DD(j,1);
        end
    end
end

indexN = NodeId(:,1);

POKE=[];
nap=0;
for i=2:length(indexN)
    for j=1:i-1
        if TRN(indexN(i),indexN(j))==1|TRN(indexN(j),indexN(i))==1
            nap=nap+1;
            POKE(nap,1)=RNN(indexN(i),indexN(j));
        end
    end
end
thresholdNII=min(POKE)%方法二找到的正常样本的阈值
                               %-------------------------生成复杂网络normal-----
fp = fopen('NetNorII.txt','wt');
linkId = 0;
for i = 1 : length(RNN)-1
    for j = i+1 : length(RNN)
        if RNN(i,j) > thresholdNII
            linkId = linkId+1;
            linksN(linkId,1) = i;
            linksN(linkId,2) = j;
            fprintf(fp,'%d %d\n',i,j);
        end
    end
end
fclose(fp);


POKE=[];
nap=0;
for i=2:length(indexN)
    for j=1:i-1
        if TRD(indexN(i),indexN(j))==1|TRD(indexN(j),indexN(i))==1
            nap=nap+1;
            POKE(nap,1)=RDD(indexN(i),indexN(j));
        end
    end
end
thresholdDII=min(POKE) %方法二找到的肿瘤样本的阈值
%-------------------------生成复杂网络diserse-------------------------------
fp = fopen('NetDisII.txt','wt');
linkId = 0;
for i = 1 : length(RDD)-1
    for j = i+1 : length(RDD)
        if RDD(i,j) > thresholdDII
            linkId = linkId+1;
            linksD(linkId,1) = i;
            linksD(linkId,2) = j;
            fprintf(fp,'%d %d\n',i,j);
        end
    end
end
fclose(fp);
%--------------------------------------------------------------------------

X=[];
X=load('NetNorI.txt');
leng=max(max(X));
NetNor1T=zeros(leng,leng);
for i=1:length(X)
    NetNor1T(X(i,1),X(i,2))=1;
    NetNor1T(X(i,2),X(i,1))=1;
end
poke=0;
GNor=(sum(NetNor1T))';%方法一产生的正常样本网络的度序列
% A=zeros(1,max(GNor));
% for i=1:1:length(GNor)
%     A(GNor(i))=A(GNor(i))+1;
% end
% DEGE(:,:)=[1:max(GNor),A/length(GNor)];%度分布

Y=[];
Y=load('NetDisI.txt');
leng=max(max(Y));
NetDis1T=zeros(leng,leng);
for i=1:length(Y)
    NetDis1T(Y(i,1),Y(i,2))=1;
    NetDis1T(Y(i,2),Y(i,1))=1;
end
poke=0;
GDis=(sum(NetDis1T))';%方法一产生的肿瘤样本网络的度序列






















