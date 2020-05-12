function out = doMatch(errors)

        %errors两文件夹的.Dat文件比较得出的16个比较用的特征值 ，[ 16 ,1 ]
        Match = 0; 
        matrix_temp = zeros(4,4);
        match_matrix = zeros(4,4);
        for i =1:4
            for j= 1:4
                matrix_temp(i,j) = errors((i-1)*4 + j);
            end
        end
        
        
       match_matrix(1,1)=matrix_temp(1,1);
       match_matrix(1,2)=matrix_temp(2,2);
       match_matrix(1,3)=matrix_temp(3,3);
       match_matrix(1,4)=matrix_temp(4,4);
       
       match_matrix(2,1)=matrix_temp(1,2);
       match_matrix(2,2)=matrix_temp(2,3);
       match_matrix(2,3)=matrix_temp(3,4);
       match_matrix(2,4)=matrix_temp(4,1);
       
       match_matrix(3,1)=matrix_temp(1,3);
       match_matrix(3,2)=matrix_temp(2,4);
       match_matrix(3,3)=matrix_temp(3,1);
       match_matrix(3,4)=matrix_temp(4,2);
       
       match_matrix(4,1)=matrix_temp(1,4);
       match_matrix(4,2)=matrix_temp(2,1);
       match_matrix(4,3)=matrix_temp(3,2);
       match_matrix(4,4)=matrix_temp(4,3);
        % match_matrix排列后的弹痕误差参数矩阵  
        %    T1 ：   C1   C2   C3   C4 
        %    T2 ：   C1   C2   C3   C4
        
        %    T1 ：   C1   C2   C3   C4
        %    T2 ：   C2   C3   C4   C1
        
        %    T1 ：   C1   C2   C3   C4 
        %    T2 ：   C3   C4   C1   C2
        
        %    T1 ：   C1   C2   C3   C4 
        %    T2 ：   C4   C1   C2   C3
       for  i =1:4
            match_matrix(i,:)=sort(match_matrix(i,:));
       end
       
       for i=1:4
          if ( match_matrix(i,3) <=0.01 )&&( match_matrix(i,1) < 0.1)
              sum = 0; 
              for k = 1:4
                   sum = match_matrix(i)+sum;
               end
               Match = sum/4;
               break;
          end
       end
       
       out = Match ;
       
       
                
           
           
           
           
           
           
           
           