%% Initialization
clear all;

% T=[-1 * cos(atan(96/240)) 0 -1 * sin(atan(96/240)) 0.2;....
%    0 1 0 -2;...
%    sin(atan(96/240)) 0 -1 * cos(atan(96/240)) 1.2;...
%    0 0 0 1];
T=[1 0 0 0.2;....
   0 -1 0 -2;...
   0 0 -1 1.2;...
   0 0 0 1];




for index = 1
    z_max = sqrt(826875 / 8 / 24) + 4410 / 48;
    z_min = -1 * sqrt(826875 / 8 / 24) + 4410 / 48;
    set_z = [z_min : 0.5 : z_max];
    order_old = 0;
    status = []
    index_z = length(set_z);
    z = set_z(index_z);
    y = sqrt((826875 / 8 - 24 * (z - 4410 / 48)^2) / 6.25);
    if index == 2
        y = -y;
    end
    x = 2 * z;

    T(1, 4) = x / 100;
    T(2, 4) = y / 100;
    T(3, 4) = z / 100;
    solution = path_calculate(T);
  
        figure(2);
     for index = 1
            solution_temp = solution(index, :);
            flag = 1;
            order_time = 1;
            T=[1 0 0 0.2; 0 -1 0 -2; 0 0 -1 1.2; 0 0 0 1];
            order_old = round(path_calculate(T) ./ 0.1) * 0.1;
            order_old = order_old(2, :)
            solution_temp = solution_temp - order_old;
            while flag == 1
                for theta_index = 1 : 6
                    if abs(solution_temp(theta_index)) > 2
                        order_diff(theta_index) =  sign(solution_temp(theta_index)) * 2;
                    else
                        order_diff(theta_index) =  sign(solution_temp(theta_index)) * round(abs(solution_temp(theta_index)) / 0.1) * 0.1;
                    end
                end
                order = order_old(1, :) + order_diff;
                order_old = order;
                solution_temp = solution_temp - order_diff
                status = status_calculate(order);
                result_plot(order_time, :) = status(1 : 3, 4)';
                order_record(index, order_time, :) = order_diff;
                status_record(index, order_time, :) = [status(1,4), status(2,4), status(3,4)];
                order_time = order_time + 1;
                stem3(status(1,4), status(2,4), status(3,4), 'bd');
                hold on
                if order_diff == zeros(1, 6)
                    flag = 0;
                end
            end
     end
     

index_2_2 = 1;


     for index_z_z = 2 : length(set_z)
         index_z = length(set_z) - index_z_z + 1;
         z = set_z(index_z) - 0.001;
         y = sqrt((826875 / 8 - 24 * (z - 4410 / 48)^2) / 6.25);
         if index == 2
             y = -y;
         end
         x = 2 * z;

         T(1, 4) = x / 100;
         T(2, 4) = y / 100;
         T(3, 4) = z / 100;
      
%          plot3(T(1, 4),T(2, 4),T(3, 4), 'k.', 'MarkerSize', 5)
         hold on


         solution = path_calculate(T);
         if length(solution) > 0
         solution_old_temp = kron(ones(size(solution, 1),1),order_old );
         solution_index = find(sum(abs(solution - solution_old_temp),2) == min(sum(abs(solution - solution_old_temp),2)));
         solution = solution(solution_index, :);
         solution_temp = solution - order_old;
         

         flag_inner = 1;
         while flag_inner == 1
             for theta_index = 1 : 6
                 if abs(solution_temp(theta_index)) > 2
                     order_diff(theta_index) =  sign(solution_temp(theta_index)) * 2;
                     solution_temp(theta_index) = solution_temp(theta_index) - order_diff(theta_index);
                 else
                     order_diff(theta_index) =  sign(solution_temp(theta_index)) * floor(abs(solution_temp(theta_index)) / 0.1) * 0.1;
                     solution_temp(theta_index) = solution_temp(theta_index) - order_diff(theta_index);
                 end
             end
             if order_diff == zeros(1, 6)
                 break;
             end
order_record1(1,index_2_2, :) = order_diff;

             order_old = order_old + order_diff;
             % order = order_old + solution_temp;
             status = status_calculate(order_old);
             status_record1(index, index_2_2, :) = [status(1,4), status(2,4), status(3,4)];
             index_2_2 = index_2_2 +1;
%              order_old = order;

             %         solution_temp = solution_temp - order_diff
             %         status = status_calculate(order);
             %         result_plot(order_time, :) = status(1 : 3, 4)';
             %         order_time = order_time + 1;

             plot3(status(1,4), status(2,4), status(3,4), 'r.', 'MarkerSize', 10);
             hold on
         end
         else
             plot3(T(1, 4),T(2, 4),T(3, 4), 'k.', 'MarkerSize', 10)
             hold on
         end

     end
end
%         if order_diff == zeros(1, 6)
%             flag = 0;
%         end

% 
% for index = 1 : size(solution, 1)
%     solution_temp = solution(index, :);
%     flag = 1;
%     order_time = 1;
%     order_old = 0;
%     while flag == 1
%         for theta_index = 1 : 6
%             if abs(solution_temp(theta_index)) > 2
%                 order_diff(theta_index) =  sign(solution_temp(theta_index)) * 2;
%             else
%                 order_diff(theta_index) =  sign(solution_temp(theta_index)) * round(abs(solution_temp(theta_index)) / 0.1) * 0.1;
%             end
%         end
%         order = order_old + order_diff;
%         order_old = order;
%         solution_temp = solution_temp - order_diff
%         status = status_calculate(order);
%         result_plot(order_time, :) = status(1 : 3, 4)';
%         order_time = order_time + 1;        
%         stem3(status(1,4), status(2,4), status(3,4), 'bd');
%         hold on         
%         if order_diff == zeros(1, 6)
%             flag = 0;
%         end
%     end
%  end
%     end
% end