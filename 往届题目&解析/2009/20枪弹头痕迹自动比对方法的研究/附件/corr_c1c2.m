function [rou]=corr_c1c2(imgdata,imgdata1)
%用于计算相关系数
[mm,nn]=size(imgdata);
rou=zeros(mm,nn);
for m=1:mm
    for n=1: nn
        time0=abs(imgdata(max(m-5,1):min(m+5,mm),max(n-5,1):min(n+5,nn)));
        time1=abs(imgdata1(max(m-5,1):min(m+5,mm),max(n-5,1):min(n+5,nn)));
        alfa=sum(sum((time0.*time1).^2))/(sum(sum(time0.^4))*sum(sum(time1.^4)))^0.5;
        if alfa>=0.5
           rou(m,n)=(2*alfa-1)^0.5;
        else
           rou(m,n)=0;  
        end
    end
end
mean(rou(:))
figure;
imagesc(rou)
colormap(gray)