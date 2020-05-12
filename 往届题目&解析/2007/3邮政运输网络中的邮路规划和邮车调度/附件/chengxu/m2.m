%function [MinD,BestPath]=MainAneal(CityPosition,pn) 
%此题以中国31省会城市的最短旅行路径为例，给出TSP问题的模拟退火程序
%CityPosition_31=[1304 2312;3639 1315;4177 2244;3712 1399;3488 1535;3326 1556;...
%                 3238 1229;4196 1044;4312  790;4386  570;3007 1970;2562 1756;...
%                 2788 1491;2381 1676;1332  695;3715 1678;3918 2179;4061 2370;...
%                 3780 2212;3676 2578;4029 2838;4263 2931;3429 1908;3507 2376;...
%                 3394 2643;3439 3201;2935 3240;3140 3550;2545 2357;2778 2826;2370 2975];

%T0=clock
clear
global DD %path 为路径，pn为并行方案
load data
load data_you
m=max(size(D));
  temp=zeros(m+2);
  temp(1:m,1:m)=D;
 for i=1:2
   temp(m+i,:)=[D(1,:),ones(1,2)*9999];
   temp(m+i,1)=9999;
   temp(:,m+i)=temp(m+i,:)';
 end
 D=temp;
 temp=0;
[m,pn]=size(D);   %m.pn不能更改
Distance=inf*ones(10000,1);
TracePath=inf*ones(1000,m);
%global path p2 D TracePath  Distance
%[m,n]=size(CityPosition);
%生成初始解空间，这样可以比逐步分配空间运行快一些
%TracePath=zeros(1e3,m);
%Distance=inf*zeros(1,1e3);
%D = sqrt((CityPosition( :,  ones(1,m)) - CityPosition( :,  ones(1,m))').^2 +...
%    (CityPosition( : ,2*ones(1,m)) - CityPosition( :,2*ones(1,m))').^2 );
%将城市的坐标矩阵转换为邻接矩阵（城市间距离矩阵）
path=zeros(pn,m);
for i=1:pn
    path(i,:)=[1,randperm(m-1)+1];%构造一个初始可行解
end
	path(1,:)=[1	10	17	4	3	6	18	13	14	2	16	15	19	5	7	8	12	9	11	 ];
%path(1,:)=[1	6	7	8	9	12	16	19	13	17	10	5	11	18	14	2	3	4	15];
%path(1,:)=[1 6 5 4 3 2 14 18 7 8 9 10 17 19 15 16 11 12 13];
% path(2,:)=[  1    13     7     3    14     2    12    18    16     9    ...
 %    17     6    11    19     5    10     4     8  15 ];
t=zeros(1,pn);    %极小阀值
R=rand(1,pn);     %概率阀值
%p2=zeros(1,m);

iter_max=256;%input('请输入固定温度下最大迭代次数iter_max=' );
m_max=16;%input('请输入固定温度下目标函数值允许的最大连续未改进次数m_nax=' ) ;
%如果考虑到降温初期新解被吸收概率较大，容易陷入局部最优
%而随着降温的进行新解被吸收的概率逐渐减少，又难以跳出局限
%人为的使初期 iter_max,m_max 较小，然后使之随温度降低而逐步增大,可能
%会收到到比较好的效果

tuo=0.9;                %温度下降梯度
T=9999%sum(max(D));          %初始温度
tau=0.1;%input('请输入最低温度tau=' );
N=1;
         
        for i=1:pn
               temp_m=0;j=0;k=0;temp=0;p=0;
                 temp_m=find(path(i,:)>m-2);
                 temp_m=[1 temp_m m+1];p=[path(i,:) 1];
           if all((temp_m(2:4)-temp_m(1:3))>1) & ...
                (dis(p(temp_m(1):temp_m(2))) & dis(p(temp_m(2):temp_m(3))) & ...
                    dis(p(temp_m(3):temp_m(4))))
                 temp=zeros(m,1);
               for j=1:3
                  if(fun(p(temp_m(j)+1:temp_m(j+1)-1)-1))
                     temp(temp_m(j))=sum(DD(p(temp_m(j)+1:temp_m(j+1)-1)-1,1));  
                    for k=1 :(temp_m(j+1)-temp_m(j)-1)
                     temp(temp_m(j)+k)=temp(temp_m(j)+k-1)...
                          -DD(p(temp_m(j)+k)-1,1)+DD(p(temp_m(j)+k)-1,2);
                    end
                  else
                     temp=zeros(m,1);;%sum([D(path(i,1:m-1)+m*(path(i,2:m)-1)) D(path(i,m)+m*(path(i,1)-1))])+99999;
                      break 
                  end
                end
                if abs(sum(temp))>0.00001
                  Len1(i)=[D(path(i,1:m-1)+m*(path(i,2:m)-1)) D(path(i,m)+m*(path(i,1)-1))]*((65-temp)/65*2);
                else
                  Len1(i)=9999;
                end
             else
               Len1(i)=9999;
             end
                  %计算一次行遍所有城市的总路程 
        end
           path2=path;Len2=Len1;
while  T>=tau %&m_num<m_max          
       iter_num=1;%某固定温度下迭代计数器
       m_num=1;%某固定温度下目标函数值连续未改进次数计算器
       %iter_max=100;
       %m_max=10;%ceil(10+0.5*nn-0.3*N);       
       while m_num<m_max & iter_num<iter_max
        %MRRTT(Metropolis, Rosenbluth, Rosenbluth, Teller, Teller)过程:
             %用任意启发式算法在path的领域N(path)中找出新的更优解
          for i=1:pn
             [path2(i,: )]=[1,ChangePath2(path(i,2:m ),m-1)];%更新路线
              temp_m=0;p=0;temp=0;j=0;k=0;
              temp_m=find(path2(i,:)>m-2);
                 temp_m=[1 temp_m m+1];p=[path2(i,:) 1];
             if all((temp_m(2:4)-temp_m(1:3))>1) & ...
                (dis(p(temp_m(1):temp_m(2))) & dis(p(temp_m(2):temp_m(3))) & ...
                     dis(p(temp_m(3):temp_m(4))))
                 temp=zeros(m,1);
               for j=1:3
                  if(fun(p(temp_m(j)+1:temp_m(j+1)-1)-1))
                     temp(temp_m(j))=sum(DD(p(temp_m(j)+1:temp_m(j+1)-1)-1,1));  
                    for k=1 :(temp_m(j+1)-temp_m(j)-1)
                     temp(temp_m(j)+k)=temp(temp_m(j)+k-1)...
                          -DD(p(temp_m(j)+k)-1,1)+DD(p(temp_m(j)+k)-1,2);
                    end
                  else
                     temp=0;;%sum([D(path(i,1:m-1)+m*(path(i,2:m)-1)) D(path(i,m)+m*(path(i,1)-1))])+99999;
                      break 
                  end
               end
                if abs(sum(temp))>0.00001
                  Len2(i)=[D(path2(i,1:m-1)+m*(path2(i,2:m)-1)) D(path2(i,m)+m*(path2(i,1)-1))]*((65-temp)/65*2);
                  %一定要注意
                else
                  Len2(i)=9999;
                end
             else
               Len2(i)=9999;
             end
                  %计算一次行遍所有城市的总路程 
             end
             
            %temp=find((Len2-Len1<t|(exp((Len1-Len2)/T)>R & (Len1-Len2)>t) | (rand(1,m)>0.372))~=0);
             temp=find((Len2-Len1<t|(exp((Len1-Len2)/T)>R ))~=0);
                    %目标值不变时随机变异
            %temp=find((Len2-Len1<t|exp((Len1-Len2)/(T))>R|(Len1-Len2)/(T)<88)~=0);
             if temp
                 path(temp, : )=path2(temp, : );
                 Len1(temp)=Len2(temp);
                 [TempMinD,TempIndex]=min(Len1);
                 TracePath(N,: )=path(TempIndex,: );%记录路径
                 Distance(N,: )=TempMinD;           %记录最小路径值
                 N=N+1;
                 m_num=0;
             else
                 m_num=m_num+1;
             end
             iter_num=iter_num+1;
       end
         min(Distance)
       T=T*tuo
end 
save data_1 TracePath  Distance
clear
%[MinD,Index]=min(Distance)
%BestPath=TracePath(Index,: )
%disp(MinD)
%T1=clock