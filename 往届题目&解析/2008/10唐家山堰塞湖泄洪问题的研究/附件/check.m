q=0;
p=0;
for i=1:1:115
    if z(i,2)-z(i+1,2)>0
        q=q+1;
    end
    if z(i,1)-z(i+1,1)>0
        p=p+1;
    end
end