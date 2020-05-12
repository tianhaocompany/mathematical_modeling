function y=fun(path)
global DD
 if isempty(path)
     y=0;
 else
  %load data_you
  n=max(size(path'));
  temp1=sum(DD(path,1));
  temp2=sum(DD(path,2));
  y=1;
  if temp1<66 & temp2<66
    for i=1:n
        temp1=temp1-DD(path(i),1)+DD(path(i),2);
      if temp1>65
           y=0;break;
      end
     end
  else
      y=0;
  end
end