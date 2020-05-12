function V_RES=NT_I
load matlab3;
V=zeros(2000,1);
for i=1:2000
    V(i,1)=max(DATA(i,:))/min(DATA(i,:));
end
V_RES=sort(V);
t=1:2000
plot(t,V_RES);