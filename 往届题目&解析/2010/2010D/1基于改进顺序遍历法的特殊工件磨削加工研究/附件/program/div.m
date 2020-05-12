function A2=div(A)
N=length(A);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 步骤1.将工件移动至磨削基准位置，计算各点新坐标
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
delta_X(1)=0-A(1,1);
delta_Y(1)=130.1755-A(2,1);
delta_theta(1)=0-A(3,1);
ri=1-cosd(A(3,1));
ri2=0-sind(A(3,1));
r=sqrt(250^2+130.1755^2);
delta_X(1)=delta_X(1)-r*ri;
delta_Y(1)=delta_Y(1)-r*ri2;
A0(1,1)=A(1,1)+delta_X(1)+r*ri;
A0(1,2:N)=A(1,2:N)+delta_X(1)+sqrt((A(1,2:N)-250).^2+A(2,2:N).^2).*(cosd(A(3,2:N)-delta_theta(1))-cosd(A(3,2:N)));
A0(2,1)=A(2,1)+delta_Y(1)+r*ri2;
A0(2,2:N)=A(2,2:N)+delta_Y(1)+sqrt((A(1,2:N)-250).^2+A(2,2:N).^2).*(sind(A(3,2:N)-delta_theta(1))-sind(A(3,2:N)));
A0(3,:)=A(3,:)+delta_theta(1);
%A0
%plot(A(1,:),A(2,:),'r');
%hold on
%plot(A0(1,:),A0(2,:),'g');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 步骤1完成
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%步骤2.计算加工工件时各次的x，y，theta 电机给进量, 存入矩阵A2
%      并计算每次给进后工件旋转母线上各点的新坐标，存入矩阵X,Y
%      以便模拟工件按本方案加工时的动态过程
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X=zeros(N,N);
Y=zeros(N,N);
X(1,:)=A0(1,:);
Y(1,:)=A0(2,:);
A1=A0;
A2=zeros(3,99);
%A2=A0;
%sum=0;
%for i=2:N    
%    sum=A1(:,i)-A1(:,1);      
%    for j=i+1:N
%         A1(:,j)=A1(:,j)-sum;        
%     end
%end
%a=A2(:,1);
%for i=2:N    
%    sum=A2(:,i)-a;    
%   for j=1:N
%         A2(:,j)=A2(:,j)-sum;
%        X(i,:)=A2(1,:);
%        Y(i,:)=A2(2,:);
%    end
%end

%A1(2,:)=130.1755-A1(2,:);     %
%a=A1(1,:);
%b=A1(2,:);
%c=1-cosd(A1(3,:));
%d=sind(A1(3,:));
%r=sqrt((a-250).^2+(b-0).^2);
%for i=2:N
%   A2(1,i)=A1(1,i)+c(i)*r(i);  %%%%%%%%%%%%%%%%%
%   A2(2,i)=A1(2,i)+d(i)*r(i);  %%%%%%%%%%%%%%%%%
%   A2(3,i)=A1(3,i);
%end
%A2(1,:)=-A2(1,:);
for i=1:N-1
    delta_theta=0-A1(3,i+1);  % <0
    div1=0-A1(1,i+1);       %   <0
    div2=130.1755-A1(2,i+1);    %  >0
    delta_X=div1+sqrt((A1(1,i+1)-250)^2+A1(2,i+1)^2)*(1-cosd(delta_theta)); 
     delta_Y=div2+sqrt((A1(1,i+1)-250)^2+A1(2,i+1)^2)*(0-sind(delta_theta));
    %存放本次给进量
    A2(1,i)=delta_X;
     A2(2,i)=delta_Y;
    A2(3,i)=-delta_theta;
    %更新移动后各点坐标值,以及各点新切线与x轴正方向夹角
    for j=1:N
        %if A1(1,i)<=250
         %   A1(1,j)=A1(1,j)+delta_X+sqrt((A1(1,j)-250)^2+A1(2,j)^2)*(cosd(25.5-A1(3,j)+delta_theta)-cosd(25.5-A1(3,j)));
          %  A1(2,j)=A1(2,j)+delta_Y+sqrt((A1(1,j)-250)^2+A1(2,j)^2)*(sind(25.5-A1(3,j)+delta_theta)-sind(25.5-A1(3,j)));
          %  A1(3,j)=A1(3,j)+delta_theta;
       % else
            A1(1,j)=A1(1,j)+delta_X+sqrt((A1(1,j)-250)^2+A1(2,j)^2)*(cosd(A1(3,j)+delta_theta)-cosd(A1(3,j)));
            A1(2,j)=A1(2,j)+delta_Y+sqrt((A1(1,j)-250)^2+A1(2,j)^2)*(sind(A1(3,j)+delta_theta)-sind(A1(3,j)));
            A1(3,j)=A1(3,j)+delta_theta;
        %end
    end    
     %将新坐标值存入矩阵X，Y
     X(i+1,:)=A1(1,:);
     Y(i+1,:)=A1(2,:);  
     if i==2
         A1
         A2
     end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 步骤2 完成
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:2
    A2(i,:)=A2(i,:)*300;
end
A2(3,:)=A2(3,:)*10;
A2=roundn(A2,0);
%plot(A(1,:),A(2,:),'g');
%hold on
%plot(X(1,:),Y(1,:),'b');
%hold on
%p=plot(X(5,:),Y(5,:),'r');
%imrotate(p,A2(3,6))
%hold on
%p=plot(X(20,:),Y(20,:),'r');
%imrotate(p,A2(3,21))
%hold on
%p=plot(X(50,:),Y(50,:),'r');
%imrotate(p,A2(3,51))
%hold on
%p=plot(X(80,:),Y(80,:),'r');
%imrotate(p,A2(3,81))
%hold on
%end