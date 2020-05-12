function bDis=Dist_Bhatt
load matlab3;
bDis=zeros(1,2000);
for i=1:2000
    u1=sum(DATA(i,1:22))/22;
    u2=sum(DATA(i,23:62))/40;
    o1=var(DATA(i,1:22));
    o2=var(DATA(i,23:62));
    bDis(1,i)=0.25*(u1-u2)^2/(o1^2+o2^2)+0.5*log((o1^2+o2^2)/2/o1/o2);
end