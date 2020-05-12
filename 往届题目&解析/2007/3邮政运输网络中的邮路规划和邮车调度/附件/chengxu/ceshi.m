global DD
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
[m,pn]=size(D);
 path=[1	15	16	17	12	13	19	14	2	3	4	5	18	11	10	9	8	6	7];
                 temp_m=find(path>m-2);
                 temp_m=[1 temp_m m+1];p=[path 1];
             if all((temp_m(2:4)-temp_m(1:3))>1)
                temp=zeros(m,1);
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
                    temp
                    [D(path(1:m-1)+m*(path(2:m)-1)) D(path(m)+m*(path(1)-1))]
                    sum( [D(path(1:m-1)+m*(path(2:m)-1)) D(path(m)+m*(path(1)-1))])
                  Len1=[D(path(1:m-1)+m*(path(2:m)-1)) D(path(m)+m*(path(1)-1))];%*((65-temp)/65*2);
                else
                  Len1=9999;
                end
            else
             Len1=9999;        
             end
             Len1
                  %计算一次行遍所有城市的总路程 