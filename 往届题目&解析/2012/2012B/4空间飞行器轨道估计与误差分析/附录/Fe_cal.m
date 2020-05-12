function  F = Fe_cal( r )
%已知位置矢量 求飞行器所受的外力项 Fe
global Gm

rx = r(:,1);
ry = r(:,2);
rz = r(:,3);
rm  = sum(r.^2,2).^(0.5); % 位置 模值

Fe_x = -Gm./(rm.^3).*rx;% x轴方向
Fe_y = -Gm./(rm.^3).*ry;% y轴方向
Fe_z = -Gm./(rm.^3).*rz;% z轴方向

F = [Fe_x Fe_y Fe_z];

end