H=[]; 
V=[];
Hzh=[];
a=[21.5 16.5 0 2 5 0 0 0 1 0 0 3 27 2 0 0 4 3 0 ];

 h=717.92;
%v0=51167*h^2-6.9662*10^7*h+2.3708*10^10+0.3*10^8;
v0=62215*h^2-8.5068*10^7*h+2.9107*10^10;

 
 %积水面积
 S=2867.83;
 p=0.5;
 [x,y]=size(a);
 v=v0;
 curh=h;
 for i=1:y
 %增加的水量
 Vzh=S*10^6*a(i)*0.001*p;
 newV=Vzh+v;
 %newh=-5.1662*10^(-16)*newV^2+3.7352*10^(-7)*newV+683.16;
 helpv=newV/100000000;
 newh=-3.7630*helpv^2-30.3729*helpv+690.65;
 hzn=newh-curh;
 V=[V newV];
 H=[H newh];
 Hzh=[Hzh hzn];
 curh=newh;
 v=newV;
 end
 
 
 
 
 
 
 



 
     