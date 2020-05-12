% 将海岸线转换为球坐标

% 清空变量空间
clear all
clc

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
imwrite(bb,'a.bmp')
take=imread('a.bmp');
axis([1,2288,1,2288])

image(take);
colormap(gray)
hold on









