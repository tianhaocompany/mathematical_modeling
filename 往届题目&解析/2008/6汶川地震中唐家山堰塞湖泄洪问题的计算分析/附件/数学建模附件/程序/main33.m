function [y,qq,L,tt]=main33(Q);
%已经存在Q的行向量
m=120*length(Q);%10min
q=[];%zeros(1,m);
temp=[];
tt=zeros(1,200000);
L=zeros(1,200000);

for j = 1:length(Q)
    temp=Q(j)*ones(1,120);
    q=[q temp];
end
%q;%生成流量by second
qlt=zeros(1,200000);
h=zeros(1,200000);
%dl=5;%m
v=5;
B=100;
dt=600;%
dl=v*dt;
l=0;
t=0;
qm=max(q);
i=1;
Wt=0;
while(i<200000)
   if i<=m
    l=l+dl;L(i)=l;
    v=vl(l);
    dt=dl/v;
    t=t+dt;tt(i)=t;
    Wt=Wt+q(i)*dt;
    %qlt(i)=flowdown(l,t,dt,q(i),qm);
    h(i)=Wt/l/B;
    qlt(i)=Wt/t;    
   i=i+1;
else
    l=l+dl;L(i)=l;
    v=vl(l);
    dt=dl/v;
    t=t+dt;tt(i)=t;
      if (abs(h(i)-h(i-1))<0.1) 
          break;
       end
    h(i)=Wt/l/B;
    qlt(i)=Wt/t;
    i=i+1;
end
end
y=h;
qq=qlt;

