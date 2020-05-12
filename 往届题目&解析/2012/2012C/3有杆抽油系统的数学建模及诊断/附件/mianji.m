clc;
clear;

% e=2.1e+11;
% load uu1;
% load dd1;
% cc=7.6; %≥Â¥Œ
% x=[792.5];  %≥È”Õ∏À∏À≥§

load uu2;
load dd2;
cc=4; %≥Â¥Œ
x=[523.61 664.32 618.35];

uu=-uu;
len=length(uu);
pt=find(uu==min(uu));
point=pt(length(pt));
uu=[uu(point:len) uu(1:point-1)];
dd=[dd(point:len) dd(1:point-1)];

ss=0;
l1=0;
uu0=uu(1);
dd0=dd(1);
m=2;
n=length(uu);

while(1)
    deltam=uu(m)-uu0;
    deltan=uu(n)-uu0;
    if deltam<=deltan
        l2=dd(m)-dd0+(dd0-dd(n))/deltan*deltam;
        uu0=uu(m);
        dd0=dd(m);
        delta=deltam;
        m=m+1;
    end
    if deltam>deltan
        l2=dd0-dd(n)+(dd(m)-dd0)/deltam*deltan;
        uu0=uu(n);
        dd0=dd(n);
        delta=deltan;
        n=n-1;
    end
    if(m>n)
        break;
    end
    ss=ss+(l1+l2)*delta/2;
    l1=l2;
end

product=1.44*cc*ss/(sum(x)*9.8);