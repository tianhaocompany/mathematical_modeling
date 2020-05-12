function Ipolor=polarsample(a)
%此函数为图像极坐标抽样
%采样密度为1.63度，采样点数10
v=1.37;q=15;
for theta=1:1:360
    for c1=0:q-1
        v1=cos(theta*pi/180)*(v^c1);
        v2=sin(theta*pi/180)*(v^c1);
        v1=floor(v1+0.5);
        v2=floor(v2+0.5);
        c(theta,(c1+1))=a((86-v2),(85+v1))*(v^c1);% 极坐标变换
    end
end
c=c';
for k=1:180
    for la=1:q
        if c(la,k)>=c(la,k+180)            
    v(la,k)=c(la,k);
        else v(la,k)=c(la,k+180);                 %极坐标抽样
        end
    end
end
Ipolor=v;
