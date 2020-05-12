clc
clear

        
load  'E:\数模2009\数模2009\bdata\B题－第三问数据\6x2次棱数据\77t2-1812492\c1.dat' ;
load  'E:\数模2009\数模2009\bdata\B题－第三问数据\6x2次棱数据\77t2-1812492\c2.dat' ;
load  'E:\数模2009\数模2009\bdata\B题－第三问数据\6x2次棱数据\77t2-1812492\c3.dat' ;
load  'E:\数模2009\数模2009\bdata\B题－第三问数据\6x2次棱数据\77t2-1812492\c4.dat' ;

c1=reshape(c1(:,3),564,756);
c2=reshape(c2(:,3),564,756);
c3=reshape(c3(:,3),564,756);
c4=reshape(c4(:,3),564,756);

cc1=c1;
cc2=c2;
cc3=c3;
cc4=c4;

load  'E:\数模2009\数模2009\bdata\B题－第三问数据\6x2次棱数据\77t1-1812492\c1.dat' ;
load  'E:\数模2009\数模2009\bdata\B题－第三问数据\6x2次棱数据\77t1-1812492\c2.dat' ;
load  'E:\数模2009\数模2009\bdata\B题－第三问数据\6x2次棱数据\77t1-1812492\c3.dat' ;
load  'E:\数模2009\数模2009\bdata\B题－第三问数据\6x2次棱数据\77t1-1812492\c4.dat' ;

c1=reshape(c1(:,3),564,756);
c2=reshape(c2(:,3),564,756);
c3=reshape(c3(:,3),564,756);
c4=reshape(c4(:,3),564,756);

[pc1] = pol_fit(c1(:,150:600));
[pc2] = pol_fit(c2(:,150:600));
[pc3] = pol_fit(c3(:,150:600));
[pc4] = pol_fit(c4(:,150:600));

[pcc1] = pol_fit(cc1(:,150:600));
[pcc2] = pol_fit(cc2(:,150:600));
[pcc3] = pol_fit(cc3(:,150:600));
[pcc4] = pol_fit(cc4(:,150:600));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
        roum
        max_roum=max(roum)
        M
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if M == 1
[master_img1,slave_img1]=pingyi_offset_fun(pc1(50:500,100:400),pcc1);
[master_img2,slave_img2]=pingyi_offset_fun(pc2(50:500,100:400),pcc2);
[master_img3,slave_img3]=pingyi_offset_fun(pc3(50:500,100:400),pcc3);
[master_img4,slave_img4]=pingyi_offset_fun(pc4(50:500,100:400),pcc4);
de1=master_img1-slave_img1;
thegma1=std(reshape(de1,1,[]));
de2=master_img2-slave_img2;
thegma2=std(reshape(de2,1,[]));
de3=master_img3-slave_img3;
thegma3=std(reshape(de3,1,[]));
de4=master_img4-slave_img4;
thegma4=std(reshape(de4,1,[]));
thega=[thegma1,thegma2,thegma3,thegma4];
thega=sort(thega);
thega=thega(3)+thega(4)
end


if M == 2
[master_img1,slave_img1]=pingyi_offset_fun(pc1(50:500,100:400),pcc2);
[master_img2,slave_img2]=pingyi_offset_fun(pc2(50:500,100:400),pcc3);
[master_img3,slave_img3]=pingyi_offset_fun(pc3(50:500,100:400),pcc4);
[master_img4,slave_img4]=pingyi_offset_fun(pc4(50:500,100:400),pcc1);
de1=master_img1-slave_img1;
thegma1=std(reshape(de1,1,[]));
de2=master_img2-slave_img2;
thegma2=std(reshape(de2,1,[]));
de3=master_img3-slave_img3;
thegma3=std(reshape(de3,1,[]));
de4=master_img4-slave_img4;
thegma4=std(reshape(de4,1,[]));
thega=[thegma1,thegma2,thegma3,thegma4];
thega=sort(thega);
thega=thega(3)+thega(4)

end


if M == 3
[master_img1,slave_img1]=pingyi_offset_fun(pc1(50:500,100:400),pcc3);
[master_img2,slave_img2]=pingyi_offset_fun(pc2(50:500,100:400),pcc4);
[master_img3,slave_img3]=pingyi_offset_fun(pc3(50:500,100:400),pcc1);
[master_img4,slave_img4]=pingyi_offset_fun(pc4(50:500,100:400),pcc2);
de1=master_img1-slave_img1;
thegma1=std(reshape(de1,1,[]));
de2=master_img2-slave_img2;
thegma2=std(reshape(de2,1,[]));
de3=master_img3-slave_img3;
thegma3=std(reshape(de3,1,[]));
de4=master_img4-slave_img4;
thegma4=std(reshape(de4,1,[]));
thega=[thegma1,thegma2,thegma3,thegma4];
thega=sort(thega);
thega=thega(3)+thega(4)

end


if M == 4

[master_img1,slave_img1]=pingyi_offset_fun(pc1(50:500,100:400),pcc4);
[master_img2,slave_img2]=pingyi_offset_fun(pc2(50:500,100:400),pcc1);
[master_img3,slave_img3]=pingyi_offset_fun(pc3(50:500,100:400),pcc2);
[master_img4,slave_img4]=pingyi_offset_fun(pc4(50:500,100:400),pcc3);
de1=master_img1-slave_img1;
thegma1=std(reshape(de1,1,[]));
de2=master_img2-slave_img2;
thegma2=std(reshape(de2,1,[]));
de3=master_img3-slave_img3;
thegma3=std(reshape(de3,1,[]));
de4=master_img4-slave_img4;
thegma4=std(reshape(de4,1,[]));
thega=[thegma1,thegma2,thegma3,thegma4];
thega=sort(thega);
thega=thega(3)+thega(4)

end

