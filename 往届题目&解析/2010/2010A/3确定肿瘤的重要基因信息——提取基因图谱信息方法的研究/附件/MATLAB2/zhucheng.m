function a= zhucheng(Ms)
%  Author : DING Tao  
[r,c]=size(Ms);
a=[];
% M_j=mean(Ms);
% M_the=std(Ms);
% for i=1:c
%     Ms(:,j)=(Ms(:,i)-Ms_j)./M_the;
% end
Ms1=corrcoef(Ms);
L=eig(Ms1);
L=sort(L);
L=flipud(L)';
l=length(L);
for i=1:l
%     sum(L(1:i))/sum(L)
    a=[a;sum(L(1:i))/sum(L)];
end
