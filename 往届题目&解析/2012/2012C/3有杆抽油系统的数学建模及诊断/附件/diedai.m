clc;
clear;

c0=0.1;
epsl=0.01;
alp=0.5;

% load fj1s;
% load fj1f;
% u=-fj1s';
% d=fj1f'*1000;
% dr=[0.022]; %抽油杆杆径
% x=[792.5];  %抽油杆杆长
% n=7.6; %曲柄角速度
% hsl=0.98;
% jie=1;
% dt=0.07;  %油管内径 
% cco=3.2;

load fj2s;
load fj2f;
u=-fj2s';
d=fj2f'*1000;
dr=[0.025 0.022 0.019];
x=[523.61 664.32 618.35];
n=4;
hsl=0.912;
jie=3;
dt=0.044;  %油管内径
cco=4.2;

T=60/n;
f=pi*(dr/2).^2;  %截面积
rou=8456; %抽油杆密度
rou0=864/1.025; %原油密度
rouw=1000; %水的密度
rouy=rou0*(1-hsl)+rouw*hsl;
f0=sum(pi/4*(dt.^2-dr.^2).*x)*rouy*9.8;
[sou sod]=fmianji1(u,d);
% cco=abs(max(u)-min(u));
fou=sou/cco;
fod=sod/cco;
c=c0;
while(1)
% mini=100;
% for c=c0:0.01:0.2
    [uu,dd]=fgibbs(u,d,c,jie,x,dr,n,hsl);
    [spu,spd]=fmianji1(uu,dd);
    ccp=abs(max(uu)-min(uu));
    fpu=spu/ccp;
    fpd=spd/ccp;
    cd=T*abs((1-alp)*(fpd-fod)-alp*(fpu-fou))/(cco*(1+ccp/cco)*rou*sum(f.*x));
    
    k1=fou-fod;
    xx=(k1-f0)/(k1-fpu+fpd);
    if abs(xx-1)<epsl
        break;
    end
    if abs(c-cd)<epsl
        break;
    end
    c=cd;
    
%     if abs(c-cd)<mini
%         mini=abs(c-cd);
%         cfinal=cd;
%         cset=c;
%     end
end