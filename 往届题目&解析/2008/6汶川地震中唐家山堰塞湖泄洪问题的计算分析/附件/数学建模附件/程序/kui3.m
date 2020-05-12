%1/3
clear
clc
Q=[];
Q(1)=23000;
%Q(1)=overtop;%漫顶流量
T=240;
deltaT=10/60;
Ntime=T/deltaT;
b=[];
b(1)=expand(0,48);
i=2;
H=[];
H(1)=30;%缺口深
V=[];
V(1)=2.457;%容量
while (i<Ntime)
    b(i)=expand((i-1)*deltaT,48);
    if Q(i-1)>0
        V(i)=0.09*deltaT/24+V(i-1)-Q(i-1)*deltaT*3600/10^8;
    else
        V(i)=V(i-1)+0.09*deltaT/24;
    end
    if (V(i)<0)
        break;
    end
    H(i)=erosion(H(i-1),V(i-1),Q(i-1),b(i));
    Q(i)=flood(H(i),b(i),V(i),V(i-1));
     if H(i)-H(i-1)<1e-9
         break;
     end
     
   i=i+1;
end
mm=floor(min(size(Q,2),210)/6)*6;
hold on
subplot(2,2,1),plot([6:mm]/6,Q(6:mm)),title('溃口流量Q')
subplot(2,2,2),plot([6:mm]/6,H(6:mm)),title('溃口深度H')
subplot(2,2,3),plot([6:mm]/6,V(6:mm)),title('水库蓄水量Hw')
subplot(2,2,4),plot([6:mm]/6,b(6:mm)),title('溃口展宽B')