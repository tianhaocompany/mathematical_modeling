%用于求取两幅弹痕的平移误差
%输出平移误差量，以及经过平移处理后的待测数据
% master_img=pc4(50:500,100:400);
% slave_img=pcc4;

master_img=(pc1(50:500,100:400));
slave_img=(pcc1);

im2=master_img;
im1=slave_img;
[y x ] = size(im2);
[y1 x1] = size(im1);

if (x1 <= x) || (y1 <= y)
    errordlg('测试数据应该大于样本数据的维数 ！');
    return
end

c = normxcorr2(im2,im1);
max(abs(c(:)))
[max_c, imax] = max(abs(c(:)));
[ypeak, xpeak] = ind2sub(size(c),imax(1));
corr_offset = [(xpeak-size(im2,2)) (ypeak-size(im2,1))];

offset = corr_offset;
xoffset = offset(1);
yoffset = offset(2);

xbegin = xoffset + 1;
xend   = xoffset + size(im2,2);
ybegin = yoffset + 1;
yend   = yoffset + size(im2,1);

if xend > x1 
    xend = x1;
    master_img = master_img(:,1:(x1-xbegin+1));
end

if yend > y1 
    yend = y1;
    master_img = master_img(1:(y1-ybegin+1),:);
end

if xbegin < 1 
    master_img = master_img(:,(-xbegin+2):end);
    xbegin = 1;
end

if ybegin < 1 
    master_img = master_img((-ybegin+2):end,:);
    ybegin = 1;
end

slave_img = slave_img(ybegin:yend,xbegin:xend);



