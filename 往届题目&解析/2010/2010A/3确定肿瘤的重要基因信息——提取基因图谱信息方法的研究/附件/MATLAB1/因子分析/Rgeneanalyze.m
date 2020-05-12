%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  R,Q型因子分析程序              %
%  2010-9-18 东南大学  丁涛 %
%主要参考书籍：
% 高惠璇，应用多元统计分析，北京大学出版社,2005
%袁志发，周静芋，多元统计分析，科学出版社,2002
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           载入数据            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 载入数据，使用时注意数据格式
clc;
clear
load('data61.mat');
x=s;
%x=load('Paperdata.txt');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           参数设置            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PCNum=7; %提取因子数目
RorQ=1;   %分析类型：1-R型分析；2-Q型分析
IsRattion=1; %是否进行因子旋转：0-否；1-是
IsSTD=1; %是否进行标准化处理：0-否；1-是
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           参数设置完毕            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[rr,tt]=size(x);
a1=mean(x);
stdr=std(x);
if IsSTD==1
    sr=(x-a1(ones(rr,1),:))./stdr(ones(rr,1),:);%输入矩阵标准化处理
    x=sr;  %求因子得分系数阵公式中x应为标准化变量
else
    sr=x;
end;
if RorQ==1
    r=corrcoef(sr);%相关矩阵
else
    r=calAssempleX(sr);%样品相似矩阵
    tt=rr;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('求特征值和特征向量：');
[v,d]=eig(r);     %求特征值和特征向量
d=d(tt:-1:1,tt:-1:1);%特征值从大到小排序
v=v(:,tt:-1:1);   %特征向量也相应排序
aa=sum(d) %计算列和，实际是提取特征值
a2=100*d/sum(aa);%求因子对方差的贡献率，由此确定主因子数
for i=1:tt %求因子荷最初阵
    for j=1:tt
        a3(j,i)=v(j,i)*sqrt(aa(i));
    end
end;
v
length(find((d>1)==1))
pp=sum(a2);
pv=sum(pp(1:PCNum)); %用于图形中输出
disp(['前',num2str(PCNum),'个主因子累积贡献率: ',num2str(pv,'%0.2f'),'%]']);

a3=a3(:,1:PCNum);  %求主因子
disp('旋转前因子载荷矩阵：');
a3

for i=1:PCNum%求公因子方差贡献，其结果实际等于各主因子对应的方差
    a5(i)=0;
    for j=1:tt
        a5(i)=a5(i)+a3(j,i)^2;
    end
end
disp(['前',num2str(PCNum),'个主因子方差贡献与贡献率(%)']);
[a5',pp(1:PCNum)']

for i=1:tt   %求主因子分别承载各变量的方差
    a(i)=0;
    for j=1:PCNum
        a(i)=a(i)+a3(i,j)^2;
    end
end;
disp(['前',num2str(PCNum),'个主因子分别承载',num2str(tt) ,'个变量的方差（变量共同度）: %']);
a*100

%旋转计算测试
% a3=[  0.64 -0.64;
%     0.68  -0.55;
%     0.65  -0.52;
%     0.65  0.52;
%     0.68  0.55;
%     0.64  0.64;
%     ]
% PCNum=2;
% tt=6;

A=a3;
kkk=0;
if IsRattion==1
    orgA=a3;
    if PCNum==2
        disp('旋转前直角坐标：');
        TA=[1 0;
            0 1]
    end;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %以下进行旋转迭代计算
    v2=1e+10;
    VV=[];
    for kk=1:20%矩阵旋转的最大次数
        c1=0;
        b=0;%求主因子矩阵的方差
        [a3]=GuiGeHua(orgA);  %每次旋转都要做正规化（规格化）处理
        for j=1:PCNum
            c=0;
            for i=1:tt
                b=b+a3(i,j)^4;
                c=c+a3(i,j)^2;
            end
            c1=c1+c*c;
        end
        v1=b/tt-c1/tt^2;
        if abs(v1-v2)<=1e-6%判断是否需要旋转
            break
        end
        VV=[VV;v1];
        %a3=ration(a3);%矩阵旋转函数
        [a3,RT]=rationNew(orgA,a3);%矩阵旋转函数
        if PCNum==2
            TA=TA*RT;
        end;
        orgA=a3;
        kkk=kkk+1;
        v2=v1;
    end
    if PCNum==2
        disp('旋转后直角坐标：');
        TA
    end;
    disp(['旋转',num2str(kkk),'次']);
    disp('方差最大正交旋转矩阵：');
    a3=orgA
    disp('矩阵总方差变化：')
    VV
    for i=1:PCNum%求公因子方差贡献，其结果实际等于各主因子对应的方差
        a5(i)=0;
        for j=1:tt
            a5(i)=a5(i)+a3(j,i)^2;
        end
    end
    disp(['前',num2str(PCNum),'个主因子方差贡献']);
    a5
