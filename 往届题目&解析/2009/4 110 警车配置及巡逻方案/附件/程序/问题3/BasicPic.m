load 增加6个点的道路信息和W距阵.mat;

plot(Point2(:,2),Point2(:,3),'.r');

for l=1:464
    hold on;
    Z=[Road2(l,4),Road2(l,5);Road2(l,6),Road2(l,7)];
    plot(Z(:,1),Z(:,2));
end

%for l=1:16
%    plot(Point2(MiddleSquareRoadNode(l,1),2),Point2(MiddleSquareRoadNode(l,1),3),'om');
%end

%for l=1:12
%    plot(Point2(SmallRoadCircleNode(l,1),2),Point2(SmallRoadCircleNode(l,1),3),'^b');
%end

%for l=1:41
%    hold on;
%    plot(Point2(BigRoadCircleNode(l,1),2),Point2(BigRoadCircleNode(l,1),3),'sr');
%end

%for l=1:4
   % hold on;
   % plot(Point2(OtherNode(l,1),2),Point2(OtherNode(l,1),3),'pr');
%end

%for l=1:45
%   hold on;
 %   plot(Point2(qitafugaijiedian(1,l),2),Point2(qitafugaijiedian(1,l),3),'sr');
%end

%hold on;
%plot(InP(:,1),InP(:,2),'*r');