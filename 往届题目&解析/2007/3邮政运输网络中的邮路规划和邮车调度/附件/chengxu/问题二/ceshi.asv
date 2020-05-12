global  n distance
   load D1 D1 D1_1
   distance=D1;   
 n=1
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
   path=[    1    12    10    13    14     9     8     7     6     5    15     4     3     2    11];
   D1_1([     1    12    10    13    14     9     8     7     6     5    1     4     3     2    11])'
   Len1=D2_fitness_1(path)
   [distance(path(1:m-1)+m*(path(2:m)-1)) distance(path(m)+m*(path(1)-1))]'
   dis=sum([distance(path(1:m-1)+m*(path(2:m)-1)) distance(path(m)+m*(path(1)-1))])
   