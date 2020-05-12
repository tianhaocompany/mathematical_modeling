%while k<10000
% per_num=N/pn/100;
% N=0; 
%  tau=0.01%1e-5;%input('请输入最低温度tau=' );        
%  iter_num=1;%某固定温度下迭代计数器
%       while iter_num<iter_max
 %       %MRRTT(Metropolis, Rosenbluth, Rosenbluth, Teller, Teller)过程:
             %用任意启发式算法在path的领域N(path)中找出新的更优解
 %            for i=1:pn
 %                Len1(i)=sum([D(path(i,1:m-1)+m*(path(i,2:m)-1)) D(path(i,m)+m*(path(i,1)-1))]);
                  %计算一次行遍所有城市的总路程 
 %                [path2(i,: )]=ChangePath2(path(i,: ),m);%更新路线
 %                Len2(i)=sum([D(path2(i,1:m-1)+m*(path2(i,2:m)-1)) D(path2(i,m)+m*(path2(i,1)-1))]);
 %            end
 %            temp=find((Len2-Len1<t|exp((Len1-Len2)/(T))>R)~=0);
  %           if temp
  %               path(temp, : )=path2(temp, : );
  %               Len1(temp)=Len2(temp);
   %              [TempMinD,TempIndex]=min(Len1);
   %              N=N+1;
   %          end
  %          iter_num=iter_num+1;
   %           T=T*tuo
    %   end
  %next_num=N/pn/100;
  % if abs(next_num-tuo)<0.01
  % elseif next_num<tuo & per_num<tuo
  %    k=k+1;T=T+t0; 
  % elseif per_num<tuo & next_num>tuo
  %    k=k+1;T=T-t0/2; 
  % elseif per_num>tuo & next_num<tuo
  %    k=k+1;T=T+t0/2; 
  % else
  %    k=k+1;T=T-t0; 
  % end 
 %   end 
 i=1;
 while i<max(size(data))
    j=i+1;
    while j<=max(size(data))
        if(abs((data(i,2)-data(j,2)))<0.001)
            data=[data(1:j-1,:);data(j+1:max(size(data)),:)];
        else
            break
        end
    end
       i=j;
 end
        
        
    
    
    