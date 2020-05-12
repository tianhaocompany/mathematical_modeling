function x = f1(fea,label)

w = findWightPoint(fea,label);
w_all = findWightPoint(fea,ones(71,1));
num = max(label(:));

for i = 1:num
    f = label == i;
    tot = sum(f);
    x(i) = 0;
    t = 1;
    for k = 1:71
        if f(k)
            tmp(t,:) = fea(k,:);
            t = t + 1;
        end
    end
    for j = 1:tot
        x(i) = x(i) + (tmp(j,:) - w_all) * (tmp(j,:) - w(i,:))';
    end
end