% 结合解析几何和演化算法求解指令集合
tic
clear
clc
global P
sita0=zeros(1,6);
Loc0=[0    0    0      0    0
      0    0    255    510  510
      0    140  140    140  75 ];
Axis0=[0 1 1 0 1 0
       0 0 0 1 0 0
       1 0 0 0 0 1];
Cen0=[0   0  0     0   0   0
      0   0 255  510  510  510
      0 140 140  140  140  75];
P0=[20 -200 120];
Loc=Loc0;
Axis=Axis0;
Cen=Cen0;
P=P0;
xCD=my_CDloc;
Obj=[0   0  xCD(1)  xCD(4)  20
     0   0  xCD(2)  xCD(5)  -200
     0  140 xCD(3)  xCD(6)  120];
n1=[0 140 0]';
n2=[xCD(1) xCD(2) 0]';
n3=cross(n1,n2);
if n3(3)>0
    sita0(1)=acos(n1'*n2/norm(n1)/norm(n2));
else
    sita0(1)=-acos(n1'*n2/norm(n1)/norm(n2));
end
n4=[0  255  0]';
n5=[0 xCD(2) xCD(3)-140]';
n6=cross(n4,n5);
if n6(1)>0
    sita0(2)=acos(n4'*n5/norm(n4)/norm(n5));
else
    sita0(2)=-acos(n4'*n5/norm(n4)/norm(n5));
end
n7=[0 255 0]';
n8=[0 xCD(5)-255 xCD(6)-140]';
n9=cross(n7,n8);
if n9(1)>0
    sita0(3)=acos(n7'*n8/norm(n7)/norm(n8));
else
    sita0(3)=-acos(n7'*n8/norm(n7)/norm(n8));
end
n10=cross([0 0 140]',xCD(4:6)-[0 0 140]');
n11=cross(xCD(4:6)-[0 0 140]',P'-[0 0 140]');
n12=cross(n10,n11);
if xCD(1)*n12(2)==xCD(2)*n12(1)&&xCD(1)*n12(3)==(xCD(3)-140)*n12(1)&&xCD(2)*n12(3)==(xCD(3)-140)*n12(2)
    sita0(4)=acos(n10'*n11/norm(n11)/norm(n10));
else
    sita0(4)=-acos(n10'*n11/norm(n11)/norm(n10));
end
u=inv([xCD(1) xCD(2);xCD(2) -xCD(1)])*[P(1)*xCD(1)+xCD(2)*P(2) 0]';
n13=[0 0 -65]';
n14=[u' 0]'-xCD(4:6);
n15=cross(n13,n14);
n16=cross([xCD(4) xCD(5) xCD(6)-140]',n13);
if n15(1)*n16(2)==n15(2)*n16(1)&&n15(1)*n16(3)==n15(3)*n16(1)&&n15(2)*n16(3)==n15(3)*n16(2)
    sita0(5)=acos(n13'*n14/norm(n13)/norm(n14));
else
    sita0(5)=-acos(n13'*n14/norm(n13)/norm(n14));
end
sita0=sita0*180/pi;
sita=sita0;
Order=zeros(1,6);
k=1;
while nnz(sita)
    for i=1:5
        if sita(i)>0
            if sita(i)>=2
                Order(k,i)=2;
                sita(i)=sita(i)-2;
            else
                Order(k,i)=round(sita(i)*10)/10;
                sita(i)=0;
            end
        elseif sita(i)<0
            if sita(i)<=-2
                Order(k,i)=-2;
                sita(i)=sita(i)+2;
            else
                Order(k,i)=round(sita(i)*10)/10;
                sita(i)=0;
            end
        else
            Order(k,i)=0;
        end
    end
    k=k+1;
end
toc