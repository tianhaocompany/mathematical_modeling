%互相关度量
clc
master_img=(pc1(50:500,100:400));
slave_img=(pcc1);
rou=zeros(1,4);
[master_img,slave_img]=pingyi_offset_fun(master_img,slave_img);
alfa=sum(sum((master_img.*slave_img).^2))/(sum(sum(master_img.^4))*sum(sum(slave_img.^4)))^0.5;
       if alfa>=0.5
           rou(1)=(2*alfa-1)^0.5;
        else
           rou(1)=0 ;
        end
           
master_img=(pc2(50:500,100:400));
slave_img=(pcc2);
[master_img,slave_img]=pingyi_offset_fun(master_img,slave_img);
alfa=sum(sum((master_img.*slave_img).^2))/(sum(sum(master_img.^4))*sum(sum(slave_img.^4)))^0.5;
       if alfa>=0.5
           rou(2)=(2*alfa-1)^0.5;
        else
           rou(2)=0;
       end
        
master_img=(pc3(50:500,100:400));
slave_img=(pcc3);
[master_img,slave_img]=pingyi_offset_fun(master_img,slave_img);
alfa=sum(sum((master_img.*slave_img).^2))/(sum(sum(master_img.^4))*sum(sum(slave_img.^4)))^0.5;
       if alfa>=0.5
           rou(3)=(2*alfa-1)^0.5;
        else
           rou(3)=0 ;
       end
        
master_img=(pc4(50:500,100:400));
slave_img=(pcc4);
[master_img,slave_img]=pingyi_offset_fun(master_img,slave_img);
alfa=sum(sum((master_img.*slave_img).^2))/(sum(sum(master_img.^4))*sum(sum(slave_img.^4)))^0.5;
         if alfa>=0.5
           rou(4)=(2*alfa-1)^0.5;
        else
           rou(4)=0 ;
         end   
       
        rou=sort(rou);
        rou1=mean(rou(3:4));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        master_img=(pc1(50:500,100:400));
slave_img=(pcc2);
rou=zeros(1,4);
[master_img,slave_img]=pingyi_offset_fun(master_img,slave_img);
alfa=sum(sum((master_img.*slave_img).^2))/(sum(sum(master_img.^4))*sum(sum(slave_img.^4)))^0.5;
       if alfa>=0.5
           rou(1)=(2*alfa-1)^0.5;
        else
           rou(1)=0 ;
        end
           
master_img=(pc2(50:500,100:400));
slave_img=(pcc3);
[master_img,slave_img]=pingyi_offset_fun(master_img,slave_img);
alfa=sum(sum((master_img.*slave_img).^2))/(sum(sum(master_img.^4))*sum(sum(slave_img.^4)))^0.5;
       if alfa>=0.5
           rou(2)=(2*alfa-1)^0.5;
        else
           rou(2)=0;
       end
        
master_img=(pc3(50:500,100:400));
slave_img=(pcc4);
[master_img,slave_img]=pingyi_offset_fun(master_img,slave_img);
alfa=sum(sum((master_img.*slave_img).^2))/(sum(sum(master_img.^4))*sum(sum(slave_img.^4)))^0.5;
       if alfa>=0.5
           rou(3)=(2*alfa-1)^0.5;
        else
           rou(3)=0 ;
       end
        
master_img=(pc4(50:500,100:400));
slave_img=(pcc1);
[master_img,slave_img]=pingyi_offset_fun(master_img,slave_img);
alfa=sum(sum((master_img.*slave_img).^2))/(sum(sum(master_img.^4))*sum(sum(slave_img.^4)))^0.5;
         if alfa>=0.5
           rou(4)=(2*alfa-1)^0.5;
        else
           rou(4)=0 ;
         end   
       
        rou=sort(rou);
        rou2=mean(rou(3:4));
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        master_img=(pc1(50:500,100:400));
slave_img=(pcc3);
rou=zeros(1,4);
[master_img,slave_img]=pingyi_offset_fun(master_img,slave_img);
alfa=sum(sum((master_img.*slave_img).^2))/(sum(sum(master_img.^4))*sum(sum(slave_img.^4)))^0.5;
       if alfa>=0.5
           rou(1)=(2*alfa-1)^0.5;
        else
           rou(1)=0 ;
        end
           
master_img=(pc2(50:500,100:400));
slave_img=(pcc4);
[master_img,slave_img]=pingyi_offset_fun(master_img,slave_img);
alfa=sum(sum((master_img.*slave_img).^2))/(sum(sum(master_img.^4))*sum(sum(slave_img.^4)))^0.5;
       if alfa>=0.5
           rou(2)=(2*alfa-1)^0.5;
        else
           rou(2)=0;
       end
        
master_img=(pc3(50:500,100:400));
slave_img=(pcc1);
[master_img,slave_img]=pingyi_offset_fun(master_img,slave_img);
alfa=sum(sum((master_img.*slave_img).^2))/(sum(sum(master_img.^4))*sum(sum(slave_img.^4)))^0.5;
       if alfa>=0.5
           rou(3)=(2*alfa-1)^0.5;
        else
           rou(3)=0 ;
       end
        
master_img=(pc4(50:500,100:400));
slave_img=(pcc2);
[master_img,slave_img]=pingyi_offset_fun(master_img,slave_img);
alfa=sum(sum((master_img.*slave_img).^2))/(sum(sum(master_img.^4))*sum(sum(slave_img.^4)))^0.5;
         if alfa>=0.5
           rou(4)=(2*alfa-1)^0.5;
        else
           rou(4)=0 ;
         end   
       
        rou=sort(rou);
        rou3=mean(rou(3:4));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        master_img=(pc1(50:500,100:400));
slave_img=(pcc4);
rou=zeros(1,4);
[master_img,slave_img]=pingyi_offset_fun(master_img,slave_img);
alfa=sum(sum((master_img.*slave_img).^2))/(sum(sum(master_img.^4))*sum(sum(slave_img.^4)))^0.5;
       if alfa>=0.5
           rou(1)=(2*alfa-1)^0.5;
        else
           rou(1)=0 ;
        end
           
master_img=(pc2(50:500,100:400));
slave_img=(pcc1);
[master_img,slave_img]=pingyi_offset_fun(master_img,slave_img);
alfa=sum(sum((master_img.*slave_img).^2))/(sum(sum(master_img.^4))*sum(sum(slave_img.^4)))^0.5;
       if alfa>=0.5
           rou(2)=(2*alfa-1)^0.5;
        else
           rou(2)=0;
       end
        
master_img=(pc3(50:500,100:400));
slave_img=(pcc2);
[master_img,slave_img]=pingyi_offset_fun(master_img,slave_img);
alfa=sum(sum((master_img.*slave_img).^2))/(sum(sum(master_img.^4))*sum(sum(slave_img.^4)))^0.5;
       if alfa>=0.5
           rou(3)=(2*alfa-1)^0.5;
        else
           rou(3)=0 ;
       end
        
master_img=(pc4(50:500,100:400));
slave_img=(pcc3);
[master_img,slave_img]=pingyi_offset_fun(master_img,slave_img);
alfa=sum(sum((master_img.*slave_img).^2))/(sum(sum(master_img.^4))*sum(sum(slave_img.^4)))^0.5;
         if alfa>=0.5
           rou(4)=(2*alfa-1)^0.5;
        else
           rou(4)=0 ;
         end   
       
        rou=sort(rou);
        rou4=mean(rou(3:4));
        
        
        roum=[rou1,rou2,rou3,rou4];
        [Y,M] = max(roum);
        M
        