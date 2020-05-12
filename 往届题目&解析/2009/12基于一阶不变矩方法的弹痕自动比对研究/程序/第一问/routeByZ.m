function [NewX,NewY] = routeByZ(x,y,DeltaCita)
% 绕Z轴旋转擦痕坐标，旋转角度为DeltaCita
% 绕Z轴旋转擦痕坐标，仅会影响擦痕的x坐标和y坐标
% 输入：
%     x： 旋转前的x坐标
%     y： 旋转前的y坐标
%     DeltaCita 旋转角度，单位弧度。规定逆时针为正，顺时针为负。
% 输出：
%     NewX：旋转后的x坐标
%     NewY：旋转后的y坐标

% By Liu Yu
% 2009-09-20


L = sqrt(x.^2+y.^2);
cita = atan(x./y);

ind = find(x==0);
cita(ind) = 0;

Cita = cita+DeltaCita;

NewX = L .* sin(Cita);
NewY = L .* cos(Cita);
