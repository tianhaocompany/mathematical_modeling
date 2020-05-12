clc
clear
load data1_750.mat
load data2_750.mat
load data3_750.mat
x1=X1;
x2=X2;
x3=X3;
x4=x1;
for i=1:678
    for j=1:1032
       if x1(i,j)==60&&x2(i,j)==80&&x3(i,j)==100
           x4(i,j)=1;
       else
           x4(i,j)=0;
       end
    end
end