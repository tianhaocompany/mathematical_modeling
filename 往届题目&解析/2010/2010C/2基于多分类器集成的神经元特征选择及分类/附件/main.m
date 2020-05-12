clc;
clear;
t=load('t.txt');
No=t(:,1);
Cell=t(:,2);
X=t(:,3);
Y=t(:,4);
Z=t(:,5);
R=t(:,6);
PCell=t(:,7);

[m,n]=size(t);

figure(1);


%tri= delaunay(X,Y)
%trisurf(tri, X, Y, Z)


%clinep( X, Y, Z);
%hold on;

format long;
SomaSurface=4*3.14*(R(1)^2); %胞体表面积
NumberofStems=0;  %茎的数目
NumberofTerminations=0; %叶子节点数目
NumberofBifurcation=0; %末端分枝数
NumberofBranch=0; %分枝数目


for i=1:m
    %% 计算茎的数目
    
    
    if PCell(i)==1
        NumberofStems=NumberofStems+1;% 父亲是胞体
    end
    
    %% 叶子节点数目
    
    isin=0;
    for ib=1:m
        if No(i)==PCell(ib)
            isin=isin+1;
           
        end
    end
    if isin==0
            NumberofTerminations=NumberofTerminations+1;
    end
    

    %% 分叉数
    
    isin=0;
    for ib=1:m
        if No(i)==PCell(ib)
            isin=isin+1;
           
        end
    end
    if isin==2
            NumberofBifurcation=NumberofBifurcation+1;
    end
    
    %%
    

    
    %ds(X(i,1),Y(i,1),Z(i,1),R(i,1));
    if i>1&&i<m
        XX(1)=X(i,1);
        XX(2)=X(PCell(i,1),1);
        YY(1)=Y(i,1);
        YY(2)=Y(PCell(i,1),1);
        ZZ(1)=Z(i,1);
        ZZ(2)=Z(PCell(i,1),1);
        p=plot3(XX,YY,ZZ);  %画线
        set(p,'Color','green','LineWidth',1.5)
        hold on;
    end
    hold on;
end


SomaSurface
NumberofStems
NumberofTerminations
NumberofBifurcation
NumberofBranch=NumberofBifurcation+NumberofTerminations