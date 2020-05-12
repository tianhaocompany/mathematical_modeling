
function y=flowdown(l,t,dt,q,qm)
%flowdown
%l 表示距离，在这里离散化表示，每个微元5米
%t 表示时刻

Wt=q*dt;%计算某t->t+dt的溢出流量
%qm记录最大流量
VK=vl(l);
y=qm/(1+qm/(VK*Wt));

    
    