%RootPath = 'E:\Modeling\4';
RootPath = 'E:\Modeling\Data\B_Data_1\6_2';

DiffGuns = ['77-1203959',
            '77-1504519',
            '77-1811345',
            '77-1812492',
            '77-1923252',
            '77-1928033'];

%{
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
%}
%{
for i=1:6
    for j = 1:2
        for k = 1:4         
            CurrentPath = [RootPath '\' DiffGuns(i,:) '\' DiffGuns(i,1:2) 'T' int2str(j) DiffGuns(i,3:10)];        
            Curve = load([CurrentPath '\' 'c' int2str(k) '.dat']);
            Curve_y_mid = Curve(find(Curve(:,2) == round(378*0.00275*100000)/100000),3);
            plot(Curve_y_mid);
            saveas(gcf,[CurrentPath '\' 'c' int2str(k) '.fig']);
        end
    end
end
%}

%{

All=[220,254,192,210;
     244,190,244,254;
     253,199,262,238;
     254,248,243,249;
     232,234,250,236;
     246,163,255,255;
     254,260,258,258;
     253,249,247,258;
     259,208,246,246;
     131,248,248,240;
     223,260,253,137;
     257,249,246,254;
     258,255,262,256;
     240,256,254,258;
     258,253,248,256;
     259,253,256,247;
     255,246,254,204;
     263,192,254,216;
     250,256,211,256;
     256,198,256,253;
     246,239,247,160;
     258,245,249,252];
%}
All=[244,195,252,253;
     246,163,255,255;
     272,240,230,238;
     216,186,254,216;
     253,270,264,264;
     258,253,262,256;
     239,252,258,259;
     250,255,210,158;
     257,254,250,252;
     260,134,248,246;
     254,247,242,249;
     246,239,247,160];

for i=1:6
    for j=1:2
        for k=1:4
            CurrentPath = [RootPath '\' DiffGuns(i,:) '\' DiffGuns(i,1:2) 'T' int2str(j) DiffGuns(i,3:10)];       
            Curve = load([CurrentPath '\' 'c' int2str(k) '.dat']);
            c1_1_z = 0;
            for y=196:204
                c1_1_temp=[Curve(find(Curve(:,2)==round((y-1)*0.00275*100000)/100000),1),Curve(find(Curve(:,2)==round(((y-1)*0.00275)*100000)/100000),3)]';
                c1_1 = c1_1_temp(:,(All(i,j)-119):(All(i,j)+30));
                c1_1_z=c1_1_z+c1_1(2,:);
            end  
            c1_1(2,:)=c1_1_z./9;
        
            c1_2_z = 0;
            for y=396:404
                c1_2_temp=[Curve(find(Curve(:,2)==round((y-1)*0.00275*100000)/100000),1),Curve(find(Curve(:,2)==round(((y-1)*0.00275)*100000)/100000),3)]';
                c1_2 = c1_2_temp(:,(All(i*j,k)-119):(All(i*j,k)+30));
                c1_2_z=c1_2_z+c1_2(2,:);
            end  
            c1_2(2,:)=c1_2_z./9;
        
            c1_3_z = 0;
            for y=596:604
                c1_3_temp=[Curve(find(Curve(:,2)==round((y-1)*0.00275*100000)/100000),1),Curve(find(Curve(:,2)==round(((y-1)*0.00275)*100000)/100000),3)]';
                c1_3 = c1_3_temp(:,(All(i*j,k)-119):(All(i*j,k)+30));
                c1_3_z=c1_3_z+c1_3(2,:);
            end  
            c1_3(2,:)=c1_3_z./9;
        
            save([CurrentPath '\' 'c' int2str(k) '_1.dat'], 'c1_1','-ascii');
            save([CurrentPath '\' 'c' int2str(k) '_2.dat'], 'c1_2','-ascii');
            save([CurrentPath '\' 'c' int2str(k) '_3.dat'], 'c1_3','-ascii');
        end
    end
end      
        