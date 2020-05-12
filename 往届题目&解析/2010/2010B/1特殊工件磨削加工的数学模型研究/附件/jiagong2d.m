clear;
a=fsolve('(-(3*cos(pi/4+x/100))/(2000*exp(x/400))-(9*sin(pi/4+x/100))/(3200*exp(x/400)))*1000',200);
b=fsolve('(-(3*cos(pi/4+x/100))/(2000*exp(x/400))-(9*sin(pi/4+x/100))/(3200*exp(x/400)))*1000',500);
n=900;
d4=n*1/300;
xa=a:d4:b;
ya=30*exp(-xa/400).*sin(1/100*(xa+25*pi))+130;
j=0;
for i=1:length(xa)
    c(i,:)=fsolve('myfun',380,[],xa(i),ya(i));
    if length(c(i,:))>1
        number(j)=i;
        d(j)=abs(c(1)-c(2))/cos(atan((3*cos(pi/4+c(1)/100))/(10*exp(c(1)/400)) - (3*sin(pi/4+c(1)/100))/(40*exp(c(1)/400))));
        j=j+1;
    end
end
maxd=max(d);
        