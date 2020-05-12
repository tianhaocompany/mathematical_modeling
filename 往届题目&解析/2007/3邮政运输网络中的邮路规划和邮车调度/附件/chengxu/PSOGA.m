%-----------------------------------------------
%------名称：带交叉因子的改进PSO算法
%------功能：求解多维无约束优化问题
%------特点：收敛性强，还可以加入变异算子
%------作者：孙明杰 <dreamsun2001@126.com>
%------单位：中国矿业大学计算数学硕2005
%------日期：2006年8月26日
%-----------------------------------------------

%格式标准化
clear all;
clc;
format long;
%初始化各个因子
c1=1.4962;    %学习因子c1
c2=1.4962;    %学习因子c2
w=0.7298;     %惯性权重w
N=20;         %粒子群规模
D=6;          %搜索空间维数(本程序适合3维及以上，不能求解1,2维)
eps=10^(-6);  %满足条件限制的误差(在不知道最小值时候不用设置)
MaxDT=500;    %粒子群繁殖的代数

%初始化粒子的速度和位置，数据结构用矩阵A表示
for i=1:N
    for j=1:2*D
        A(i,j)=rand;
    end
end
for i=1:N
    for j=2*D+1:3*D
        A(i,j)=A(i,j-2*D);
    end
end
%计算各个粒子的适应度
for i=1:N
    A(i,3*D+1)=fitness(A(i,1:D),D);
end
%对粒子的适应度进行排序
B=sortrows(A,3*D+1);
%排序后适应度低的前面一半粒子直接进入下一代
NextGeneration=zeros(N,3*D+1);
for i=1:N/2
    for j=1:3*D+1
        NextGeneration(i,j)=B(i,j);
    end
end
%后一半粒子进行遗传选择和交叉操作
for i=1:N/2
    for j=1:3*D+1
        Cross(i,j)=B(i+N/2,j);
    end
end
%产生一个随机的交叉位置
for i=1:N/4
    Anumber=randperm(D-1);
    if Anumber(1)~=1
        position=Anumber(1);
    else
        position=Anumber(2);
    end
    %交叉进行
    for j=position:D-1
        temp=Cross(i,j);
        Cross(i,j)=Cross(N/2-i+1,j);
        Cross(N/2-i+1,j)=temp;
    end
end
%交叉结束，进行更新
for i=1:N/2
    Cross(i,3*D+1)=fitness(Cross(i,1:D),D);
    if Cross(i,3*D+1)<B(i+N/2,3*D+1)
        for j=2*D+1:3*D
            Cross(i,j)=Cross(i,j-2*D);
        end
    else
        for j=2*D+1:3*D
            Cross(i,j)=B(i,j);
        end
    end
end
%下面选择最好的粒子N/2个进入下一代
Pool=zeros(N,3*D+1);
for i=1:N/2
    for j=1:3*D+1
        Pool(i,j)=B(i+N/2,j);
    end
end
for i=1+N/2:N
    for j=1:3*D+1
        Pool(i,j)=Cross(i-N/2,j);
    end
end
%POOLX表示排序后的粒子选择池
PoolX=sortrows(Pool,3*D+1);
for i=1+N/2:N
    for j=1:3*D+1
        NextGeneration(i,j)=PoolX(i-N/2,j);
    end
end
Pbest=NextGeneration(i,2*D+1:3*D);
for i=2:N
    if NextGeneration(i,3*D+1)<fitness(Pbest,D)
        Pbest=NextGeneration(i,2*D+1:3*D);
    end
end
%根据粒子群公式进行迭代(Stander PSO Step)
%速度更新
for i=1:N
    for j=D+1:2*D
        A(i,j)=w*NextGeneration(i,j)+c1*rand*(NextGeneration(i,j+D)-NextGeneration(i,j-D))+c2*rand*(Pbest(j-D)-NextGeneration(i,j-D));
    end
