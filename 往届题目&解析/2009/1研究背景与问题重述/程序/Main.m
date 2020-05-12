%%
%本程序为主程序，从原始数据出发，生成切片二维数据，
%%建立核心搜索算法，逐一扫描整个切片图形，提取特征峰。存储检索索引信息（即全部的特征峰信息）

load 30213.dat  %%%30213.dat为原始数据，我们对题中所有子弹进行编号，30213，指第三题02个枪打出的第一颗子弹第4个面。  
 data0=X30213;  %load数据后，把数据名称重定义为data0
 resnum=30213;     %任意一个面，做切片数据，最后存入resdata{}中，每一行为一个面的数据，resdata（n,1）表述对应面标号


das=size(data0,1);
x=data0(1:564,1);
y=data0(1:564:das-563,2);
%图形切片，即取不同y，分别得出xoz的信息，在x轴上周期平移叠加             
ii=10;
hang=find(data0(:,2)==y(ii));
data11=data0(hang,[1 3]);
for ii=20:10:750
    za=zeros(size(x,1),2);
hang=find(data0(:,2)==y(ii));

za(:,1)=data0(hang,1)+x(end,1)*(ii/10-1);
za(:,2)=data0(hang,3);
data11=[data11;za];
end

data12=data11;data13=data11;

%% 滤波，去除噪声。对切片数据用样条函数拟合，并作微积分，为后文计算准备。

G11=csaps(data12(:,1),data12(:,2),0.999998);        %0.999998为控制滤波的参数
data11=[data12(:,1) fnval(G11,data12(:,1))];
    ZG=csaps(data11(:,1),data11(:,2),1);           %原图形拟合
    DZ=fnder(ZG);                                  %微分函数
    TG=fnint(ZG);                                  %积分函数
%nmax=564*1;plot(data12(1:nmax,1),data11(1:nmax,2))


%% 每次抓取一段L0长度的信息。存放到矩阵sdata中，进行下一步进行特征峰的提取。
L0=50;Li=10;maxsj=floor(564/L0);%L0是标志长度。Li搜索步长

Sdata=[];

for si=1:75%75
    sj0=1;sj=0;
    while sj0
    sj=sj+1;
        if Li*(sj-1)+L0>564
            sx1=(si-1)*564+Li*(sj-1)+1;
            sx2=(si)*564;
            sj0=0;
        else
            sx1=(si-1)*564+Li*(sj-1)+1;
            sx2=(si-1)*564+Li*(sj-1)+L0;
        end
        sdata=data11(sx1:sx2,:);
       das=size(sdata,1);
       Zdata=sdata;
        
 
%%          

%寻找最低点,找该点对应的特征峰
[Zdx Zdz]=min(Zdata(:,2));
xmin=Zdata(Zdz,1);
L2=200;
ee=0.03;
xstep=0.00275;

  %  ZG=csaps(Zdata(:,1),Zdata(:,2),1);
  %  DZ=fnder(ZG);
Zii=1;i=0;
dx1=[];
while Zii
    xleft=[];
if xmin==Zdata(1,1)||xmin==Zdata(end,1) %出现最小点在端点，不搜索
Zii=0;
else
    i=i+1;
    xnow=xmin-i*xstep;
    dx10=fnval(DZ,xnow);
if xnow<data11((si-1)*564+1,1)  %特殊情况一，左偏出了一个周期
    Zii=0;
 
elseif xnow<Zdata(1,1)   %情况1、出了该段波形的左端点
    
    if xnow<Zdata(1,1)-L2*xstep %情况1、如果出了设定范围外，停止搜索
        Zii=0;
    
    else                        %情况1、其他继续搜索  
            dx1=[dx1 dx10];
    if size(dx1,2)>5  %出现拐点
        if dx1(end)*dx1(end-5)<=0&&dx1(end-1)*dx1(end-4)<=0
            Zii=0;
        
            xleft=xnow;
        end
    end
     if size(dx1,2)>5  %出现平台区
           if abs(dx1(end))<ee&&abs(dx1(end-1))<ee&&abs(dx1(end-2))<ee
            Zii=0;
          
            xleft=xnow;
           end
     end
        
    end
else                       %情况2、正常情况
    dx1=[dx1 dx10];
    if size(dx1,2)>5  %出现拐点
        if dx1(end)*dx1(end-5)<=0&&dx1(end-1)*dx1(end-4)<=0
            Zii=0;
         
            xleft=xnow;
        end
    end
     if size(dx1,2)>5  %出现平台区
           if abs(dx1(end))<ee&&abs(dx1(end-1))<ee&&abs(dx1(end-2))<ee
            Zii=0;
          
            xleft=xnow;
           end
     end
