clc
clear
for c=445:1:470
%c=470;
    b=int2str(c);
    a=['F:\2008\gmcm\2008A\ื้อผ2\',b,'.bmp'];
    X=imread(a);
    X1=X(:,:,1);
    X2=X(:,:,2);
    X3=X(:,:,3);
for i=1:666
    for j=1:996
       if X1(i,j)==60&&X2(i,j)==80&&X3(i,j)==100
           if i~=1&&j~=996
           x4(i,j)=1;
           end
       else
           x4(i,j)=0;
       end
    end
end
  axis ij
% axis([400 650 270 360])
  hold on
 y(1,c-444)=0;
for j=1:995
    for i=2:666
        if x4(i,j)==1
            y(1,c-444)=y(1,c-444)+1;
        end
    end
end
s=((70210/995)^2)/10000;
yy(1,c-444)= y(1,c-444)*s;
% for j=1:995
%     for i=2:666
%         if x4(i,j)==1
%             plot(j,i)
%         end
%     end
% end
end
for i=1:26
    yan(i)=sum(yy(1:i))/10000;
end