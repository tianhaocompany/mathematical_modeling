%% Initialization
clear all;
close all;
T=[1 0 0 0.2;....
   0 -1 0 -2;...
   0 0 -1 1.2;...
   0 0 0 1];


solution = path_calculate(T);
figure(2);

for index = 2 : size(solution, 1)
    solution_temp = solution(index, :);
    flag = 1;
    order_time = 1;
    order_old = 0;
    while flag == 1
        for theta_index = 1 : 6
            if abs(solution_temp(theta_index)) > 2
                order_diff(theta_index) =  sign(solution_temp(theta_index)) * 2;
            else
                order_diff(theta_index) =  sign(solution_temp(theta_index)) * round(abs(solution_temp(theta_index)) / 0.1) * 0.1;
            end
        end
        order = order_old + order_diff;
        order_old = order;
        solution_temp = solution_temp - order_diff
        status = status_calculate(order);
        result_plot(order_time, :) = status(1 : 3, 4)';
        order_record(index, order_time, :) = order_diff;
        status_record(index, order_time, :) = [status(1,4), status(2,4), status(3,4)];
        order_time = order_time + 1;        
        stem3(status(1,4), status(2,4), status(3,4), 'rd');
        hold on         
        if order_diff == zeros(1, 6)
            flag = 0;
        end
    end
end
