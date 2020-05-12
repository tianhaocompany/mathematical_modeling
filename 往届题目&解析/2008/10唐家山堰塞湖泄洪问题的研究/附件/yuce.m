clc;
q=0;
e=mean(d);
e=e*65/68.5;
for i=1:1:68
    for j=1:1:39
        c=x(i);
        if data(j,1)<=c
            a=data(j,1);
            va=data(j,2);
        end
        if data(j,1)>=c
            b=data(j,1);
            vb=data(j,2);
            break
        end
    end
    pa=floor(a);
    pb=floor(b);
    pc=floor(c);
    if c-pc>0
        sc=(y(pc-708)+y(pc-707))/2;
    else
        sc=(y(pc-708));
    end
    sa=(a-pa)*y(pa-707)+(1-(a-pa))*y(pa-708);
    sb=(b-pb)*y(pb-707)+(1-(b-pb))*y(pb-708);
    s=0;
    temp=pc-pa;
    q=0;
    if pc-pa>=2
        for j=pa+1:1:pc-1
            s=y(j-708)+s;
            q=q+1;
        end
    else
        s=0;
    end
    sa=(s+sa+sc)/(q+2);
    s=0;
    temp=pb-pc;
    q=0;
    if pb-pc>=2
        for j=pc+1:1:pb-1
            s=y(j-708)+s;
            q=q+1;
        end
    else
        s=0;
    end
    sb=(s+sb+sc)/(q+2);
    ss(i,1)=sa;
    ss(i,2)=sb;
    x(i,2)=(va+sa*e*(c-a))*(b-c)/(b-a)+(vb-sb*e*(c-b))*(c-a)/(b-a);
    if x(i,2)>=vb||x(i,2)<=va
       x(i,2)=(va+sa*0.3*e*(c-a))*(b-c)/(b-a)+(vb-sb*e*0.3*(c-b))*(c-a)/(b-a);
    end
end

for i=83:1:83
    a=data(39,1);
    va=data(39,2);
    b=x(i,1);
    pa=floor(a)
    pb=floor(b)
    temp=pb-pa;
    sa=(a-pa)*y(pa-707)+(1-(a-pa))*y(pa-708);
    sb=(b-pb)*y(pb-708)+(1-(b-pb))*y(pb-708);
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
    s=s+sa+sb;
    ss(i,1)=sa;
    ss(i,2)=sb;
    s=s/(q+2);
    x(i,2)=va+s*(b-a)*e;
end
    
        
        