function [flag] = collision_detection(r, A, B, C, D)
C=[0 1 2]'
D=[0 1 -1]'
A= [0 0 1]'
B=[0 0 0]'

x_A = A(1, 1);
y_A = A(2, 1);
z_A = A(3, 1);
x_B = B(1, 1);
y_B = B(2, 1);
z_B = B(3, 1);
x_C = C(1, 1);
y_C = C(2, 1);
z_C = C(3, 1);
x_D = D(1, 1);
y_D = D(2, 1);
z_D = D(3, 1);

%% l_1-A到线段CD的距离
n = [x_D - x_C y_D - y_C z_D - z_C];
t = (n * (C - A)) / (n * n') * (-1);
M = C + (t * n)';
l_1 = sqrt((M-A)' * (M-A));

%% l_2-B到线段CD的距离
n = [x_D - x_C y_D - y_C z_D - z_C];
t = (n * (C - B)) / (n * n') * (-1);
M = C + (t * n)';
l_2 = sqrt((M-B)' * (M-B));

%% l_1_p-C到线段AB的距离
n = [x_B - x_A y_B - y_A z_B - z_A];
t = (n * (A - C)) / (n * n') * (-1);
M = A + (t * n)';
l_1_p = sqrt((M-C)' * (M-C));

%% l_2_p-D到线段AB的距离
n = [x_B - x_A y_B - y_A z_B - z_A];
t = (n * (A - D)) / (n * n') * (-1);
M = A + (t * n)';
l_2_p = sqrt((M-D)' * (M-D));

l_AC = sqrt((A-C)' * (A-C));
l_AD = sqrt((A-D)' * (A-D));
l_BC = sqrt((B-C)' * (B-C));
l_BD = sqrt((B-D)' * (B-D));
l_AB = sqrt((A-B)' * (A-B));
l_CD = sqrt((C-D)' * (C-D));

if min(l_1, l_2) > 0
    mu = l_1 / (l_1 + l_2);
    E = mu * B + (1 - mu) * A;
    n = [x_D - x_C y_D - y_C z_D - z_C];
    t = (n * (C - E)) / (n * n') * (-1);
    M = C + (t * n)';
    l_3 = sqrt((M-E)' * (M-E));
else
    l_3 = 0;    
end

if min(l_1_p, l_2_p) > 0
    mu = l_1_p / (l_1_p + l_2_p);
    E_p = mu * D + (1 - mu) * C;
    n = [x_B - x_A y_B - y_A z_B - z_A];
    t = (n * (A - E_p)) / (n * n') * (-1);
    M = A + (t * n)';
    l_3_p = sqrt((M-E_p)' * (M-E_p));
else
    l_3_p = 0;    
end

delta = det([D-C B-A D-B]);
k_k = min([l_1 l_2 l_1_p l_2_p l_AC l_AD l_BC l_BD l_AB l_CD l_3 l_3_p]);

if k_k == 0
    %% 2
    if l_1 == 0 && l_2 == 0 %% Pr 4
        if min([l_AC l_AD l_BC l_BD]) == 0
            l = 0;
        elseif max([l_AC l_AD l_BC l_BD]) - min([l_AC l_AD l_BC l_BD]) > l_AB + l_CD
            l = min([l_AC l_AD l_BC l_BD]);
        else
            l = 0;
        end       
    end
    
    if min([l_1 l_2 l_1_p l_2_p]) == 0 && max([l_1 l_2 l_1_p l_2_p]) ~= min([l_1 l_2 l_1_p l_2_p]) %% Pr 5
        if max([l_1_p l_2_p]) ~= min([l_1_p l_2_p]) && min([l_1_p l_2_p]) == 0 ...
                && max([l_1 l_2]) ~= min([l_1 l_2]) && min([l_1 l_2]) == 0
            l = 0;
        end
        if max(min([l_1 l_2]), min([l_1_p l_2_p])) ~= min(min([l_1 l_2]), min([l_1_p l_2_p]))
            if min([l_1 l_2]) == 0
                l = min([l_1_p l_2_p]);
            else
                l = min([l_1 l_2]);
            end
        end
    end
    
    if min([l_1 l_2 l_1_p l_2_p]) ~= 0 && min([l_3 l_3_p]) == 0 %% Pr 6
        if l_3 == 0 && l_3_p == 0
        l = 0;
        elseif  max([l_3 l_3_p]) ~=  min([l_3 l_3_p]) && min([l_3 l_3_p]) == 0
            if l_3 == 0
                l = min(l_1_p, l_2_p);
            elseif l_3_p == 0
                l = min(l_1, l_2);
            end
        end
    end
        
elseif delta == 0
    %% 3
    if min(l_3, l_3_p) ~= 0 && delta == 0 %% Pr 7
        flag_2 = (l_1^2 + l_CD^2 < (max(l_AC, l_AD))^2);
        flag_3 = (l_2^2 + l_CD^2 < (max(l_BC, l_BD))^2);
        flag_4 = (l_1_p^2 + l_AB^2 < (max(l_AC, l_BC))^2);
        flag_5 = (l_2_p^2 + l_AB^2 < (max(l_AD, l_AD))^2);
        flag_sum = flag_2 + flag_3 + flag_4 + flag_5;
        
        if flag_sum == 4
            l = min([l_AC l_AD l_BC l_BD]);
        elseif flag_sum == 0
            l = l_1;
        elseif flag_sum == 3
            if flag_2 == 0
                l = l_1;
            elseif flag_3 == 0
                l = l_2;
            elseif flag_4 == 0
                l = l_1_p;
            else
                l = l_2_p;
            end
        elseif flag_sum == 2
            if flag_2 == 1 && flag_3 == 1
                l = min(l_1_p, l_2_p);
            elseif flag_2 == 1 && flag_4 == 1
                l = min(l_2, l_2_p);
            elseif flag_2 == 1 && flag_5 == 1
                l = min(l_2, l_1_p);
            elseif flag_3 == 1 && flag_4 == 1
                l = min(l_1, l_2_p);
            elseif flag_3 == 1 && flag_5 == 1
                l = min(l_1, l_1_p);
            elseif flag_4 == 1 && flag_5 == 1
                l = min(l_1, l_2);
            end
        else
            if flag_2 == 1
                l = min([l_2 l_1_p l_2_p]);
            elseif flag_3 == 1
                l = min([l_1 l_1_p l_2_p]);
            elseif flag_4 == 1
                l = min([l_1 l_2 l_2_p]);
            else
                l = min([l_1 l_1_p l_2]);
            end
        end        
    end
else
    %% 4
    mu = acos(abs((B - A)' * (D - C)) / (L_AB * L_CD));
    l_AA_1 = l_AB * sin(mu);
    l_CC_1 = l_CD * sin(mu);
    l_AC_1 = l_1;
    l_C_1A_1 = l_2;
    theta = acos((l_AA_1^2 + l_C_1A_1^2 - l_AC_1^2) / (2 * l_AA_1 * l_C_1A_1));
    l_0 = l_C_1A_1 * sin(theta);
    
    k = l_1^2 - l_0^2 - l_AA_1^2;
    k_p = l_1_p^2 - l_0^2 - l_CC_1^2;
    
    if k<=0 && k_p<=0
        l = l_0;
    elseif k<=0 && k_p>0
        flag_4 = (l_1_p^2 + l_AB^2 < (max(l_AC, l_BC))^2);
        flag_5 = (l_2_p^2 + l_AB^2 < (max(l_AD, l_AD))^2);
        if flag_4 == 1 && flag_5 == 1
            l = min([l_AC l_AD l_BC l_BD]);
        elseif flag_4 == 1 && flag_5 == 0
            l = l_1_p;
        elseif flag_4 == 0 && flag_5 == 1
            l = l_2_p;
        end
    elseif k_p<=0 && k>0
        flag_2 = (l_1^2 + l_CD^2 < (max(l_AC, l_AD))^2);
        flag_3 = (l_2^2 + l_CD^2 < (max(l_BC, l_BD))^2);
        if flag_2 == 1 && flag_3 == 1
            l = min([l_AC l_AD l_BC l_BD]);
        elseif flag_2 == 1 && flag_3 == 0
            l = l_1;
        elseif flag_2 == 0 && flag_3 == 1
            l = l_2;
        end
    elseif k>0 && k_p>0
        flag_2 = (l_1^2 + l_CD^2 < (max(l_AC, l_AD))^2);
        flag_3 = (l_2^2 + l_CD^2 < (max(l_BC, l_BD))^2);
        flag_4 = (l_1_p^2 + l_AB^2 < (max(l_AC, l_BC))^2);
        flag_5 = (l_2_p^2 + l_AB^2 < (max(l_AD, l_AD))^2);
        flag_sum = flag_2 + flag_3 + flag_4 + flag_5;

        if flag_sum == 4
            l = min([l_AC l_AD l_BC l_BD]);
        elseif flag_sum == 3
            if flag_2 == 0
                l = l_1;
            elseif flag_3 == 0
                l = l_2;
            elseif flag_4 == 0
                l = l_1_p;
            else
                l = l_2_p;
            end
        elseif flag_sum == 2
            if flag_2 == 1 && flag_3 == 1
                l = min(l_1_p, l_2_p);
            elseif flag_2 == 1 && flag_4 == 1
                l = min(l_2, l_2_p);
            elseif flag_2 == 1 && flag_5 == 1
                l = min(l_2, l_1_p);
            elseif flag_3 == 1 && flag_4 == 1
                l = min(l_1, l_2_p);
            elseif flag_3 == 1 && flag_5 == 1
                l = min(l_1, l_1_p);
            elseif flag_4 == 1 && flag_5 == 1
                l = min(l_1, l_2);
            end
        else
            if flag_2 == 1
                l = min([l_2 l_1_p l_2_p]);
            elseif flag_3 == 1
                l = min([l_1 l_1_p l_2_p]);
            elseif flag_4 == 1
                l = min([l_1 l_2 l_2_p]);
            else
                l = min([l_1 l_1_p l_2]);
            end
        end
    end
end

if l > d
    flag = 1;
else
    flag = 0;
end















