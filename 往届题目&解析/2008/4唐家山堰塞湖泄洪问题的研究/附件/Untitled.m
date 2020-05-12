data=zeros(size(d));
for i=1:528
    for j=1:373
        if i>484 && j<34
            data(i,j)=780;
        else
            data(i,j)=d(i,j);
        end
    end
end