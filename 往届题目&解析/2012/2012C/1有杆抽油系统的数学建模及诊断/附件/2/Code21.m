function Code21
clc;
%xx=8456*(pi*22*22/4/1000/1000)*792.5
A=load('test1.txt');
U=A(:,1);
D=A(:,2)*1000; %原始载荷
k=length(D);
n=10;
plot(U,D,'r-')
hold on

%计算声速，粘滞阻力系数
EE=2.1e11;
ru=8456;
AA=sqrt(EE/ru);
DL=70/1000.0;
DR=22/1000.0;
LL=792.5;        %一级杆杆长(m)
mm=30/1000.0;    %地面原油粘度(Pa*s)
cc=7.6;          %冲数
ww=2*pi*cc/60.0; %转速

rul=864*(1-0.98)+1000*0.98;
D=D-(ru-rul)*(pi*DR*DR/4)*LL*9.8; %去重力载荷
%计算sig0,vel0
sig0=0.0;
vel0=0.0;
for i=1:k
    sig0=sig0+2/k*D(i);
    vel0=vel0+2/k*U(i);
end
%sig(i),tau(i),vel(i),det(i)
for i=1:n
    sig(i)=0.0;
    tau(i)=0.0;
    vel(i)=0.0;
    det(i)=0.0;
    for p=1:k
       sig(i)=sig(i)+2/k*D(p)*cos(2*pi*i/k*p); 
       tau(i)=tau(i)+2/k*D(p)*sin(2*pi*i/k*p);
       vel(i)=vel(i)+2/k*U(p)*cos(2*pi*i/k*p); 
       det(i)=det(i)+2/k*U(p)*sin(2*pi*i/k*p);
    end
end

%test
for p=1:k
    DD(p)=sig0/2;
    UU(p)=vel0/2;
    for i=1:n
       DD(p)=DD(p)+sig(i)*cos(p*i/k*2*pi)+tau(i)*sin(p*i/k*2*pi);
       UU(p)=UU(p)+vel(i)*cos(p*i/k*2*pi)+det(i)*sin(p*i/k*2*pi);
    end
end
%plot(UU,DD,'+')

%粘滞阻力系数
DR=22/1000.0;
LL=792.5;        %一级杆杆长(m)
pm=DL/DR;
B1=(pm^2-1)/2/log(pm)-1;
B2=pm^4-1-(pm^2-1)^2/log(pm);
tp=ww*LL/AA*sin(ww*LL/AA)+cos(ww*LL/AA);
pc=8*mm/ru/DR/DR*(1/log(pm)+2/B2*(B1+1)*(B1+2/(tp)));
%计算ahl(i),bet(i),kin(i),muu(i)
EA=EE*(pi*DR*DR/4);
for i=1:n
    aph(i)=i*ww/AA/sqrt(2)*sqrt(1+sqrt(1+(pc/i/ww)^2));
    bet(i)=i*ww/AA/sqrt(2)*sqrt(-1+sqrt(1+(pc/i/ww)^2));
    kin(i)=(sig(i)*aph(i)+tau(i)*bet(i))/EA/(aph(i)^2+bet(i)^2);
    muu(i)=(sig(i)*bet(i)-tau(i)*aph(i))/EA/(aph(i)^2+bet(i)^2);
end
%计算OO,PP,DO,DP
LL=793; %泵深(m)
for i=1:n
    OO(i)=(kin(i)*cosh(bet(i)*LL)+det(i)*sinh(bet(i)*LL))*sin(aph(i)*LL)...
       +(muu(i)*sinh(bet(i)*LL)+vel(i)*cosh(bet(i)*LL))*cos(aph(i)*LL); 
    PP(i)=(kin(i)*sinh(bet(i)*LL)+det(i)*cosh(bet(i)*LL))*cos(aph(i)*LL)...
       -(muu(i)*cosh(bet(i)*LL)+vel(i)*sinh(bet(i)*LL))*sin(aph(i)*LL);
    tp1=tau(i)/EA; %bet(i)*kin(i)-aph(i)*muu(i); %tau(i)/EA;
    tp2=det(i)*bet(i)-vel(i)*aph(i);
    tp3=sig(i)/EA; %aph(i)*kin(i)+bet(i)*muu(i); %sig(i)/EA;
    tp4=vel(i)*bet(i)+det(i)*aph(i);
    DO(i)=(tp1*sinh(bet(i)*LL)+tp2*cosh(bet(i)*LL))*sin(aph(i)*LL)...
       +(tp3*cosh(bet(i)*LL)+tp4*sinh(bet(i)*LL))*cos(aph(i)*LL);
    DP(i)=(tp1*cosh(bet(i)*LL)+tp2*sinh(bet(i)*LL))*cos(aph(i)*LL)...
       -(tp3*sinh(bet(i)*LL)+tp4*cosh(bet(i)*LL))*sin(aph(i)*LL);
end
%计算位移
tp0=sig0/2/EA;
for p=1:k
   Xx(p)=p/k*360;
   Ux(p)=tp0*LL+vel0/2;
   Fx(p)=sig0/2;
   for i=1:n
      Ux(p)=Ux(p)+OO(i)*cos(p*i/k*2*pi)+PP(i)*sin(p*i/k*2*pi);
      Fx(p)=Fx(p)+EA*(DO(i)*cos(p*i/k*2*pi)+DP(i)*sin(p*i/k*2*pi));
   end
end
%plot(Xx,Ux,'+')

%减油压，套压差
%Fp=(0.3-0.2)*pi/4*70^2;
%Fx=Fx-Fp;

plot(Ux,Fx,'g*')
hold on
fid = fopen('case21.txt', 'wt');
for i=1:k
    fprintf(fid, '%f\t%f\n', Ux(i),Fx(i));
end 
fclose(fid);



