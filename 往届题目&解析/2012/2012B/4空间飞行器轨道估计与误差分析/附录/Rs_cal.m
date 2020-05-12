function rs = Rs_cal(  n_pos, pos6, pos9, ab1_6, ab1_9 )
 
%通过两点交汇思路，计算飞行器在 惯性系下的 位置

 
%飞行器的 位置矢量，分别在 6,9 系观测坐标系
r_in = zeros(n_pos, 3);
 
for i = 1: 1 : n_pos
    %在 第 i 个位置点 的 观测坐标系-基准坐标系的转化矩阵, 包括 旋转和 平移
    
    % 卫星的位置矢量
    r6_vec = pos6(i,:);
    r9_vec = pos9(i,:);
    
    R6 = Rcal(r6_vec);
    R9 = Rcal(r9_vec);
 
    ab6  = ab1_6(i,:);
    ab9  = ab1_9(i,:);
    
    % 基准坐标系  下的坐标相等，
    R6_inv = inv(R6);
    R9_inv = inv(R9);
     
    A1 =  R6_inv(2:3,:) -   ab6'* R6_inv(1,:);
    A2 =  R9_inv(2:3,:) -   ab9'* R9_inv(1,:);
    
    A = [A1;A2]; 
    
    b1 = R6_inv(2:3,:)*r6_vec' -   ab6'* R6_inv(1,:)*r6_vec';
    b2 = R9_inv(2:3,:)*r9_vec' -   ab9'* R9_inv(1,:)*r9_vec';
    b = [b1;b2];
 
    %用最小二乘法，求解
    A_new = A'*A;   
    b_new = A'*b;
    r_in(i,:) = (A_new\b_new)';
end

rs = r_in;
end