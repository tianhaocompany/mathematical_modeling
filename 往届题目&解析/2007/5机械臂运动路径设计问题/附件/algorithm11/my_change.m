function [NewLoc,NewObj,NewCen,NewAxis,weiyi]=my_change(Loc,Obj,Cen,Axis,sita,n)
%对第n个关节按照相应的旋转坐标旋转sita角度，并计算此次角度旋转导致各个关节点的空间位移
switch n
    case 1
        m=2;
    case 2
        m=3;
    case 3
        m=4;
    case 4
        m=5;
    case 5
        m=5;
end
NewLoc=Loc;
NewAxis=Axis;
for i=1:m-1
    X=inv(my_anyaxis(Axis(:,n),sita,Cen(:,n)))*[Loc(:,i)' 1]';
    NewLoc(:,i)=X(1:3);
    Y=inv(my_anyaxis(Axis(:,n),sita,zeros(3,1)))*[Axis(:,i)' 1]';
    NewAxis(:,i)=Y(1:3);
end
for i=m:5
    X=inv(my_anyaxis(Axis(:,n),0,Cen(:,n)))*[Loc(:,i)' 1]';
    NewLoc(:,i)=X(1:3);
end
X=inv(my_anyaxis(Axis(:,n),sita,Cen(:,n)))*[Obj 1]';
NewObj=X(1:3)';
NewCen=zeros(3,6);
for i=1:6
    if i==5
        NewCen(:,i)=NewLoc(:,4);
    elseif i==6
        NewCen(:,i)=NewLoc(:,5);
    else
        NewCen(:,i)=NewLoc(:,i);
    end
end
switch n
    case 1
        weiyi=(norm([NewLoc(1,3) NewLoc(2,3) 0])+norm([NewLoc(1,4) NewLoc(2,4) 0])+norm([NewLoc(1,5) NewLoc(2,5) 0]))*abs(sita);
    case 2
        weiyi=(norm(NewLoc(:,3)-NewLoc(:,2))+norm(NewLoc(:,4)-NewLoc(:,2))+norm(NewLoc(:,5)-NewLoc(:,2)))*abs(sita);
    case 3
        weiyi=(norm(NewLoc(:,4)-NewLoc(:,3))+norm(NewLoc(:,5)-NewLoc(:,3)))*abs(sita);
    case 4
        weiyi=65*abs(sita);
    case 5
        weiyi=65*abs(sita);
end