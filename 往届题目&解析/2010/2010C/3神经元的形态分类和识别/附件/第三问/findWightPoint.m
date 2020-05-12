function w = findWightPoint(fea,label)

num = max(label(:));

for i = 1:num
    f = label == i;
    f = f * ones(1,6);
    w(i,:) = sum(f.*fea) ./ num;
end