function status = status_calculate(order)

theta_1 = order(1) / 180 * pi;
theta_2 = order(2) / 180 * pi;
theta_3 = order(3) / 180 * pi;
theta_4 = order(4) / 180 * pi;
theta_5 = order(5) / 180 * pi;
theta_6 = order(6) / 180 * pi;

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
status = A_1*L_AB*A_2*L_BC*A_3*L_CD*A_4*A_5*A_6*L_DE;