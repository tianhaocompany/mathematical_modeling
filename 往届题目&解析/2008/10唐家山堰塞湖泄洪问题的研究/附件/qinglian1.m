clc
clear
X=imread('F:\2008\gmcm\2008A\qinglian.bmp');
    X1=X(:,:,1);
    X2=X(:,:,2);
    X3=X(:,:,3);
for i=1:152
    for j=1:194
       if X1(i,j)==0&&X2(i,j)==0&&X3(i,j)==0
           x4(i,j)=1;
       else
           x4(i,j)=0;
       end
    end
end
   axis ij
  axis([65 100 60 95])
   hold on
   y=0;
 s=((70210/995)^2)/10000
for j=65:100
    for i=60:95
        if x4(i,j)~=1
            plot(j,i,'b.')
          
        end
    end
end
for j=70:90
    for i=60:90
        if x4(i,j)~=1
            plot(j,i,'c.') 
            y=y+1;
        end
    end
end
y=y*s;