clc
t=xlsread('F:\2008\gmcm\2008A\第一问系数.xls','A1:B116');
yi=0.7:0.0001:3.056;
x1=t(:,1);
y1=t(:,2);
xi=interp1(y1,x1,yi); 
yyy=[xi;yi];
yyy=yyy';
for i=2:91
    for j=1:23561
        if y(i,1)-yyy(j,2)<=0.0001&&y(i,1)-yyy(j,2)>=0
            y(i,2)=yyy(j,1);
        end
    end
end