% T=[sqrt(2)/2 sqrt(2)/-2 0 2.55*sqrt(2)/2;....
%    sqrt(2)/-2 sqrt(2)/-2 0 2.55*sqrt(2)/2;...
%    0 0 -1 0.75;...
%    0 0 0 0];
% T=[1 0 0 2.55*sqrt(2)/2;....
%    0 -1 0 2.55*sqrt(2)/2;...
%    0 0 -1 0.75;...
%    0 0 0 1];
% T=[1 0 0 0.2;....
%    0 -1 0 -2;...
%    0 0 -1 1.2;...
%    0 0 0 1];

function [result_final_constraint] = path_calculate(T)


n_1 = T(1, 1);
n_2 = T(2, 1);
n_3 = T(3, 1);
o_1 = T(1, 2);
o_2 = T(2, 2);
o_3 = T(3, 2);
a_1 = T(1, 3);
a_2 = T(2, 3);
a_3 = T(3, 3);
p_1 = T(1, 4);
p_2 = T(2, 4);
p_3 = T(3, 4);

theta_1 = 0;
theta_2 = 0;
theta_3 = 0;
theta_4 = 0;
theta_5 = 0;
theta_6 = 0;
index = 1;

for index_1 = 1 : 2
if p_1 - 0.65 * a_1 == 0 && (p_2 - 0.65 * a_2) == 0
    disp('Error!!!');
else
    theta_1 = atan(-1 * (p_1 - 0.65 * a_1) / (p_2 - 0.65 * a_2));
    if index_1 == 2
        if theta_1 < 0
            theta_1 = theta_1 + pi;
        else
            theta_1 = theta_1 - pi;
        end
    end
end
for index_2 = 1 : 2
if (p_1 - 0.65 * a_1) == 0 && (p_1 - 0.65 * a_1) == 0
    disp('Error!!!');
else
    delta_p_1 = (p_1 - 0.65 * a_1) / (2.55 * sin(theta_1));
end

delta_p_3 = (p_3 - 0.65 * a_3 - 1.4) / 2.55;
for index_x = 1 : 2
x = (4 * delta_p_3 + sqrt(16 * delta_p_3^2 - 4 * (delta_p_1^2 + delta_p_3^2 - 2 * delta_p_1) * (delta_p_1^2 + delta_p_3^2 + 2 * delta_p_1))) / (2 * (delta_p_1^2 + delta_p_3^2 - 2 * delta_p_1 ));
if index_x == 2
x = (4 * delta_p_3 - sqrt(16 * delta_p_3^2 - 4 * (delta_p_1^2 + delta_p_3^2 - 2 * delta_p_1) * (delta_p_1^2 + delta_p_3^2 + 2 * delta_p_1))) / (2 * (delta_p_1^2 + delta_p_3^2 - 2 * delta_p_1 ));
end
theta_2_2 = atan(x);
if index_2 == 2
    if theta_2_2 < 0
        theta_2_2 = theta_2_2 + pi;
    else
        theta_2_2 = theta_2_2 - pi;
    end
end
theta_2 = 2 * theta_2_2;

theta_3 = asin(sin(theta_2) * (delta_p_1 + cos(theta_2)) + cos(theta_2) * (delta_p_3 - sin(theta_2)));
if -1 * cos(theta_2) * (delta_p_1 + cos(theta_2)) + sin(theta_2) * (delta_p_3 - sin(theta_2)) < 0
    if theta_3 < 0
        theta_3 = -pi - theta_3;
    else
        theta_3 = pi - theta_3;
    end
end
for index_6 = 1 : 2
% theta_3 = acos(-1 * cos(theta_2) * (delta_p_1 + cos(theta_2)) + sin(theta_2) * (delta_p_3 - sin(theta_2)));

L_1 = cos(theta_1) * n_1 + sin(theta_1) * n_2;
L_2 = cos(theta_1) * o_1 + sin(theta_1) * o_2;
L_3 = cos(theta_1) * a_1 + sin(theta_1) * a_2;

delta_n_1 = -1 * (n_1 - cos(theta_1) * L_1) / sin(theta_1);
X = (delta_n_1 * (-1 * cos(theta_2) * cos(theta_3) + sin(theta_2) * sin(theta_3)) - n_3 * (sin(theta_2) * cos(theta_3) + cos(theta_2) * sin(theta_3)))...
    / ((-1 * cos(theta_2) * cos(theta_3) + sin(theta_2) * sin(theta_3))^2 + (sin(theta_2) * cos(theta_3) + cos(theta_2) * sin(theta_3))^2);
