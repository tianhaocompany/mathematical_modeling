clear all
clc


figure
load IR1_2030.mat
for i=1:max(size(aa))
    for j=1:max(size(aa))
        if aa(i,j)<0
            aa(i,j)=1;
        else
            aa(i,j)=aa(i,j)/1024;
        end
    end
end
imshow(aa)



figure
load IR1_2100.mat
for i=1:max(size(bb))
    for j=1:max(size(bb))
        if bb(i,j)<0
            bb(i,j)=1;
        else
            bb(i,j)=bb(i,j)/1024;
        end
    end
end
imshow(bb)



figure
load IR1_2130.mat
for i=1:max(size(cc))
    for j=1:max(size(cc))
        if cc(i,j)<0
            cc(i,j)=1;
        else
            cc(i,j)=cc(i,j)/1024;
        end
    end
end
imshow(cc)















