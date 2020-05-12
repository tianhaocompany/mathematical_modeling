
% 区域节点遍历算法
function bsf(xx,yy,num,r)
global s;
global e;
global x;
global y;
  for i=1:458 
     if  s(i)==num
           j=e(i);
           l=sqrt((y(j)-yy)^2+(x(j)-xx)^2) ;
         if l<r %判断路径长度是否小于标准
              N=j
             bsf(x(j),y(j),j,r-l);%递归调用
         else
           s(i);  %输出邻接点
           X=x(s(i)) %输出邻接点x坐标
           Y=y(s(i)) %输出邻接点y坐标
        end
     end  
  end