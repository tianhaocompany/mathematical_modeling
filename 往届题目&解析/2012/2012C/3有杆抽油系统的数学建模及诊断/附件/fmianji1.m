function [ssu,ssd]=fmianji1(uu,dd)
uu=-uu;
len=length(uu);
point=find(uu==min(uu));
pt=point(length(point));
p0=point(1);
uu=[uu(pt:len) uu(1:p0-1)];
dd=[dd(pt:len) dd(1:p0-1)];
pfinal=find(uu==max(uu),1);

ssu=0;
ssd=0;
ss=0;
l1=dd(pt)-dd(p0);
l1u=l1;
l1d=0;
uu0=uu(1);
dd0=dd(1);
m=2;
n=length(uu);

while(1)
    deltam=uu(m)-uu0;
    deltan=uu(n)-uu0;
    if(deltam==0&&deltan==0)
        break;
    end
    if deltam<=deltan
        l2=dd(m)-dd0+(dd0-dd(n))/deltan*deltam;
        l2u=dd(m)-(dd(1)+(uu(m)-uu(1))*(dd(pfinal)-dd(1))/(uu(pfinal)-uu(1)));
        l2d=l2-l2u;
        uu0=uu(m);
        dd0=dd(m);
        delta=deltam;
        m=m+1;
    end
    if deltam>deltan
        l2=dd0-dd(n)+(dd(m)-dd0)/deltam*deltan;
        l2d=-dd(n)+dd(1)+(uu(n)-uu(1))*(dd(pfinal)-dd(1))/(uu(pfinal)-uu(1));
        l2u=l2-l2d;
        uu0=uu(n);
        dd0=dd(n);
        delta=deltan;
        n=n-1;
    end
    
    ssu=ssu+(l1u+l2u)*delta/2;
    ssd=ssd+(l1d+l2d)*delta/2;
    ss=ss+(l1+l2)*delta/2;
    l1u=l2u;
    l1d=l2d;
    l1=l2;
    if(m>pfinal||n<pfinal)
        break;
    end
end