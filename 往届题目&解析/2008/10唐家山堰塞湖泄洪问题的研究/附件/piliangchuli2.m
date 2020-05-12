clc
clear
d=1;
%for c=709:1:750
c=709;
    b=int2str(c);
    a=['F:\2008\gmcm\2008A\ื้อผ\',b,'.bmp'];
    X=imread(a);
    X1=X(:,:,1);
    X2=X(:,:,2);
    X3=X(:,:,3);
for i=1:678
    for j=1:1032
       if X1(i,j)==60&&X2(i,j)==80&&X3(i,j)==100
           x4(i,j)=1;
       else
           x4(i,j)=0;
       end
    end
end
x5=x4;
for i=2:677
    for j=2:1031
       if x4(i,j-1)==1&&x4(i,j+1)==1&&x4(i-1,j-1)==1&&x4(i-1,j)==1&&x4(i-1,j+1)==1&&x4(i+1,j-1)==1&&x4(i+1,j)==1&&x4(i+1,j+1)==1
           x5(i,j)=0;
       end
    end
end
%axis ij
for j=1:625
    for i=275:359
        if x5(i,j)==1
            %plot(j,i,'b')
            plot3(j,i,0.5,'b')
            hold on
        end
    end
end 
d=d+5;
%end