clc
clear
for c=709:1:750
%c=750;
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
%  axis ij
% axis([400 650 270 360])
%  hold on
y(1,c-708)=0;
for j=1:625
    for i=275:359
        if x4(i,j)==1
            % plot(j,i,'b.')
           y(1,c-708)=y(1,c-708)+1;
        end
    end
end  
end