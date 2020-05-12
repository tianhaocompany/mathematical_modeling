function [M,h]=data_pros
%  Author : DING Tao  
[a,b]=xlsread('project_data1.xls');
a(:,1:5)=[];
h=b(2:end,2);
name=unique(h);
n=length(name);
m=62;
M=zeros(n,m);
for i=1:n
    x={};
    x=h(i);
    y=find(strcmp(x,h)==1);
    if length(y)>=2
    M(i,:)=mean(a(y,:));
%     h(y)
    h(y(2:end))=[];
    a(y(2:end),:)=[];
    else 
        M(i,:)=a(y,:);
    end

end
M=M';