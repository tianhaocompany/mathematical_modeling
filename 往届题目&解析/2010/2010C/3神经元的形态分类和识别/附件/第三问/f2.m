function x = f2(fea,label)

w = findWightPoint(fea,label);
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
        x(i) = x(i) + (tmp(j,:) - w(i,:)) * (tmp(j,:) - w(i,:))';
    end
end