function test=if_reachable(d,e)

test=1;

p1=(e+d)/2;
p2=(p1+e)/2;
p3=(p1+d)/2

if if_inside(d)==1 | if_inside(p1)==1 | if_inside(p2)==1 | if_inside(p3)==1 
   test=0;
end