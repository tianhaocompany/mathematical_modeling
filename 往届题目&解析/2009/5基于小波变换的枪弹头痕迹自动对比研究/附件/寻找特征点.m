RootPath = 'E:\Modeling\Data\B_Data_4';
DiffGuns = ['77-1202999',
            '77-1203959',
            '77-1504519',
            '77-1811345',
            '77-1812492',
            '77-1814117',
            '77-1814688',
            '77-1923252',
            '77-1930832',
            '77-1931817',
            '77-1932803'];
DiffBullet = ['T1',
              'T2'];
DiffCurves = ['c1.dat',
              'c2.dat',
              'c3.dat',
              'c4.dat'];
DiffLines = ['c_line1.dat',
              'c_line2.dat',
              'c_line3.dat',
              'c_line4.dat'];
DiffCuts = ['c1_mid.dat'
            'c2_mid.dat'
            'c3_mid.dat'
            'c4_mid.dat'];
          
for i=1:size(DiffGuns,1)
    for j=1:size(DiffBullet,1)
        for k = 1:size(DiffCurves,1)
            Curve = load([RootPath '\' DiffGuns(i,:) '\' DiffGuns(i,1:2) DiffBullet(j,:) DiffGuns(i,3:length(DiffGuns(i,:))) '\' DiffCurves(k,:)]);
            Curve_main(1:756,1:3)=0;
      
            for y_step = 150:606                                    %y由1到756
                y_scale = round((y_step-1)*0.00275*100000)/100000;  %换算出y的实际大小
                Curve_y = find(Curve(:,2) == y_scale);          %找出某一个固定Y值对应的所有点的下标
                Curve_z = Curve(Curve_y,3);                     %生成X-Z的坐标x由1到564
                        
                               
                Diff_Left = (Curve_z(2:563)-Curve_z(1:562));    %所有点减去它前面的一个点
                Diff_Left = [Diff_Left(1);Diff_Left;Diff_Left(size(Diff_Left,1))];      %补齐
                
                Diff_Right = (Curve_z(3:564)-Curve_z(2:563));   %所有点后面一个点减去这个点
                Diff_Right = [Diff_Right(1);Diff_Right;Diff_Right(size(Diff_Right,1))];  %补齐
                
                Peak = find((Diff_Left.*Diff_Right)<=0);        %由左右导数乘积小于等于零，得到所有拐点
                
                Peak(find(Diff_Right(Peak)==0))=[];             %去除所有右导数为零的项，因为只要存在右倒数为零的项，肯定存在相邻的左导数为
                                                                %零的项，两者取其
                                                                
                %Peak(find(Diff_Left(Peak-1)==0&Diff_Right(Peak-1)==0))=[];
                Peak(find(Peak>514|Peak<50))=[];                    %x方向起始和终止的点不具有说服力，直接去除
                
                Diff_Peak_Left_1 = Curve_z(Peak)-Curve_z(Peak-1);  %对于所有的拐点再次计算它们的左导数	
                Diff_Peak_Left_n = Curve_z(Peak)-Curve_z(Peak-8);  %对于所有拐点计算于它们相距稍远的点的左导数
                Diff_Peak_Right_1 = Curve_z(Peak+1)-Curve_z(Peak); %对于所有的拐点再次计算它们的右导数
                Diff_Peak_Right_n = Curve_z(Peak+8)-Curve_z(Peak); %对于所有拐点计算于它们相距稍远的点的右导数                
                
                Peak(find(Diff_Peak_Left_1.*Diff_Peak_Left_n<0 | Diff_Peak_Right_1.*Diff_Peak_Right_n<0 | Diff_Peak_Right_n.*Diff_Peak_Left_n>0))=[];   %去除较小的拐点
                %Peak(find((Curve_z(Peak)-Curve_z(Peak-1)).*(Curve_z(Peak)-Curve_z(Peak-8))<0|(Curve_z(Peak+1)-Curve_z(Peak)).*(Curve_z(Peak+8)-Curve_z(Peak))<0|((Curve_z(Peak+8)-Curve_z(Peak)).*(Curve_z(Peak)-Curve_z(Peak-8))>0)))=[];             
                
                if (size(Peak,1)<1)
                    break;
                end
                
                Peak_i=1;
                while Peak_i<=size(Peak,1)
                    Peak_temp = find((Peak<Peak(Peak_i)+10) & (Peak>Peak(Peak_i)-10));  %找出集中在较小的x范围内的拐点
                    Peak_i=Peak_temp(size(Peak_temp,1))+1;                              %循环值移动
                    [Unuse,Peak_temp_max] = max(abs(Curve_z(Peak(Peak_temp))));                 %在这一个范围内的极值
                    Peak(Peak_temp(find(Peak_temp~=Peak_temp(Peak_temp_max))))=0;                  %其余拐点标记为零
                    %Peak(Peak_temp(find(abs(Curve_z(Peak_temp)) ~= max(abs(Curve_z(Peak_temp))))))=0;
                end
                Peak(find(Peak==0)) = [];                                               %去除标记为零的拐点
                
                if (size(Peak,1)>1)
                    
                    Diff_Peak_z = abs(Curve_z(Peak(2:size(Peak,1)))-Curve_z(Peak(1:size(Peak,1)-1))); %计算z方向上的相邻点之间的差距
                    Diff_Peak_z_max = max(Diff_Peak_z);                                               %z方向上差值的最大值
                    Diff_Peak_z_large = find(abs(Diff_Peak_z) >= 0.10*Diff_Peak_z_max);               %所有大于最大值0.1倍的点
                    Peak = Peak(Diff_Peak_z_large(1):Diff_Peak_z_large(size(Diff_Peak_z_large,1))+1); %更新Peak
                    Curve_main_mid_x = round((Peak(size(Peak,1))+Peak(1))/2);
                else
                    Curve_main_mid_x = Peak(1);
                end
                    
                Curve_main_x = 0.00275*(Curve_main_mid_x-1);                     %取中间点的x值
                Curve_main_y = (y_step-1)*0.00275;                                                %y坐标
                Curve_main_z = Curve_z(Curve_main_mid_x);
                
                if (Curve_main_mid_x<64)
                        Curve_main_mid_x =65;
                end
  
%{
                if(y_step==200)
                    Curve_xz_1_4 = [[Curve_main_mid_x-63-1:Curve_main_mid_x+64-1]'*0.00275,Curve_z(Curve_main_mid_x-63:Curve_main_mid_x+64)];
                    save([RootPath '\' DiffGuns(i,:) '\' DiffGuns(i,1:2) DiffBullet(j,:) DiffGuns(i,3:length(DiffGuns(i,:))) '\' DiffCuts(k,:) '_1_4.dat'],'Curve_xz_1_4','-ascii');
                end
                if(y_step==400)
                    Curve_xz_1_2 = [[Curve_main_mid_x-63:Curve_main_mid_x+64]'*0.00275,Curve_z(Curve_main_mid_x-63:Curve_main_mid_x+64)];
                    save([RootPath '\' DiffGuns(i,:) '\' DiffGuns(i,1:2) DiffBullet(j,:) DiffGuns(i,3:length(DiffGuns(i,:))) '\' DiffCuts(k,:) '_1_2.dat'],'Curve_xz_1_2','-ascii');
                end
                if(y_step==600)
                    Curve_xz_3_4 = [[Curve_main_mid_x-63:Curve_main_mid_x+64]'*0.00275,Curve_z(Curve_main_mid_x-63:Curve_main_mid_x+64)];
                    save([RootPath '\' DiffGuns(i,:) '\' DiffGuns(i,1:2) DiffBullet(j,:) DiffGuns(i,3:length(DiffGuns(i,:))) '\' DiffCuts(k,:) '_3_4.dat'],'Curve_xz_3_4','-ascii');
                end
%}                                
                Curve_main(y_step,:)=[Curve_main_x,Curve_main_y,Curve_main_z];
            end
            
            Curve_main(find((Curve_main(:,1)==0 & Curve_main(:,2)==0 & Curve_main(:,3)==0)),:)=[];
            save([RootPath '\' DiffGuns(i,:) '\' DiffGuns(i,1:2) DiffBullet(j,:) DiffGuns(i,3:length(DiffGuns(i,:))) '\' DiffLines(k,:)],'Curve_main','-ascii');
           
            mid_y = Curve_main(round(size(Curve_main,1)/2),2);
            y_scale = round(mid_y*100000)/100000;  %换算出y的实际大小
                Curve_y = find(Curve(:,2) == y_scale);          %找出某一个固定Y值对应的所有点的下标
                Curve_z = Curve(Curve_y,3);                     %生成X-Z的坐标x由1到564
                             
                Diff_Left = (Curve_z(2:563)-Curve_z(1:562));    %所有点减去它前面的一个点
                Diff_Left = [Diff_Left(1);Diff_Left;Diff_Left(size(Diff_Left,1))];      %补齐
                
                Diff_Right = (Curve_z(3:564)-Curve_z(2:563));   %所有点后面一个点减去这个点
                Diff_Right = [Diff_Right(1);Diff_Right;Diff_Right(size(Diff_Right,1))];  %补齐
                
                Peak = find((Diff_Left.*Diff_Right)<=0);        %由左右导数乘积小于等于零，得到所有拐点
                
                Peak(find(Diff_Right(Peak)==0))=[];             %去除所有右导数为零的项，因为只要存在右倒数为零的项，肯定存在相邻的左导数为
                                                                %零的项，两者取其
                Peak(find(Peak>514|Peak<50))=[];                    %x方向起始和终止的点不具有说服力，直接去除
                
                Diff_Peak_Left_1 = Curve_z(Peak)-Curve_z(Peak-1);  %对于所有的拐点再次计算它们的左导数	
                Diff_Peak_Left_n = Curve_z(Peak)-Curve_z(Peak-8);  %对于所有拐点计算于它们相距稍远的点的左导数
                Diff_Peak_Right_1 = Curve_z(Peak+1)-Curve_z(Peak); %对于所有的拐点再次计算它们的右导数
                Diff_Peak_Right_n = Curve_z(Peak+8)-Curve_z(Peak); %对于所有拐点计算于它们相距稍远的点的右导数                
                
                Peak(find(Diff_Peak_Left_1.*Diff_Peak_Left_n<0 | Diff_Peak_Right_1.*Diff_Peak_Right_n<0 | Diff_Peak_Right_n.*Diff_Peak_Left_n>0))=[];   %去除较小的拐点 
                
                Peak_i=1;
                while Peak_i<=size(Peak,1)
                    Peak_temp = find((Peak<Peak(Peak_i)+10) & (Peak>Peak(Peak_i)-10));  %找出集中在较小的x范围内的拐点
                    Peak_i=Peak_temp(size(Peak_temp,1))+1;                              %循环值移动
                    [Unuse,Peak_temp_max] = max(abs(Curve_z(Peak(Peak_temp))));                 %在这一个范围内的极值
                    Peak(Peak_temp(find(Peak_temp~=Peak_temp(Peak_temp_max))))=0;                  %其余拐点标记为零
                    %Peak(Peak_temp(find(abs(Curve_z(Peak_temp)) ~= max(abs(Curve_z(Peak_temp))))))=0;
                end
                Peak(find(Peak==0)) = [];                                               %去除标记为零的拐点
                
                if (size(Peak,1)>1)
                    
                    Diff_Peak_z = abs(Curve_z(Peak(2:size(Peak,1)))-Curve_z(Peak(1:size(Peak,1)-1))); %计算z方向上的相邻点之间的差距
                    Diff_Peak_z_max = max(Diff_Peak_z);                                               %z方向上差值的最大值
                    Diff_Peak_z_large = find(abs(Diff_Peak_z) >= 0.10*Diff_Peak_z_max);               %所有大于最大值0.1倍的点
                    Peak = Peak(Diff_Peak_z_large(1):Diff_Peak_z_large(size(Diff_Peak_z_large,1))+1); %更新Peak
                    Curve_main_mid_x = round((Peak(size(Peak,1))+Peak(1))/2);
                else
                    Curve_main_mid_x = Peak(1);
                end
                    
                Curve_main_x = 0.00275*(Curve_main_mid_x-1);                     %取中间点的x值
                Curve_main_y = (y_step-1)*0.00275;                                                %y坐标
                Curve_main_z = Curve_z(Curve_main_mid_x);
                
                if (Curve_main_mid_x<64)
                        Curve_main_mid_x =65;
                end
                Curve_mid = [[Curve_main_mid_x-63-1:Curve_main_mid_x+64-1]'*0.00275,Curve_z(Curve_main_mid_x-63:Curve_main_mid_x+64)];
                save([RootPath '\' DiffGuns(i,:) '\' DiffGuns(i,1:2) DiffBullet(j,:) DiffGuns(i,3:length(DiffGuns(i,:))) '\' DiffCuts(k,:)],'Curve_mid','-ascii');
            
            clear Curve_main
        end
    end
end
    
        
    
    
    
    
       


