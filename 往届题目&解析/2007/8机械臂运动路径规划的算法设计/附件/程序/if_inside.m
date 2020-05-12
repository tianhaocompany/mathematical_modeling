function test=if_inside(p)
l=0;
test=0;
if p(3)>=0 & p(3)<=180+l & (p(1)-210)^2+p(2)^2<=4/25*(420-p(3))^2
    test=1;
 end