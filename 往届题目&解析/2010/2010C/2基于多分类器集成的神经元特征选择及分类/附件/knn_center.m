clc;
clear;

load 7center;
load test;




testfeature=test(:,1:43);



[r,c]=size(testfeature);

for i=1:c
    suma=0;
    for j=1:r
        suma=suma+abs(testfeature(j,i));
    end
    testfeature(:,i)=testfeature(:,i)/suma;
    
end
[rtrain,ctrain]=size(center);

cluster=7;
newlabel=zeros(r,cluster);
%KNN ·ÖÀà
K=1;
resultlabel=zeros(1,r);
for i=1:r
    min=99999999999;
   for j=1:rtrain
       d=sp_dist2(testfeature(i,:),center(j,:));
       if d<min
           min=d;
           resultlabel(1,i)=j;
       end
   end
   

 

 
 
end
