
clc
%画图，保存格式
clc
a=zeros(2288,2288);
bb=load('IR1_2100.mat')
a=bb.bb;
for i=1:2288
    for j=1:2288
        if a(i,j)==-1
            a(i,j)=983;
        end
    end
end
a=a/983;
imshow(a);
hold on
%海岸线
%coastline=importdata('coastline0.txt');
a=6378136.5; 
c=6356751.8;
a0=0.5*pi;
a1=0.5*pi;
m=size(coastline,1);
H=42164000;
zuobiao=zeros(m,2); %海岸线经纬度对应成灰度坐标
k=0;

for n=1:m
if coastline(n,1)<99999   
      k=k+1;  
p=(90-coastline(n,2))*pi/180;
q=(coastline(n,1)+3.5)*pi/180;
if p<=a0&&q<=a1  %北半球，左边
z=sqrt(1/(1/c^2+tan(p)^2/a^2));
m=z*tan(p);
x=m*cos(q);
y=m*cos(a0-q);
n=z/x;
mm=(y-H)/x;
sitai=atan(n/(sqrt(1+mm^2)));
sitaj=atan(1/(sqrt(mm^2+n^2)));
i=1145-sitai/0.00014;
j=1145-sitaj/0.00014;
elseif p>a0&&q<=a1  %南半球左边
z=sqrt(1/(1/c^2+tan(pi-p)^2/a^2));  
m=z*tan(pi-p);
x=m*cos(q);
y=m*cos(a0-q);
n=z/x;
mm=(y-H)/x;
sitai=atan(n/(sqrt(1+mm^2)));
sitaj=atan(1/(sqrt(mm^2+n^2)));
i=1145+sitai/0.00014;
j=1145-sitaj/0.00014;
elseif p<=a0&&q>a1  %北半球，右边
z=sqrt(1/(1/c^2+tan(p)^2/a^2));
m=z*tan(p);
x=m*cos(pi-q);
y=m*sin(pi-q);
n=z/x;
mm=(y-H)/x;
sitai=atan(n/(sqrt(1+mm^2)));
sitaj=atan(1/(sqrt(mm^2+n^2)));
i=1145-sitai/0.00014;
j=1145+sitaj/0.00014; 
elseif p>a0&&q>a1  %南半球，右边
z=sqrt(1/(1/c^2+tan(pi-p)^2/a^2));
m=z*tan(pi-p);
x=m*cos(pi-q);
y=m*sin(pi-q);
n=z/x;
mm=(y-H)/x;
sitai=atan(n/(sqrt(1+mm^2)));
sitaj=atan(1/(sqrt(mm^2+n^2)));
i=1145+sitai/0.00014;
j=1145+sitaj/0.00014; 
end
zuobiao(k,1)=i; 
zuobiao(k,2)=j;
end
end
plot(zuobiao(1:k,2),zuobiao(1:k,1),'b.')  
hold off

