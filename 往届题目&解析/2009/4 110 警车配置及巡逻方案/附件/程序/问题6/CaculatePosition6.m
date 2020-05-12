clear;

fposition=[0
3827
7654
11481
15308
19135
22962];

fposition2=0;
fposition3=0;
fposition4=0;

%输出文件头
dlmwrite('1025106-Result6.txt','','delimiter', '');
fid = fopen('1025106-Result6.txt', 'at+');
fprintf(fid,'12,m1,m2,...\n');
%dlmwrite('1025106-Result3.txt','16,m1,m2,...','delimiter', '');

%输出零时刻的坐标
fprintf(fid,'0,(216,342),(4043,342),(7407,805),(7407,4632),(6058,7110),(2231,7110),(907,4106),(5031,2529),(5607,4356),(9990,5256),(11574,7164),(11952,2142)\n');


%迭代并输出4小时的坐标
for l=1:240
    
    %输出到文本中
   fprintf(fid,'%.0f,',l);
   
   for m=1:7
       fposition(m,1)=fposition(m,1)+333.333;
       fposition(m,1)=mod(fposition(m,1),26789);
       if fposition(m,1)<=7179
           X(m,1)=fposition(m,1)+216;
           X(m,2)=342;
       elseif fposition(m,1)<=13959
           X(m,1)=7407;
           X(m,2)=fposition(m,1)-7191+342;
       elseif fposition(m,1)<=19908
           X(m,1)=21366-fposition(m,1);
           X(m,2)=7110;
       else
            X(m,1)=1458-1242*(fposition(m,1)-19908)/6881;
            X(m,2)=7110-6768*(fposition(m,1)-19908)/6881;
       end
        fprintf(fid,'(%.0f,%.0f),',X(m,1),X(m,2));
   end
   
   m=1;
       fposition2(m,1)=fposition2(m,1)+333.333;
       fposition2(m,1)=mod(fposition2(m,1),5670);
       if fposition2(m,1)<=396
           X2(m,1)=5031;
           X2(m,2)=2529+fposition2(m,1);
       elseif fposition2(m,1)<=531
           X2(m,1)=fposition2(m,1)-396+5031;
           X2(m,2)=2925;
       elseif fposition2(m,1)<=954
           X2(m,1)=5166;
           X2(m,2)=fposition2(m,1)-531+2925;
       elseif fposition2(m,1)<=2970
           X2(m,1)=5166+954-fposition2(m,1);
           X2(m,2)=3348;
       elseif fposition2(m,1)<=3789
           X2(m,1)=3150;
           X2(m,2)=3348+2970-fposition2(m,1);
       else
            X2(m,1)=3150+fposition2(m,1)-3789;
            X2(m,2)=2529;
       end
       fprintf(fid,'(%.0f,%.0f),',X2(m,1),X2(m,2));
       
       
   m=1;
       fposition3(m,1)=fposition3(m,1)+333.333;
       fposition3(m,1)=mod(fposition3(m,1),3600);
       if fposition3(m,1)<=846
           X3(m,1)=5607;
           X3(m,2)=fposition3(m,1)+4356;
       elseif fposition3(m,1)<=1800
           X3(m,1)=5607-fposition3(m,1)+846;
           X3(m,2)=5202;
       elseif fposition3(m,1)<=2646
           X3(m,1)=4653;
           X3(m,2)=5202-fposition3(m,1)+1800;
       else
            X3(m,1)=4653+fposition3(m,1)-2646;
            X3(m,2)=4356;
       end
       fprintf(fid,'(%.0f,%.0f),',X3(m,1),X3(m,2));
       
   m=1;
       fposition4(m,1)=fposition4(m,1)+333.333;
       fposition4(m,1)=mod(fposition4(m,1),3294);
       if fposition4(m,1)<=837
           X4(m,1)=9990;
           X4(m,2)=5256-fposition4(m,1);
       elseif fposition4(m,1)<=1647
           X4(m,1)=9990-fposition4(m,1)+837;
           X4(m,2)=4419;
       elseif fposition4(m,1)<=2484
           X4(m,1)=9180;
           X4(m,2)=fposition4(m,1)-1647+4419;
       else
            X4(m,1)=fposition4(m,1)-2484+9180;
            X4(m,2)=5256;
       end
       fprintf(fid,'(%.0f,%.0f),',X4(m,1),X4(m,2));
   
   fprintf(fid,'(11574,7164),(11952,2142)\n');

   
end

fprintf(fid,'End');
fclose(fid);


