% main
load 71.mat
load label.mat
mi = min(fea);
fea = fea - ones(size(fea,1),1) * mi;
ma = max(fea);
fea = fea ./ (ones(size(fea,1),1) * ma);
[eigvector, eigvalue, meanData, new_data] = PCA(fea);
fea = new_data(:,1:6);

for i = 2:10
     x = f1(fea,label(:,i));
     y = f2(fea,label(:,i));
     Pk = sum(x);
     T = sum(y);
    R2(i) = 1- Pk/T; 
end
