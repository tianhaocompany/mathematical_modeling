clc
clear
t=xlsread('F:\2008\gmcm\2008A\第一问系数.xls','A1:B116');
r=xlsread('F:\2008\gmcm\2008A\泄洪过程.xls','B2:B95');
xi=709:0.0001:750;
x=t(:,1);
y=t(:,2);
yi=interp1(x,y,xi); 
yyy=[xi;yi];
yyy=yyy';
for i=1:94
    for j=1:410001
        if r(i,1)-yyy(j,1)<=0.0001&&r(i,1)-yyy(j,1)>=0
            r(i,2)=yyy(j,2);
        end
    end
end