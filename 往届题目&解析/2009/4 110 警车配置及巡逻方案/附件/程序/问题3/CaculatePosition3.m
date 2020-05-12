clear;

%大环初始点
X=[216	342
3216	342
6216	342
7407	2151
7407	5151
6366	7110
3366	7110
1261	6036
719	3085];

fposition=[0
3000
6000
9000
12000
15000
18000
21000
24000];

%中环初始点
X2=[3105 2097
    5157 3771];

fposition2=[0
    3726];

%小环初始点
X3=[5607 4356];

fposition3=[0];

%输出文件头
dlmwrite('1025106-Result3.txt','','delimiter', '');
fid = fopen('1025106-Result3.txt', 'at+');
fprintf(fid,'16,m1,m2,...\n');
%dlmwrite('1025106-Result3.txt','16,m1,m2,...','delimiter', '');

%输出零时刻的坐标
fprintf(fid,'0,(216,342),(3216,342),(6216,342),(7407,2151),(7407,5151),(6366,7110),(3366,7110),(1261,6036),(719,3085),(3105,2097),(5157,3771),(5607,4356),(10296,7182),(14040,6840),(9162,4662),(11952,2142)\n');
%dlmwrite('1025106-Result3.txt','0,(216,342),(3216,342),(6216,342),(7407,2151),(7407,5151),(6366,7110),(3366,7110),(1261,6036),(719,3085),(10296,7182),(14040,6840),(4968,4680),(9162,4662),(5166,3780),(11952,2142),(3096,2070)','-append','delimiter', '');

%迭代并输出4小时的坐标
for l=1:240
    
    %输出到文本中
   fprintf(fid,'%.0f,',l);
   
   for m=1:9
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
   
   for m=1:2
       fposition2(m,1)=fposition2(m,1)+333.333;
       fposition2(m,1)=mod(fposition2(m,1),7452);
       if fposition2(m,1)<=2052
           X2(m,1)=fposition2(m,1)+3105;
           X2(m,2)=2097;
       elseif fposition2(m,1)<=3726
           X2(m,1)=5157;
           X2(m,2)=fposition2(m,1)-2052+2097;
       elseif fposition2(m,1)<=5778
           X2(m,1)=8883-fposition2(m,1);
           X2(m,2)=3771;
       else
            X2(m,1)=3105;
            X2(m,2)=3771-fposition2(m,1)+5778;
       end
       fprintf(fid,'(%.0f,%.0f),',X2(m,1),X2(m,2));
   end
   
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
   
   
   fprintf(fid,'(10296,7182),(14040,6840),(9162,4662),(11952,2142)\n');

   
end

fprintf(fid,'End');
fclose(fid);

%STR='('+X(1,1) +','+ X(2,2)+')';
%dlmwrite('1025106-Result3.txt',STR,'-append','delimiter', ' ');

