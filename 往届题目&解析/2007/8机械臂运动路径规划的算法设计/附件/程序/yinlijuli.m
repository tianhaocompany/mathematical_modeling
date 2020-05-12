%该程序通过角度坐标求解出机械臂末端和目标（引力源）之间的距离 
function d=yinlijuli(t1,t2,t3,t4,t5,t6,o)
[x,y,z]=robot2(t1,t2,t3,t4,t5,t6);
d=norm([x,y,z]-o);



