function h=polarmarr
%此函数为墨西哥草帽小波极坐标抽样
m=1;n=1;q=15;v=1.37;
for theta=1:1:180
    for rou=0:1:q-1
        iks=((v^rou)^2)*(0.2+0.8*sin(theta/180*pi)*sin(theta/180*pi));%极坐标变换
        fai(m,n)=(2-iks)*exp(-0.5*iks)*(v^rou);%二维墨西哥草帽表达式
        m=m+1;
    end
    m=1;
    n=n+1;
end
h=fai;