%%提取中间段数据300行到400行，[0.825,1.1]
clc
clear
D=load('c2.dat');
data=D(169201:226164,:);
%[0.825,1.1]，长度为56964
%x=0:10*0.00275:1.5125
data=sortrows(data,1);
for x=1:564
    num=0;
    for y=1:101
        num=num+data((x-1)*101+y,3); 
    end
    newdata(x)=num/101;
end
%xx=1:10:550;
%xx=1:564;
%plot(xx,newdata(1,1:10:550));
%plot(xx,newdata,'r');
xlswrite('c2',newdata','sheet1');





        
