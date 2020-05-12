aa=load( 'IR1_2100.mat')
H=42164000;
a=6378136.5;
b=6378136.5;
c=6356751.8;
x=0;y=0;z=0;
lat=zeros(2288,2288);
lon=zeros(2288,2288);
for i=1:1145
    for j=1:1145
    if aa.bb(i,j)~=-1     
    p=0.00014*(1145-i);
    q=0.00014*(1145-j);
if j~=1145 
    m=-sqrt((1-tan(q)^2*tan(p)^2)/(tan(q)^2*tan(p)^2+tan(q)^2));
    n=tan(p)*sqrt((1-tan(q)^2*tan(p)^2)/(tan(q)^2*tan(p)^2+tan(q)^2)+1);
    temp1=1/(m^2*a^2)+n^2/(m^2*c^2)+1/b^2;
    temp2=-2*H*(1/(m^2*a^2)+n^2/(m^2*c^2));
    temp3=H^2*(1/(m^2*a^2)+n^2/(m^2*c^2))-1;
    if temp2^2-4*temp1*temp3>0
        y=(-temp2+sqrt(temp2^2-4*temp1*temp3))/(2*temp1);
        x=(y-H)/m;
        z=x*n;
        f=x^2/(6378136.5^2)+y^2/(6378136.5^2)+z^2/(6356751.8^2);
    else
        x= 99999999;
        y= 99999999;
        z= 99999999;
    end
else
    t1=c^2+a^2*tan(p)^2;
    t2=-2*H*a^2*tan(p)^2;
    t3=a^2*tan(p)^2*H^2-a^2*c^2;
    if t2^2-4*t1*t3>0
        y=(-t2+sqrt(t2^2-4*t1*t3))/(2*t1);
        z=(H-y)*tan(p);
        x=0;
    else
        x= 99999999;
        y= 99999999;
        z= 99999999;
    end
end
   
   
    end
    lat(i,j)=atan(z/(sqrt(x^2+y^2)));
    lat(i,j)=lat(i,j)*180/pi;
    lat(i,2290-j)=lat(i,j);
    lat(2290-i,j)=-lat(i,j);
    lat(2290-i,2290-j)=-lat(i,j);
    lon(i,j)=atan(x/y);
    lon(i,j)=86.5-lon(i,j)*180/pi;%到不了西经，没有区分东西经
    lon(i,2290-j)=86.5+(86.5-lon(i,j)); 
    lon(2290-i,j)= lon(i,j);
    lon(2290-i,2290-j)=86.5+(86.5-lon(i,j)); 
    end
end
