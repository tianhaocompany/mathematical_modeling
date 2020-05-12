function scores = D2_fitness(x,distance)
global n    %增加的车辆数
scores = zeros(size(x,1),1);
for j = 1:size(x,1)
    p = x{j}; 
    p=[0 p]+1;
    m=max(size(p));
    temp=find(p>m-n);
    temp=[1 temp m+1]; p=[p 1];
    temp1=max(size(temp));
    if sum((temp(2:temp1)-temp(1:temp1-1))==1)
        temp1=9999;
    else
        temp1=0;
      for i=1:n+1
        if sum(distance(p(temp(i):temp(i+1)-1)+m*(p(temp(i)+1:temp(i+1))-1))) ...
               <=(300-(temp(i+1)-temp(i)-1)*5)*65/60
           temp1=temp1+sum(distance(p(temp(i):temp(i+1)-1)+m*(p(temp(i)+1:temp(i+1))-1)));
        else
            temp1=9999;break
        end
      end
    end
     scores(j) =temp1;
end 

