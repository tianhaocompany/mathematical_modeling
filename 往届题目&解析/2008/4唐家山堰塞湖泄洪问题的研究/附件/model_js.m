H=[]; 
V=[];
Hzh=[];
a=[21.5 16.5 0 2 5 0 0 0 1 0 0 3 27 2 0 0 4 3 0 ];
 
left_map_x             = 438750
lower_map_y            = 3522960
right_map_x            = 446040
upper_map_y            = 3527280
number_of_rows         = 49
number_of_columns      = 82

step=0.05;
x=1:number_of_columns ;
y=1:number_of_rows;
[x1,y1]=meshgrid(y,x);
x2=1:step:number_of_columns ;
y2=1:step:number_of_rows;
[x3,y3]=meshgrid(y2,x2);
t11=interp2(x1,y1,data,x3,y3,'cubic');
 
 data2=t11;
 [row,col]=size(data2);
 scale=abs(left_map_x -right_map_x )*abs(lower_map_y- upper_map_y)/(number_of_rows*number_of_columns);

 h=717.92;
 %v0=51167*h^2-6.9662*10^7*h+2.3708*10^10+0.3*10^8;
 %v0=62215*h^2-8.5068*10^7*h+2.9107*10^10;
 
 %积水面积
 S=2867.83;
 p=0.5;
 [x,y]=size(a);
 v=0;
 for i=1:row
     for j=1:col
      if data2(i,j)<h
         v=v+(h- data2(i,j))*step*step; 
      end
     end
 end 
 v=v*scale*(2.831/1.18);
 curh=h;
 
 
 for i=1:y
 %增加的水量
 Vzh=S*10^6*a(i)*0.001*p;
 newV=Vzh+v;
 %newh=-5.1662*10^(-16)*newV^2+3.7352*10^(-7)*newV+683.16;
 pp=0;
 for hh=h+0.1:0.1:770.1     
   pp=0;
    for i=1:row
     for j=1:col
      if data2(i,j)<hh
         pp=pp+(hh- data2(i,j))*step*step; 
      end
     end
    end 
    
    pp=pp*scale*(2.831/1.18);
    if pp>=newV        
        newh=hh;
        break;
    end
 end

 
 
 hzn=newh-curh;
 V=[V newV];
 H=[H newh];
 Hzh=[Hzh hzn];
 curh=newh;
 v=newV;
 end