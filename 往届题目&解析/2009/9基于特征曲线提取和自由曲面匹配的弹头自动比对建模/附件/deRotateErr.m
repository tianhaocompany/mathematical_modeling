function out = deRotateErr(fileT)

T = load(fileT);
 for j=1:756,
       for i=1:564,
            Z_T1(i,j)=T(i+(j-1)*564,3);
       end
   end
   
   for i = 1:300
       for j = 1:50
           Z_cutted(i,j) = Z_T1(i,j+200);
       end
   end
   
   for colum = 2:50
       
       num_moved = 0;
       for upAndDown = [-10 10]
             sum =0;
             num_to_move = upAndDown;    
             
             if num_to_move == 0  % num_to_move为零是，不做数据的平移
                 continue;
             end
             
             if num_to_move > 0  % 第i+5列数据要向上移动 num_to_move个数据单元
                for row = 1:(300 - num_to_move)
                    Z_cutted_shadow(row,colum) = Z_cutted(row + num_to_move,colum);
                end
                for row = (300 - num_to_move):300 %被移空的数据位置置零
                    Z_cutted_shadow(row,colum) = Z_cutted( (300 - num_to_move -1),colum);
                end
             else
                for row = 300:-1:(1 - num_to_move )
                    Z_cutted_shadow(row,colum) = Z_cutted(row + num_to_move ,colum); %注意num_to_move<0
                end
                for row =1:( - num_to_move ) %被移空的数据位置置零
                    Z_cutted_shadow(row,colum) = Z_cutted( (1 - num_to_move),colum );
                end
             end
        
               temp =10000;
               
               for i= (1+abs(upAndDown)):(300-abs(upAndDown))
               sum = sum + ( Z_cutted(i,j) - Z_cutted(i,j-1) )^2;
               end
               if temp > (sum/(300-2*abs(upAndDown)))^0.5
                   num_moved = upAndDown;
               end
               
               if num_moved == 0  % num_to_move为零是，不做数据的平移
                 continue;
             end
             
             if num_moved > 0  % 第i+5列数据要向上移动 num_to_move个数据单元
                for row = 1:(300 - num_moved)
                    Z_cutted(row,colum) = Z_cutted(row + num_to_move,colum);
                end
                for row = (300 - num_moved):300 %被移空的数据位置置零
                    Z_cutted(row,colum) = Z_cutted( (300 - num_moved -1),colum);
                end
             else
                for row = 300:-1:(1 - num_moved )
                    Z_cutted(row,colum) = Z_cutted(row + num_moved ,colum); %注意num_to_move<0
                end
                for row =1:( - num_to_move ) %被移空的数据位置置零
                    Z_cutted(row,colum) = Z_cutted( (1 - num_moved),colum );
                end
             end
               

               
       end
   end
       
    
       line_to_compare = zeros(1,300);
       
       for i= 1:300
           sum=0;
           for j = 1:50
               sum=sum+Z_cutted(i,j);
           end
           line_to_compare(i) = sum/50;
       end
       
       out = line_to_compare;
           
               
       
       
       
       
       