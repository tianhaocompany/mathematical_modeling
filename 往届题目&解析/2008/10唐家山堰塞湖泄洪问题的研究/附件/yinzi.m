clc;
for i=1:1:39
    a=data(i,1);
    b=data(i+1,1);
    va=data(i,2);
    vb=data(i+1,2);
    pa=floor(a);
    pb=floor(b);
    temp=pb-pa;
    sa=(a-pa)*y(pa-707)+(1-(a-pa))*y(pa-708);
    sb=(b-pb)*y(pb-707)+(1-(b-pb))*y(pb-708);
    s=0;
    q=0;
    if pb-pa>=2
        for j=pa+1:1:pb-1
            s=y(j-708)+s;
            q=q+1;
        end
    else
        s=0;
    end
    if q>0
        q
    end
    s=s+sa+sb;
    s=s/(q+2);
    if pb==pa
        c(i)=0;
    else
        c(i)=(vb-va)/s/(b-a);
    end
    cc(i)=(vb-va)/s/(b-a);
end
c=c';
cc=cc';
    
    