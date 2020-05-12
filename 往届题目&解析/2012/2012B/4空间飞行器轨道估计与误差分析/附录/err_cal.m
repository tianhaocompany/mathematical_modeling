%利用估计出的轨道，求出残差
function err = err_cal( rv_gus, n_pos, pos, ab)
alpha = zeros(n_pos,1);
beta = zeros(n_pos,1);

% %
for i = 1 : 1 : n_pos
    r_fi = rv_gus(i,1:3);% 飞行器的估计位置
    rs_i = pos(i,:);
    
    R = Rcal(rs_i);
    Ri = inv(R);
    
    alpha(i) = (Ri(2,:)*(r_fi-rs_i)')/(Ri(1,:)*(r_fi-rs_i)');
    beta(i) = (Ri(3,:)*(r_fi-rs_i)')/(Ri(1,:)*(r_fi-rs_i)');
    
end
%
err = [alpha beta] - ab;
% b9_err = beta - b6;

end