end;

if RorQ==2
    hold on;
    for i=1:length(A)
        x=A(i,1);
        if x>=0
            x=x*1.05;
        else
            x=x*0.95;
        end;
        y=A(i,2);
        if y>=0
            y=y*1.05;
        else
            y=y*0.95;
        end;
        text(x,y,int2str(i),'FontSize',10,'FontWeight','bold');
        plot(A(i,1),A(i,2),'^r', 'MarkerFaceColor','r','MarkerSize',6);
    end;
    hold off;
    h=legend('样品',-1);
    set(h,'fontsize',9,'FontWeight','bold');
    h=xlabel(['Q型因子分析平面样品点聚类图 旋转',num2str(kkk),'次，[累积贡献率: ',num2str(pv,'%0.2f'),'%]']);
    set(h,'fontsize',9,'FontWeight','bold');
    break;
end;

disp('因子得分函数：');
y1=a3'*inv(r) %求因子得分系数阵,用此公式，x应为标准化变量
disp(['R－型因子分析：',num2str(rr),'个样品因子得分矩阵：']);
AA=(y1*x')'  %主因子的得分

%%%%%%%%%%%%%%%%%%%%%%%
%  以下绘图程序        %
%%%%%%%%%%%%%%%%%%%%%%%
figure(1);
subplot(2,1,1);
hold on;
plot3(0,0,0);
size(A)
for i=1:length(A)
    x=A(i,1);
    y=A(i,2);
    z=A(i,3);
    plot3(x,y,z);
    text(x,y,z,int2str(i),'FontSize',9,'FontWeight','normal','BackgroundColor','r','color','w','EdgeColor','k');
end;
hold off;
h=legend('变量',-1);
set(h,'fontsize',9,'FontWeight','bold');
h=xlabel(['R型因子分析平面变量点聚类图 旋转',num2str(kkk),'次，[累积贡献率: ',num2str(pv,'%0.2f'),'%]']);
set(h,'fontsize',9,'FontWeight','bold');



A=AA; %第一，二主因子的得分
%A=[A(:,1),-A(:,2)];
minX=min(A(:,1));
maxX=max(A(:,1));
minY=min(A(:,2));
maxY=max(A(:,2));
[X1]=Mod_Scale(minX,minX,maxX,0);
[X2]=Mod_Scale(maxX,minX,maxX,1);
[Y1]=Mod_Scale(minY,minY,maxY,0);
[Y2]=Mod_Scale(maxY,minY,maxY,1);

subplot(2,1,2);

hold on;
plot(0,0)
for i=1:length(A(:,1))
    x=A(i,1);
    y=A(i,3);
    plot(x,y)
    %      text(x,y,int2str(i),'FontSize',9,'FontWeight','bold');
    %      plot(A(i,1),A(i,2),'^b', 'MarkerFaceColor','b','MarkerSize',8);
    text(x,y,int2str(i),'FontSize',9,'FontWeight','normal','BackgroundColor','r','color','w','EdgeColor','k');
end;
hold off;
h=legend('样品',-1);
set(h,'fontsize',9,'FontWeight','bold');
h=xlabel(['R型因子分析平面样品点聚类图 旋转',num2str(kkk),'次，[累积贡献率: ',num2str(pv,'%0.2f'),'%]']);
set(h,'fontsize',9,'FontWeight','bold');
axis([X1, X2, Y1, Y2]);