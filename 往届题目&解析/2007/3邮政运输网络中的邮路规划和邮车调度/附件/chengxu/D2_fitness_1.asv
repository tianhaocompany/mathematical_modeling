function scores = D2_fitness_1(p)
global n  distance  %增加的车辆数
t=5.261538462; %5.320512821	7.108974359	5.287179487
  m=max(size(p));
    temp=find(p>m-n);    
    temp=[1 temp m+1]; p=[p 1];
     temp1=max(size(temp));
    if all((temp(2:temp1)-temp(1:temp1-1))>1)
         temp1=0;
      for i=1:n+1
         if sum(distance(p(temp(i):temp(i+1)-1)+m*(p(temp(i)+1:temp(i+1))-1))) ...
                <=(t-(temp(i+1)-temp(i)+1)*5/60)*65
            temp1=temp1+sum(distance(p(temp(i):temp(i+1)-1)+m*(p(temp(i)+1:temp(i+1))-1)));
         else
             temp1=9999;break
         end
      end
    else
           temp1=9999;
    end
     scores=temp1;
end
