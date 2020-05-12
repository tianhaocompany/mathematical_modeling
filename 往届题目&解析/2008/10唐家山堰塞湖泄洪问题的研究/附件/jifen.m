clc
% clear
% y=0;
% q=1;
% load ll1.mat
% load rong.mat
ll=q;
y(1)=ll(4)*0.5*3600;
for i=5:94
    y(i-3)=y(i-4)+ll(i)*0.5*3600;
    %q=q+1;
end
y=y/(100000000);
y=3.05-y;
%  x=0:0.5:46.5;
%  plot(x,y)
%  hold on
%  c=max(r(:,2));
%  r(:,2)=c-r(:,2);
%  plot(x,r(:,2),'g')