end
%位置更新
for i=1:N
    for j=1:D
        A(i,j)=NextGeneration(i,j)+A(i,j+D);
    end
    A(i,3*D+1)=fitness(A(i,1:D),D);
    if A(i,3*D+1)<NextGeneration(i,3*D+1)
        for j=2*D+1:3*D
            A(i,j)=A(i,j-2*D);
        end
    else
        for j=2*D+1:3*D
            A(i,j)=NextGeneration(i,j-2*D);
        end
    end
end
%下面进入主要循环，循环到最大次数得到最优解和最小值
%DDTime=1;
for time=1:MaxDT
    B=sortrows(A,3*D+1);
    NextGeneration=zeros(N,3*D+1);
    for i=1:N/2
        for j=1:3*D+1
            NextGeneration(i,j)=B(i,j);
        end
    end
    %遗传选择交叉
    for i=1:N/2
        for j=1:3*D+1
            Cross(i,j)=B(i+N/2,j);
        end
    end

    for i=1:N/4
        Anumber=randperm(D-1);
        if Anumber(1)~=1
            position=Anumber(1);
        else
            position=Anumber(2);
        end
        
        for j=position:D-1
            temp=Cross(i,j);
            Cross(i,j)=Cross(N/2-i+1,j);
            Cross(N/2-i+1,j)=temp;
        end
    end
    %交叉结束，进行更新
    for i=1:N/2
        Cross(i,3*D+1)=fitness(Cross(i,1:D),D);
        if Cross(i,3*D+1)<B(i+N/2,3*D+1)
            for j=2*D+1:3*D
                Cross(i,j)=Cross(i,j-2*D);
            end
        else
            for j=2*D+1:3*D
                Cross(i,j)=B(i,j);
            end
        end
    end
    %下面选择最好的粒子N/2个进入下一代
    Pool=zeros(N,3*D+1);
    for i=1:N/2
        for j=1:3*D+1
            Pool(i,j)=B(i+N/2,j);
        end
    end
    for i=1+N/2:N
        for j=1:3*D+1
            Pool(i,j)=Cross(i-N/2,j);
        end
    end
    
    PoolX=sortrows(Pool,3*D+1);
    for i=1+N/2:N
        for j=1:3*D+1
            NextGeneration(i,j)=PoolX(i-N/2,j);
        end
    end
    Pbest=NextGeneration(i,2*D+1:3*D);
    for i=2:N
        if NextGeneration(i,3*D+1)<fitness(Pbest,D)
            Pbest=NextGeneration(i,2*D+1:3*D);
        end
    end
    %根据粒子群公式进行迭代
    for i=1:N
        for j=D+1:2*D
            A(i,j)=w*NextGeneration(i,j)+c1*rand*(NextGeneration(i,j+D)-NextGeneration(i,j-D))+c2*rand*(Pbest(j-D)-NextGeneration(i,j-D));
       end
    end
    
    for i=1:N
        for j=1:D
            A(i,j)=NextGeneration(i,j)+A(i,j+D);
        end
        A(i,3*D+1)=fitness(A(i,1:D),D);
        if A(i,3*D+1)<NextGeneration(i,3*D+1)
            for j=2*D+1:3*D
                A(i,j)=A(i,j-2*D);
            end
        else
            for j=2*D+1:3*D
                A(i,j)=NextGeneration(i,j-2*D);
            end
        end
    end
    Pg(time)=fitness(Pbest,D);
    %DDTime=DDTime+1;
    %if fitness(Pbest,D)<eps
        %break;
    %end
end
%算法结束，得到的结果显示如下：
disp('****************************************************')
disp('最后得到的最优位置为：')
X=Pbest'
disp('得到的函数最小值为：')
Minimize=fitness(Pbest,D)
disp('****************************************************')
%绘制进化代数和适应度关系曲线图
xx=linspace(1,MaxDT,MaxDT);
yy=Pg(xx);
plot(xx,yy,'b-')
hold on
grid on
title('带交叉因子的粒子群优化算法进化代数与适应度值关系曲线图')
legend('粒子适应度曲线走势')
%------算法结束---DreamSun GL & HF-------------------------

