clc
clear
X=imread('F:\2008\gmcm\2008A\tongkou.bmp');
    X1=X(:,:,1);
    X2=X(:,:,2);
    X3=X(:,:,3);
for i=1:164
    for j=1:156
       if X1(i,j)~=0&&X2(i,j)~=0&&X3(i,j)~=0
           x4(i,j)=1;
       else
           x4(i,j)=0;
       end
    end
end
   axis ij
  axis([70 125 125 164])
   hold on
   y=0;
 s=((70210/995)^2)/10000
for j=70:130
    for i=125:164
        if x4(i,j)==1
            plot(j,i,'b.')
           
        end
    end
end
for j=80:120
    for i=130:156
        if x4(i,j)==1
            plot(j,i,'c.')
            y=y+1;
        end
    end
end
y=y*s;