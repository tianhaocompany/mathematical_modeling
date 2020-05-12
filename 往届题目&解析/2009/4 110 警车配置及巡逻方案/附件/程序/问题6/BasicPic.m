load 增加6个点的道路信息和W距阵.mat;

plot(Point2(:,2),Point2(:,3),'.r');

for l=1:464
    hold on;
    Z=[Road2(l,4),Road2(l,5);Road2(l,6),Road2(l,7)];
    plot(Z(:,1),Z(:,2));
end

