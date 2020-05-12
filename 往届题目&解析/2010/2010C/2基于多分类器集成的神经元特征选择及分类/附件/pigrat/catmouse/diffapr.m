clc;
clear;

load cat1mouse2;
data=cat1mouse2;

K=2;
feature=data(:,1:43);
label=data(:,46);

[rtrain,ctrain]=size(feature);


for i=1:ctrain
    suma=0;
     for j=1:rtrain
        suma=suma+abs(feature(j,i));
    end
    
    feature(:,i)=feature(:,i)/suma;
end
%%

for k=1:K
    
 nd(k)=0;
for i=1:rtrain
   
    if(data(i,46)==k)
         nd(k)=nd(k)+1;
        c{k}{nd(k)}=feature(i,:);    
    end
end


end


%%
for k=1:K
%每一个类求个硬性均值
for cc=1:ctrain
    suma=0;
    for rr=1:nd(k)
        suma=suma+abs(c{k}{rr}(cc));
    end
    
    center(k,cc)=suma/nd(k);
end

end

%%



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
for ii=1:ctrain
    all=[all ii];
end

for dfi=1:K
    decfeature{dfi,:}=all;%初始化全集
end

[numr,numc]=size(dl);
for i=1:numr
    [dv(i,:),di(i,:)]=sort(dl(i,:),'descend');
    
    for j=1:numc
        if dv(i,j)<0.2
            dv(i,j)=0;
            di(i,j)=0;
        end
    end
    
  
        
    decfeature{floor((i-1)/(K-1))+1,:}=intersect(decfeature{floor((i-1)/(K-1))+1,:},di(i,:));
        
    
   
end














