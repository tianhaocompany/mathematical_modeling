%clear
global  n distance
 % load D:\chengxu\m2\D2 D2
   distance=D2;  
for n=4:6
 if n>0
    cities = max(size(distance));
    temp=zeros(cities+n);
    temp(1:cities,1:cities)=distance;
  for i=1:n
     temp(cities+i,:)=[distance(1,:),ones(1,n)*9999];
     temp(cities+i,1)=9999;
     temp(:,cities+i)=temp(cities+i,:)';
  end
    distance=temp;
 end
   [m,pn]=size(distance);
   Distance=inf*ones(10000,1);
   TracePath=inf*ones(10000,m);
   path=zeros(pn,m);
 for i=1:pn
     path(i,:)=[1,randperm(m-1)+1];%构造一个初始可行解
 end
  %path(1,:)=[1	6	18	19	7	10	23	11	9	8 20	12	14	13	...
  %    24	16	17	21	15	25	4	3	22	2	5	1];
  %    24	16	17	21	15	25	4	3	22	2	5];

  %  path(1,:)=[1	6	18	5	23	11	12	13	14	15	21	17	16	24 ...
  %       3	2	22	4	25	10	8	19	20	9	7];%n=4时引导数值
  %load path  %n=4时
% path=path(1:pn,:);  %引导
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
   T=9999;%(1/0.9)^150;%sum(max(D));          %初始温度
   tau=0.1;%input('请输入最低温度tau=' );
   N=1;
   Len1=zeros(1,pn);
      for i=1:pn
         %Len1(i)= sum([distance(path(i,1:m-1)+m*(path(i,2:m)-1)) distance(path(i,m)+m*(path(i,1)-1))]);
         Len1(i)=D2_fitness_2(path(i,: ));                       
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
                 %Len2(i)= sum([distance(path2(i,1:m-1)+m*(path2(i,2:m)-1)) distance(path2(i,m)+m*(path2(i,1)-1))]);
                  Len2(i)=D2_fitness_2(path2(i,: ));                       
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
       min(Distance);
       T=T*tuo;
 end
 n
 [m1 m2]=min(Distance);
   if m1<9999
    TracePath(m2,:)
     m1
   end
end
