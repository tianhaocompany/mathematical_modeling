function pose = waveltmethod(a)

v=1.37;
h1=polarsample(a);         %图像极坐标抽样
h2=polarmarr;              %墨西哥草帽小波极坐标抽样
h1=symmetrix(h1);
h2=symmetrix(h2);
H1=fft2(h1);              %二维离散傅立叶变化
H2=fft2(h2);
H3=H1.*H2;                %对应元素相乘
h3=ifft2(H3);             %进行逆傅立叶变换
[v1 v2]=size(h3);   
v1=v1/2;
for k1=1:v1
    for k2=1:v2
      cx=(v^(k1-1));
       h4(k1,k2)=h3(v1+k1-1,k2)/cx;
       h4(k1,k2)=h4(k1,k2)^2;
       h4(k1,k2)=h4(k1,k2)/cx;         %h4为角度系数
   end
end
% h4
f=sum(h4)/max(sum(h4));          %角能量密度
[x y]=max(f);
% figure,plot(f);
% axis([0 180 0 1.2]);
y=angleadjust(y);
%disp(y);
%disp(y+180);
pose=y;                        %使角能量密度最大的角度就是方位角

