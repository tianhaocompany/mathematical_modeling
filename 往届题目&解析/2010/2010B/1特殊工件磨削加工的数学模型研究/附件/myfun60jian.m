function f=myfun60jian(x,xa,ya)
p=tan(atan(-1/((3*cos(pi/4+xa/100))/(10*exp(xa/400))-(3*sin(pi/4+xa/100))/(40*exp(xa/400)))-pi/3));
f=p*(x-xa)+ya-(30*exp(-x/400)*sin(1/100*(x+25*pi))+130);