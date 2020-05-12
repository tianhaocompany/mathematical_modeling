function resl = slove_vrm(r, v, a0 ,t )
% 已知 r 和 v, 求方程的 解   vr 和mdotm, 返回两列结果， 第一列为 分量求得的结果，第二列为模值求得的数据
% t为行向量

% function  F = Fe_cal( r )
% %已知位置矢量 求飞行器所受的外力项 Fe
Fe = Fe_cal( r );
a  =  a0 - Fe;
dt = t - t(1);

ax = a(:,1);
ay = a(:,2);
az = a(:,3);

vm  = sum(v.^2,2).^(0.5); % 速度 模值
vx = v(:,1);
vy = v(:,2);
vz = v(:,3);

A_vr = -[vx./vm; vy./vm; vz./vm];% vr(t)的
A_m = [ax; ay; az;];

bx = -dt'.*  ax  ;
by = -dt'.*  ay  ;
bz = -dt'.*  az ;

b = [bx;  by; bz];


A = [ A_m -A_vr];
A_new = A'*A;
b_new = A'*b;

para_prj = A_new\b_new;


%Fr,火箭产生的加速度
% 化简成 方程组
% A * x + B * y = b; 其中 A= accl+Gm/r^3*r_vec, B = v_unit( 飞行器 的 速度 方向)， x = m0/mdot, y = vr; 
A_m2 = sum(a.^2,2).^(0.5);  %((ax - Fe_x).^2+( ay - Fe_y).^2+ (az - Fe_z).^2).^(0.5);
b_mod = dt'.*A_m2;
num = size( a, 1);
A_mod = [A_m2 -1*ones(num,1)];
A_mod_new = A_mod'*A_mod;
b_mod_new = A_mod'*b_mod; 
para_mod = A_mod_new\b_mod_new;

resl = [para_prj para_mod];

end