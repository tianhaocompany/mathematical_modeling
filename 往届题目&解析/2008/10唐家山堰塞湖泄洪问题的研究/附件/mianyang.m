clc
clear
c=453;
%c=456;
 %c=457;
    b=int2str(c);
    a=['F:\2008\gmcm\2008A\×éÍ¼2\',b,'.bmp'];
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
 axis([760 860 550 660])
  hold on
y=0;
s=((70210/995)^2)/10000

for j=760:860
    for i=550:660
        if x4(i,j)==0
            if j>=790&&i<=610
            elseif j>=850
            %elseif j>=790&&i>=590&&j<=800
            else
            plot(j,i,'c.')
            y=y+1;
            end
        end
    end
end
% for j=760:860
%     for i=550:660
%         if x4(i,j)==0
%             if j>=810&&j<=820&&i>=560&&i<=610
%             plot(j,i,'c.')
%             y=y+1;
%             end
%         end
%     end
% end
% for j=760:860
%     for i=550:660
%         if x4(i,j)==0
%             if j>=805&&j<=820&&i>=560&&i<=610
%             plot(j,i,'c.')
%             y=y+1;
%             end
%         end
%     end
% end
for j=760:860
    for i=550:660
        if x4(i,j)==1
            plot(j,i,'k.')
            %y=y+1;
        end
    end
end
y=y*s;