%拟合 位置，去掉 随机 误差的 思路
% [d_ab6 ssq6 cnt6] =  LMFsolve('ab_fun',ab_gus);

function Del = coe_fun(x)
load str.mat
cx = Str.cx;
cy = Str.cy;

f  = log(abs(x(1).*cx + x(2))) - x(3)*cx - log(abs(cy));
Del =[ f
     (1- ((x(1).*cx + x(2))>0))*1e3;
    ];
end