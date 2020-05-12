clc;
clear;

load train;

K=5;
feature=train(1:51,1:43);
if K==5
label=train(1:51,44);
end
if K==7
label=train(1:51,45);
end

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
   if K==5
    if(train(i,44)==k)
         nd(k)=nd(k)+1;
        c{k}{nd(k)}=feature(i,:);    
    end
   end
   if K==7
    if(train(i,45)==k)
         nd(k)=nd(k)+1;
        c{k}{nd(k)}=feature(i,:);    
    end
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
        if dv(i,j)<0.04
            dv(i,j)=0;
            di(i,j)=0;
        end
    end
    
  
        
    decfeature{floor((i-1)/(K-1))+1,:}=intersect(decfeature{floor((i-1)/(K-1))+1,:},di(i,:));
        
    
   
end

sefe12=zeros(K,ctrain);

for i=1:K
    feid=decfeature{i};
    for j=1:size(feid,2)
        sefe12(i,feid(j))=1;
    end
end
















