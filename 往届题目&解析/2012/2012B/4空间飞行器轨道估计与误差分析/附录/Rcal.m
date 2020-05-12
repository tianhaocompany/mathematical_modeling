% 求 卫星在 该位置处，观测坐标系与基准坐标系的转换矩阵
function R = Rcal( pos_v) %pos_v 为行向量

xs_u = pos_v/norm(pos_v);

z_in = [0 0 1];
ys = cross(z_in, pos_v);
ys_u = ys/norm( ys);

zs_u = cross(xs_u, ys_u);

R = [xs_u' ys_u' zs_u'];%从观测坐标系到 惯性系的转化矩阵
end




