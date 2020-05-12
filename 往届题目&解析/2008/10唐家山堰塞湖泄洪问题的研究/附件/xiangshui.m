clc
clear
X=imread('F:\2008\gmcm\2008A\shi1.bmp');
    X1=X(:,:,1);
    X2=X(:,:,2);
    X3=X(:,:,3);
for i=1:196
    for j=1:278
       if X1(i,j)==0&&X2(i,j)==0&&X3(i,j)==0
           x4(i,j)=1;
       else
           x4(i,j)=0;
       end
    end
end
   axis ij
   axis([130 195 30 80])
   hold on
 y=0;
 s=((70210/995)^2)/10000;
for j=170:190
    for i=50:70
        if x4(i,j)==1
            plot(j,i,'k.')
           y=y+1;
        end
    end
end
 y=y*s;
