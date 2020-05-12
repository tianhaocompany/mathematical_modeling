q=0;
for i=1:1:39
    if c(i)>0
        q=q+1;
        d(q)=c(i);
    end
end
mean(d)
var(d)
    