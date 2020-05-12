clc;
clear;

load center;
Kold=5;
gof=2;
K=Kold-gof;

for k=1:K
    num=0;
    for kin=1:K   
        if kin~=k
             num=num+1;
             dif{k}{num}=abs(center(k,:)-center(kin,:));
             dl((k-1)*(K-1)+num,:)=abs(center(k,:)-center(kin,:));% 差表
        end
    end
end

%%

all=[];%全集
for ii=1:43
    all=[all ii];
end

for dfi=1:K
    decfeature{dfi,:}=all;%初始化全集
end

[numr,numc]=size(dl);
for i=1:numr
    [dv(i,:),di(i,:)]=sort(dl(i,:),'descend');
    
    for j=1:numc
        if dv(i,j)<0.02
            dv(i,j)=0;
            di(i,j)=0;
        end
    end
    
  
        
    decfeature{floor((i-1)/(K-1))+1,:}=intersect(decfeature{floor((i-1)/(K-1))+1,:},di(i,:));
        
    
   
end




load sefe5;

for i=gof+1:Kold
    feid=decfeature{i-gof};
    for j=1:size(feid,2)
        sefe5(i,feid(j))=1;
    end
end









