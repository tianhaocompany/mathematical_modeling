%通过灰度矩阵计算出投影到经纬度坐标平面的温度矩阵wendu1
wendu1=zeros(1801,1801);
for i=1:1801
    for j=1:1801
        a=touyingbb(i,j);
        if ((a+1)/8)~=floor((a+1)/8)
            p=floor((a+1)/8)+1;
            q=mod((a+1),8);      
        else
            p=(a+1)/8;
            q=8;
        end
        wendu1(i,j)=duizhao(p,q);%对照矩阵即k_temp.txt，读入duizhao数组
    end
end