
clc;
clear;
MaxDis=zeros(1,5);
load center_n;



load train;
load test;
load testlabel;


feature=train(1:135,1:43);
%feature=[feature;train(68:70,1:43)];
%feature=[feature;train(39:40,1:43)];
label=train(1:135,44);
%label=[label;train(68:70,45)];
%label=[label;train(39:40,45)];

testfeature=test(:,1:43);



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


for(i=1:135)
    j=label(i,1);
    n2=sp_dist2(feature(i,:),center(j,:));
    if MaxDis(1,j)<n2
        MaxDis(1,j)=n2;
    end
end