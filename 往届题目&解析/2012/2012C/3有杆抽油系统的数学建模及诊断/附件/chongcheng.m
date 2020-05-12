clc;
clear;

delta=0.1;

% load uu1;
% load dd1;
% dt=0.07;  %油管内径
% n=7.6; %冲次
% dr=0.022; %抽油杆杆径
% hsl=0.98;

load uu2;
load dd2;
dt=0.044;  %油管内径
n=4; %冲次
dr=0.025;
hsl=0.912;

uu=-uu;
len=length(uu);
pt=find(uu==min(uu));
point=pt(length(pt));
uu=[uu(point:len) uu(1:point-1)];
dd=[dd(point:len) dd(1:point-1)];

upj=zeros(1,len);
dpj=zeros(1,len);
ulong=[uu(len-1) uu(len) uu uu(1) uu(2)];
dlong=[dd(len-1) dd(len) dd dd(1) dd(2)];
for i=1:len
    upj(i)=sum(ulong(i:i+4))/5;
    dpj(i)=sum(dlong(i:i+4))/5;
end
ugy=(upj-min(upj))/(max(upj)-min(upj));
dgy=(dpj-min(dpj))/(max(dpj)-min(dpj));

%单值展开
point=find(ugy==max(ugy),1);
uz=[ugy(1:point) 2-ugy(point+1:len)];
dz=dgy;
% plot(uz,dz);
k=zeros(1,len);
dk=zeros(1,len);
uzt=[uz(len) uz uz(1)];
dzt=[dz(len) dz dz(1)];
for i=2:len+1
    l1=sqrt((uzt(i)-uzt(i-1))^2+(dzt(i)-dzt(i-1))^2);
    l2=sqrt((uzt(i)-uzt(i+1))^2+(dzt(i)-dzt(i+1))^2);
    l3=sqrt((uzt(i-1)-uzt(i+1))^2+(dzt(i-1)-dzt(i+1))^2);
    p=l1+l2+l3;
    s=sqrt(p*(p-l1)*(p-l2)*(p-l3));
    k(i-1)=4*s/(l1*l2*l3);
end
for i=1:len-1
    dk(i)=abs(k(i+1)-k(i));
end
dk(len)=abs(k(1)-k(len));
dkl=[dk(len-1) dk(len) dk dk(1) dk(2)];
for i=1:len
    dk(i)=sum(dkl(i:i+4))/5;
end
% plot(dk);
dfa=mean(dgy);
dfu=dfa+delta;
dfd=dfa-delta;
up=find(dz>dfu);
down=find(dz<dfd);
kup=zeros(1,len);
kdown=kup;
kup(up)=dk(up);
kdown(down)=dk(down);
% tmp=max(kup(fix(len/4):fix(len/2)));
% set1=find(dk==tmp);
set1=find(kup==max(kup));
tmp=max(kup(1:fix(len/4)));
set2=find(dk==tmp);
tmp=max(kdown(fix(len/2):fix(len*5/6)));
set3=find(dk==tmp);
tmp=max(kdown(fix(len*3/4):len));
set4=find(dk==tmp);


grid on;
subplot(2,1,1);
plot(uz,dz,'^-');
xlabel('归一化位移');
ylabel('归一化载荷');
hold on;
plot([0 2],[dfa dfa],'r');
plot([0 2],[dfu dfu],'r-.');
plot([0 2],[dfd dfd],'r-.');
grid on;
subplot(2,1,2);
plot(uz,dk,'*-');
xlabel('归一化位移');
ylabel('归一化载荷');
grid on;

figure;
plot(uu,dd,'o-');
hold on;
plot(uu(set1),dd(set1),'r.','MarkerSize',25);
plot(uu(set2),dd(set2),'r.','MarkerSize',25);
plot(uu(set3),dd(set3),'r.','MarkerSize',25);
plot(uu(set4),dd(set4),'r.','MarkerSize',25);
xlabel('位移/m');
ylabel('载荷/N');
grid on;
hold off;

s1=abs(uu(set2)-uu(set1));
s2=abs(uu(set3)-uu(set4));

rou0=864/1.025; %原油密度
rouw=1000; %水的密度
rouy=rou0*(1-hsl)+rouw*hsl;

product=1.44*pi*(dt^2-dr^2)/4*min([s1 s2])*n*rouy;
