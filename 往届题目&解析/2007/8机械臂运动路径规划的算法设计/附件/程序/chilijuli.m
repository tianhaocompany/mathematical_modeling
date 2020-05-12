%该程序通过角度坐标求解出机械臂整体和障碍物（斥力源）之间的距离 
function d=chilijuli(t1,t2,t3,t4,t5,t6,p)

%%-----------------构造障碍物的边界点

%%----------------构造杆的边界点

[cx,cy,cz]=robot3(t1,t2,t3);
[dx,dy,dz]=robot4(t1,t2,t3,t4);
[ex,ey,ez]=robot2(t1,t2,t3,t4,t5,t6);

q=[cx,cy,cz;dx,dy,dz;ex,ey,ez;(cx+dx)/2 (cy+dy)/2 (cz+dz)/2; (ex+dx)/2 (ey+dy)/2 (ez+dz)/2;];
%d=norm([x,y,z]'-o);

d=1000;
for i=1:420
   for j=1:5
      l=norm(q(j,:)-p(i,:));
      if l<d
          d=l;
      end
   end
end
