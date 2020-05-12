function [y,qq]=main3(Q);
%已经存在Q的行向量
m=600*length(Q);%10min
q=[];%zeros(1,m);
temp=[];

for j = 1:length(Q)
    temp=Q(j)*ones(1,600);
    q=[q temp];
end
%q;%生成流量by second
qlt=zeros(1,200000);
h=zeros(1,200000);
dl=5;%m
v=5;
B=100;
dt=dl/v;
l=0;
t=0;
qm=max(q);
i=1;
while(i<200000)
   if i<=m
    l=l+dl;
    v=vl(l);
    dt=dl/v;
    t=t+dt;
    
    qlt(i)=flowdown(l,t,dt,q(i),qm);
    h(i)=qlt(i)/v/B;
   
   
   i=i+1;
else
    l=l+dl;
    v=vl(l);
    dt=dl/v;
    t=t+dt;
      if (abs(h(i)-h(i-1))<0.1) 
          break;
       end
    qlt(i)=0.9*qlt(i-1);
    h(i)=qlt(i)/v/B;
    i=i+1;
end
end
y=h;
qq=qlt;
