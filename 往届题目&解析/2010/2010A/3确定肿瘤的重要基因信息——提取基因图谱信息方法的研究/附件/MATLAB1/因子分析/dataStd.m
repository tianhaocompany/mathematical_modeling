function [XY,MA,SSTD]=dataStd(dataXY);
XY=[];
[n,m]=size(dataXY);
stda=zeros(1,m);
meana=mean(dataXY);
for j=1:m
    t=0;
    for i=1:n
       t=t+(dataXY(i,j)-meana(j))^2;       
    end;
    %stda(j)=(t/(n-1))^0.5; 
    stda(j)=t^0.5; 
end;

%stda=std(dataXY);

for j=1:m
   for i=1:n
       if  stda(j)<0.000001
           stda(j)=0.000001;
       end;
       dataXY(i,j)=(dataXY(i,j)-meana(j))/stda(j);
   end;
end;
 XY=dataXY;
 MA=meana(1:m);
 SSTD=stda(1:m);
return;