clc;
clear;

load train;
load traintest;
load traintestlabel;
load test;

feature=train(1:51,1:43);
%feature=[feature;train(68:70,1:43)];
%feature=[feature;train(39:40,1:43)];
label=train(1:51,44);
%label=[label;train(68:70,45)];
%label=[label;train(39:40,45)];

testfeature=traintest(:,1:43);



[r,c]=size(testfeature);
[rtrain,ctrain]=size(feature);

for i=1:c
    suma=0;
    for j=1:r
        suma=suma+abs(testfeature(j,i));
    end
    testfeature(:,i)=testfeature(:,i)/suma;
    
end

for i=1:ctrain
    suma=0;
     for j=1:rtrain
        suma=suma+abs(feature(j,i));
    end
    
    feature(:,i)=feature(:,i)/suma;
end

cluster=5;
newlabel=zeros(r,cluster);
%KNN ·ÖÀà
K=1;
resultlabel=zeros(1,r);
for i=1:r
    
   for j=1:rtrain
       d=sp_dist2(testfeature(i,:),feature(j,:));
       dis(j)=d;
   end
   
 [a,pos]=sort(dis);
 
 for k=1:K
     newlabel(i,label(pos(k)))= newlabel(i,label(pos(k)))+1;
 end
 [aa,bb]=max(newlabel(i,:));
resultlabel(i)=bb;
 
 
end

right=0;

resultlabel7=resultlabel;

for i=1:r
    if traintestlabel(i)==resultlabel(i)
        right=right+1;
    end
    
    if resultlabel(i)==4
        if test(i,2)==2
            resultlabel7(i)=4;
        end
         if test(i,2)==3
            resultlabel7(i)=5;
         end
          if test(i,2)>3
            resultlabel7(i)=6;
        end
    end
    if resultlabel(i)==5
        
       resultlabel7(i)=7;
       
    end
    
    
    
    
end

fprintf('accuracy=%f,%d/%d',right/r,right,r);

