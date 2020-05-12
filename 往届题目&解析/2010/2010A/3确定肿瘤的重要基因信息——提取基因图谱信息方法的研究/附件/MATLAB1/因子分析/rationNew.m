function [y,T]=rationNew(A,x)%矩阵最大方差旋转函数,y:旋转结果，T：旋转变换矩阵
[r,c]=size(x);

for k=1:c-1  %求旋转角度
    for j=k+1:c %两两配对旋转
        aa=0;bb=0;cc=0;dd=0;
        for i=1:r
            uu=x(i,k)^2-x(i,j)^2;
            vv=x(i,k)*x(i,j)*2;
            aa=aa+uu;
            bb=bb+vv;
            cc=cc+uu^2-vv^2;
            dd=dd+uu*vv*2;
        end
        dd=r*dd-2*aa*bb;
        cc=r*cc-aa^2+bb^2;
        %由dd,  cc确定旋转角的范围，即所在象限
        if abs(cc)<=1e-10
            b=pi/2;
        else
            b=abs(atan(dd/cc));
        end
        if cc<0
            b=pi-b;
            if dd>0;
                b=0.25*b;
            else
                b=-b*0.25;
            end
        elseif dd>0
            b=0.25*b;
        else
            b=-0.25*b;
        end
        si=sin(b);c0=cos(b);    %旋转处理            
        T=[c0,  -si;   %记录旋转矩阵
            si,  c0];
        for i=1:r  %对规格化前的矩阵实施旋转处理
            qq=A(i,k)*c0+A(i,j)*si;
            A(i,j)=-A(i,k)*si+c0*A(i,j);
            A(i,k)=qq;
        end
    end
end
y=A;
end

