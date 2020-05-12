
for i =1:22
    for j = (i+1):22
        maxr(j,i)=maxr(i,j);
    end
end
for i = 1:22
    maxr_new(i,:)=sort(maxr(i,:),'descend')
end
for i = 1:22
    for j = 1:22
        for k = 1:22
            if(maxr(i,k)==maxr_new(i,j))
                 sort_r(i,j) = k;
            end
        end
    end
end