% 此程序用于将机械臂末端从p3位置达到第4个焊接点p4
clear
jy3_1
o=[255 88 161.363];
epsilon=.2;
t0=[-20.1	29	119.1	-53.7	97.8];%总路径初始值
t1=t0(1); 
t2=t0(2); 
t3=t0(3); 
t4=t0(4); 
t5=t0(5); 
t6=0;
t01=t1;t02=t2;t03=t3;t04=t4;t05=t5;t06=0; %末端初始位置
xyz0=[190.0321	-124.8086	81.9822];
x=xyz0(1);
y=xyz0(2);
z=xyz0(3);
dyin=[];
dchi=[];
for k=1:150
    k
[s1,s2,s3,s4,s5]=step_rules(yinlijuli(t01,t02,t03,t04,t05,t06,o));
field0=0;
for td1=s1
 for td2=s2
  for td3=s3
   for td4=s4
    for td5=s5
         field1=field(td1+t01,td2+t02,td3+t03,td4+t04,td5+t05,0,o,p);
      if field1>field0;
          field0=field1;
          d1=td1;
          d2=td2;
          d3=td3;
          d4=td4;
          d5=td5;
              
      end
    end
   end
  end
 end
end
          t01=t01+d1;
          t02=t02+d2;
          t03=t03+d3;
          t04=t04+d4;
          t05=t05+d5;
          t1=[t1 t01];
          t2=[t2 t02];
          t3=[t3 t03];
          t4=[t4 t04];
          t5=[t5 t05];
          t6=[t6 0];
[xd,yd,zd]=robot2(t01,t02,t03,t04,t05,0);
dc=chilijuli(t01,t02,t03,t04,t05,0,p)
x=[x,xd];
y=[y,yd];
z=[z,zd];
d=norm([xd,yd,zd]-o)
dyin=[dyin d];
dchi=[dchi dc];
if d<epsilon
 break
end

end
tt=[t1' t2' t3' t4' t5' t6']
xyz=[x' y' z']


