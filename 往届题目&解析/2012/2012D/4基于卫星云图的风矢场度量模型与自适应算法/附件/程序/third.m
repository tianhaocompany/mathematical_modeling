clear all
clc

% draw_f(x,y,vel,ang,pres)
% 画风矢量符号
% 输入： x,y坐标，速度，角度，压强

open 'first.fig';
load B_date.mat 

k=1;
for i=1:max(size(B_date))
if B_date(i,4)>0 & B_date(i,5)>0
  DD(k,:)=B_date(i,:);
k=k+1;
end
end
 B_date=DD;

for i=1:max(size(B_date))
    draw_f(B_date(i,1),B_date(i,2),B_date(i,3),B_date(i,4),B_date(i,5));
    hold on
end




