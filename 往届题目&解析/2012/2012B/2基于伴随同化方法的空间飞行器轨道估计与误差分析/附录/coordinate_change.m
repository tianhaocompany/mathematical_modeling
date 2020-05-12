function [xx,yy,zz]=coordinate_change(x0,y0,z0,a,b)
% 2012-9-21
% 坐标系转换
% （x0,y0,z0）为观测卫星点位置（即观测坐标系原点在基础坐标系里的位置）
% （a，b）为观测的值，可以用来确定小坐标系中某一点P的位置
% （xx，yy，zz）为P点在观测坐标系中的位置
% （x0,y0,z0）不能是坐标+原点

r3=sqrt(x0^2+y0^2+z0^2);
px=[x0/r3 y0/r3 z0/r3];
r2=sqrt(x0^2+y0^2);
if r2==0
    py=[0 0 0];
else
    py=[-y0/r2 x0/r2 0];
end
r1=sqrt(x0^2*z0^2+y0^2*z0^2+(x0^2+y0^2)^2);
if r1==0
    pz=[0 0 0];
else
    pz=[-x0*z0/r1 -y0*z0/r1 (x0^2+y0^2)/r1];
end

xx=x0+1*px(1)+a*py(1)+b*pz(1);
yy=y0+1*px(2)+a*py(2)+b*pz(2);
zz=z0+1*px(3)+a*py(3)+b*pz(3);