end
    
end
end


Zii=1;i=0;
dx2=[];
while Zii
    xright=[];
if xmin==Zdata(1,1)||xmin==Zdata(end,1) %出现最小点在端点，不搜索
Zii=0;
else
    i=i+1;
    xnow=xmin+i*xstep;
    dx10=fnval(DZ,xnow);
if xnow>data11((si)*564-1,1)  %特殊情况一，左偏出了一个周期
    Zii=0;
    
elseif xnow>Zdata(end,1)   %情况1、出了该段波形的左端点
    
    if xnow>Zdata(end,1)+L2*xstep %情况1、如果出了设定范围外，停止搜索
        Zii=0;
     
    else                        %情况1、其他继续搜索  
            dx2=[dx2 dx10];
    if size(dx2,2)>5  %出现拐点
        if dx2(end)*dx2(end-5)<=0&&dx2(end-1)*dx2(end-4)<=0
            Zii=0;
           
            xright=xnow;
        end
    end
     if size(dx2,2)>5  %出现平台区
           if abs(dx2(end))<ee&&abs(dx2(end-1))<ee&&abs(dx2(end-2))<ee
            Zii=0;
           
            xright=xnow;
           end
     end
        
    end
else                       %情况2、正常情况
    dx2=[dx2 dx10];
    if size(dx2,2)>5  %出现拐点
        if dx2(end)*dx2(end-5)<=0&&dx2(end-1)*dx2(end-4)<=0
            Zii=0;
         
            xright=xnow;
        end
    end
     if size(dx2,2)>5  %出现平台区
           if abs(dx2(end))<ee&&abs(dx2(end-1))<ee&&abs(dx2(end-2))<ee
            Zii=0;
           
            xright=xnow;
           end
     end
end
    
end
end



if isempty(xleft)
    
elseif isempty(xright)
    
else
    [xleft xmin xright];
    
     %figure; hold on;      plot(sdata(:,1),sdata(:,2));
     %nmax=564*1;plot(data12(1:nmax,1),data11(1:nmax,2));
     %plot([xleft+0.00275*1 xleft+0.00275*1],[min(Zdata(:,2)) max(Zdata(:,2))]);
     %plot([xright-0.00275*1 xright-0.00275*1],[min(Zdata(:,2)) max(Zdata(:,2))]);
     
     
     %4个指标：夹角v0，左边比右边L12，三角形面积As，峰面积Af
xmy=fnval(ZG,[xleft xmin xright]);yleft=xmy(1);ymin=xmy(2);yright=xmy(3);
va=[xleft-xmin yleft-ymin];vb=[xright-xmin yright-ymin];
v0=acos(va*vb'/(sqrt(va(1).^2+va(2).^2)*sqrt(vb(1).^2+vb(2).^2)));

L12=sqrt(va*va')/sqrt(vb*vb');

%As=abs((xleft*ymin+xmin*yright+xright*yleft-xleft*yright-xmin*yleft-xright*ymin)/2) 
As=sqrt(va*va')*sqrt(vb*vb')*sin(v0)/2;
Ar=abs((yleft+yright)*(xright-xleft)/2);
I=abs(fnval(TG,xleft)-fnval(TG,xright));
Af=abs(Ar-I);
saa=[v0;L12;As;Af;si;sj];
Sdata=[Sdata saa];
end  
        
        
    end
    
    
end
    
Sdata;
    
    
    %  TUnum=zeros(100000,1);TUzhb=zeros(100000,4);TUdata00=cell(100000,3);
SSe=0.02;

SSdata=[Sdata;zeros(1,size(Sdata,2))];
for SSi=2:size(Sdata,2)
   if abs(SSdata(1,SSi)-SSdata(1,SSi-1))<SSe*SSdata(1,SSi)&&abs(SSdata(2,SSi)-SSdata(2,SSi-1))<SSe*SSdata(2,SSi)
   else
      SSdata(7,SSi)=1;
   end
end

Udata=SSdata(:,find(SSdata(7,:)==1))';

%resdata 为定义的存储数据库，每个样本占一条信息，包含标号，特征峰矩阵，和切片数据。
load resdata  %  resdata=cell(10000,6);save resdata resdata
ii01=0;ii02=1;
while ii02
    ii01=ii01+1;
    if isempty(resdata{ii01,1})
        ii02=0;
    end
end
resdata{ii01,1}=resnum;
resdata{ii01,2}=Udata;
resdata{ii01,3}=data13;
save resdata resdata
% save beifen1 resdata
resdata{ii01,1}