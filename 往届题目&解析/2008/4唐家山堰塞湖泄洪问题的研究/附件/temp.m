 h=708:1:743;
 %h=717.92;
 

left_map_x             = 438750
lower_map_y            = 3522960
right_map_x            = 446040
upper_map_y            = 3527280
number_of_rows         = 49
number_of_columns      = 82


 % ²åÖµ
step=0.05;
x=1:number_of_columns ;
y=1:number_of_rows;
[x1,y1]=meshgrid(y,x);
x2=1:step:number_of_columns ;
y2=1:step:number_of_rows;
[x3,y3]=meshgrid(y2,x2);
t11=interp2(x1,y1,data,x3,y3,'cubic');
%surf(x3,y3,t11);

 p=[];
 [yy xx]=size(h);
 data2=t11;
 [row,col]=size(data2);
 scale=abs(left_map_x -right_map_x )*abs(lower_map_y- upper_map_y)/(number_of_rows*number_of_columns);
 for k=1:xx
     pp=0;
 for i=1:row
     for j=1:col
     if data2(i,j)<h(k)
        pp=pp+(h(k)- data2(i,j))*step*step;
     end
    end
 end
 
 pp=pp*scale;%+0.4*10^8;
 p=[p pp];
 end

 
     