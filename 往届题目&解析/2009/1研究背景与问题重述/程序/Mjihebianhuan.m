clear
%% 几何变化，使得平面对x偏导和y偏导接近于零
load datac1.mat  %datac1.mat为包含c1原始数据的文件
data0=c1;

das=size(data0,1);
da4=1:size(data0,1);
data=[data0 da4'];
z=zeros(564,756);
x=data(1:564,1);     %构造564*765的图形矩阵
y=data(1:564:das-563,2);
num=zeros(das,1);
for i=1:564
    za=find(data(:,1)==x(i));
    zdata=data(za,:);
    for j=1:756
        num((i-1)*756+j)=zdata(find(zdata(:,2)==y(j)),4);
        z(i,j)=data(num((i-1)*756+j),3);
     end
end

G=csapi({x,y},z);  %样条函数拟合

resxy=[];resi=0;
Ndata=data0;

ii=100:100:600;
ansx=fnval(G,{x,y(ii)});
resx=mean(std(ansx,1),2);
ii=50:50:250;
ansy=fnval(G,{x(ii),y});
resy=mean(std(ansy,1),2);


resi=resi+1;
    resxy(resi,1)=resx;
    resxy(resi,2)=resy;
    resxy(resi,3)=0;
     resxy(resi,4)=0;

%%

for x1=(-1:.4:1)*.2*pi/180           %x1为绕x轴旋转的角度，x2，为绕轴旋转角度   
    for x2=(-1:.4:1)*.2*pi/180

                                   %平面旋转
Ndata=[data0(:,1:3) ones(das,1)]*[1 0 0 0;0 cos(x1) sin(x1) 0;0 -sin(x1) cos(x1) 0;0 0 0 1]...
    *[cos(x2) 0 sin(x2) 0;0 1 0 0;-sin(x2) 0 cos(x2) 0;0 0 0 1];

x=Ndata(1:564,1);
y=Ndata(1:564:das-563,2);


for i=1:564
        for j=1:756
          z(i,j)=Ndata(num((i-1)*756+j),3);
        end
end

G=csaps({x,y},z,0.998);%0.999998

ii=100:10:160;
ansx=fnval(G,{x(ii),y(150)});
resx1=mean(ansx);
ii=400:10:460;
ansx=fnval(G,{x(ii),y(150)});
resx2=mean(ansx);
resx=abs((resx2-resx1)/(x(430)-x(130)));

ii=50:10:90;
ansy=fnval(G,{x(200),y(ii)});
resy1=mean(ansy);
ii=230:10:270;
ansy=fnval(G,{x(200),y(ii)});
resy2=mean(ansy);
resy=abs((resy2-resy1)/(y(250)-y(70)));


resi=resi+1;
    resxy(resi,1)=resx;
    resxy(resi,2)=resy;
    resxy(resi,3)=x1;
     resxy(resi,4)=x2;


    end
end




res00=sqrt(resxy(:,1).^2+resxy(:,2).^2);
aa0=find(res00(:,1)==min(res00(2:end,1)))
res001=resxy(aa0,:)






%%
%做出绕xy轴旋转前后的截面图


num0=[1 aa0]
res002=resxy(num0,:);
for jj=1:size(num0,2)
x1=res002(jj,3);x2=res002(jj,4);

       
Ndata=[data0(:,1:3) ones(das,1)]*[1 0 0 0;0 cos(x1) sin(x1) 0;0 -sin(x1) cos(x1) 0;0 0 0 1]...
    *[cos(x2) 0 sin(x2) 0;0 1 0 0;-sin(x2) 0 cos(x2) 0;0 0 0 1];

x=Ndata(1:564,1);
y=Ndata(1:564:das-563,2);


for i=1:564
        for j=1:756
          z(i,j)=Ndata(num((i-1)*756+j),3);
        end
end

G=csaps({x,y},z,1);%0.999998



figure
hold on
%for ii=10:100:760
    for ii=[10 50 120 260 750];
    hold on
plot(x,fnval(G,{x,y(ii)}),'g')
a=num2str(ii);
text(x(50),fnval(G,{x(50),y(ii)}),a);
end
axis([0 1.6 -0.1 0.05])


figure
hold on
%for ii=1:50:560
    for ii=[50 200 400 450 500 560];
    hold on
plot(y,fnval(G,{x(ii),y}),'b')
a=num2str(ii);
text(y(600),fnval(G,{x(ii),y(600)}),a);
end
axis([0 2.5 -.15 .05])

end
        






%%
%绕轴旋转，使得，y//划痕  方向导数
res001=resxy(aa0,:);

x1=res001(1,3);x2=res001(1,4);
      
Ndata=[data0(:,1:3) ones(das,1)]*[1 0 0 0;0 cos(x1) sin(x1) 0;0 -sin(x1) cos(x1) 0;0 0 0 1]...
    *[cos(x2) 0 sin(x2) 0;0 1 0 0;-sin(x2) 0 cos(x2) 0;0 0 0 1];
Zdata=Ndata;


aaa=[];

x=Zdata(1:564,1);
y=Zdata(1:564:das-563,2);
figure
hold on
for r=(-1:.2:1)*2*pi/180
for i=1:564
        for j=1:756
          z(i,j)=Zdata(num((i-1)*756+j),3);
        end
end

G=csaps({x,y},z,0.998);%0.999998
dG=fndir(G,[sin(r) 0;0 cos(r)]);

for iii=1:size(y,1)
    res000=fnval(dG,{x(450),y(iii)});
yy(iii)=sqrt(res000(1).^2+res000(2).^2);
end
plot(y,yy,'b')
a=num2str(r*180/pi*10);
text(y(600),yy(600),a);
axis([0 2.5 -.01 .01])

end



