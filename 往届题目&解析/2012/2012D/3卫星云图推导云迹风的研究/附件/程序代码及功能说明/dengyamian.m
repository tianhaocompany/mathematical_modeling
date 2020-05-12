%由温度矩阵、temp3.mat求各非零风矢所在等压面
minwdc=ones(81,81);
minwdc=1000*minwdc;
ceng=zeros(81,81);%所在压强层
yq=zeros(81,81);%对应等压面（压强值）
wenmean=zeros(81,81);
for i=1:81
    for j=1:81
        if V(i,j)~=0
            weidu=i-41;
            jingdu=j+45;
            p=(45-weidu)*20+1;%对应wendu1中行号
            q=(jingdu-40)*20+1;%对应wendu1中列号   
            a=zeros(1,256);
            for ii=1:16
               for jj=1:16
                  a(16*(ii-1)+jj)=wendu1(p-7+ii,q-7+jj);
               end
            end
           [n,x]=hist(a,10);%n存频数，x存每个段的中间值
            [maxn,nn]=max(n);
            frequecy=n/256;
            for kk=1:10
                wenmean(i,j)=wenmean(i,j)+frequecy(kk)*x(kk);
            end 
            pp=round(641*(90-weidu)/180);%对应t中x轴
            qq=round(1280*jingdu/360);%对应t中y轴
            for ii=1:36
                wdc=abs(wenmean(i,j)-t(pp,qq,ii))%t为temp3.mat
                if wdc<minwdc(i,j)
                    minwdc(i,j)=wdc;
                    ceng(i,j)=ii;
                end
            end
        end
    end
end
for i=1:81
    for j=1:81
        if ceng(i,j)~=0
        yq(i,j)=yaqiang(1,ceng(i,j));%yaqiang为各层对应压强值
        end
    end
end
        