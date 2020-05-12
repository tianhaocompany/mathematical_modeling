clear;
load E:\x\77T2-1812492\77T2-1812492\c4.dat;      %读原始数据
x0=[c4]';
n=1;
while n<=425821
x=x0(1,n:n+563);                                 %各测点的空间坐标数据
y=x0(2,n:n+563);
z=x0(3,n:n+563);
z0=z(1)-3.95;                                    %参考圆心的绝对空间坐标
r1=sqrt(x.^2+(-z0+z).^2);                        %各测点相对于参考圆心的半径
subplot(1,2,1);
plot(z,x);
axis([min(z),max(z),min(x),max(x)]);
title('实测弹头截面C1痕迹曲线');
xlabel('z轴/毫米');
ylabel('x轴/毫米');
subplot(1,2,2);
sin=x./r1;                                     %各测点相对于参考圆心的正弦
cos=(-z0+z)./r1;                               %各测点相对于参考圆心的余弦
rl1=sum(r1)/length(x);                         %最小二乘圆的半径
u=sum(r1.*sin)*(2)/length(x);                  %最小二乘圆的空间坐标   
w=sum(r1.*cos)*(2)/length(x)+z0;
x1=(r1.*sin+u);                                %各测点相对于最小二乘圆圆心的空间坐标
z1=(r1.*cos+w);
x00=[x1;y;z1];
fid=fopen('c4.txt','at');
fprintf(fid,'%f\t%f\t%f\n',x00);
fclose(fid);
n=n+564;
end
disp('运行结束');
plot(z1,x1);
axis([min(z1),max(z1),min(x1),max(x1)]);
title('经误差补偿后的C1痕迹曲线');
xlabel('z轴/毫米');
ylabel('x轴/毫米');