delta_o_1 = -1 * (o_1 - cos(theta_1) * L_2) / sin(theta_1);
Z = (delta_o_1 * (-1 * cos(theta_2) * cos(theta_3) + sin(theta_2) * sin(theta_3)) - o_3 * (sin(theta_2) * cos(theta_3) + cos(theta_2) * sin(theta_3)))...
    / ((-1 * cos(theta_2) * cos(theta_3) + sin(theta_2) * sin(theta_3))^2 + (sin(theta_2) * cos(theta_3) + cos(theta_2) * sin(theta_3))^2);

theta_6 = atan(X / Z);
if index_6 == 2
    if theta_6 < 0
        theta_6 = theta_6 + pi;
    else
        theta_6 = theta_6 - pi;
    end
end
for index_5 = 1 : 2
    
theta_5 = acos(X / sin(theta_6));
if index_5 == 2
theta_5 = -1 * theta_5;
end

for index_4 = 1 : 2
theta_4 = asin(L_3 / cos(theta_5));
if index_4 == 2
if theta_4 < 0
    theta_4 = -pi - theta_4;
else
    theta_4 = pi - theta_4;
end
end

result(index, 1)=(theta_1/pi*180);
result(index, 2)=(theta_2/pi*180);
result(index, 3)=(theta_3/pi*180);
result(index, 4)=(theta_4/pi*180);
result(index, 5)=(theta_5/pi*180);
result(index, 6)=(theta_6/pi*180);

A_1 = [cos(theta_1) -1 * sin(theta_1) 0 0; sin(theta_1) cos(theta_1) 0 0; 0 0 1 0; 0 0 0 1];
L_AB= [1 0 0 0; 0 1 0 0; 0 0 1 1.4; 0 0 0 1];
A_2 = [1 0 0 0; 0 sin(theta_2) cos(theta_2) 0; 0 -1 * cos(theta_2) sin(theta_2) 0; 0 0 0 1];
L_BC= [1 0 0 0; 0 1 0 0; 0 0 1 2.55; 0 0 0 1];
A_3 = [1 0 0 0; 0 cos(theta_3) -1 * sin(theta_3) 0; 0 sin(theta_3) cos(theta_3) 0; 0 0 0 1];
L_CD= [1 0 0 0; 0 1 0 0; 0 0 1 2.55; 0 0 0 1];
A_4 = [cos(theta_4) -1 * sin(theta_4) 0 0; sin(theta_4) cos(theta_4) 0 0; 0 0 1 0; 0 0 0 1];
A_5 = [1 0 0 0; 0 sin(theta_5) cos(theta_5) 0; 0 -1 * cos(theta_5) sin(theta_5) 0; 0 0 0 1];
A_6 = [cos(theta_6) -1 * sin(theta_6) 0 0; sin(theta_6) cos(theta_6) 0 0; 0 0 1 0; 0 0 0 1];
L_DE= [1 0 0 0; 0 1 0 0; 0 0 1 0.65; 0 0 0 1];
T_compare = A_1*L_AB*A_2*L_BC*A_3*L_CD*A_4*A_5*A_6*L_DE;

if abs(sum(sum(T_compare - T))) < 1e-5
    result(index, 7) = 1;
else
    result(index, 7) = 0;
end
index = index + 1;

end
end
end
end
end
end

index = 1;
result_final = [];
for index_final = 1 : size(result, 1)
    if result(index_final, 7) == 1
        result_final(index, :) = result(index_final, 1 : 6);
        index = index + 1;
    end
end

index = 1;
result_final_constraint = [];
for index_final = 1 : size(result_final, 1)
    temp = result_final(index_final, :);
    ok_1 = (temp(1,1) < 180 && temp(1,1) > -180);
    ok_2 = (temp(1,2) < 125 && temp(1,2) > -125);
    ok_3 = (temp(1,3) < 138 && temp(1,3) > -138);
    ok_4 = (temp(1,4) < 270 && temp(1,4) > -270);
    ok_5 = (temp(1,5) < 120 && temp(1,5) > -133.5);
    ok_6 = (temp(1,6) < 270 && temp(1,6) > -270);
    
    if ok_1 * ok_2 * ok_3 * ok_4 * ok_5 * ok_6 == 1
        result_final_constraint(index, :) = result_final(index_final, :);
        index = index + 1;
    end    
end









