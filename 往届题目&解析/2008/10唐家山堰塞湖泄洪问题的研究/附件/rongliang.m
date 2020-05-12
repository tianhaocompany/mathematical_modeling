clc
clear
load yy.mat
x=yy;
xx=xlsread('F:\2008\gmcm\2008A\12.xls','B1:B25');
for i=1:25
     for j=1:4101
         if xx(i)==x(j,1)
             xxx(i,1)=x(j,2);
         end
     end
end