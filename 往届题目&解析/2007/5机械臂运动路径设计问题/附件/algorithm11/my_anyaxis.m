function RotateM=my_anyaxis(r,sita,Cen_point)
RotateM=[r(1)^2*(1-cos(sita))+cos(sita)           r(1)*r(2)*(1-cos(sita))-r(3)*sin(sita)      r(1)*r(3)*(1-cos(sita))+r(2)*sin(sita)   Cen_point(1)
         r(1)*r(2)*(1-cos(sita))+r(3)*sin(sita)   r(2)^2*(1-cos(sita))+cos(sita)              r(2)*r(3)*(1-cos(sita))-r(1)*sin(sita)   Cen_point(2)
         r(1)*r(3)*(1-cos(sita))-r(2)*sin(sita)   r(2)*r(3)*(1-cos(sita))+r(1)*sin(sita)      r(3)^2*(1-cos(sita))+cos(sita)           Cen_point(3)
         0                                        0                                           0                                        1            ];       