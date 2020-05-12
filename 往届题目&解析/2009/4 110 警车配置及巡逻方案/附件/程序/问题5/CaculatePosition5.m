clear;

fposition1=0;%Line1初始点
fposition2=0;%Line2初始点
fposition3=0;%Line3初始点
fposition4=0;%Line4初始点
fposition5=0;%Line5初始点
fposition6=0;%Line6初始点
fposition7=0;%Line7初始点
fposition8=0;%Other初始点


%输出文件头
dlmwrite('1025106-Result5.txt','','delimiter', '');
fid = fopen('1025106-Result5.txt', 'at+');
fprintf(fid,'10,m1,m2,...\n');
%dlmwrite('1025106-Result3.txt','16,m1,m2,...','delimiter', '');

%输出零时刻的坐标
fprintf(fid,'0,(9180,4074),(7434,1368),(5607,4356),(5616,7110),(1236,5814),(432,2061),(9162,6993),(6012,2214),(11952,2142),(4104,2916)\n');

%迭代并输出4小时的坐标
for l=1:240
    
    %输出到文本中
   fprintf(fid,'%.0f,',l);
   
   m=1;
       fposition1(m,1)=fposition1(m,1)+333.333;
       fposition1(m,1)=mod(fposition1(m,1),3672);
       if fposition1(m,1)<=702
           X1(m,1)=fposition1(m,1)+9180;
           X1(m,2)=4074;
       elseif fposition1(m,1)<=2538
           X1(m,1)=9882+702-fposition1(m,1);
           X1(m,2)=4074;
       else
           X1(m,1)=8046+fposition1(m,1)-2538;
           X1(m,2)=4074;
       end
       fprintf(fid,'(%.0f,%.0f),',X1(m,1),X1(m,2));
    
       
    m=1;
       fposition2(m,1)=fposition2(m,1)+333.333;
       fposition2(m,1)=mod(fposition2(m,1),4212);
       if fposition2(m,1)<=1008      
           X2(m,1)=7434;
           X2(m,2)=fposition2(m,1)+1368;
       elseif fposition2(m,1)<=3114
           X2(m,1)=7434;
           X2(m,2)=2376+1008-fposition2(m,1);           
       else           
           X2(m,1)=7434;
           X2(m,2)=270+fposition2(m,1)-3114;
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
       fposition4(m,1)=mod(fposition4(m,1),3672);
       if fposition4(m,1)<=864
           X4(m,1)=fposition4(m,1)+5616;
           X4(m,2)=7110;
       elseif fposition4(m,1)<=2700
           X4(m,1)=6480+864-fposition4(m,1);
           X4(m,2)=7110;
       else
           X4(m,1)=4644+fposition4(m,1)-2700;
           X4(m,2)=7110;
       end
       fprintf(fid,'(%.0f,%.0f),',X4(m,1),X4(m,2));
       
    m=1;
       fposition5(m,1)=fposition5(m,1)+333.333;
       fposition5(m,1)=mod(fposition5(m,1),3564);
       if fposition5(m,1)<=1170      
           X5(m,1)=1236;
           X5(m,2)=fposition5(m,1)+5814;
       elseif fposition5(m,1)<=2952
           X5(m,1)=1236;
           X5(m,2)=6984+1170-fposition5(m,1);           
       else           
           X5(m,1)=1236;
           X5(m,2)=5202+fposition5(m,1)-2952;
       end
       fprintf(fid,'(%.0f,%.0f),',X5(m,1),X5(m,2));
       
    m=1;
       fposition6(m,1)=fposition6(m,1)+333.333;
       fposition6(m,1)=mod(fposition6(m,1),2484);
       if fposition6(m,1)<=1242
           X6(m,1)=fposition6(m,1)+432;
           X6(m,2)=2061;
       else
           X6(m,1)=1674+1242-fposition6(m,1);
           X6(m,2)=2061;
       end
       fprintf(fid,'(%.0f,%.0f),',X6(m,1),X6(m,2));
       
    m=1;
       fposition7(m,1)=fposition7(m,1)+333.333;
       fposition7(m,1)=mod(fposition7(m,1),9756);
       if fposition7(m,1)<=4878
           X7(m,1)=fposition7(m,1)+9162;
           X7(m,2)=6993;
       else
           X7(m,1)=14040+4878-fposition7(m,1);
           X7(m,2)=6993;
       end
       fprintf(fid,'(%.0f,%.0f),',X7(m,1),X7(m,2));
       
   
   fprintf(fid,'(6012,2214),(11952,2142),(4104,2916)\n');

   
end

fprintf(fid,'End');
fclose(fid);

%STR='('+X(1,1) +','+ X(2,2)+')';
%dlmwrite('1025106-Result3.txt',STR,'-append','delimiter', ' ');

