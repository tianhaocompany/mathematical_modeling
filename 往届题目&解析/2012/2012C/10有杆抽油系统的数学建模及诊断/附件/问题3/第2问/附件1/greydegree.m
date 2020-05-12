%%基于灰色理论的
clear,clc,close all
x=0:0.1:2;
y=-0.5:0.1:0.5;
m=length(x);n=length(y);
% JZ=[];
% for i=1:m
%     for j=1:n
%     JZ=[JZ;[x(i),y(j)]];
%     end
% end
[X,Y]=meshgrid(x,y);
load xuangongtu
% % 归一化
s=2*(s-min(s))/(max(s)-min(s));
f=(f-min(f))/(max(f)-min(f))-0.5;
l=length(s);
G=zeros(m-1,n-1);
for k=1:l
    for i=1:m-1
        for j=1:n-1
            if x(i)<=s(k)&s(k)<x(i+1)&f(k)>=y(j)&f(k)<y(j+1)
                %                 G(i,j)=min([i,m-i,j,n-j]);
                G(i,j)=1;
            end
        end
    end
    if s(k)==x(m)&f(k)>=y(j)&f(k)<y(j+1)
        G(m,j)=1;
    end
    if f(k)==y(n)&s(k)>=x(i)&s(k)<x(i+1)
        G(i,n)=1;
    end
end
% G
%%求灰度为1的坐标
BY=[];
for i=1:m-1
    for j=1:n-1
        if G(i,j)==1
            BY=[BY;[i,j]];
        end
    end
end

G=G';
for i=1:n-1
    indices=find(G(i,:)==1);
    for j=1:m-1
        dist_x=j-indices;
        if (dist_x>0)>0
            Gx(i,j)=1-min(dist_x);
        elseif (dist_x<0)>0
            Gx(i,j)=1-min(abs(dist_x));
        else Gx(i,j)=1+min(abs(dist_x));
        end
    end
end
for j=1:m-1
    indices=find(G(:,j)==1);
    for i=1:n-1
        dist_y=i-indices;
        if (dist_y>0)>0
            Gy(i,j)=1-min(dist_y);
        elseif (dist_y<0)>0
            Gy(i,j)=1-min(abs(dist_y));
        else Gy(i,j)=1+min(abs(dist_y));
        end
    end
end
for i=1:n-1
    for j=1:m-1
        if (Gx(i,j)>1)&&(Gy(i,j)>1)
            Gmin(i,j)=min(Gx(i,j),Gy(i,j));       %Gmin?a1|í?í??????ó
        else Gmin(i,j)=max(Gx(i,j),Gy(i,j));
        end
    end
end   % Gmin为灰度矩阵

for r=1:max(max(Gmin))
    b(r)=sum(sum(Gmin==r));
    p(r)=b(r)/((n-1)*(m-1));
end
r=1:max(max(Gmin));
f1=sum(r.*p);
f2=sum((r-f1).^2.*p);
f3=1/(f2^1.5)*sum((r-f1).^3.*p);
f4=1/(f2^2)*sum((r-f1).^4.*p);
f5=sum(p.^2);
f6=-sum((1-p).*log(1-p)/log(10));
f0=[f1 f2 f3 f4 f5 f6];
F=[3.1136718  32.0434667 0.1288956 2.0821096 0.05858221 0.42127466;
    -4.9452427 71.4339934 -0.6116463 2.2483225 0.042239802 0.42493713;
    -0.6643067 67.7457798 -0.8128626 3.1408006 0.0446386 0.42438138;
    3.9783761 34.3002095 -0.072428078 2.4957887 0.0502976 0.376742835;
    0.9414063 59.1030529 -0.7324376 2.4839578 0.04490261 0.42433961;
    3.3991699 34.9128874 -0.4907762 3.4235788 0.05203366 0.42275149;
    -1.5135091 52.6342076 -0.6535104 3.0365169 0.04369354 0.42463393;
    -5.1904297 54.5995376 -0.4134820 2.1493670 0.04365373 0.42464151;
    -9.4008789 70.8467032 -0.5035313 2.2455963 0.03682065 0.42617836;
    3.7084351 35.6364861 -0.2692522 2.8842139 0.05268651 0.42259852;
    -1.9907227 -30.1507928 -0.63026266 2.4998256 0.05625772 0.9712296];%%参考
p=0.1;
for i=1:length(f0)
    fmax1(i)=max(abs(F(i,:)-f0));
    fmin1(i)=min(abs(F(i,:)-f0));
end
fmax=max(fmax1);
fmin=min(fmin1);
for i=1:size(F,1)%11
    for k=1:size(F,2)%6
        e(i,k)=(fmin+p*fmax)/(abs(f0(k)-F(i,k))+p*fmax);
    end
    ek(i)=mean(e(i,:));
end
k=find(ek==max(ek))
% if k==1
%     disp 泵正常
% elseif k==2
%     disp 液击
% elseif k==3
%     disp 供液不足
% elseif k==4
%     disp 双凡尔漏失
% elseif k==5
%     disp 气体影响
% elseif k==6
%     disp 游动凡尔漏失
% elseif k==7
%     disp 抽油杆断脱
% elseif k==8
%     disp 泵上碰
% elseif k==9
%     disp 泵下碰
% elseif k==10
%     disp 固定凡尔漏失
% elseif k==11
%     disp 严重供液不足
% end
figure
i=1:21;
j=1:11;
plot(i,meshgrid(j,i),'k'),hold on,plot(meshgrid(i,j),j,'k')
i=1:20;
j=1:10;
pcolor(i,j,Gmin)
axis([1 21 1 11])

%%%%%%%%%%%%%%%%% 泵功图%%%%%%%%%%%%%%%
fig1=figure;
xSize = 3;%3; 
ySize = 2.25;%2.25;                            %  图片的长和高，3英寸 x 2.25英寸
xLeft = (6-xSize)/2;  yTop = (10-ySize)/2;  
set(fig1,'Units','inches');                                %  单位为英寸
set(fig1,'position',[xLeft yTop xSize ySize]);  % 图片在屏幕上显示的位置
set(fig1,'PaperUnits','inches');                       %  单位为英寸
set(fig1,'PaperPosition',[xLeft yTop xSize ySize]);  % 图片在“纸上”显示的位置
%%%%%%%%%%%%%%%画图%%%%%%%%%%%%%%%%%%%%%%%
plot(x,meshgrid(y,x),'k'),hold on,plot(meshgrid(x,y),y,'k')
plot(s,f,'b')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(gca,'fontsize',9);           % 坐标轴上的数字字号为9 pt
h1 = xlabel('位移(m)'); h2 = ylabel('载荷(kN)');   % 坐标轴名称
set(h1,'fontsize',9);             %  X轴的字号为9 pt
set(h2,'fontsize',9);             %  Y轴的字号为9 pt
print('-djpeg','-r600','附件1灰度图')          % 以600 dpi的分辨率输出一个JPG 图片
print('-dtiff','-r300',' 附件1灰度图')  % 以300 dpi的分辨率输出一个tiff 的 图片
saveas(gcf,' 附件1灰度图.fig')% 输出fig

