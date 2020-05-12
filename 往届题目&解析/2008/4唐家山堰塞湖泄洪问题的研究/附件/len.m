arrive= [475 50 
 231 9  
 45 354 
 427 311 
 427 314 
 221 308 
 300 337 
 ]; 

kk=zeros(1,2);
kk(1)=484;
kk(2)=34;

left_map_x             = 443340
lower_map_y            = 3480030
right_map_x            = 476820
upper_map_y            = 3527460
number_of_rows         = 528
number_of_columns      = 373
scale=abs(left_map_x -right_map_x )*abs(lower_map_y- upper_map_y)/(number_of_rows*number_of_columns);

p=[]
for i=1:7
    pp=sqrt(((arrive(i,1)-kk(1))^2+(arrive(i,2)-kk(2))^2)*scale);
    p=[p;pp];
end
    