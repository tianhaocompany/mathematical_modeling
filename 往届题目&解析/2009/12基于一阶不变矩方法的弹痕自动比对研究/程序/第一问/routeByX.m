function [NewY,NewZ] = routeByX(y,z,DeltaCita)
% 绕X轴旋转擦痕坐标，旋转角度为DeltaCita
% 绕X轴旋转擦痕坐标，仅会影响擦痕的y坐标和z坐标
% 输入：
%     y： 旋转前的y坐标
%     z： 旋转前的z坐标
%     DeltaCita 旋转角度，单位弧度。规定逆时针为正，顺时针为负。
% 输出：
%     NewY：旋转后的y坐标
%     NewZ：旋转后的z坐标

% By Liu Yu
% 2009-09-20


L = sqrt(y.^2+z.^2);
cita = atan(z./y);


ind = find(z==0);
cita(ind) = 0;
Cita = cita+DeltaCita;

NewY = L .* cos(Cita);
NewZ = L .* sin(Cita);